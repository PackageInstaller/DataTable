_class("N28AVGData", Object)
N28AVGData = N28AVGData

function N28AVGData:Constructor()
  self.activityCampaign = UIActivityCampaign:New()
  self.dictBadgePos = {
    [1] = Vector2(-213, 162),
    [2] = Vector2(98, 162),
    [3] = Vector2(411, 162),
    [4] = Vector2(723, 162),
    [5] = Vector2(-55, -105),
    [6] = Vector2(256, -105),
    [7] = Vector2(564, -105)
  }
  self.notRemindJump = false
  self.uiName = "UIN28AVGStory"
  self.storyManager = nil
  self.optionPos = {
    Vector2(212, 333),
    Vector2(129, 143),
    Vector2(31, -50),
    Vector2(-64, -239)
  }
end

function N28AVGData:RequestCampaign(TT)
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self.activityCampaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N42, ECampaignN28ComponentID.ECAMPAIGN_N28_AVG_PHASE_2)
  return res
end

function N28AVGData:GetComponentAVG()
  return self.activityCampaign:GetComponent(ECampaignN28ComponentID.ECAMPAIGN_N28_AVG_PHASE_2)
end

function N28AVGData:GetComponentInfoAVG()
  return self.activityCampaign:GetComponentInfo(ECampaignN28ComponentID.ECAMPAIGN_N28_AVG_PHASE_2)
end

function N28AVGData:IsActiveOpen()
  local c = self:GetComponentAVG()
  if c and c:ComponentIsOpen() then
    return true
  end
  return false
end

function N28AVGData.CheckCode(res)
  local result = res:GetResult()
  if result == CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS then
    return true
  end
  local msg = StringTable.Get("str_activity_error_" .. result)
  ToastManager.ShowToast(msg)
  Log.warn("### ", msg)
  if result == CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED or result == CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_NO_OPEN then
    GameGlobal.UIStateManager():SwitchState(UIStateType.UIMain)
  elseif result == CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_COMPONENT_CLOSE then
    CutsceneManager.ExcuteCutsceneIn_Shot()
    GameGlobal.UIStateManager():SwitchState(UIStateType.UIActivityN28MainController)
  else
    GameGlobal.UIStateManager():SwitchState(UIStateType.UIMain)
  end
  return false
end

function N28AVGData:Init()
  self:InitActors()
  self:InitGraph()
  self:InitLines()
  self:InitBadge()
  self:InitEvidence()
  self:InitEnding()
end

function N28AVGData:InitActors()
  local cfg_component_avg_story_limit = self:GetCfgComponentAvgStoryLimit()
  local actorInfo = cfg_component_avg_story_limit.ActorInfo
  self.actorLeader = N28AVGActorLeader:New()
  self.actorLeader.icon = actorInfo[1].icon
  self.actorLeader.iconOption = actorInfo[1].iconOption
  self.actorLeader.min = cfg_component_avg_story_limit.MinBlood
  self.actorLeader.max = cfg_component_avg_story_limit.MaxBlood
  self.actorLeader.default = cfg_component_avg_story_limit.StartBlood
  self.actorPartners = {}
  if cfg_component_avg_story_limit.TeammateInitList then
    for i, s in ipairs(cfg_component_avg_story_limit.TeammateInitList) do
      local actor = N28AVGActorPartner:New()
      actor.icon = cfg_component_avg_story_limit.ActorInfo[i + 1].icon
      actor.iconOption = cfg_component_avg_story_limit.ActorInfo[i + 1].iconOption
      actor.min = cfg_component_avg_story_limit.TeammateMinList[i]
      actor.max = cfg_component_avg_story_limit.TeammateMaxList[i]
      actor.default = cfg_component_avg_story_limit.TeammateInitList[i]
      table.insert(self.actorPartners, actor)
    end
  end
  self.defaultEvidences = cfg_component_avg_story_limit.StartEvidences
end

function N28AVGData:InitGraph()
  self.dictStoryNode = {}
  self.dictStoryIdNodeId = {}
  local cfg_component_avg_story_node = self:GetCfgComponentAvgStoryNode()
  self.graph = Digraph:New()
  for _, cfgv in pairs(cfg_component_avg_story_node) do
    local node = N28AVGStoryNode:New()
    node.id = cfgv.ID
    node.endId = cfgv.Ending or 0
    node.storyId = cfgv.StoryId
    if string.isnullorempty(cfgv.VisibleCondition) then
      node.hideVisibleCondition = nil
    else
      node.hideVisibleCondition = N28AVGCondition:New(cfgv.VisibleCondition, false)
    end
    node.hideStartArchive = cfgv.StartArchive or {}
    node.hideStartEvidences = cfgv.StartEvidences or {}
    node.pos.x = cfgv.NodePos[1]
    node.pos.y = cfgv.NodePos[2]
    node.title = StringTable.Get(cfgv.Title)
    node.desc = StringTable.Get(cfgv.Desc)
    node.cg = cfgv.CG
    node.cgNode = cfgv.CGNode
    node.cgCanPlay = cfgv.CanplayCG
    node.cgCanplayCGNode = cfgv.CanplayCGNode
    node.hideEvidenceBook = cfgv.HideEvidenceBook
    self.dictStoryNode[cfgv.ID] = node
    self.dictStoryIdNodeId[node.storyId] = cfgv.ID
    local node = self.dictStoryNode[cfgv.ID]
    local nextNodeIds = cfgv.NextStory
    if nextNodeIds then
      node.defaultNextId = nextNodeIds[1]
      for _, nodeId in ipairs(nextNodeIds) do
        self.graph:AddEdge(cfgv.ID, nodeId)
      end
    else
      node.defaultNextId = -1
    end
  end
end

function N28AVGData:InitNodes()
  local cfgSectionExcel = self:GetCfgComponentAvgStorySection()
  local cfgOptionExcel = self:GetCfgComponentAvgStoryManual()
  for id, node in pairs(self.dictStoryNode) do
    node:Init(cfgSectionExcel, cfgOptionExcel)
  end
end

function N28AVGData:InitLines()
  self.lines = {}
  local cfg_avg_line = self:GetCfgAvgLine()
  for _, cfgv in pairs(cfg_avg_line) do
    local cfgvPos = cfgv.Pos
    for eNodeId, t in pairs(cfgvPos) do
      local line = N28AVGStoryLine:New()
      line.sNodeId = cfgv.ID
      line.eNodeId = eNodeId
      line.posS = Vector2(t.s[1], t.s[2])
      line.posE = Vector2(t.e[1], t.e[2])
      if t.l then
        line.posLs = {}
        for index, lp in ipairs(t.l) do
          local pos = Vector2(lp[1], lp[2])
          table.insert(line.posLs, pos)
        end
      end
      table.insert(self.lines, line)
    end
  end
end

function N28AVGData:InitEvidence()
  self.allEvidences = {}
  local cfg_component_avg_evidence = self:GetCfgComponentAvgEvidence()
  for id, cfgv in pairs(cfg_component_avg_evidence) do
    local evidence = N28AVGEvidenceInfo:New()
    evidence.id = cfgv.ID
    evidence.type = cfgv.EvidenceType
    evidence.name = StringTable.Get(cfgv.EvidenceName)
    evidence.desc = StringTable.Get(cfgv.EvidenceIntro)
    evidence.icon = cfgv.EvidenceIcon
    if #self.allEvidences == 0 then
      self.allEvidences[1] = evidence
    else
      local insertID = 0
      for i = 1, #self.allEvidences do
        if self.allEvidences[i].id > evidence.id then
          insertID = i
          break
        end
      end
      insertID = 0 < insertID and insertID or #self.allEvidences + 1
      table.insert(self.allEvidences, insertID, evidence)
    end
  end
end

function N28AVGData:InitBadge()
  self.badges = {}
  local cfg_component_avg_story_badge = self:GetCfgComponentAvgStoryBadge()
  for id, cfgv in pairs(cfg_component_avg_story_badge) do
    local badge = N28AVGBadgeInfo:New()
    badge.id = cfgv.ID
    badge.itemId = cfgv.BadgeID or 0
    badge.name = StringTable.Get(cfgv.Name)
    badge.desc = StringTable.Get(cfgv.Desc)
    badge.icon = cfgv.Icon
    if #self.badges == 0 then
      self.badges[1] = badge
    else
      local insertID = 0
      for i = 1, #self.badges do
        if self.badges[i].id > badge.id then
          insertID = i
          break
        end
      end
      insertID = 0 < insertID and insertID or #self.badges + 1
      table.insert(self.badges, insertID, badge)
    end
  end
  for i = 1, #self.badges do
    self.badges[i].pos = self.dictBadgePos[i]
  end
  self.badgeStages = {}
  local cfg_component_avg_story_badge_reward = self:GetCfgComponentAvgStoryBadgeReward()
  for id, cfgv in pairs(cfg_component_avg_story_badge_reward) do
    local stage = N28AVGBadgeStage:New()
    stage.id = cfgv.ID
    stage.count = cfgv.StageCount
    for _, tAward in ipairs(cfgv.Reward) do
      local ra = RoleAsset:New()
      ra.assetid = tAward[1]
      ra.count = tAward[2]
      table.insert(stage.awards, ra)
    end
    table.insert(self.badgeStages, stage)
  end
end

function N28AVGData:InitEnding()
  self.endings = {}
  local cfg_component_avg_story_ending = self:GetCfgComponentAvgStoryEnding()
  for id, cfgv in pairs(cfg_component_avg_story_ending) do
    local ending = N28AVGEnding:New()
    ending.id = cfgv.ID
    ending.itemIdGift = cfgv.AcceptableCGGift or 0
    ending.itemId = cfgv.AcceptableCG or 0
    ending.cg = cfgv.CG
    ending.cgEnding = cfgv.EndingCG
    ending.cgCollectTab = cfgv.CollectTab
    ending.cgCollect = cfgv.CollectCG
    ending.title = StringTable.Get(cfgv.Title)
    ending.desc = StringTable.Get(cfgv.Desc)
    ending.getConditionDesc = StringTable.Get(cfgv.GetConditionDesc)
    ending.awards = {}
    local cfgGift = Cfg.cfg_item_gift[cfgv.AcceptableCGGift]
    if cfgGift then
      local itemList = cfgGift.ItemList
      if itemList and 0 < table.count(itemList) then
        for index, idCount in ipairs(itemList) do
          local ra = RoleAsset:New()
          ra.assetid = idCount[1]
          ra.count = idCount[2]
          table.insert(ending.awards, ra)
        end
      end
    end
    ending.isBE = cfgv.IsBE
    table.insert(self.endings, ending)
  end
  table.sort(self.endings, function(a, b)
    return a.id < b.id
  end)
end

function N28AVGData:Update()
  self:UpdateActors()
  self:UpdateGraph()
  self:UpdateBadge()
  self:UpdateEnding()
end

function N28AVGData:UpdateActors()
end

function N28AVGData:UpdateGraph()
  for _, node in pairs(self.dictStoryNode) do
    if node:IsHide() then
      if node:IsComplete() then
        node.state = N28AVGStoryNodeState.Complete
      elseif node:IsSatisfyVisible() then
        node.state = N28AVGStoryNodeState.CanPlay
      else
        node.state = nil
      end
    elseif node:IsComplete() then
      node.state = N28AVGStoryNodeState.Complete
    else
      local serverNodeInfo = self:GetServerNodeDataByNodeId(node.id)
      if serverNodeInfo then
        node.state = N28AVGStoryNodeState.CanPlay
      else
        node.state = nil
      end
    end
  end
  for id, node in pairs(self.dictStoryNode) do
    if node:IsHide() then
    elseif node.state then
    else
      local nodeIds = self.graph:Indegree(id)
      if nodeIds then
        for _, nodeId in ipairs(nodeIds) do
          local nodeIndegree = self:GetNodeById(nodeId)
          if nodeIndegree and nodeIndegree.state == N28AVGStoryNodeState.Complete then
            node.state = N28AVGStoryNodeState.CantPlay
            break
          end
        end
      end
    end
  end
end

function N28AVGData:UpdateBadge()
end

function N28AVGData:UpdateEnding()
end

function N28AVGData:GetComponentId()
  if not self.componentId then
    local c = self:GetComponentAVG()
    self.componentId = c:GetComponentCfgId()
  end
  return self.componentId
end

function N28AVGData:GetCfgComponentAvgStoryBadge()
  local cId = self:GetComponentId()
  local cfg = Cfg.cfg_component_avg_story_badge({ComponentID = cId})
  return cfg
end

function N28AVGData:GetCfgComponentAvgEvidence()
  local cId = self:GetComponentId()
  local cfg = Cfg.cfg_component_avg_evidence({ComponentID = cId})
  return cfg
end

function N28AVGData:GetCfgComponentAvgStoryBadgeReward()
  local cId = self:GetComponentId()
  local cfg = Cfg.cfg_component_avg_story_badge_reward({ComponentID = cId})
  return cfg
end

function N28AVGData:GetCfgComponentAvgStoryEnding()
  local cId = self:GetComponentId()
  local cfg = Cfg.cfg_component_avg_story_ending({ComponentID = cId})
  return cfg
end

function N28AVGData:GetCfgComponentAvgStoryLimit()
  local cId = self:GetComponentId()
  local cfg = Cfg.cfg_component_avg_story_limit({ComponentID = cId})
  if cfg then
    return cfg[1]
  end
end

function N28AVGData:GetCfgComponentAvgStoryManual()
  local cId = self:GetComponentId()
  local cfg = Cfg.cfg_component_avg_story_manual({ComponentID = cId})
  return cfg
end

function N28AVGData:GetCfgComponentAvgStoryNode()
  local cId = self:GetComponentId()
  local cfg = Cfg.cfg_component_avg_story_node({ComponentID = cId})
  return cfg
end

function N28AVGData:GetCfgComponentAvgStorySection()
  local cId = self:GetComponentId()
  local cfg = Cfg.cfg_component_avg_story_section({ComponentID = cId})
  return cfg
end

function N28AVGData:GetCfgAvgLine()
  local cId = self:GetComponentId()
  local cfg = Cfg.cfg_avg_line({ComponentID = cId})
  return cfg
end

function N28AVGData:GetCfgAvgPhase()
  local cId = self:GetComponentId()
  local cfg = Cfg.cfg_avg_phase2_event({ComponentID = cId})
  return cfg
end

function N28AVGData:FirstNodeId()
  if not self.fstNodeId then
    for id, node in pairs(self.dictStoryNode) do
      if self.graph:IndegreeCount(id) == 0 and not node:IsHide() then
        self.fstNodeId = node.id
        break
      end
    end
  end
  return self.fstNodeId
end

function N28AVGData:CurNodeId()
  local info = self:GetComponentInfoAVG()
  local curNodeId = info.cur_node_id
  if curNodeId == 0 then
    curNodeId = self:FirstNodeId()
  end
  return curNodeId
end

function N28AVGData:CurNode()
  local nodeId = self:CurNodeId()
  local node = self:GetNodeById(nodeId)
  return node
end

function N28AVGData:GetNodeById(id)
  if not id then
    Log.fatal("### node id is nil.")
  end
  local node = self.dictStoryNode[id]
  return node
end

function N28AVGData:GetNodeByStoryId(storyId)
  local nodeId = self.dictStoryIdNodeId[storyId]
  if not nodeId then
    Log.fatal("### no corresponding nodeId. storyId=", storyId)
  end
  local node = self:GetNodeById(nodeId)
  return node
end

function N28AVGData:GetNodeByEndId(endId)
  for id, node in pairs(self.dictStoryNode) do
    if node.endId == endId then
      return node
    end
  end
end

function N28AVGData:OnTheWay()
  local nodeId = self:CurNodeId()
  if nodeId == self:FirstNodeId() then
    return false
  end
  return true
end

function N28AVGData:HasNew()
  local hasNewNode = self:HasNewNode()
  local hasNewBadge = self:HasNewBadge()
  local hasNewEvidence = self:HasNewEvidence()
  local hasNewCG = self:HasNewCG()
  return hasNewNode or hasNewBadge or hasNewCG or hasNewEvidence
end

function N28AVGData:HasNewNode()
  for id, node in pairs(self.dictStoryNode) do
    if node:IsHide() and node:IsSatisfyVisible() and node:IsHideNew() then
      return true
    end
  end
  return false
end

function N28AVGData:HasNewEvidence()
  for id, evidence in ipairs(self.allEvidences) do
    if evidence:HasNew() then
      return true
    end
  end
  return false
end

function N28AVGData:HasNewBadge()
  for index, badge in ipairs(self.badges) do
    if badge:HasNew() then
      return true
    end
  end
  return false
end

function N28AVGData:HasNewCG()
  for index, ending in ipairs(self.endings) do
    if ending:HasNew() then
      return true
    end
  end
  return false
end

function N28AVGData:HasRed()
  local hasRedBadge = self:HasRedBadge()
  local hasRedCG = self:HasRedCG()
  return hasRedBadge or hasRedCG
end

function N28AVGData:HasRedBadge()
  for index, badgeStage in ipairs(self.badgeStages) do
    if badgeStage:HasRed() then
      return true
    end
  end
  return false
end

function N28AVGData:HasRedCG()
  for index, ending in ipairs(self.endings) do
    if ending:HasRed() then
      return true
    end
  end
  return false
end

function N28AVGData:GetActorByIndex(index)
  local actor = self.actorPartners[index]
  if actor then
    return actor
  end
  return self.actorLeader
end

function N28AVGData:IsEndReach(endId)
  local info = self:GetComponentInfoAVG()
  if table.icontains(info.conplated_ending_ids, endId) then
    return true
  end
end

function N28AVGData:GetBadgeById(id)
  for index, badge in ipairs(self.badges) do
    if id == badge.id then
      return badge
    end
  end
end

function N28AVGData:GetBadgeStageById(id)
  for index, badgeStage in ipairs(self.badgeStages) do
    if id == badgeStage.id then
      return badgeStage
    end
  end
end

function N28AVGData:GetEndingById(id)
  for index, ending in ipairs(self.endings) do
    if id == ending.id then
      return ending
    end
  end
end

function N28AVGData:Timestamp2Str(timestamp)
  local t = UICommonHelper.Time2Day(timestamp)
  local year = os.date("%Y", timestamp)
  local month = os.date("%m", timestamp)
  local day = os.date("%d", timestamp)
  local hour = os.date("%H", timestamp)
  local min = os.date("%M", timestamp)
  local str = year .. "." .. month .. "." .. day .. " " .. hour .. ":" .. min
  return str
end

function N28AVGData.Sign(list)
  local key = table.concat(list, "_")
  return key
end

function N28AVGData.Sign2Numbers(sign)
  if type(sign) ~= "string" then
    Log.fatal("invalid param.", sign)
  end
  local strs = string.split(sign, "_")
  local t = {}
  for index, str in ipairs(strs) do
    local n = tonumber(str)
    table.insert(t, n)
  end
  return t
end

function N28AVGData:GetServerNodeDataByNodeId(nodeId)
  local info = self:GetComponentInfoAVG()
  local serNodeData = info.mission_datas[nodeId]
  return serNodeData
end

function N28AVGData:StoryManager(storyManager)
  if storyManager then
    self.storyManager = storyManager
  else
    return self.storyManager
  end
end

function N28AVGData:IsSelectedOption(optionId)
  local info = self:GetComponentInfoAVG()
  if table.icontains(info.choosed_manual_ids, optionId) then
    return true
  end
end

function N28AVGData:CalcCurData()
  if GameGlobal.UIStateManager():IsShow(self.uiName) then
    local hp, strategies = GameGlobal.UIStateManager():CallUIMethod(self.uiName, "CalcCurData")
    return hp, strategies
  end
  return 0, {}
end

_class("N28AVGActor", Object)
N28AVGActor = N28AVGActor

function N28AVGActor:Constructor()
  self.icon = ""
  self.iconOption = ""
  self.min = 0
  self.max = 0
  self.default = 0
  self.isLeader = false
  self.mCampaign = GameGlobal.GetModule(CampaignModule)
  self.data = self.mCampaign:GetN28AVGData()
end

_class("N28AVGActorLeader", N28AVGActor)
N28AVGActorLeader = N28AVGActorLeader

function N28AVGActorLeader:Constructor()
  self.isLeader = true
end

_class("N28AVGActorPartner", N28AVGActor)
N28AVGActorPartner = N28AVGActorPartner

function N28AVGActorPartner:Constructor()
  self.index = 0
end

_class("N28AVGEvidenceInfo", Object)
N28AVGEvidenceInfo = N28AVGEvidenceInfo

function N28AVGEvidenceInfo:Constructor()
  self.id = 0
  self.type = 0
  self.name = ""
  self.desc = ""
  self.icon = ""
  self.mCampaign = GameGlobal.GetModule(CampaignModule)
  self.data = self.mCampaign:GetN28AVGData()
end

function N28AVGEvidenceInfo:HasNew()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local info = self.data:GetComponentInfoAVG()
  local key = "N28AVGEvidenceInfo" .. pstId .. self.id
  if table.icontains(info.gained_evidence, self.id) and LocalDB.GetInt(key, 0) ~= 1 then
    return true
  end
  return false
end

function N28AVGEvidenceInfo:SetNew()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local key = "N28AVGEvidenceInfo" .. pstId .. self.id
  LocalDB.SetInt(key, 1)
end

function N28AVGEvidenceInfo:HasGot()
  local info = self.data:GetComponentInfoAVG()
  if table.icontains(info.gained_evidence, self.id) then
    return true
  end
  return false
end

_class("N28AVGBadgeInfo", Object)
N28AVGBadgeInfo = N28AVGBadgeInfo

function N28AVGBadgeInfo:Constructor()
  self.id = 0
  self.itemId = 0
  self.name = ""
  self.desc = ""
  self.icon = ""
  self.pos = Vector2.zero
  self.mCampaign = GameGlobal.GetModule(CampaignModule)
  self.data = self.mCampaign:GetN28AVGData()
end

function N28AVGBadgeInfo:HasGot()
  local mRole = GameGlobal.GetModule(RoleModule)
  local count = mRole:GetAssetCount(self.itemId)
  return 0 < count
end

function N28AVGBadgeInfo:HasNew()
  local mItem = GameGlobal.GetModule(ItemModule)
  local items = mItem:GetItemByTempId(self.itemId)
  for _, item in pairs(items) do
    if item:IsNewOverlay() then
      return true
    end
  end
  return false
end

_class("N28AVGBadgeStage", Object)
N28AVGBadgeStage = N28AVGBadgeStage

function N28AVGBadgeStage:Constructor()
  self.id = 0
  self.count = 0
  self.awards = {}
  self.mCampaign = GameGlobal.GetModule(CampaignModule)
  self.data = self.mCampaign:GetN28AVGData()
end

function N28AVGBadgeStage:AwardIcon()
  local award = self.awards[1]
  local cfgv = Cfg.cfg_item[award.assetid]
  local icon = cfgv.Icon
  return icon
end

function N28AVGBadgeStage:AwardCount()
  local award = self.awards[1]
  return award.count
end

function N28AVGBadgeStage:State()
  local info = self.data:GetComponentInfoAVG()
  if table.icontains(info.accepted_badge_rewards, self.id) then
    return N28AVGAwardState.Got
  else
    local hasGotBadgeCount = 0
    for index, badge in ipairs(self.data.badges) do
      if badge:HasGot() then
        hasGotBadgeCount = hasGotBadgeCount + 1
      end
    end
    if hasGotBadgeCount >= self.count then
      return N28AVGAwardState.CanGet
    end
  end
end

function N28AVGBadgeStage:HasRed()
  local state = self:State()
  return state == N28AVGAwardState.CanGet
end

_class("N28AVGEnding", Object)
N28AVGEnding = N28AVGEnding

function N28AVGEnding:Constructor()
  self.id = 0
  self.itemIdGift = 0
  self.itemId = 0
  self.cg = ""
  self.cgEnding = ""
  self.cgCollect = ""
  self.title = ""
  self.desc = ""
  self.getConditionDesc = ""
  self.awards = {}
  self.isBE = false
end

function N28AVGEnding:AwardState()
  local mRole = GameGlobal.GetModule(RoleModule)
  local countGift = mRole:GetAssetCount(self.itemIdGift)
  if 0 < countGift then
    return N28AVGAwardState.CanGet
  else
    local count = mRole:GetAssetCount(self.itemId)
    if 0 < count then
      return N28AVGAwardState.Got
    end
  end
end

function N28AVGEnding:HasGot()
  local state = self:AwardState()
  return state == N28AVGAwardState.Got
end

function N28AVGEnding:HasRed()
  local state = self:AwardState()
  return state == N28AVGAwardState.CanGet
end

function N28AVGEnding:HasNew()
  local mItem = GameGlobal.GetModule(ItemModule)
  local items = mItem:GetItemByTempId(self.itemId)
  for _, item in pairs(items) do
    if item:IsNewOverlay() then
      return true
    end
  end
  return false
end

function N28AVGEnding:GetTimestamp()
  if self.isBE then
    return 0
  end
  local mItem = GameGlobal.GetModule(ItemModule)
  local items = mItem:GetItemByTempId(self.itemId)
  if items and 0 < table.count(items) then
    for key, item in pairs(items) do
      local ts = item:GetGainTime()
      return ts
    end
  end
  return 0
end

local N28AVGAwardState = {CanGet = 1, Got = 2}
_enum("N28AVGAwardState", N28AVGAwardState)
_class("N28AVGCondition", Object)
N28AVGCondition = N28AVGCondition

function N28AVGCondition:Constructor(strCondition, default)
  self.hasCondition = true
  local mCampaign = GameGlobal.GetModule(CampaignModule)
  self.data = mCampaign:GetN28AVGData()
  self.bt = self:ParseCondition(strCondition)
  self.default = default or false
end

function N28AVGCondition:IsSatisfy()
  if self.bt then
    local b = BTConditionManager:GetInstance():IsSatisfy(self.bt)
    return b
  end
  return self.default
end

function N28AVGCondition:GetHasCondition()
  return self.hasCondition
end

function N28AVGCondition:ParseCondition(strCondition)
  if string.isnullorempty(strCondition) then
    self.hasCondition = false
    Log.warn("### strCondition is nil.")
    return
  end
  local bt
  local charAnd, charOr = "&", "|"
  local indexAnd, ph = string.find(strCondition, charAnd)
  local indexOr, ph = string.find(strCondition, charOr)
  if indexAnd and 0 < indexAnd then
    local nodes = {}
    local strs = string.split(strCondition, charAnd)
    for index, str in ipairs(strs) do
      local btNode = self:ParseConditionSpecific(str)
      table.insert(nodes, btNode)
    end
    bt = BTConditionManager:GetInstance():BuildBTAnd(nodes)
  elseif indexOr and 0 < indexOr then
    local nodes = {}
    local strs = string.split(strCondition, charOr)
    for index, str in ipairs(strs) do
      local btNode = self:ParseConditionSpecific(str)
      table.insert(nodes, btNode)
    end
    bt = BTConditionManager:GetInstance():BuildBTOr(nodes)
  else
    local btNode = self:ParseConditionSpecific(strCondition)
    bt = BTConditionManager:GetInstance():BuildBTSingle(btNode)
  end
  return bt
end

function N28AVGCondition:ParseConditionSpecific(strConditionSingle)
  local charComma = ","
  local strs = string.split(strConditionSingle, charComma)
  local conditionId = ""
  local params = {}
  for index, str in ipairs(strs) do
    if index == 1 then
      conditionId = str
    elseif index == 2 or index == 3 then
    else
      table.insert(params, str)
    end
  end
  local funcName = "ParseConditionSpecific" .. conditionId
  local func = self[funcName]
  if not func then
    Log.fatal("### no function names: ", funcName)
    return
  end
  local node = func(self, params)
  return node
end

function N28AVGCondition:ParseConditionSpecific1230(strConditionParams)
  local comparisionType = tonumber(strConditionParams[1])
  local hpParam = tonumber(strConditionParams[2])
  local node = ComparisonOperationNode:New(nil, comparisionType, function()
    local hp, strategies = self.data:CalcCurData()
    return hp
  end, function()
    return hpParam
  end)
  return node
end

function N28AVGCondition:ParseConditionSpecific1231(strConditionParams)
  local indexPartner = tonumber(strConditionParams[1])
  local comparisionType = tonumber(strConditionParams[2])
  local strategyParam = tonumber(strConditionParams[3])
  local node = ComparisonOperationNode:New(nil, comparisionType, function()
    local hp, strategies = self.data:CalcCurData()
    local strategy = strategies[indexPartner] or 0
    return strategy
  end, function()
    return strategyParam
  end)
  return node
end

function N28AVGCondition:ParseConditionSpecific1232(strConditionParams)
  local optionIds = {}
  for index, str in ipairs(strConditionParams) do
    local optionId = tonumber(str)
    table.insert(optionIds, optionId)
  end
  local node = self:NewConditionNode(function()
    if not GameGlobal.UIStateManager():IsShow("UIN28AVGStory") then
      return false
    end
    local selectedOptionIds = GameGlobal.UIStateManager():CallUIMethod("UIN28AVGStory", "SelectedOptionId")
    for index, optionId in ipairs(optionIds) do
      if not selectedOptionIds[optionId] then
        return false
      end
    end
    return true
  end)
  return node
end

function N28AVGCondition:ParseConditionSpecific1233(strConditionParams)
  local optionIds = {}
  for index, str in ipairs(strConditionParams) do
    local optionId = tonumber(str)
    table.insert(optionIds, optionId)
  end
  local node = self:NewConditionNode(function()
    for index, optionId in ipairs(optionIds) do
      if not self.data:IsSelectedOption(optionId) then
        return false
      end
    end
    return true
  end)
  return node
end

function N28AVGCondition:ParseConditionSpecific1234(strConditionParams)
  local endIds = {}
  for index, str in ipairs(strConditionParams) do
    local endId = tonumber(str)
    table.insert(endIds, endId)
  end
  local node = self:NewConditionNode(function()
    for index, endId in ipairs(endIds) do
      if not self.data:IsEndReach(endId) then
        return false
      end
    end
    return true
  end)
  return node
end

function N28AVGCondition:NewConditionNode(func)
  local node = ConditionNode:New(nil, func)
  return node
end

function AVGLog(...)
  if IsUnityEditor() then
    Log.fatal("### [AVG]", ...)
  end
end
