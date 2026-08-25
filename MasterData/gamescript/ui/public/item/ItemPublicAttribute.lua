local CS = _ENV.CS
local typeof = _ENV.typeof
local Animator = CS.UnityEngine.Animator
local ItemPublicAttribute, Super = System.NewComponent("ItemPublicAttribute")

function ItemPublicAttribute:ctor(res, currentAttribute, addAttribute, attributeName, icon, active)
  Super.ctor(self)
  self.ui = Item_Public_AttributeResource(res)
  self.currentAttribute = currentAttribute
  self.addAttribute = addAttribute
  self.attributeName = attributeName
  self.icon = icon
  self.active = active or false
end

function ItemPublicAttribute:OnBind(binder)
  self.binder = binder
  self.animator = self.ui.uiNode:GetComponent(typeof(Animator))
  self.Text_AddAttr = self.ui.Text_AddAttribute:GetComponent(typeof(CS.UnityEngine.UI.Text))
  if self.icon then
    self.binder:SetImage(self.ui.Icon_Attribute, self.icon)
  end
  if self.currentAttribute then
    self.binder:SetText(self.ui.Text_CurrentAttribute, self.currentAttribute)
  end
  self.binder:SetText(self.ui.Text_AddAttribute, self.addAttribute or "")
  if self.attributeName then
    self.binder:SetText(self.ui.Text_AttributeName, self.attributeName)
  end
end

function ItemPublicAttribute:UpdateCurrentAttribute(data)
  self.binder:SetText(self.ui.Text_CurrentAttribute, data)
  self.currentAttribute = data
end

function ItemPublicAttribute:UpdateCurrentAttribute2(data)
  self.binder:SetText(self.ui.Text_CurrentAttribute_2, data)
end

function ItemPublicAttribute:UpdateCurrentAttributeInAnim(data)
  if self.currentAttribute ~= data then
    self.binder:SetText(self.ui.Text_CurrentAttribute_2, data)
    CS.Framework.UIUtilTool.AnimatorSetBool(self.animator, "Play", true)
    self.binder:BindTimer(1, 1, nil, function()
      self.currentAttribute = data
      self.binder:SetText(self.ui.Text_CurrentAttribute, self.currentAttribute)
    end)
  end
end

function ItemPublicAttribute:UpdateAddAttribute(data)
  self:ResetAddAttrAnim()
  if 0 == data then
    self.ui.Text_AddAttribute:SetActive(false)
  else
    self.ui.Text_AddAttribute:SetActive(true)
    self.Text_AddAttr.color.a = 1
    if data then
      self.binder:SetText(self.ui.Text_AddAttribute, "+" .. data)
      self.binder:SetTextColorByHtml(self.ui.Text_AddAttribute, StrUtils.GetWordsEffectColor(DT.WordsEffectConfig.Positive))
    end
  end
end

function ItemPublicAttribute:ResetAddAttrAnim()
  CS.Framework.UIUtilTool.AnimatorSetBool(self.animator, "Init", true)
end

function ItemPublicAttribute:UpdateShown(name, icon)
  if name then
    self.binder:SetText(self.ui.Text_AttributeName, name)
  end
  if icon then
    self.binder:SetImage(self.ui.Icon_Attribute, icon)
  end
end

function ItemPublicAttribute:GetCurrentAttr()
  return self.currentAttribute
end

function ItemPublicAttribute:SetVisible(show)
  self.binder:SetActive(self.ui.uiNode, show)
end

return ItemPublicAttribute
