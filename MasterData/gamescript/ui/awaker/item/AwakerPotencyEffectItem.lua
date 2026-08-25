local AwakerPotencyEffectItem, Super = System.NewComponent("AwakerPotencyEffectItem")

function AwakerPotencyEffectItem:ctor(res, data)
  Super.ctor(self)
  self.ui = Item_Awaker_Qiling_IconResource(res)
  self.data = data
end

function AwakerPotencyEffectItem:OnBind(binder)
  self.binder = binder
  binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self.OnClick))
  binder:SetActive(self.ui.Group_None, not self.data.isActive)
  binder:SetActive(self.ui.Group_Up, self.data.showStar)
  binder:SetImage(self.ui.Image_Qiling_Icon, self.data.iconPath)
end

function AwakerPotencyEffectItem:OnClick()
  if self.data and self.data.callback then
    self.data.callback()
  end
end

function AwakerPotencyEffectItem:SetIsActive(active)
  self.binder:SetActive(self.ui.Group_None, not active)
end

return AwakerPotencyEffectItem
