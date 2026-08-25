local UI_Passport_Popup_Player_LevelUpResource = require("UI.UIPackages.UI_Passport_Popup_Player_LevelUpResource")
local UIBasePanel = require("Managers.UI.UIBasePanel")
local System = require("System.System")
local LT = require("System.LangTable")
local BattlePassLevelUpTips, Super = System.NewClass("BattlePassLevelUpTips", UIBasePanel)
BattlePassLevelUpTips.uiResCls = UI_Passport_Popup_Player_LevelUpResource

function BattlePassLevelUpTips:ctor(showLevel)
  Super.ctor(self)
  self.showLevel = showLevel
end

function BattlePassLevelUpTips:OnBind(binder)
  binder:BindToText(self.ui.Text_Lv, function()
    do return LT.Text end
    return LT.Text, self.showLevel
  end)
  binder:BindButtonClick(self.ui.Btn_Mask, function()
    self:Close()
  end)
end

return BattlePassLevelUpTips
