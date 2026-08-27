local UICommonUpgradeTips = class("UICommonUpgradeTips", UIBaseWindow)
local base = UIBaseWindow

function UICommonUpgradeTips:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.__OnClickClose)
end

function UICommonUpgradeTips:InitAthEffiUpSuccess(fromValue, toValue)
  self:SetAthUpgradeSign(true)
  self.ui.tex_Title.text = ConfigData:GetTipContent(940)
  self.ui.tex_CurNum.text = fromValue
  self.ui.tex_NewNum.text = toValue
  AudioManager:PlayAudioById(1074)
end

function UICommonUpgradeTips:InitBattlePassLevelUp(fromValue, toValue)
  self:SetAthUpgradeSign(false)
  self.ui.tex_Title.text = ConfigData:GetTipContent(941)
  self.ui.tex_CurNum.text = string.format("LV.%d", fromValue)
  self.ui.tex_NewNum.text = string.format("LV.%d", toValue)
  AudioManager:PlayAudioById(1074)
end

function UICommonUpgradeTips:SetBackClickAction(clickAction)
  self.__clickAction = clickAction
end

function UICommonUpgradeTips:SetAthUpgradeSign(active)
  self.ui.tex_CurSign.gameObject:SetActive(active)
  self.ui.tex_NewSign.gameObject:SetActive(active)
end

function UICommonUpgradeTips:__OnClickClose()
  self:Delete()
  if self.__clickAction ~= nil then
    local bindfunc = self.__clickAction
    self.__clickAction = nil
    bindfunc()
  end
end

function UICommonUpgradeTips:OnDelete()
  base.OnDelete(self)
end

return UICommonUpgradeTips
