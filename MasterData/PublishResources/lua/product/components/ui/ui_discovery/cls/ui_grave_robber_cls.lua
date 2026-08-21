_class("GraveRobberData", Object)
GraveRobberData = GraveRobberData

function GraveRobberData:Constructor()
  self.mCampaign = GameGlobal.GetModule(CampaignModule)
  self.campaign = nil
  self.chapters = nil
end

function GraveRobberData:RequestCampaign(TT)
  local res = AsyncRequestRes:New()
  if not self.mCampaign then
    return
  end
  if not self.campaign or self.campaign._id <= 0 then
    self._campaign = UIActivityCampaign:New()
    self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_GRASS)
    self:Init()
    return
  end
  self.mCampaign:CampaignComProtoLoadInfo(TT, res, self.campaign._id)
  self:Init()
end

function GraveRobberData:GetCampaign()
  return self.campaign
end

function GraveRobberData:GetCampaignLocalProgress()
  local campaign = self:GetCampaign()
  if campaign then
    return campaign:GetLocalProcess()
  end
end

function GraveRobberData:GetComponentGrassMission()
  local lp = self:GetCampaignLocalProgress()
  if lp then
    local c = lp:GetComponent(ECampaignGrassComponentID.ECAMPAIGN_GRASS_MISSION)
    return c
  end
end

function GraveRobberData:GetComponentInfoGrassMission()
  local lp = self:GetCampaignLocalProgress()
  if lp then
    local cInfo = lp:GetComponentInfo(ECampaignGrassComponentID.ECAMPAIGN_GRASS_MISSION)
    return cInfo
  end
end

function GraveRobberData:Init()
  local cInfo = self:GetComponentInfoGrassMission()
  if not cInfo then
    Log.warn("### GraveRobberData Init failed. GetComponentInfoGrassMission is nil.")
    return
  end
  local c = self:GetComponentGrassMission()
  local cCfgId = c:GetComponetCfgId(cInfo.m_campaign_id, cInfo.m_component_id)
  local cfg_component_line_mission = Cfg.cfg_component_line_mission({ComponentID = cCfgId})
  local len_cfg_component_line_mission = table.count(cfg_component_line_mission)
  
  local function GetCfgPassMissionInfo(campaignMissionId)
    if cfg_component_line_mission and 0 < len_cfg_component_line_mission then
      for key, cfgv in pairs(cfg_component_line_mission) do
        if cfgv.CampaignMissionId == campaignMissionId then
          return cfgv
        end
      end
    else
      Log.fatal("### GraveRobberData Init failed. no data in cfg_component_line_mission. ComponentID=", cCfgId)
    end
  end
  
  local m_pass_mission_info = cInfo.m_pass_mission_info
  local len_m_pass_mission_info = table.count(m_pass_mission_info)
  
  local function GetNodeState(campaignMissionId, cfgvLineMission)
    local hasPass = false
    if m_pass_mission_info and 0 < len_m_pass_mission_info then
      for stageId, v in pairs(m_pass_mission_info) do
        if v.mission_id == campaignMissionId then
          hasPass = true
          break
        end
      end
    end
    if hasPass then
      return DiscoveryStageState.Nomal
    else
      local mMission = GameGlobal.GetModule(MissionModule)
      local discoveryData = mMission:GetDiscoveryData()
      local nodeMain = discoveryData:GetCanMoveNodeDataByStageId(cfgvLineMission.NeedMainMissionId)
      if nodeMain:State() == DiscoveryStageState.Nomal then
        return DiscoveryStageState.CanPlay
      end
    end
  end
  
  local cfgChapter = Cfg.cfg_grass_chapter()
  self.chapters = {}
  for key, cfgv in pairs(cfgChapter) do
    if not self.chapters[cfgv.ChapterID] then
      self.chapters[cfgv.ChapterID] = GraveRobberChapter:New()
      self.chapters[cfgv.ChapterID].chapterId = cfgv.ChapterID
    end
    local node = GraveRobberNode:New()
    node.stageId = cfgv.MissionID
    node.chapterId = cfgv.ChapterID
    local cfgvLineMission = GetCfgPassMissionInfo(cfgv.MissionID)
    node.pos.x = cfgvLineMission.MapPosX
    node.pos.y = cfgvLineMission.MapPosY
    node.name = StringTable.Get(cfgvLineMission.Name)
    node.state = GetNodeState(cfgv.MissionID, cfgvLineMission)
    table.insert(self.chapters[cfgv.ChapterID].nodes, node)
  end
  self:CancelTimerEvent()
  local leftSeconds = UICommonHelper.CalcLeftSeconds(cInfo.m_close_time)
  self.te = GameGlobal.Timer():AddEvent(leftSeconds * 1000, function()
    self:CancelTimerEvent()
    self.campaign = nil
    self.chapters = nil
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GrassClose)
  end)
end

function GraveRobberData:CancelTimerEvent()
  if self.te then
    GameGlobal.Timer():CancelEvent(self.te)
  end
end

function GraveRobberData:IsOpenGraveRobber()
  local cInfo = self:GetComponentInfoGrassMission()
  if cInfo and cInfo.m_b_unlock then
    local nowTimestamp = UICommonHelper.GetNowTimestamp()
    if nowTimestamp < cInfo.m_unlock_time then
      return false
    elseif nowTimestamp > cInfo.m_close_time then
      return false
    else
      return true
    end
  end
  return false
end

function GraveRobberData:GetChapterByChapterId(chapterId)
  if self.chapters then
    return self.chapters[chapterId]
  end
end

function GraveRobberData:IsChapterCanPlay(chapterId)
  local chapter = self:GetChapterByChapterId(chapterId)
  if chapter then
    return chapter:HasCanPlayNode()
  end
  return false
end

function GraveRobberData:GetCanPlayNodesCount()
  local count = 0
  if self.chapters and 0 < table.count(self.chapters) then
    for k, v in pairs(self.chapters) do
      local chapter = self:GetChapterByChapterId(v.chapterId)
      count = count + chapter:GetCanPlayNodesCount()
    end
  end
  return count
end

function GraveRobberData:GetCanPlayNodeByChapterId(chapterId)
  if self.chapters and table.count(self.chapters) > 0 then
    local chapter = self:GetChapterByChapterId(chapterId)
    local node = chapter:GetCanPlayNode()
    if node then
      return node
    end
  end
end

function GraveRobberData:GetCanPlayNode()
  if self.chapters and table.count(self.chapters) > 0 then
    for k, v in pairs(self.chapters) do
      local node = self:GetCanPlayNodeByChapterId(v.chapterId)
      if node then
        return node
      end
    end
  end
end

function GraveRobberData:HasCanPlayNode()
  local node = self:GetCanPlayNode()
  if node then
    return true
  end
  return false
end

function GraveRobberData:GetNodeByStageId(stageId)
  if self.chapters and table.count(self.chapters) > 0 then
    for i, chapter in pairs(self.chapters) do
      for j, node in ipairs(chapter.nodes) do
        if node and node.stageId == stageId then
          return node
        end
      end
    end
  end
end

function GraveRobberData:LastNode()
  return self.lastNode
end

function GraveRobberData:SaveLastNode(node)
  self.lastNode = node
end

function GraveRobberData:GrassNodeFirst()
  return self.grassNodeFirst
end

function GraveRobberData:SaveGrassNodeFirst(node)
  self.grassNodeFirst = node
end

_class("GraveRobberChapter", Object)
GraveRobberChapter = GraveRobberChapter

function GraveRobberChapter:Constructor()
  self.chapterId = 0
  self.nodes = {}
end

function GraveRobberChapter:GetCanPlayNodesCount()
  local count = 0
  if self.nodes and 0 < table.count(self.nodes) then
    for i, v in ipairs(self.nodes) do
      if v:State() == DiscoveryStageState.CanPlay then
        count = count + 1
      end
    end
  end
  return count
end

function GraveRobberChapter:GetCanPlayNode()
  if self.nodes and table.count(self.nodes) > 0 then
    for i, v in ipairs(self.nodes) do
      if v:State() == DiscoveryStageState.CanPlay then
        return v
      end
    end
  end
end

function GraveRobberChapter:HasCanPlayNode()
  local node = self:GetCanPlayNode()
  if node then
    return true
  end
  return false
end

_class("GraveRobberNode", Object)
GraveRobberNode = GraveRobberNode

function GraveRobberNode:Constructor()
  self.stageId = 0
  self.chapterId = 0
  self.pos = Vector2.zero
  self.state = DiscoveryStageState.Nomal
  self.name = ""
end

function GraveRobberNode:State()
  return self.state
end
