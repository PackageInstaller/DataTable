local MainShopCoinItem, Super = System.NewComponent("MainShopCoinItem")

function MainShopCoinItem:ctor(uiNode, id, callBack)
  Super.ctor(self)
  self.ui = Com_CoinResource(uiNode)
  self.itemId = Vue.ref(id or -1)
  self.callBack = callBack
end

function MainShopCoinItem:OnBind(binder)
  self.binder = binder
  binder:BindToText(self.ui.Text_Money_Num, function()
    local itemId = self.itemId.value
    if -1 == itemId then
      return 0
    end
    do return ItemDataUtils.GetItemNum end
    return ItemDataUtils.GetItemNum, itemId
  end)
  binder:BindToImage(self.ui.Icon_Money, function()
    local itemId = self.itemId.value
    if -1 == itemId then
      return ""
    end
    do return ItemDataUtils.GetIcon end
    return ItemDataUtils.GetIcon, itemId
  end)
  binder:SetActive(self.ui.Btn_Arithmetic_Add, self.callBack ~= nil)
  binder:BindButtonClick(self.ui.Btn_Arithmetic_Add, System.fn(self, self.OnBtnAddClick))
  binder:BindButtonClick(self.ui.Btn_Money_Tips, System.fn(self, self.OnClickTips))
  binder:BindButtonClick(self.ui.Btn_MoneyIcon_Mask, System.fn(self, self.OnClickIconMask))
end

function MainShopCoinItem:SetItemId(itemId)
  assert(type(itemId) == "number", "MainShopCoinItem.UpdateView param Error")
  self.itemId.value = itemId
end

function MainShopCoinItem:OnBtnAddClick()
  if self.callBack then
    self.callBack(self.itemId.value)
  end
end

function MainShopCoinItem:OnClickTips()
  self.ui.Root_MoneyIcon_Tips:SetActive(true)
  local binder = self.binder
  local data = {
    configId = self.itemId.value,
    isItem = true,
    rootGameObject = self.ui.uiNode,
    autoAdjustPos = true
  }
  local _, childBinder = binder:BindNewComponent(UIManager.GetTipPopRoot(), ItemObjectTip, Item_Public_Object_TipResource, nil, data)
  self.tipBinder = childBinder
end

function MainShopCoinItem:OnClickIconMask()
  if self.tipBinder then
    self.ui.Root_MoneyIcon_Tips:SetActive(false)
    self.tipBinder:teardown()
    self.tipBinder = nil
  end
end

return MainShopCoinItem
