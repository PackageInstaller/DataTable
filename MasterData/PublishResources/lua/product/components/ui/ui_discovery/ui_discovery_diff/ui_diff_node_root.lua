_class("UIDiffNodeRoot", UICustomWidget)
UIDiffNodeRoot = UIDiffNodeRoot

function UIDiffNodeRoot:Constructor()
end

function UIDiffNodeRoot:SetData(diffChapter)
  self._chapterData = diffChapter
  self:GetComponents()
  self:OnValue()
end

function UIDiffNodeRoot:GetComponents()
  self._nodePool = self:GetUIComponent("UISelectObjectPath", "nodePool")
  self._linePool = self:GetUIComponent("UISelectObjectPath", "linePool")
  self._lineNextPool = self:GetUIComponent("UISelectObjectPath", "lineNextPool")
end

function UIDiffNodeRoot:OnValue()
  self:NodePool()
  self:Lines()
end

function UIDiffNodeRoot:Lines()
  local lineCount = #self._tab - 1
  if lineCount < 0 then
    lineCount = 0
  end
  self._linePool:SpawnObjects("UIDiffPathItem", lineCount)
  local spawnLines = self._linePool:GetAllSpawnList()
  for i = 1, #spawnLines do
    if i <= lineCount then
      local line = spawnLines[i]
      line:GetGameObject():SetActive(true)
      local node1Pos = self._tab[i]:Pos()
      local node2Pos = self._tab[i + 1]:Pos()
      line:SetData(node1Pos, node2Pos)
    else
      local line = spawnLines[i]
      line:GetGameObject():SetActive(false)
    end
  end
end

function UIDiffNodeRoot:NodePool()
  local uiModule = GameGlobal.GetUIModule(DifficultyMissionModule)
  local node = self._nodePool:SpawnObject("UIDiffNodePool")
  local nodes = self._chapterData:Nodes()
  self._tab = {}
  for i = 1, #nodes do
    local id = nodes[i]
    local node = uiModule:GetNode(id)
    if node:Lock() == DiffMissionNodeStatus.Open then
      table.insert(self._tab, node)
    else
      break
    end
  end
  local chapterid = self._chapterData:ID()
  local allPass = uiModule:AllPass(chapterid)
  if allPass then
    local cfg = Cfg.cfg_difficulty_mission_chapter_desc[chapterid]
    local nextChapter = cfg.NextChapter
    local node = DiffMissionNode:New(nil, chapterid, nextChapter, nil, true)
    table.insert(self._tab, node)
  end
  node:SetData(self._tab, self._chapterData)
end
