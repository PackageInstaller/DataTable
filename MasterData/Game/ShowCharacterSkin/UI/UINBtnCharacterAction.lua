local UINBtnCharacterAction = class("UINBtnCharacterAction", UIBaseNode)
local base = UIBaseNode

function UINBtnCharacterAction:OnShow()
end

function UINBtnCharacterAction:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_House, self, self.OnClick)
end

function UINBtnCharacterAction:InitShowCharacterSkin(index, tipId, callback)
  self.index = index
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(ConfigData:GetTipContent(tipId))
  self.callback = callback
end

function UINBtnCharacterAction:OnClick()
  if self.callback then
    self.callback(self.index)
  end
end

function UINBtnCharacterAction:OnDelete()
end

return UINBtnCharacterAction
