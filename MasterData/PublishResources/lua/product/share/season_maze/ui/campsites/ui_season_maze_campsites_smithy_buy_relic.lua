_class("UISeasonMaze_Campsites_SmithyBuyRelic", UIController)
UISeasonMaze_Campsites_SmithyBuyRelic = UISeasonMaze_Campsites_SmithyBuyRelic

function UISeasonMaze_Campsites_SmithyBuyRelic:InitWidget()
  self._Icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._PriceText = self:GetUIComponent("UILocalizationText", "PriceText")
  self._DescTitleText = self:GetUIComponent("UILocalizationText", "DescTitleText")
  self._Content = self:GetUIComponent("UILocalizationText", "Content")
  self._DescText = self:GetUIComponent("UILocalizedTMP", "DescText")
  
  function self._DescText.onHrefClick(hrefName)
    GameGlobal.UIStateManager():ShowDialog("UISeasonMaze_RelicHrefInfo", hrefName)
  end
  
  self._CustomSuitTips = self:GetUIComponent("UILocalizationText", "CustomSuitTips")
  self._SuitAreaGo = self:GetGameObject("SuitArea")
  self._SuitAreaGo:SetActive(false)
  self._CustomSuitTitle = self:GetUIComponent("UILocalizationText", "CustomSuitTitle")
  self._RelicItemGen = self:GetUIComponent("UISelectObjectPath", "RelicItem")
end

function UISeasonMaze_Campsites_SmithyBuyRelic:OnShow(uiParams)
  self:InitWidget()
  self._uiData = uiParams[1]
  self._com = uiParams[2]
  self._callback = uiParams[3]
  self.uiSeasonMazeModule = GameGlobal.GetUIModule(SeasonMazeModule)
  self.mazeRelics = self.uiSeasonMazeModule:GetSeasonMazeRelics()
  if self.mazeRelics then
    local relics = {}
    for key, value in pairs(self.mazeRelics) do
      relics[#relics + 1] = key
    end
    self.my_relics = relics
  end
  self:RefreshUI()
end

function UISeasonMaze_Campsites_SmithyBuyRelic:RefreshUI()
  local itemId = self._uiData._slotData.item.id
  local cfg = Cfg.cfg_item[itemId]
  if cfg then
    self._DescText:SetText(StringTable.Get(cfg.RpIntro))
  else
    Log.fatal("###error --> maze relic info controller - the cfg_item is nil ! id --> ", self._relicID)
  end
  local price = self._uiData._slotData.price
  local priceStr = tostring(price)
  local curGold = self._com:GetAttrValue(SeasonMazeAttrType.SMAT_Gold)
  if price > curGold then
    priceStr = "<color=#c97d7d>" .. priceStr .. "</color>"
  end
  self._PriceText:SetText(priceStr)
  self:GenRelicItem()
  self:CheckSuitArea()
end

function UISeasonMaze_Campsites_SmithyBuyRelic:GenRelicItem()
  local itemId = self._uiData._slotData.item.id
  self._relicItem = self._RelicItemGen:SpawnObject("UISeasonMazeRelicItem")
  self._relicItem:SetData(1, itemId, function(tIndex)
  end, false, true, false, true)
end

function UISeasonMaze_Campsites_SmithyBuyRelic:CheckSuitArea()
  local itemId = self._uiData._slotData.item.id
  local cfg_prof = Cfg.cfg_item_relic[itemId]
  if cfg_prof == nil then
    return
  end
  if cfg_prof.SuiteID == nil or cfg_prof.SuiteID == 0 then
    self._SuitAreaGo:SetActive(false)
  else
    self:RefreshSuit(cfg_prof.SuiteID)
  end
end

function UISeasonMaze_Campsites_SmithyBuyRelic:CancelBtnOnClick(go)
  self:CloseDialog()
end

function UISeasonMaze_Campsites_SmithyBuyRelic:BuyBtnOnClick(go)
  local price = self._uiData._slotData.price
  local curGold = self._com:GetAttrValue(SeasonMazeAttrType.SMAT_Gold)
  if price > curGold then
    local tips = StringTable.Get("str_season_maze_gold_not_enough")
    ToastManager.ShowToast(tips)
    return
  end
  self:CloseDialog()
  if self._callback then
    self._callback()
  end
end

function UISeasonMaze_Campsites_SmithyBuyRelic:OnHide()
end

function UISeasonMaze_Campsites_SmithyBuyRelic:RefreshSuit(suiteID)
  self._SuitAreaGo:SetActive(true)
  local curSuitCount = 0
  local suite_cfg = Cfg.cfg_component_season_maze_suit[suiteID]
  if suite_cfg == nil then
    self._SuitAreaGo:SetActive(false)
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
  self._CustomSuitTitle:SetText(StringTable.Get(suite_cfg.Name) .. "：(" .. suitPercent .. ")")
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
  self._CustomSuitTips:SetText(tips)
end
