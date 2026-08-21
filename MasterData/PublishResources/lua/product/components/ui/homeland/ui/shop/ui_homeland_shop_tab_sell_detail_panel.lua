_class("UIHomelandShopTabSellDetailPanel", UICustomWidget)
UIHomelandShopTabSellDetailPanel = UIHomelandShopTabSellDetailPanel

function UIHomelandShopTabSellDetailPanel:OnShow(uiParams)
  self._isOpen = true
end

function UIHomelandShopTabSellDetailPanel:OnHide()
  self._isOpen = false
end

function UIHomelandShopTabSellDetailPanel:SetData(itemId, btnCallback)
  self._itemId = itemId
  self._btnCallback = btnCallback
  self:_SetState(itemId)
  if itemId then
    self:_SetType(itemId)
  end
end

function UIHomelandShopTabSellDetailPanel:_SetState(itemId)
  local cfg = itemId and Cfg.cfg_item[itemId]
  local state = cfg and 1 or 2
  if not self._stateObj then
    self._stateObj = UIWidgetHelper.GetObjGroupByWidgetName(self, {
      {
        "_state_normal"
      },
      {
        "_state_empty"
      }
    })
  end
  UIWidgetHelper.SetObjGroupShow(self._stateObj, state)
end

function UIHomelandShopTabSellDetailPanel:_SetType(itemId)
  local filter_Architecture = 3
  local cfg = Cfg.cfg_item[itemId]
  local type = cfg and cfg.TabType == filter_Architecture and 3 or 1
  if not self._typeObj then
    self._typeObj = UIWidgetHelper.GetObjGroupByWidgetName(self, {
      {
        "_type_default"
      },
      {"_type_tool"},
      {
        "_type_architecture"
      }
    })
  end
  UIWidgetHelper.SetObjGroupShow(self._typeObj, type)
  self:_SetMainItem(itemId)
  local func = {
    self._SetType_Default,
    self._SetType_Tool,
    self._SetType_Architecture
  }
  func[type](self, itemId)
end

function UIHomelandShopTabSellDetailPanel:_SetMainItem(itemId)
  UIWidgetHelper.SetItemIcon(self, itemId, "_itemIcon")
  UIWidgetHelper.SetItemText(self, itemId, "_txtTitle", "_txtDesc")
end

function UIHomelandShopTabSellDetailPanel:_SetType_Default(itemId)
  UIWidgetHelper.SetItemCount(self, itemId, "_txtCount", UIHomelandShopTabSellDetailPanel._FormatCount)
  local price = UIHomelandShopHelper.CalcItemSellPrice(itemId, 1)
  UIWidgetHelper.SetLocalizationText(self, "_txtSinglePrice", price.count)
end

function UIHomelandShopTabSellDetailPanel:_SetType_Tool(itemId)
  UIWidgetHelper.SetLocalizationText(self, "_txtLv", "")
  self:GetGameObject("LvUpBtn"):SetActive(false)
  self:GetGameObject("_txtMaxObj"):SetActive(false)
end

function UIHomelandShopTabSellDetailPanel:_SetType_Architecture(itemId)
  local cfg_item_architecture = Cfg.cfg_item_architecture[itemId]
  if cfg_item_architecture then
    local strLiveable = "+" .. cfg_item_architecture.LivableValue
    UIWidgetHelper.SetLocalizationText(self, "_txtLiveable", strLiveable)
    local x = cfg_item_architecture.Size[1]
    local y = cfg_item_architecture.Size[2]
    local strSize = x .. "*" .. y
    UIWidgetHelper.SetLocalizationText(self, "_txtSize", strSize)
  else
    Log.error("### no data in cfg_item_architecture. id =", itemId)
  end
  local curCount, placedCount = UIForgeData.GetOwnPlaceCount(itemId)
  local strPlace = curCount - placedCount .. "/" .. curCount
  UIWidgetHelper.SetLocalizationText(self, "_txtPlace", strPlace)
end

function UIHomelandShopTabSellDetailPanel._FormatCount(count)
  if 999999 < count then
    local c = math.floor(count * 0.001) * 0.1
    return StringTable.Get("str_homeland_backpack_n_w", c)
  end
  return count
end

function UIHomelandShopTabSellDetailPanel:LvUpBtnOnClick(go)
end

function UIHomelandShopTabSellDetailPanel:GetFromBtnOnClick(go)
  self:ShowDialog("UIHomelandGetPath", self._itemId)
end

function UIHomelandShopTabSellDetailPanel:BtnOnClick(go)
  self:ShowDialog("UIHomelandShopSellConfirm", self._itemId, self._btnCallback)
end
