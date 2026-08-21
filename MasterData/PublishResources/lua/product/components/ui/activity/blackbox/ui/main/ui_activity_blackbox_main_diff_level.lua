require("ui_activity_diff_level")
_class("UIActivityBlackBoxMainDiffLevel", UIActivityDiffLevel)
UIActivityBlackBoxMainDiffLevel = UIActivityBlackBoxMainDiffLevel

function UIActivityBlackBoxMainDiffLevel:OnInit()
  self._contentRect = self._controller:GetUIComponent("RectTransform", "Content")
  self._linesPool = self._controller:GetUIComponent("UISelectObjectPath", "Lines")
  self._selectNode = nil
  self._linesRect = self._controller:GetUIComponent("RectTransform", "Lines")
  self._nodesRect = self._controller:GetUIComponent("RectTransform", "DiffNodes")
  self._screenWidth = ResolutionManager.ScreenWidth()
  self._screenHeight = ResolutionManager.ScreenHeight()
  self._campaign = self._controller:GetCampaign()
end

function UIActivityBlackBoxMainDiffLevel:GetTimeDownString()
  return "str_n27_level_remain_time_tips"
end

function UIActivityBlackBoxMainDiffLevel:NodePlayAnimationInterval(TT)
  YIELD(TT, 30)
end

function UIActivityBlackBoxMainDiffLevel:CreateItems(TT)
  self._controller:Lock("UIActivityN27DiffLevel_CreateItems")
  local extra_width = 249
  local right = 0
  local lineCfgs = Cfg.cfg_blackbox_line({
    ComponentID = self._blackHardComponent:GetComponentCfgId()
  })
  self._nodesPool:SpawnObjects("UIActivityBlackBoxMainDiffLevelNode", #self._levelDatas)
  self._linesPool:SpawnObjects("UIActivityBlackBoxMainDiffLevelLine", #lineCfgs)
  local lines = self._linesPool:GetAllSpawnList()
  self._nodes = self._nodesPool:GetAllSpawnList()
  for i = 1, #self._nodes do
    local pos = self._levelDatas[i]:GetPosition()
    right = right > pos.x and right or pos.x
    self._nodes[i]:SetData(self._levelDatas[i], self._campaign, function(data, node)
      if self._selectNode then
        self._selectNode:SetSelect(false)
      end
      self._selectNode = node
      self._selectNode:SetSelect(true)
      GameGlobal.TaskManager():StartTask(function(TT)
        YIELD(TT, 200)
        self:OnNodeClick(data)
      end, self)
    end)
  end
  for i = 1, #lines do
    local cfg = lineCfgs[i]
    lines[i]:Flush(cfg)
  end
  self:NodePlayAnimationInterval(TT)
  local width = right + extra_width
  local ratio = self._screenWidth / self._screenHeight
  if 1.8 < ratio then
    local dis = (ratio - 1.8) * 500
    self._linesRect.anchoredPosition = Vector2(dis, 0)
    self._nodesRect.anchoredPosition = Vector2(dis, 0)
  end
  self._contentRect.sizeDelta = Vector2(width, self._contentRect.sizeDelta.y)
  self._controller:UnLock("UIActivityN27DiffLevel_CreateItems")
end

function UIActivityBlackBoxMainDiffLevel:GetIntroName()
  return "UIN29DiffLevelIntro"
end

function UIActivityBlackBoxMainDiffLevel:OpenLevel(createInfo)
  for _, v in pairs(self._nodes) do
    if v:GetDiffLevelID() == createInfo.nCampaignMissionId then
      v:BtnOnClick()
    end
  end
end
