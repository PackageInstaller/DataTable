local UINSpring23StoryPage = class("UINSpring23StoryPage", UIBaseNode)
local base = UIBaseNode

function UINSpring23StoryPage:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_root, self, self.OnClickPage)
end

function UINSpring23StoryPage:InitSpring23StoryPage(index, unlock, callback, pageName)
  self.ui.img_Icon:SetIndex(index - 1)
  self.ui.tex_StoryName.text = LanguageUtil.GetLocaleText(pageName)
  self.ui.obj_Lock:SetActive(not unlock)
  self._index = index
  self._callback = callback
end

function UINSpring23StoryPage:SetLockTip(pageName)
  self.ui.tex_LockTips.text = ConfigData:GetTipContent(20012, LanguageUtil.GetLocaleText(pageName))
end

function UINSpring23StoryPage:ActiveSpring23StoryPage(flag)
  self.ui.img_Icon.image.color = flag and Color.white or self.ui.clor_unSelect
  self.ui.bottom.color = flag and self.ui.color_bg_selected or self.ui.color_bg_unselect
end

function UINSpring23StoryPage:OnClickPage()
  if self._callback ~= nil and self.ui.obj_Lock.activeSelf == false then
    self._callback(self._index, self)
  end
end

return UINSpring23StoryPage
