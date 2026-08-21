_class("UISeasonMaze_Campsites_SmithyBuyItem", UIController)
UISeasonMaze_Campsites_SmithyBuyItem = UISeasonMaze_Campsites_SmithyBuyItem

function UISeasonMaze_Campsites_SmithyBuyItem:InitWidget()
  self._Icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._PriceText = self:GetUIComponent("UILocalizationText", "PriceText")
  self._DescTitleText = self:GetUIComponent("UILocalizationText", "DescTitleText")
  self._Content = self:GetUIComponent("UILocalizationText", "Content")
end

function UISeasonMaze_Campsites_SmithyBuyItem:OnShow(uiParams)
  self:InitWidget()
  self._uiData = uiParams[1]
  self._com = uiParams[2]
  self._callback = uiParams[3]
  self._isEffectItem = uiParams[4]
  if not self._isEffectItem then
    self:RefreshUI()
  else
    self:RefreshUI_FromEffect()
  end
end

function UISeasonMaze_Campsites_SmithyBuyItem:RefreshUI()
  local itemId = self._uiData._slotData.item.id
  local iconRes = ""
  local onceCfg = Cfg.cfg_component_season_maze_once({OnceID = itemId})[1]
  if onceCfg then
    iconRes = onceCfg.Icon
    local desc = onceCfg.Desc
    if desc then
      self._Content:SetText(StringTable.Get(desc))
    end
  end
  self._Icon:LoadImage(iconRes)
  local price = self._uiData._slotData.price
  local priceStr = tostring(price)
  local curGold = self._com:GetAttrValue(SeasonMazeAttrType.SMAT_Gold)
  if price > curGold then
    priceStr = "<color=#c97d7d>" .. priceStr .. "</color>"
  end
  self._PriceText:SetText(priceStr)
end

function UISeasonMaze_Campsites_SmithyBuyItem:RefreshUI_FromEffect()
  local itemId = self._uiData._slotData.item.id
  local iconRes = ""
  local attCfg = Cfg.cfg_season_maze_attribute[itemId]
  if attCfg ~= nil then
    iconRes = attCfg.ItemIcon
    self._Content:SetText(StringTable.Get(attCfg.Desc))
  end
  self._Icon:LoadImage(iconRes)
  local price = self._uiData._slotData.price
  local priceStr = tostring(price)
  local curGold = self._com:GetAttrValue(SeasonMazeAttrType.SMAT_Gold)
  if price > curGold then
    priceStr = "<color=#c97d7d>" .. priceStr .. "</color>"
  end
  self._PriceText:SetText(priceStr)
end

function UISeasonMaze_Campsites_SmithyBuyItem:CancelBtnOnClick(go)
  self:CloseDialog()
end

function UISeasonMaze_Campsites_SmithyBuyItem:BuyBtnOnClick(go)
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

function UISeasonMaze_Campsites_SmithyBuyItem:OnHide()
end
