local ThrowGiftPanel_400009 = class("ThrowGiftPanel_400009", BasePanel)
ThrowGiftPanel_400009._sUIResRootPath = "UI_Activity/"
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
ThrowGiftPanel_400009._tbDefine = {
  {
    sPrefabPath = "_400009/ThrowGiftsPanel.prefab",
    sCtrlName = "Game.UI.Activity.ThrowGifts.ThrowGiftCtrl"
  }
}

function ThrowGiftPanel_400009:Awake()
  self.nLevelPanelId = PanelId.ThrowGiftLevelPanel_400009
  self.sGamepadPanelName = "ThrowGiftPanel_400009"
  self.nTransition = 45
  self._rootPath = "UI_Activity/_400009/GoalPerfab/Goal%s.prefab"
  GamepadUIManager.EnterAdventure(true)
  GamepadUIManager.EnableGamepadUI(self.sGamepadPanelName, {}, nil, true)
end

function ThrowGiftPanel_400009:OnEnable()
end

function ThrowGiftPanel_400009:OnAfterEnter()
end

function ThrowGiftPanel_400009:OnDisable()
end

function ThrowGiftPanel_400009:OnDestroy()
  GamepadUIManager.DisableGamepadUI(self.sGamepadPanelName)
  GamepadUIManager.QuitAdventure()
end

function ThrowGiftPanel_400009:OnRelease()
end

return ThrowGiftPanel_400009
