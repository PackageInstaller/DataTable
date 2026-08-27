local base = UIBaseNode
local UINWarChessInfoOpNodeBtn = class("UINWarChessInfoOpNodeBtn", base)

function UINWarChessInfoOpNodeBtn:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Info, self, self.__OnClick)
end

function UINWarChessInfoOpNodeBtn:SetClickCallback(clickCallback)
  self.clickCallback = clickCallback
end

function UINWarChessInfoOpNodeBtn:SetInterActionType(index, costAP)
  self.gameObject.name = tostring(index)
  if costAP ~= nil and 0 < costAP then
    self.ui.obj_ActionPoint:SetActive(true)
    self.ui.tex_Point.text = tostring(-costAP)
  else
    self.ui.obj_ActionPoint:SetActive(false)
  end
  self.ui.img_Info:SetIndex(index)
  self.ui.tex_des:SetIndex(index)
end

function UINWarChessInfoOpNodeBtn:__OnClick()
  if self.clickCallback ~= nil then
    self.clickCallback()
    self.clickCallback = nil
  end
end

function UINWarChessInfoOpNodeBtn:OnDelete()
  base.OnDelete(self)
end

return UINWarChessInfoOpNodeBtn
