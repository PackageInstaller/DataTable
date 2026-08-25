local Vector2
local MainShopBuyConfirmPanel, Super = System.NewClass("MainShopBuyConfirmPanel", UIBasePanel)
MainShopBuyConfirmPanel.uiResCls = Popup_Shop_Buy_ConfirmResource

function MainShopBuyConfirmPanel:ctor(viewData)
  Super.ctor(self)
  Vector2 = CS.UnityEngine.Vector2
  self.viewData = viewData
  self.addCount = self:GetAddCount(viewData.shopItemData)
  self.cost = 0
end

function MainShopBuyConfirmPanel:OnBind(binder)
  self.binder = binder
  self:BindButton()
  self:BindText()
  self:BindScrollView()
end

function MainShopBuyConfirmPanel:GetAddCount(shopItems)
  local result = {}
  for k, v in ipairs(shopItems) do
    local c = result[v.itemTid] or 0
    c = c + v.num
    result[v.itemTid] = c
  end
  return result
end

function MainShopBuyConfirmPanel:BindButton()
  local binder = self.binder
  binder:BindButtonClick(self.ui.Btn_Confirm, System.fn(self, self.OnConfirmClick))
  binder:BindButtonClick(self.ui.Btn_Cancel, System.fn(self, self.OnBtnCancelClick))
end

function MainShopBuyConfirmPanel:BindText()
  local binder = self.binder
  binder:BindToText(self.ui.Text_Cur_Coin, function()
    do return ItemDataUtils.GetItemNum end
    return ItemDataUtils.GetItemNum, self.viewData.itemId
  end)
  local cost = 0
  for _, v in ipairs(self.viewData.shopItemData) do
    cost = cost + v.price
  end
  binder:SetText(self.ui.Text_Expend_Coin, cost)
  self.cost = cost
  binder:BindToTextColorOld(self.ui.Text_Expend_Coin, function()
    if cost > ItemDataUtils.GetItemNum(self.viewData.itemId) then
      return "#E25312"
    else
      return "#323232"
    end
  end)
  local costName = ItemDataUtils.GetItemName(self.viewData.itemId)
  binder:SetText(self.ui.Text_Cur_Title, string.format(LT.Text("Shop_Confirm_Buy_Str_Now_Money"), costName))
  binder:SetText(self.ui.Text_Expend_Title, string.format(LT.Text("Shop_Confirm_Buy_Str_Need_Money"), costName))
  local richColor = string.format("<OptionHighlight:%d>", self.cost)
  binder:SetText(self.ui.Text_Tips, string.format(LT.Text("Shop_Confirm_Buy_Str_Tips"), MainShopDataUtils.GetRichStr(self.viewData.shopType) .. richColor))
end

function MainShopBuyConfirmPanel:BindScrollView()
  self.binder:BindToCircularListView(self.ui.ScrollView_Buy_List, function()
    return self.viewData.shopItemData
  end, function(itemBinder, item, index)
    local itemData = self.viewData.shopItemData[index]
    itemBinder:BindComponent(MainShopBuyConfirmItem(item, itemData, self.addCount[itemData.itemTid]))
    if 1 == #self.viewData.shopItemData then
      item:GetComponent(typeof(CS.UnityEngine.RectTransform)).anchoredPosition = Vector2(320, -75)
    end
  end)
end

function MainShopBuyConfirmPanel:OnConfirmClick()
  local shopType = self.viewData.shopType
  if self.cost > ItemDataUtils.GetItemNum(self.viewData.itemId) then
    local desc = string.format(LT.Text("Shop_Buy_Lack_Money"), ItemDataUtils.GetItemName(self.viewData.itemId))
    Alert.Show(10434, nil, nil, nil, desc)
    return
  end
  if 1 == #self.viewData.shopItemData then
    local uid = self.viewData.shopItemData[1].uid
    EventMgr.Instance.OpenReqMask:Dispatch()
    ProtoManager.Instance:ReqServer("GameRequest", "OnShopBuyGoods", function(data)
      MainShopDataUtils.OnUpdateShopGoods(data)
    end, nil, uid, shopType, 1)
  else
    local uids = {}
    for _, v in ipairs(self.viewData.shopItemData) do
      table.insert(uids, v.uid)
    end
    EventMgr.Instance.OpenReqMask:Dispatch()
    ProtoManager.Instance:ReqServer("GameRequest", "OnShopBatchBuyGoods", function(data)
      MainShopDataUtils.OnUpdateShopGoods(data)
    end, nil, uids, shopType)
  end
  self:Close()
end

function MainShopBuyConfirmPanel:OnBtnCancelClick()
  self:Close()
end

return MainShopBuyConfirmPanel
