local UINHandBookCardTag = class("UINHandBookCardTag", UIBaseNode)
local base = UIBaseNode

function UINHandBookCardTag:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Item, self, self.OnClickCardTag)
end

function UINHandBookCardTag:InitHandBookCardTag(tagId, tagName, callback)
  self._tagId = tagId
  self.ui.tex_tagName.text = LanguageUtil.GetLocaleText(tagName)
  self._callback = callback
end

function UINHandBookCardTag:RefreshCardTag(tagId)
  local flag = self._tagId == tagId
  self.ui.img_bottom.color = flag and self.ui.color_select or self.ui.color_unselect
end

function UINHandBookCardTag:OnClickCardTag()
  if self._callback ~= nil then
    self._callback(self._tagId)
  end
end

return UINHandBookCardTag
