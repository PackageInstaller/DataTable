local UINATHDungeonInfo = class("UINATHDungeonInfo", UIBaseNode)
local base = UIBaseNode

function UINATHDungeonInfo:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_background, self, self.__OnClickCloseBtnInfo)
  UIUtil.AddButtonListener(self.ui.btn_yes, self, self.__OnClickCloseBtnInfo)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.__OnClickCloseBtnInfo)
end

function UINATHDungeonInfo:InitDungeonInfo(infoText, infoTitleIndex)
  UIUtil.SetTopStatus(self, self.BackAction, nil, nil, nil, true)
  self.ui.tex_DropInfo.text = infoText
  self.ui.tex_InfoTitle:SetIndex(infoTitleIndex)
end

function UINATHDungeonInfo:BackAction()
  self:Hide()
end

function UINATHDungeonInfo:__OnClickCloseBtnInfo()
  UIUtil.OnClickBackByUiTab(self)
end

return UINATHDungeonInfo
