local ThrowGiftLevelSelectPanel = class("ThrowGiftLevelSelectPanel", BasePanel)
ThrowGiftLevelSelectPanel._sUIResRootPath = "UI_Activity/"
ThrowGiftLevelSelectPanel._tbDefine = {
  {
    sPrefabPath = "_400005/ThrowGiftsLevelSelectPanel.prefab",
    sCtrlName = "Game.UI.Activity.ThrowGifts.ThrowGiftLevelSelectCtrl"
  }
}

function ThrowGiftLevelSelectPanel:Awake()
  self.nTransition = 37
  self.nLevelPanelId = PanelId.ThrowGiftLevelPanel
  self.nQuestPanelId = PanelId.Task_10105
end

function ThrowGiftLevelSelectPanel:OnEnable()
end

function ThrowGiftLevelSelectPanel:OnAfterEnter()
end

function ThrowGiftLevelSelectPanel:OnDisable()
end

function ThrowGiftLevelSelectPanel:OnDestroy()
end

function ThrowGiftLevelSelectPanel:OnRelease()
end

return ThrowGiftLevelSelectPanel
