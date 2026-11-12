local ThrowGiftLevelSelectPanel_400015 = class("ThrowGiftLevelSelectPanel_400015", BasePanel)
ThrowGiftLevelSelectPanel_400015._sUIResRootPath = "UI_Activity/"
ThrowGiftLevelSelectPanel_400015._tbDefine = {
  {
    sPrefabPath = "_400015/ThrowGiftsLevelSelectPanel.prefab",
    sCtrlName = "Game.UI.Activity.ThrowGifts.ThrowGiftLevelSelectCtrl"
  }
}

function ThrowGiftLevelSelectPanel_400015:Awake()
  self.nTransition = 52
  self.nLevelPanelId = PanelId.ThrowGiftLevelPanel_400015
  self.nQuestPanelId = PanelId.Task_10110
end

function ThrowGiftLevelSelectPanel_400015:OnEnable()
end

function ThrowGiftLevelSelectPanel_400015:OnAfterEnter()
end

function ThrowGiftLevelSelectPanel_400015:OnDisable()
end

function ThrowGiftLevelSelectPanel_400015:OnDestroy()
end

function ThrowGiftLevelSelectPanel_400015:OnRelease()
end

return ThrowGiftLevelSelectPanel_400015
