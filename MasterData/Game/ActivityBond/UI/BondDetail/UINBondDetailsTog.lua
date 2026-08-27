local base = UIBaseNode
local UINBondDetailsTog = class("UINBondDetailsTog", base)

function UINBondDetailsTog:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddValueChangedListener(self.ui.toggle, self, self.__OnValueChage)
end

function UINBondDetailsTog:InitBondDetailTog(type, selectCallback)
  self.__type = type
  self.ui.tex_Title:SetIndex(type - 1)
  self.__selectCallback = selectCallback
  self.ui.toggle.isOn = false
  self:__OnValueChage(false)
end

function UINBondDetailsTog:__OnValueChage(bool)
  self.ui.obj_Selected:SetActive(bool)
  if bool then
    if self.__selectCallback ~= nil then
      self.__selectCallback(self.__type)
    end
    self.ui.tex_Title.text.color = Color.black
  else
    self.ui.tex_Title.text.color = Color.white
  end
end

function UINBondDetailsTog:OnDelete()
  base.OnDelete(self)
end

return UINBondDetailsTog
