local ItemPublicGetBtnComponent, Super = System.NewComponent("ItemPublicGetBtnComponent")

function ItemPublicGetBtnComponent:ctor(uiNode, approachInfo, clickCb)
  Super.ctor(self)
  self.ui = Item_Goods_Gain_TipsResource(uiNode)
  self.approachInfo = approachInfo
  self.clickCb = clickCb
end

function ItemPublicGetBtnComponent:OnBind(binder)
  self.binder = binder
  binder:SetText(self.ui.Text_Name, self.approachInfo.cfg.Desc)
  local active = self.approachInfo.isUnlock and self.approachInfo.timeOpen
  binder:SetActive(self.ui.Group_Lock, not active)
  binder:BindButtonClick(self.ui.uiNode, System.fn(self, self.OnClick))
end

function ItemPublicGetBtnComponent:OnClick()
  if self.approachInfo.isUnlock and self.approachInfo.timeOpen then
    if self.clickCb then
      self.clickCb(self.approachInfo)
    end
  elseif not self.approachInfo.isUnlock then
    Alert.Show(10195)
  else
    Alert.Show(10196)
  end
end

return ItemPublicGetBtnComponent
