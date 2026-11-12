local ThrowGiftLevelSelectPanel_400009 = class("ThrowGiftLevelSelectPanel_400009", BasePanel)
ThrowGiftLevelSelectPanel_400009._sUIResRootPath = "UI_Activity/"
ThrowGiftLevelSelectPanel_400009._tbDefine = {
  {
    sPrefabPath = "_400009/ThrowGiftsLevelSelectPanel.prefab",
    sCtrlName = "Game.UI.Activity.ThrowGifts.ThrowGiftLevelSelectCtrl"
  }
}

function ThrowGiftLevelSelectPanel_400009:Awake()
  self.nTransition = 45
  self.nLevelPanelId = PanelId.ThrowGiftLevelPanel_400009
  self.nQuestPanelId = PanelId.Task_10107
end

function ThrowGiftLevelSelectPanel_400009:OnEnable()
end

function ThrowGiftLevelSelectPanel_400009:OnAfterEnter()
end

function ThrowGiftLevelSelectPanel_400009:OnDisable()
end

function ThrowGiftLevelSelectPanel_400009:OnDestroy()
end

function ThrowGiftLevelSelectPanel_400009:OnRelease()
end

return ThrowGiftLevelSelectPanel_400009
