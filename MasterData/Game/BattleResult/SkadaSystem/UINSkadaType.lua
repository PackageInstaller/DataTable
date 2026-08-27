local UINSkadaType = class("UINSkadaType", UIBaseNode)

function UINSkadaType:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddValueChangedListener(self.ui.tog_DataType, self, self.OnSkadaTogChanged)
end

function UINSkadaType:InitSkadaType(typeId, eventAction)
  self.typeId = typeId
  self.ui.tex_TypeName:SetIndex(typeId - 1)
  self.eventAction = eventAction
end

function UINSkadaType:OnSkadaTogChanged(value)
  if value then
    self.ui.img_DataType:SetIndex(1)
    self.ui.img_DataType.image.color = Color.white
    self.ui.img_AttriIcon.color = self.ui.color_normal
    self.ui.tex_TypeName.text.color = self.ui.color_normal
  else
    self.ui.img_DataType:SetIndex(0)
    self.ui.img_DataType.image.color = self.ui.color_normal
    self.ui.img_AttriIcon.color = Color.white
    self.ui.tex_TypeName.text.color = Color.white
  end
  if self.eventAction ~= nil then
    self.eventAction(value, self)
  end
end

function UINSkadaType:SetSkadaTypeOpen(active)
  self.ui.tog_DataType.isOn = active
end

return UINSkadaType
