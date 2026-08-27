local UINMiniGameTag = class("UINMiniGameTag", UIBaseNode)
local base = UIBaseNode

function UINMiniGameTag:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.pageItem, self, self.OnClickTag)
end

function UINMiniGameTag:InitMiniGameTag(index, callback)
  self._index = index
  self._callback = callback
  self.ui.img_Icon:SetIndex(index - 1)
  self.ui.tex_Text:SetIndex(index - 1)
end

function UINMiniGameTag:RefreshTagState(selectIndex)
  local flag = selectIndex == self._index
  self.ui.img_SelectFrame.gameObject:SetActive(flag)
  local color = self.ui.tex_Text.text.color
  color.a = flag and 1 or 0.7
  self.ui.tex_Text.text.color = color
  self.ui.img_Icon.image.color = color
end

function UINMiniGameTag:SetHTGTaskTagDot(flag)
  self.ui.blueDot:SetActive(flag)
end

function UINMiniGameTag:OnClickTag()
  if self._callback ~= nil then
    self._callback(self._index)
  end
end

return UINMiniGameTag
