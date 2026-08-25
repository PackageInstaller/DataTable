local CardKeyWordComponent, Super = System.NewComponent("CardKeyWordComponent")

function CardKeyWordComponent:ctor(res, desc)
  Super.ctor(self)
  self.ui = CardKeyWordItemResource(res)
  self.desc = Vue.ref(desc)
end

function CardKeyWordComponent:OnBind(binder)
  self.binder = binder
  binder:SetText(self.ui.Text_Description, self.desc.value)
end

return CardKeyWordComponent
