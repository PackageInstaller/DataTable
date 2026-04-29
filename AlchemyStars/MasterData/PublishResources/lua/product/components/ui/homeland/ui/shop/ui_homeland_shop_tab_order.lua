_class("UIHomelandShopTabOrder", UICustomWidget)
UIHomelandShopTabOrder = UIHomelandShopTabOrder

function UIHomelandShopTabOrder:OnShow(uiParams)
  self._isOpen = true
  self._firstReqTime = true
end

function UIHomelandShopTabOrder:OnHide()
  self._isOpen = false
end

function UIHomelandShopTabOrder:SetData(shop_info)
  self._shop_info = shop_info
  self._infos = self:_GetDynamicListData()
  self:_SetDynamicList()
  self:_SetRefreshText()
end

function UIHomelandShopTabOrder:_GetDynamicListData()
  local tb = {}
  for i, v in pairs(self._shop_info.goods_info) do
    tb[i + 1] = v
  end
  return tb
end

function UIHomelandShopTabOrder:_SetDynamicList()
  if not self._dynamicListHelper then
    self._dynamicListHelper = UIActivityDynamicListHelper:New(self, self:GetUIComponent("UIDynamicScrollView", "_dynamicList"), "UIHomelandShopTabOrderListItem", function(listItem, itemIndex)
      local info = self._infos[itemIndex]
      listItem:SetData(itemIndex, info)
      if itemIndex == 1 then
        self._firstSubmitBtnObj = listItem:GetSubmitBtn()
      end
    end)
  end
  local itemCount = #self._infos
  local itemCountPerRow = 1
  self._dynamicListHelper:Refresh(itemCount, itemCountPerRow)
end

function UIHomelandShopTabOrder:_SetRefreshText()
  local itemCount, maxCount = UIHomelandShopHelper.GetGoodsRefreshCount()
  local endTime = self._shop_info.goods_refresh_time
  local obj = UIWidgetHelper.SpawnObject(self, "_remainingTimePool", "UIActivityCommonRemainingTime")
  local text = StringTable.Get("str_homeland_shop_tab_order_refresh_text", itemCount, maxCount)
  UIWidgetHelper.SetLocalizationText(obj, "txtDesc", text)
  if maxCount <= itemCount then
    obj:SetData(0, nil, nil)
    local text3 = StringTable.Get("str_homeland_shop_tab_order_refresh_text_3")
    UIWidgetHelper.SetLocalizationText(obj, "txtTime", text3)
  else
    obj:SetCustomTimeStr_Common_1()
    obj:SetAdvanceText("str_homeland_shop_tab_order_refresh_text_2")
    obj:SetData(endTime, nil, function(first)
      if not first then
        UIHomelandShopHelper.Start_HomelandShopRefreshReq(5)
      elseif self._firstReqTime then
        UIHomelandShopHelper.Start_HomelandShopRefreshReq(5)
        self._firstReqTime = false
      end
    end)
  end
end

function UIHomelandShopTabOrder:GetSubmitBtn()
  return self._firstSubmitBtnObj[1]
end
