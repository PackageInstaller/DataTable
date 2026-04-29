_class("UIDiffNodePool", UICustomWidget)
UIDiffNodePool = UIDiffNodePool

function UIDiffNodePool:Constructor()
  self.mMission = self:GetModule(MissionModule)
  self.data = self.mMission:GetDiscoveryData()
end

function UIDiffNodePool:OnShow()
  self.chapter = self:GetGameObject("chapter")
  self.section = self:GetGameObject("section")
  self._normalNodesPool = self:GetUIComponent("UISelectObjectPath", "Normal")
  self._bossNodesPool = self:GetUIComponent("UISelectObjectPath", "Boss")
  self._plotNodesPool = self:GetUIComponent("UISelectObjectPath", "Plot")
  self._notReachNodesPool = self:GetUIComponent("UISelectObjectPath", "NotReach")
  self._nextChapterPool = self:GetUIComponent("UISelectObjectPath", "NextChapter")
  self.nSectionPool = self:GetUIComponent("UISelectObjectPath", "nSection")
  self.GrassPool = self:GetUIComponent("UISelectObjectPath", "Grass")
end

function UIDiffNodePool:SetData(nodes, chapter)
  self._chapter = chapter
  local plot = {}
  local norm = {}
  local boss = {}
  local next = {}
  for i = 1, #nodes do
    local node = nodes[i]
    if node:Next() then
      table.insert(next, node)
    elseif node:Type() == 1 then
      table.insert(norm, node)
    elseif node:Type() == 2 then
      table.insert(boss, node)
    end
  end
  self._normalNodesPool:SpawnObjects("UIDiffNodeNorm", #norm)
  self._bossNodesPool:SpawnObjects("UIDiffNodeBoss", #boss)
  self._plotNodesPool:SpawnObjects("UIDiffNodePlot", #plot)
  self._nextChapterPool:SpawnObjects("UIDiffNodeNext", #next)
  local normalNodes = self._normalNodesPool:GetAllSpawnList()
  local bossNodes = self._bossNodesPool:GetAllSpawnList()
  local plotNodes = self._plotNodesPool:GetAllSpawnList()
  local nextNodes = self._nextChapterPool:GetAllSpawnList()
  for i = 1, #normalNodes do
    local item = normalNodes[i]
    local data = norm[i]
    item:SetData(data, function(node)
      self:NodeItemClick(node)
    end)
  end
  for i = 1, #bossNodes do
    local item = bossNodes[i]
    local data = boss[i]
    item:SetData(data, function(node)
      self:NodeItemClick(node)
    end)
  end
  for i = 1, #plotNodes do
    local item = plotNodes[i]
    local data = plot[i]
    item:SetData(data, function(node)
      self:NodeItemClick(node)
    end)
  end
  for i = 1, #nextNodes do
    local item = nextNodes[i]
    local data = next[i]
    item:SetData(data, function(node)
      self:NodeItemClick(node)
    end)
  end
end

function UIDiffNodePool:NodeItemClick(node)
  local pos = node:Pos()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.DiscoveryCameraMove, pos, -1, false, function()
    if node:Next() then
      local uiModule = GameGlobal.GetUIModule(DifficultyMissionModule)
      local diffCid = node:ChapterID()
      local nextChapterID = uiModule:GetNextChapterID(diffCid)
      if nextChapterID then
        local nextChapter = uiModule:GetChapterData(nextChapterID)
        if nextChapter then
          local missionid = nextChapter:MissionChapterID()
          local missionModule = self:GetModule(MissionModule)
          local data = missionModule:GetDiscoveryData()
          local c = data:GetChapterByChapterId(missionid)
          local complete = c:IsThreeComplete()
          if not complete then
            local missionChapterName = c.name
            local tips = StringTable.Get("str_diff_mission_main_chapter_lock", missionChapterName)
            ToastManager.ShowToast(tips)
            return
          end
          if nextChapter:Lock() == DiffMissionChapterStatus.Lock then
            local diffChapterName = StringTable.Get(nextChapter:Name())
            local tips = StringTable.Get("str_diff_mission_diff_chapter_lock", diffChapterName)
            ToastManager.ShowToast(tips)
            return
          end
        end
        uiModule:JumpNextChapter(nextChapterID)
      end
    elseif node:Type() == 1 then
      self:ShowDialog("UIDiffStage", self._chapter, node)
    elseif node:Type() == 2 then
      self:ShowDialog("UIDiffStage", self._chapter, node)
    end
  end)
end

function UIDiffNodePool:OnHide()
end
