local ThrowGiftPanel_400015 = class("ThrowGiftPanel_400015", BasePanel)
ThrowGiftPanel_400015._sUIResRootPath = "UI_Activity/"
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
ThrowGiftPanel_400015._tbDefine = {
  {
    sPrefabPath = "_400015/ThrowGiftsPanel.prefab",
    sCtrlName = "Game.UI.Activity.ThrowGifts.ThrowGiftCtrl"
  }
}

function ThrowGiftPanel_400015:Awake()
  self.nLevelPanelId = PanelId.ThrowGiftLevelPanel_400015
  self.sGamepadPanelName = "ThrowGiftPanel_400015"
  self.nTransition = 52
  self._rootPath = "UI_Activity/_400015/GoalPerfab/Goal%s.prefab"
  GamepadUIManager.EnterAdventure(true)
  GamepadUIManager.EnableGamepadUI(self.sGamepadPanelName, {}, nil, true)
end

function ThrowGiftPanel_400015:OnEnable()
end

function ThrowGiftPanel_400015:OnAfterEnter()
end

function ThrowGiftPanel_400015:OnDisable()
end

function ThrowGiftPanel_400015:OnDestroy()
  GamepadUIManager.DisableGamepadUI(self.sGamepadPanelName)
  GamepadUIManager.QuitAdventure()
end

function ThrowGiftPanel_400015:OnRelease()
end

return ThrowGiftPanel_400015
