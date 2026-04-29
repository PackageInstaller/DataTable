_class("UIDiscoveryNodePool", UICustomWidget)
UIDiscoveryNodePool = UIDiscoveryNodePool

function UIDiscoveryNodePool:Constructor()
  self.mMission = self:GetModule(MissionModule)
  self.data = self.mMission:GetDiscoveryData()
end

function UIDiscoveryNodePool:OnShow()
  self.chapter = self:GetGameObject("chapter")
  self.section = self:GetGameObject("section")
  self._normalNodesPool = self:GetUIComponent("UISelectObjectPath", "Normal")
  self._bossNodesPool = self:GetUIComponent("UISelectObjectPath", "Boss")
  self._plotNodesPool = self:GetUIComponent("UISelectObjectPath", "Plot")
  self._notReachNodesPool = self:GetUIComponent("UISelectObjectPath", "NotReach")
  self._nextChapterPool = self:GetUIComponent("UISelectObjectPath", "NextChapter")
  self.sectionNormal = self:GetUIComponent("UISelectObjectPath", "sectionNormal")
  self.sectionBoss = self:GetUIComponent("UISelectObjectPath", "sectionBoss")
  self.sectionPlot = self:GetUIComponent("UISelectObjectPath", "sectionPlot")
  self.sectionNotReach = self:GetUIComponent("UISelectObjectPath", "sectionNotReach")
  self.sectionNextChapter = self:GetUIComponent("UISelectObjectPath", "sectionNextChapter")
  self.GrassPool = self:GetUIComponent("UISelectObjectPath", "Grass")
end

function UIDiscoveryNodePool:OnHide()
end

function UIDiscoveryNodePool:Init(uiDiscovery)
  self.uiDiscovery = uiDiscovery
end

function UIDiscoveryNodePool:Flush(chapterId)
  self.chapterId = chapterId
  local section = self.data:GetDiscoverySectionByChapterId(chapterId)
  if section.isBetween then
    self.chapter:SetActive(false)
    self.section:SetActive(true)
    self:FlushSectionNodes()
  else
    self.chapter:SetActive(true)
    self.section:SetActive(false)
    self:FlushNodes()
  end
  self:FlushGrassNodes()
end

function UIDiscoveryNodePool:FlushSectionNodes()
  if not self.data then
    return
  end
  local chapter = self.data:GetChapterByChapterId(self.chapterId)
  if not chapter then
    return
  end
  local normalNodeCount, bossNodeCount, plotNodeCount, notReachNodeCount = 0, 0, 0, 0
  local normalNodeIndex, bossNodeIndex, plotNodeIndex, notReachNodeIndex = 1, 1, 1, 1
  for i, node in ipairs(chapter.nodes) do
    if not node.stages[1]:LevelReach() then
      notReachNodeCount = notReachNodeCount + 1
    elseif node:GetStageType() == DiscoveryStageType.FightNormal then
      normalNodeCount = normalNodeCount + 1
    elseif node:GetStageType() == DiscoveryStageType.FightBoss then
      bossNodeCount = bossNodeCount + 1
    else
      plotNodeCount = plotNodeCount + 1
    end
  end
  self.sectionNormal:SpawnObjects("UIMapNodeNormalPart", normalNodeCount)
  self.sectionBoss:SpawnObjects("UIMapNodeBossPart", bossNodeCount)
  self.sectionPlot:SpawnObjects("UIMapNodePlotPart", plotNodeCount)
  self.sectionNotReach:SpawnObjects("UIMapNodeNotReachPart", notReachNodeCount)
  local normalNodes = self.sectionNormal:GetAllSpawnList()
  local bossNodes = self.sectionBoss:GetAllSpawnList()
  local plotNodes = self.sectionPlot:GetAllSpawnList()
  local notReachNodes = self.sectionNotReach:GetAllSpawnList()
  self.uiDiscovery._uiMapNodes = {}
  for i, node in ipairs(chapter.nodes) do
    local uiNode
    if not node.stages[1]:LevelReach() then
      uiNode = notReachNodes[notReachNodeIndex]
      notReachNodeIndex = notReachNodeIndex + 1
    elseif node:GetStageType() == DiscoveryStageType.FightNormal then
      uiNode = normalNodes[normalNodeIndex]
      normalNodeIndex = normalNodeIndex + 1
    elseif node:GetStageType() == DiscoveryStageType.FightBoss then
      uiNode = bossNodes[bossNodeIndex]
      bossNodeIndex = bossNodeIndex + 1
    else
      uiNode = plotNodes[plotNodeIndex]
      plotNodeIndex = plotNodeIndex + 1
    end
    uiNode:Init(node, self.data.showUIStage)
    uiNode:Flush()
    self.uiDiscovery._uiMapNodes[#self.uiDiscovery._uiMapNodes + 1] = uiNode
  end
end

function UIDiscoveryNodePool:FlushNodes()
  if not self.data then
    return
  end
  local chapter = self.data:GetChapterByChapterId(self.chapterId)
  if not chapter then
    return
  end
  local normalNodeCount, bossNodeCount, plotNodeCount, notReachNodeCount = 0, 0, 0, 0
  local normalNodeIndex, bossNodeIndex, plotNodeIndex, notReachNodeIndex = 1, 1, 1, 1
  for i, node in ipairs(chapter.nodes) do
    if not node.stages[1]:LevelReach() then
      notReachNodeCount = notReachNodeCount + 1
    elseif node:GetStageType() == DiscoveryStageType.FightNormal then
      normalNodeCount = normalNodeCount + 1
    elseif node:GetStageType() == DiscoveryStageType.FightBoss then
      bossNodeCount = bossNodeCount + 1
    else
      plotNodeCount = plotNodeCount + 1
    end
  end
  self._normalNodesPool:SpawnObjects("UIMapNodeItemNormal", normalNodeCount)
  self._bossNodesPool:SpawnObjects("UIMapNodeItemBoss", bossNodeCount)
  self._plotNodesPool:SpawnObjects("UIMapNodeItemPlot", plotNodeCount)
  self._notReachNodesPool:SpawnObjects("UIMapNodeItemNotReach", notReachNodeCount)
  local normalNodes = self._normalNodesPool:GetAllSpawnList()
  local bossNodes = self._bossNodesPool:GetAllSpawnList()
  local plotNodes = self._plotNodesPool:GetAllSpawnList()
  local notReachNodes = self._notReachNodesPool:GetAllSpawnList()
  self.uiDiscovery._uiMapNodes = {}
  for i, node in ipairs(chapter.nodes) do
    local uiNode
    if not node.stages[1]:LevelReach() then
      uiNode = notReachNodes[notReachNodeIndex]
      notReachNodeIndex = notReachNodeIndex + 1
    elseif node:GetStageType() == DiscoveryStageType.FightNormal then
      uiNode = normalNodes[normalNodeIndex]
      normalNodeIndex = normalNodeIndex + 1
    elseif node:GetStageType() == DiscoveryStageType.FightBoss then
      uiNode = bossNodes[bossNodeIndex]
      bossNodeIndex = bossNodeIndex + 1
    else
      uiNode = plotNodes[plotNodeIndex]
      plotNodeIndex = plotNodeIndex + 1
    end
    uiNode:Init(node, self.data.showUIStage)
    uiNode:Flush()
    self.uiDiscovery._uiMapNodes[#self.uiDiscovery._uiMapNodes + 1] = uiNode
  end
end

function UIDiscoveryNodePool:FlushNextChapter()
  local section = self.data:GetDiscoverySectionByChapterId(self.chapterId)
  if section.isBetween then
    self:FlushNSectionNextChapter()
  else
    self:FlushNormalNextChaper()
  end
end

function UIDiscoveryNodePool:FlushNSectionNextChapter()
  local curChapter = self.data:GetCurPosChapter()
  local nextChapterData = self.data.next_chapter[curChapter.id]
  local linesNextPool = self.uiDiscovery._linesNextPool
  if nextChapterData then
    self.sectionNextChapter:SpawnObjects("UIMapNodeNextPart", 1)
    local nextChapter = self.sectionNextChapter:GetAllSpawnList()[1]
    if nextChapter then
      nextChapter:Init(nextChapterData, self.data.showUIStage)
      nextChapter:Flush()
    end
    linesNextPool:SpawnObjects("UIMapPathNextChapterItem", 1)
    local spawnLine = linesNextPool:GetAllSpawnList()[1]
    local lastNode = self.data:GetNodeDataByNodeId(nextChapterData.lastNodeId)
    if lastNode then
      spawnLine:Flush(lastNode.pos, nextChapterData.pos, nextChapterData, false)
    end
  else
    self.sectionNextChapter:SpawnObjects("UIMapNodeNextPart", 0)
    linesNextPool:SpawnObjects("UIMapPathNextChapterItem", 0)
  end
end

function UIDiscoveryNodePool:FlushNormalNextChaper()
  local curChapter = self.data:GetCurPosChapter()
  local nextChapterData = self.data.next_chapter[curChapter.id]
  local linesNextPool = self.uiDiscovery._linesNextPool
  if nextChapterData and not EngineGameHelper.EnableAppleVerifyBulletin() then
    self._nextChapterPool:SpawnObjects("UIMapNodeItemNextChapter", 1)
    local nextChapter = self._nextChapterPool:GetAllSpawnList()[1]
    if nextChapter then
      nextChapter:Init(nextChapterData, self.data.showUIStage)
      nextChapter:Flush()
    end
    linesNextPool:SpawnObjects("UIMapPathNextChapterItem", 1)
    local spawnLine = linesNextPool:GetAllSpawnList()[1]
    local lastNode = self.data:GetNodeDataByNodeId(nextChapterData.lastNodeId)
    if lastNode then
      spawnLine:Flush(lastNode.pos, nextChapterData.pos, nextChapterData, false)
    end
  else
    self._nextChapterPool:SpawnObjects("UIMapNodeItemNextChapter", 0)
    linesNextPool:SpawnObjects("UIMapPathNextChapterItem", 0)
  end
end

function UIDiscoveryNodePool:FlushGrassNodes()
  local grassData = self:GetModule(CampaignModule):GetGraveRobberData()
  if not grassData then
    return
  end
  if not grassData:IsOpenGraveRobber() then
    return
  end
  local chapter = grassData:GetChapterByChapterId(self._chapterId)
  if not chapter then
    return
  end
  local len = table.count(chapter.nodes)
  self.GrassPool:SpawnObjects("UIMapNodeItemGraveRobber", len)
  local uiNodes = self.GrassPool:GetAllSpawnList()
  for i, node in ipairs(chapter.nodes) do
    uiNodes[i]:Flush(node, function()
      local c = self.grassData:GetComponentGrassMission()
      local cInfo = self.grassData:GetComponentInfoGrassMission()
      self._scale = 1.2
      self:ShotGrass(node.pos)
      self:ShowDialog("UIActivityStage", node.stageId, cInfo.m_pass_mission_info[node.stageId], c, self._rt, self._offset * self._scale, self._width, self._height, self._scale, false)
    end)
  end
end

function UIDiscovery:ShotGrass(nodePos)
  local transformScale = 1
  self._shot.OwnerCamera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
  local shotRect = self:GetUIComponent("RectTransform", "screenShot")
  self._width = shotRect.rect.width
  self._height = shotRect.rect.height
  local AnchorLeftTop = self:GetGameObject("AnchorLeftTop")
  local AnchorTop = self:GetGameObject("AnchorTop")
  local AnchorBottom = self:GetGameObject("AnchorBottom")
  AnchorLeftTop:SetActive(false)
  AnchorTop:SetActive(false)
  AnchorBottom:SetActive(false)
  self._shot.width = self._width
  self._shot.height = self._height
  self._shot.blurTimes = 0
  local svCloud = self:GetGameObject("svCloud")
  svCloud:SetActive(false)
  local oriScale = self._content.localScale.x
  self._content.localScale = Vector3.one * transformScale
  local oriScale2 = self._ignLayout.localScale.x
  self._ignLayout.localScale = Vector3.one * transformScale
  self._shot:CleanRenderTexture()
  self._rt = self._shot:RefreshBlurTexture()
  AnchorLeftTop:SetActive(true)
  AnchorTop:SetActive(true)
  AnchorBottom:SetActive(true)
  svCloud:SetActive(true)
  local iPos = self._ignLayout.anchoredPosition
  self._offset = Vector2(-(nodePos.x + iPos.x), -(nodePos.y + iPos.y))
  self._ignLayout.localScale = Vector3.one * oriScale2
  self._content.localScale = Vector3.one * oriScale
end
