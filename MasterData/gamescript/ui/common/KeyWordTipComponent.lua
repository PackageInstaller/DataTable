local KeyWordTipComponent, Super = System.NewComponent("KeyWordTipComponent")

function KeyWordTipComponent:ctor(uiNode, desc)
  Super.ctor(self)
  self.ui = Item_Relic_KeywordResource(uiNode)
  self.desc = desc
end

function KeyWordTipComponent:OnBind(binder)
  self.binder = binder
  binder:SetText(self.ui.Text_Desc, self.desc)
end

function KeyWordTipComponent:SetText(text)
  self.desc = text
  self.binder:SetText(self.ui.Text_Desc, text)
end

return KeyWordTipComponent
