_class("UISeasonMazeRelicInfoController", UIController)
UISeasonMazeRelicInfoController = UISeasonMazeRelicInfoController

function UISeasonMazeRelicInfoController:OnShow(uiParam)
  self._atlas = self:GetAsset("UIMazeChoose.spriteatlas", LoadType.SpriteAtlas)
  self.ItemColorToTextColor = {
    [ItemColor.ItemColor_White] = Color(0.8117647058823529, 0.8117647058823529, 0.8117647058823529, 1),
    [ItemColor.ItemColor_Green] = Color(0.12549019607843137, 0.8470588235294118, 0.6470588235294118, 1),
    [ItemColor.ItemColor_Blue] = Color(0.21568627450980393, 0.6588235294117647, 1.0, 1),
    [ItemColor.ItemColor_Purple] = Color(0.6980392156862745, 0.5372549019607843, 0.9803921568627451, 1),
    [ItemColor.ItemColor_Yellow] = Color(1.0, 0.9529411764705882, 0.21568627450980393, 1),
    [ItemColor.ItemColor_Golden] = Color(1.0, 0.5568627450980392, 0 / 255, 1)
  }
  self._relicID = uiParam[1]
  self.my_relics = uiParam[2]
  if not self._relicID then
    Log.fatal("###error --> maze relic info controller - the uiParam is nil !")
    return
  end
  self:GetComponents()
end

function UISeasonMazeRelicInfoController:GetComponents()
  local relicPool = self:GetUIComponent("UISelectObjectPath", "relicPool")
  local item = relicPool:SpawnObject("UISeasonMazeRelicItem")
  self.seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
  self.uiSeasonMazeModule = self.seasonMazeModule:UIModule()
  item:SetData(1, self._relicID, function(tIndex)
  end, false, true, false, false, true)
  local nameTex = self:GetUIComponent("UILocalizationText", "name")
  local descTex = self:GetUIComponent("UILocalizedTMP", "desc")
  local colorBg = self:GetUIComponent("Image", "colorDown")
  self.lessUseCountRoot = self:GetGameObject("LessUseCountRoot")
  self.lessUseCountText = self:GetUIComponent("UILocalizationText", "LessUseCountText")
  self.customRoot = self:GetGameObject("CustomRoot")
  self.customSuitTitile = self:GetUIComponent("UILocalizationText", "CustomSuitTitile")
  self.customSuitTips = self:GetUIComponent("UILocalizationText", "CustomSuitTips")
  self.anim = self:GetUIComponent("Animation", "anim")
  local cfg = Cfg.cfg_item[self._relicID]
  if cfg then
    nameTex:SetText(StringTable.Get(cfg.Name))
    descTex:SetText(StringTable.Get(cfg.RpIntro))
    
    function descTex.onHrefClick(hrefName)
      GameGlobal.UIStateManager():ShowDialog("UISeasonMaze_RelicHrefInfo", hrefName)
    end
    
    colorBg.sprite = self._atlas:GetSprite("map_shengwu_xian" .. cfg.Color)
    local c = Color(1, 1, 1, 1)
    c = self.ItemColorToTextColor[cfg.Color]
    nameTex.color = c
  else
    Log.fatal("###error --> maze relic info controller - the cfg_item is nil ! id --> ", self._relicID)
  end
  local cfg_prof = Cfg.cfg_item_relic[self._relicID]
  if cfg_prof.OutGameTriggerCount > 0 then
    local useCount = 0
    useCount = self.uiSeasonMazeModule:GetSeasonMazeRelicCanUseCount(self._relicID)
    local count = useCount
    self.lessUseCountRoot:SetActive(true)
    self.lessUseCountText:SetText(StringTable.Get("str_season_maze_relic_less_count", count))
  else
    self.lessUseCountRoot:SetActive(false)
  end
  if cfg_prof.SuiteID == nil or cfg_prof.SuiteID == 0 then
    self.customRoot:SetActive(false)
  else
    self:RefreshSuit(cfg_prof.SuiteID)
  end
end

function UISeasonMazeRelicInfoController:RefreshSuit(suiteID)
  self.customRoot:SetActive(true)
  local curSuitCount = 0
  local suite_cfg = Cfg.cfg_component_season_maze_suit[suiteID]
  if suite_cfg == nil then
    self.customRoot:SetActive(false)
    return
  end
  local suits = suite_cfg.RelicList
  local suitEffect = suite_cfg.SuitEffect
  for i = 1, #suits do
    local id = suits[i]
    if table.icontains(self.my_relics, id) then
      curSuitCount = curSuitCount + 1
    end
  end
  local suitPercent = "" .. curSuitCount .. "/" .. #suits
  self.customSuitTitile:SetText(StringTable.Get(suite_cfg.Name) .. "：(" .. suitPercent .. ")")
  local tips = ""
  for j = 1, #suite_cfg.Words do
    local tip = suite_cfg.Words[j]
    local singleEff = suitEffect[j]
    if curSuitCount >= singleEff[1] then
      tips = tips .. "<color=#5bb800>" .. StringTable.Get(tip) .. "</color>" .. "\n"
    else
      tips = tips .. "<color=#808080>" .. StringTable.Get(tip) .. "</color>" .. "\n"
    end
  end
  self.customSuitTips:SetText(tips)
end

function UISeasonMazeRelicInfoController:BgOnClick()
  self.anim:Play("uieffanim_UISeasonMazeRelicInfoController_out")
  local timerEvent = GameGlobal.Timer():AddEventTimes(200, TimerTriggerCount.Once, function()
    self:CloseDialog()
  end)
end
