_class("DiscoveryData", Object)
DiscoveryData = DiscoveryData

function DiscoveryData:Constructor()
  self.cell_size = Vector2.zero
  self.fairy_land_pos = Vector2.zero
  self.chapters = {}
  self._module = nil
  self.mapScale = 1
  self.row = 0
  self.col = 0
  self.chapter_begin_pos = {}
  self._curPosNodeId = 0
  self.chapterAwardData = ChapterAwardData:New()
  self.showUIStage = false
  self.next_chapter = {}
  self.sections = {}
end

function DiscoveryData:Init(cfg_discovery)
  self._module = GameGlobal.GetModule(MissionModule)
  local v2 = cfg_discovery.cell_size
  self.cell_size.x = v2.x
  self.cell_size.y = v2.y
  self.row = cfg_discovery.row
  self.col = cfg_discovery.col
  v2 = cfg_discovery.fairy_land_pos
  self.fairy_land_pos.x = v2.x
  self.fairy_land_pos.y = v2.y
  for k, v in pairs(cfg_discovery.chapterBeginPos) do
    self.chapter_begin_pos[k] = Vector2(v.pos.x, v.pos.y)
  end
  for k, v in pairs(cfg_discovery.nextChapter) do
    self.next_chapter[k] = {
      pos = Vector2(v.pos.x, v.pos.y),
      chapterId = v.chapterId,
      lastNodeId = v.lastNode
    }
  end
  local cfg_mission_chapter = table.cloneconf(Cfg.cfg_mission_chapter())
  if not cfg_mission_chapter then
    Log.fatal("### DiscoveryData:Init cfg_mission_chapter is nil.")
  end
  self.chapters = {}
  local chapterId = 0
  local idx = 1
  local fullIdx = 0
  for k, v in pairs(cfg_mission_chapter) do
    local mainChapterId = v.MainChapterID
    local stageId = v.MissionID
    local wayPointId = v.WayPointID
    local stage = DiscoveryStage:New()
    stage:Init(stageId, wayPointId)
    local node = DiscoveryNode:New()
    local cfgNode = cfg_discovery.map_nodes[wayPointId]
    node:Init(wayPointId, cfgNode, v.Type)
    if v.Type == 1 then
      if chapterId ~= mainChapterId then
        chapterId = mainChapterId
        idx = 1
      else
        idx = idx + 1
      end
      fullIdx = fullIdx + 1
      node.idx = idx
      node.fullIdx = fullIdx
    end
    if not self.chapters[mainChapterId] then
      self.chapters[mainChapterId] = DiscoveryChapter:New()
      self.chapters[mainChapterId]:Init(mainChapterId)
    end
    table.insert(node.stages, stage)
    table.insert(self.chapters[mainChapterId].nodes, node)
  end
  for chapterId, chapter in pairs(self.chapters) do
    for i, node in ipairs(chapter.nodes) do
      for j, line in ipairs(cfg_discovery.lines) do
        if node.id == line.s then
          if not chapter.lines[line.s] then
            chapter.lines[line.s] = {}
          end
          table.insert(chapter.lines[line.s], line.e)
        end
      end
    end
  end
  self:InitSections()
end

function DiscoveryData:InitSections()
  self.sections = {}
  for chapterId, chapter in pairs(self.chapters) do
    local stage = chapter:Get1stStage()
    if stage then
      local sectionId = stage.sectionId
      if not self.sections[sectionId] then
        self.sections[sectionId] = DiscoverySection:New()
        self.sections[sectionId].id = sectionId
        self.sections[sectionId].index_name = StringTable.Get("str_chapter_section_index_" .. sectionId)
        self.sections[sectionId].name = StringTable.Get("str_chapter_section_name_" .. sectionId)
        local betweenChapters = Cfg.cfg_global.ui_discovery_between_chapters.ArrayValue
        self.sections[sectionId].isBetween = table.icontains(betweenChapters, sectionId) or false
        self.sections[sectionId].icon = Cfg.cfg_discovery_section[sectionId].icon
      end
      if not self.sections[sectionId].chapterIds[chapterId] then
        self.sections[sectionId].chapterIds[chapterId] = true
      end
    end
  end
end

function DiscoveryData:GetChapters()
  return self:GetVisibleChapters()
end

function DiscoveryData:GetVisibleChapters()
  local dict = {}
  if self.chapters then
    for k, v in pairs(self.chapters) do
      if v:State() then
        dict[k] = v
      end
    end
  end
  return dict
end

function DiscoveryData:GetVisibleChaptersOfSection(sectionId)
  local vChapters = {}
  if self.chapters then
    for k, chapter in pairs(self.chapters) do
      if chapter:GetSectionId() == sectionId and chapter:State() then
        table.insert(vChapters, chapter)
      end
    end
  end
  return vChapters
end

function DiscoveryData:Update(passStages, canActiveStages)
  for k, v in pairs(self.chapters) do
    v:UpdateState()
  end
end

function DiscoveryData:GetNodeDataByStageId(stageId)
  for _, chapter in pairs(self.chapters) do
    for _, node in ipairs(chapter.nodes) do
      for _, stage in ipairs(node.stages) do
        if stage.id == stageId then
          return node
        end
      end
    end
  end
  return nil
end

function DiscoveryData:GetCanMoveNodeDataByStageId(stageId)
  local node = self:GetNodeDataByStageId(stageId)
  local stage = node:GetStageById(stageId)
  if not stage.state then
    local nodeT = self:GetCanPlayNode()
    return nodeT
  else
    return node
  end
end

function DiscoveryData:GetNodeDataByNodeId(nodeId)
  for _, chapter in pairs(self.chapters) do
    for _, node in ipairs(chapter.nodes) do
      if node.id == nodeId then
        return node
      end
    end
  end
  return nil
end

function DiscoveryData:GetPosByNodeId(nodeId, isV3)
  local node = self:GetNodeDataByNodeId(nodeId)
  if node then
    return isV3 and Vector3(node.pos.x, node.pos.y) or node.pos
  end
  return isV3 and Vector3.zero or Vector2.zero
end

function DiscoveryData:GetCanReviewStorys()
  local stages = {}
  for _, chapter in pairs(self.chapters) do
    for _, node in ipairs(chapter.nodes) do
      if node:State() == DiscoveryStageState.Nomal then
        local stage = node.stages[1]
        if stage:IsThereStory() then
          table.insert(stages, stage)
        end
      end
    end
  end
  return stages
end

function DiscoveryData:GetStoryByStageIdStoryType(stageId, storyType)
  local node = self:GetNodeDataByStageId(stageId)
  if node then
    return node.stages[1].story:GetStoryByStoryType(storyType)
  end
  return nil
end

function DiscoveryData:GetChapterByStageId(stageId)
  if stageId == 0 then
    return self:Get1stChapter()
  end
  for _, chapter in pairs(self.chapters) do
    for _, node in ipairs(chapter.nodes) do
      for _, stage in ipairs(node.stages) do
        if stage.id == stageId then
          return chapter
        end
      end
    end
  end
end

function DiscoveryData:Get1stChapter()
  for k, v in pairs(self.chapters) do
    return v
  end
end

function DiscoveryData:GetLastChapter()
  local last
  local chapters = self:GetChapters()
  for k, v in pairs(chapters) do
    last = v
  end
  return last
end

function DiscoveryData:GetChapterByChapterId(chapterId)
  return self.chapters[chapterId]
end

function DiscoveryData:GetCanPlayChapterNode()
  local chapters = self:GetChapters()
  for _, chapter in pairs(chapters) do
    local node = chapter:Get1stCanPlayNode()
    if node then
      return chapter, node
    end
  end
end

function DiscoveryData:GetCanPlayNode()
  local nodeT
  local chapters = self:GetChapters()
  for _, chapter in pairs(chapters) do
    for _, node in ipairs(chapter.nodes) do
      if node:State() then
        nodeT = node
      end
    end
  end
  return nodeT
end

function DiscoveryData:GetCurPosNode()
  if self._curPosNodeId == 0 then
    local fstChapter = self:Get1stChapter()
    local fstNode = fstChapter:Get1stNode()
    return fstNode
  end
  if self._curPosNodeId < 0 then
    self._curPosNodeId = 0
    return self:GetCurPosNode()
  end
  local node = self:GetNodeDataByNodeId(self._curPosNodeId)
  return node
end

function DiscoveryData:SetCurPosNodeId(nodeId)
  if nodeId < 0 then
    return
  end
  self._curPosNodeId = nodeId
end

function DiscoveryData:GetCurPosChapter()
  local node = self:GetCurPosNode()
  if node then
    return node:GetChapter()
  end
end

function DiscoveryData:FirstFinishMissionID(missionid)
  self.firstMissionID = missionid
end

function DiscoveryData:UpdatePosByEnter(enterFlag, param)
  if enterFlag == 1 then
    local canPlayChapter, canPlayNode = self:GetCanPlayChapterNode()
    if canPlayChapter and canPlayNode then
      self:SetCurPosNodeId(canPlayNode.id)
    else
      local module = GameGlobal.GetModule(MissionModule)
      local stageId = module:GetCurMissionID()
      local chapter = self:GetChapterByStageId(stageId)
      if not chapter or not chapter:State() then
        chapter = self:GetLastChapter()
      end
      local fstNode = chapter:Get1stNode()
      self:SetCurPosNodeId(fstNode.id)
    end
  elseif enterFlag == 2 then
    local chapterId = param
    local chapter = self:GetChapterByChapterId(chapterId)
    local node = chapter:Get1stCanPlayNode()
    if node then
      self:SetCurPosNodeId(node.id)
    else
      local fstNode = chapter:Get1stNode()
      self:SetCurPosNodeId(fstNode.id)
    end
  elseif enterFlag == 3 then
    local stageId = param
    local node = self:GetNodeDataByStageId(stageId)
    self:SetCurPosNodeId(node.id)
    self.showUIStage = true
  elseif enterFlag == 4 then
    local canPlayChapter, canPlayNode = self:GetCanPlayChapterNode()
    if canPlayChapter and canPlayNode then
      local fstNode = canPlayChapter:Get1stNode()
      if fstNode.id == canPlayNode.id and canPlayNode:IsFirstShow() then
        self:SetCurPosNodeId(canPlayNode.id)
      end
    end
  elseif enterFlag == 5 then
    local stageId = param
    local node = self:GetNodeDataByStageId(stageId)
    self:SetCurPosNodeId(node.id)
  elseif enterFlag == 6 then
    local stageId = param
    local node = self:GetCanMoveNodeDataByStageId(stageId)
    self:SetCurPosNodeId(node.id)
    self.showUIStage = true
  elseif enterFlag == 7 then
    local stageId = param
    local grassData = GameGlobal.GetModule(CampaignModule):GetGraveRobberData()
    if stageId then
      local nodeGrass = grassData:GetNodeByStageId(stageId)
      local chapter = self:GetChapterByChapterId(nodeGrass.chapterId)
      local node = chapter:Get1stNode()
      self:SetCurPosNodeId(node.id)
      grassData:SaveGrassNodeFirst(nodeGrass)
    else
      local canPlayGrassNode = grassData:GetCanPlayNode()
      local chapter = self:GetChapterByChapterId(canPlayGrassNode.chapterId)
      local canPlayMainNode = chapter:Get1stNode()
      self:SetCurPosNodeId(canPlayMainNode.id)
      grassData:SaveGrassNodeFirst(canPlayGrassNode)
    end
  elseif enterFlag == 8 then
    self._isDiff = true
    local uiDiffModule = GameGlobal.GetUIModule(DifficultyMissionModule)
    uiDiffModule:SetMoveNodePos(param)
  elseif enterFlag == 9 then
    self._showDiffStage = true
    self._showNodeID = param
    self._isDiff = true
    local uiDiffModule = GameGlobal.GetUIModule(DifficultyMissionModule)
    uiDiffModule:SetMoveNodePos(param)
  end
end

function DiscoveryData:GetDiffNodeInfo()
  if self._isDiff then
    self._isDiff = false
    return true
  end
  return false
end

function DiscoveryData.EnterStateUIDiscovery(enterFlag, param)
  local module = GameGlobal.GetModule(MissionModule)
  local data = module:GetDiscoveryData()
  data:UpdatePosByEnter(enterFlag, param)
  GameGlobal.UIStateManager():ShowDialog("UIDiscovery")
end

function DiscoveryData:IsChapterReachUnlockTime(chapterId)
  local chapter = self:GetChapterByChapterId(chapterId)
  local isUnlock = chapter:IsReachUnlockTime()
  return isUnlock
end

function DiscoveryData:GetDiscoverySectionBySectionId(sectionId)
  for _, section in pairs(self.sections) do
    if sectionId == section.id then
      return section
    end
  end
end

function DiscoveryData:GetDiscoverySectionByChapterId(chapterId)
  for _, section in pairs(self.sections) do
    for cId, b in pairs(section.chapterIds) do
      if chapterId == cId then
        return section
      end
    end
  end
end

function DiscoveryData:GetDiscoveryLastSection()
  local len = table.count(self.sections)
  local last = self.sections[len]
  return last
end

_class("DiscoverySection", Object)
DiscoverySection = DiscoverySection

function DiscoverySection:Constructor()
  self.id = 0
  self.index_name = ""
  self.name = ""
  self.chapterIds = {}
  self.isBetween = false
  self.icon = ""
  self.data = GameGlobal.GetModule(MissionModule):GetDiscoveryData()
end

function DiscoverySection:State()
  local completeCount = 0
  for chapterId, b in pairs(self.chapterIds) do
    local chapter = self.data:GetChapterByChapterId(chapterId)
    if chapter then
      local state = chapter:State()
      if state == DiscoveryStageState.CanPlay then
        return DiscoveryStageState.CanPlay, chapterId
      elseif state == DiscoveryStageState.Nomal then
        completeCount = completeCount + 1
      end
    end
  end
  if completeCount == table.count(self.chapterIds) then
    return DiscoveryStageState.Nomal
  end
  return nil
end

function DiscoverySection:CanCollect()
  local chapterAwardData = self.data.chapterAwardData
  local red = chapterAwardData:ChapterListCanCollect(self.chapterIds)
  return red
end

_class("DiscoveryChapter", Object)
DiscoveryChapter = DiscoveryChapter

function DiscoveryChapter:Constructor()
  self.id = 0
  self.index_name = ""
  self.index_name_en = ""
  self.name = ""
  self.name_en = ""
  self.nodes = {}
  self.lines = {}
end

function DiscoveryChapter:Init(id)
  self.id = id
  self.index_name = StringTable.Get("str_chapter_idx_" .. id)
  self.index_name_en = StringTable.Get("str_chapter_idx_" .. id .. "_en")
  self.name = StringTable.Get("str_chapter_" .. id)
  self.name_en = StringTable.Get("str_chapter_" .. id .. "_en")
end

function DiscoveryChapter:UpdateState()
  for _, node in ipairs(self.nodes) do
    node:UpdateState()
  end
end

function DiscoveryChapter:IsComplete()
  local totalCount = 0
  local passCount = 0
  for _, node in ipairs(self.nodes) do
    if node.type == DiscoveryNodeType.Main then
      totalCount = totalCount + 1
      if node:State() == DiscoveryStageState.Nomal then
        passCount = passCount + 1
      end
    end
  end
  return totalCount == passCount
end

function DiscoveryChapter:IsThreeComplete()
  local three = true
  for _, node in ipairs(self.nodes) do
    if node.type == DiscoveryNodeType.Main or node.type == DiscoveryNodeType.Branch then
      local stages = node.stages
      if next(stages) then
        for i = 1, #stages do
          local stage = stages[i]
          if stage.type ~= DiscoveryStageType.Plot and not stage:HasPassThreeStar() then
            three = false
            return three
          end
        end
      end
    end
  end
  return three
end

function DiscoveryChapter:Get1stNode()
  for _, node in ipairs(self.nodes) do
    if node.idx == 1 then
      return node
    end
  end
end

function DiscoveryChapter:Get1stStage()
  local node = self:Get1stNode()
  if node then
    for _, stage in ipairs(node.stages) do
      return stage
    end
  end
end

function DiscoveryChapter:Get1stCanPlayNode()
  for _, node in ipairs(self.nodes) do
    if node.type == DiscoveryNodeType.Main and node:State() == DiscoveryStageState.CanPlay then
      return node
    end
  end
end

function DiscoveryChapter:State()
  if self:IsReachUnlockTime() then
    local completeCount = 0
    for _, node in ipairs(self.nodes) do
      local state = node:State()
      if state == DiscoveryStageState.CanPlay then
        return DiscoveryStageState.CanPlay
      elseif state == DiscoveryStageState.Nomal then
        completeCount = completeCount + 1
      end
    end
    if completeCount == table.count(self.nodes) then
      return DiscoveryStageState.Nomal
    end
  end
  return nil
end

function DiscoveryChapter:PrevNode(nodeId)
  local prevStageId = 0
  local node = self:GetNodeByNodeId(nodeId)
  if node then
    local fstNode = self:Get1stNode()
    if fstNode.id == node.id then
      return nil
    end
    for istage, vstage in ipairs(node.stages) do
      prevStageId = tonumber(vstage.prevStageId[1])
      break
    end
  end
  local data = self:GetDiscoveryData()
  local node = data:GetNodeDataByStageId(prevStageId)
  return node
end

function DiscoveryChapter:GetDiscoveryData()
  local module = GameGlobal.GetModule(MissionModule)
  return module:GetDiscoveryData()
end

function DiscoveryChapter:GetNodeByNodeId(nodeId)
  for _, node in ipairs(self.nodes) do
    if node.id == nodeId then
      return node
    end
  end
end

function DiscoveryChapter:GetSectionId()
  local stage = self:Get1stStage()
  return stage.sectionId
end

function DiscoveryChapter:IsReachUnlockTime()
  local cfg = Cfg.cfg_global.ui_chapter_unlock_time.TableValue
  if not cfg then
    return false
  end
  local unlockTimestamp = cfg[self.id] or 0
  local nowTimestamp = UICommonHelper.GetNowTimestamp()
  local isUnlock = unlockTimestamp < nowTimestamp
  return isUnlock
end

_class("DiscoveryNode", Object)
DiscoveryNode = DiscoveryNode

function DiscoveryNode:Constructor()
  self.id = 0
  self.idx = 0
  self.fullIdx = 0
  self.name = ""
  self.monstercg = ""
  self.pos = Vector2.zero
  self.stages = {}
  self.type = DiscoveryNodeType.Main
  self._missionModule = GameGlobal.GetModule(MissionModule)
end

function DiscoveryNode:Init(id, nodeV, type)
  if not nodeV then
    Log.fatal("### no waypoint in cfg_discovery. WayPointID=", id)
  end
  self.id = id
  self.pos.x = nodeV.pos.x
  self.pos.y = nodeV.pos.y
  local cfgv = Cfg.cfg_waypoint[id]
  if cfgv then
    self.monstercg = cfgv.MonsterCG
    self.name = StringTable.Get(cfgv.Name)
  end
  if type == 1 then
    self.type = DiscoveryNodeType.Main
  elseif type == 2 then
    self.type = DiscoveryNodeType.Branch
  end
end

function DiscoveryNode:UpdateState()
  for i, v in ipairs(self.stages) do
    local passStage = self._missionModule:GetPassMissionById(v.id)
    local canActiveSatge = self._missionModule:GetCanActiveMissionById(v.id)
    if passStage then
      local starCount, completeStarList = self._missionModule:ParseStarInfo(passStage.star)
      v:UpdateStar(starCount)
      v:UpdateCondition(completeStarList)
      v:UpdateState(DiscoveryStageState.Nomal)
    end
    if canActiveSatge then
      v:UpdateStar(0)
      v:UpdateState(DiscoveryStageState.CanPlay)
    end
  end
  if self.id then
    Log.debug("###[DiscoveryNode] UpdateState pass mission id : ", self.id)
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.DiscoveryNodeStateChange, self.id)
end

function DiscoveryNode:State()
  if self.stages then
    local passCount = 0
    local canActiveCount = 0
    for i, v in ipairs(self.stages) do
      if v.state == DiscoveryStageState.Nomal then
        passCount = passCount + 1
      elseif v.state == DiscoveryStageState.CanPlay then
        canActiveCount = canActiveCount + 1
      end
    end
    if 0 < passCount then
      return DiscoveryStageState.Nomal
    end
    if 0 < canActiveCount then
      return DiscoveryStageState.CanPlay
    end
  end
  return nil
end

function DiscoveryNode:LevelReach()
  if GameSingle then
    return true
  end
  for i, v in ipairs(self.stages) do
    return v:LevelReach()
  end
end

function DiscoveryNode:GetStageType()
  for i, v in ipairs(self.stages) do
    return v.type
  end
end

function DiscoveryNode:GetCanPlayStages()
  local stages = {}
  for i, v in ipairs(self.stages) do
    if v.state then
      table.insert(stages, v)
    end
  end
  return stages
end

function DiscoveryNode:GetStageById(stageId)
  if self.stages and #self.stages > 0 then
    for i, v in ipairs(self.stages) do
      if v.id == stageId then
        return v
      end
    end
  end
  return nil
end

function DiscoveryNode:IsFirstShow()
  local playerPrefsKey = self:GetFirstShowKey()
  local isFirst = UnityEngine.PlayerPrefs.GetInt(playerPrefsKey, 0)
  return isFirst == 0
end

function DiscoveryNode:SaveIsFirstShow()
  local playerPrefsKey = self:GetFirstShowKey()
  UnityEngine.PlayerPrefs.SetInt(playerPrefsKey, 1)
end

function DiscoveryNode:GetFirstShowKey()
  local playerPrefsKey = self:GetPstId() .. "DiscoveryNodeIsFirstShow" .. self.id
  return playerPrefsKey
end

function DiscoveryNode:GetPstId()
  local roleModule = GameGlobal.GetModule(RoleModule)
  return roleModule:GetPstId()
end

function DiscoveryNode:GetChapter()
  if self.stages then
    for i, v in ipairs(self.stages) do
      return v:GetChapter()
    end
  end
end

local DiscoveryNodeType = {Main = 1, Branch = 2}
_enum("DiscoveryNodeType", DiscoveryNodeType)
