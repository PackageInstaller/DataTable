local base = UIBaseNode
local UINActSGLbInteract = class("UINActSGLbInteract", base)

function UINActSGLbInteract:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Interact, self, self._OnInteractBtnClick)
end

function UINActSGLbInteract:InitActLbInteractItem(intrctAction)
  self._intrctAction = intrctAction
  intrctAction:InvokeLbIntrctActionUIInit(self)
end

function UINActSGLbInteract:SetInteractIsTalk(isTalk)
  self.ui.icon:SetIndex(isTalk and 0 or 1)
end

function UINActSGLbInteract:SetSGInteractDes(name)
  local subName = self._intrctAction:GetLbIntrctActionSubName()
  if string.IsNullOrEmpty(name) then
    self.ui.tex_Des.text = subName
    return
  end
  local realDes = string.format(subName, name)
  self.ui.tex_Des.text = realDes
end

function UINActSGLbInteract:GetInteractTexDes()
  return self.ui.tex_Des
end

function UINActSGLbInteract:_OnInteractBtnClick()
  if self._intrctAction ~= nil then
    self._intrctAction:InvokeLbIntrctAction()
  end
end

function UINActSGLbInteract:OnDelete()
  base.OnDelete(self)
end

return UINActSGLbInteract
