local UINMiniGameMainBtn = class("UINMiniGameMainBtn", UIBaseNode)
local base = UIBaseNode

function UINMiniGameMainBtn:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Item, self, self.OnClickMiniBtn)
end

function UINMiniGameMainBtn:InitMiniBtn(index, callback)
  self._index = index
  self.ui.tex_Text:SetIndex(index - 1)
  self._callback = callback
end

function UINMiniGameMainBtn:SetMiniBtnState(selectIndex)
  local flag = selectIndex == self._index
  self.ui.obj_selected:SetActive(flag)
  local color = self.ui.tex_Text.text.color
  color.a = flag and 1 or 0.7
  self.ui.tex_Text.text.color = color
end

function UINMiniGameMainBtn:SetMiniBtnReddot(flag, isBlue)
  self.ui.blueDot:SetActive(flag and isBlue)
  self.ui.redDot:SetActive(flag and not isBlue)
end

function UINMiniGameMainBtn:GetMiniBtnIndex()
  return self._index
end

function UINMiniGameMainBtn:OnClickMiniBtn()
  if self._callback ~= nil then
    self._callback(self._index)
  end
end

return UINMiniGameMainBtn
