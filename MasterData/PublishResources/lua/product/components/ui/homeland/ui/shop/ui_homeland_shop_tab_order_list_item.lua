_class("UIHomelandShopTabOrderListItem", UICustomWidget)
UIHomelandShopTabOrderListItem = UIHomelandShopTabOrderListItem

function UIHomelandShopTabOrderListItem:OnShow(uiParams)
end

function UIHomelandShopTabOrderListItem:OnHide()
end

function UIHomelandShopTabOrderListItem:SetData(index, goods_info)
  self._index = index
  self._cfg_id = goods_info.cfg_id
  self._cfg = Cfg.cfg_homeland_goods[goods_info.cfg_id]
  self._infos = goods_info.item_info
  self:_SetRewardIconCount()
  self:_SetRewardCountBg()
  self:_SetTypeIcon()
  self:_SetTitle()
  self:_SetExtra()
  self:_SetDesc()
  self:_SetDynamicList()
  self:_SetRefreshBtn()
  self:_SetSubmitBtn()
end

function UIHomelandShopTabOrderListItem:_SetRewardIconCount()
  local reward = self:_CalcReward()
  local url = UIHomelandShopHelper.GetItemIconName(reward.assetid)
  UIWidgetHelper.SetRawImage(self, "_rewardIcon", url)
  local text = "x" .. reward.count
  UIWidgetHelper.SetLocalizationText(self, "_rewardCount_shop", text)
  local color = "#3790F5"
  if self:_IsExtraReward() then
    local count = self:_GetExtraCount()
    color = UIHomelandShopHelper.GetGoodsExtraColor(count)
  end
  local s = string.format("<color=%s>%s</color>", color, text)
  UIWidgetHelper.SetLocalizationText(self, "_rewardCount_minimap", s)
end

function UIHomelandShopTabOrderListItem:_SetRewardCountBg()
  local color = "#3790F5"
  if self:_IsExtraReward() then
    local count = self:_GetExtraCount()
    color = UIHomelandShopHelper.GetGoodsExtraColor(count)
  end
  local bg = self:GetUIComponent("Image", "_rewardCountBg_shop")
  bg.color = UIHomelandShopHelper.Hex2Color(color)
end

function UIHomelandShopTabOrderListItem:_SetTypeIcon()
  local url = self._cfg.TypeIcon
  UIWidgetHelper.SetRawImage(self, "_typeIcon", url)
end

function UIHomelandShopTabOrderListItem:_SetTitle()
  local text = StringTable.Get(self._cfg.Title)
  UIWidgetHelper.SetLocalizationText(self, "_txtTitle", text)
end

function UIHomelandShopTabOrderListItem:_SetDesc()
  local text = StringTable.Get(self._cfg.Desc)
  UIWidgetHelper.SetLocalizationText(self, "_txtDesc", text)
end

function UIHomelandShopTabOrderListItem:_SetExtra()
  local isExtra = self:_IsExtraReward()
  if isExtra then
    local count = self:_GetExtraCount()
    local text = StringTable.Get("str_homeland_shop_tab_order_extra_reward", count)
    local color = UIHomelandShopHelper.GetGoodsExtraColor(count)
    local s = string.format("<color=%s>%s</color>", color, text)
    UIWidgetHelper.SetLocalizationText(self, "_txtExtra", s)
  end
  self:GetGameObject("_txtExtra"):SetActive(isExtra)
end

function UIHomelandShopTabOrderListItem:_SetDynamicList()
  if not self._dynamicListHelper then
    self._dynamicListHelper = UIActivityDynamicListHelper:New(self, self:GetUIComponent("UIDynamicScrollView", "_dynamicList"), "UIHomelandShopTabOrderItem", function(listItem, itemIndex)
      listItem:SetData(self._infos[itemIndex], "#e43131", "#747474")
    end)
  end
  local itemCount = #self._infos
  local itemCountPerRow = 1
  self._dynamicListHelper:Refresh(itemCount, itemCountPerRow)
end

function UIHomelandShopTabOrderListItem:_SetRefreshBtn()
  if not self._refreshBtnObj then
    self._refreshBtnObj = UIWidgetHelper.GetObjGroupByWidgetName(self, {
      {"RefreshBtn"},
      {
        "RefreshBtn_Disable"
      }
    })
  end
  local mode = self._cfg.Type ~= HomelandGoodsType.HGT_INITFIX and 1 or 2
  UIWidgetHelper.SetObjGroupShow(self._refreshBtnObj, mode)
end

function UIHomelandShopTabOrderListItem:_SetSubmitBtn()
  if not self._submitBtnObj then
    self._submitBtnObj = UIWidgetHelper.GetObjGroupByWidgetName(self, {
      {"SubmitBtn"},
      {
        "SubmitBtn_Disable"
      }
    })
  end
  local mode = UIHomelandShopHelper.CheckOrderRequire(self._infos) and 1 or 2
  UIWidgetHelper.SetObjGroupShow(self._submitBtnObj, mode)
end

function UIHomelandShopTabOrderListItem:_CalcReward()
  local roleAsset = RoleAsset:New()
  roleAsset.assetid = UIHomelandShopHelper.GetCoinItemId()
  roleAsset.count = 0
  for _, v in ipairs(self._infos) do
    local cfg = Cfg.cfg_homeland_univalence[v.assetid]
    if not cfg then
      Log.exception("UIHomelandShopTabOrderListItem:_CalcReward() cfg_homeland_univalence[", v.assetid, "] = nil")
    end
    roleAsset.count = roleAsset.count + cfg.Goods * v.count
  end
  if self:_IsExtraReward() then
    local extra = self._cfg.Extra
    roleAsset.count = Mathf.Floor(roleAsset.count * (1 + extra))
  end
  return roleAsset
end

function UIHomelandShopTabOrderListItem:_IsExtraReward()
  local extra = self._cfg.Extra
  return extra ~= nil
end

function UIHomelandShopTabOrderListItem:_GetExtraCount()
  local extra = self._cfg.Extra
  if extra ~= nil then
    return math.floor(extra * 100)
  end
end

function UIHomelandShopTabOrderListItem:RefreshBtnOnClick(go)
  local itemCount, maxCount = UIHomelandShopHelper.GetGoodsRefreshCount()
  if itemCount == 0 then
    ToastManager.ShowHomeToast(StringTable.Get("str_homeland_shop_tab_order_confirm_desc_3"))
  else
    self:_ShowDialog_Confirm()
  end
end

function UIHomelandShopTabOrderListItem:SubmitBtnOnClick(go)
  local reward = self:_CalcReward()
  UIHomelandShopHelper.CheckCoinOverflow(reward.count, function()
    UIHomelandShopHelper.Start_HomelandGoodReq(self._index, true, {reward})
  end)
end

function UIHomelandShopTabOrderListItem:_ShowDialog_Confirm()
  local descs = {
    "str_homeland_shop_tab_order_confirm_desc_1",
    "str_homeland_shop_tab_order_confirm_desc_2"
  }
  local type = self:_IsExtraReward() and 2 or 1
  local title = StringTable.Get("str_homeland_shop_tab_order_confirm_title")
  local desc = StringTable.Get(descs[type])
  UIHomelandShopHelper.ShowHomelandMessageBox_OK_Cancel(title, desc, function()
    UIHomelandShopHelper.Start_HomelandGoodReq(self._index, false)
  end)
end

function UIHomelandShopTabOrderListItem:GetSubmitBtn()
  local mode = UIHomelandShopHelper.CheckOrderRequire(self._infos) and 1 or 2
  return self._submitBtnObj[mode]
end
