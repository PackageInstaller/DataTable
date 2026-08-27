local UINEpAutoOperator = class("UINEpAutoOperator", UIBaseNode)

function UINEpAutoOperator:OnInit()
  self.ui.tex_Operator = self.transform:FindComponent("Tex_Operator", eUnityComponentID.TextItemInfo)
  self.ui.img_Operator = self.transform:FindComponent("Img_Operator", eUnityComponentID.Image)
end

function UINEpAutoOperator:BindAutoParent(parent)
  self.transform:SetLayer(parent.gameObject.layer)
  self.ui.img_Operator.material = nil
  self.ui.tex_Operator.text.material = nil
  UIManager:CopyUI3DModifier(parent, self.ui.img_Operator.transform)
  UIManager:CopyUI3DModifier(parent, self.ui.tex_Operator.transform)
end

function UINEpAutoOperator:UpdateAutoOperatorText(second)
  self.ui.tex_Operator:SetIndex(0, tostring(second))
end

return UINEpAutoOperator
