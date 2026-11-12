local DoubleDropActQuestPanel = class("DoubleDropActQuestPanel", BasePanel)
DoubleDropActQuestPanel._bIsMainPanel = false
DoubleDropActQuestPanel._sUIResRootPath = "UI_Activity/"
DoubleDropActQuestPanel._tbDefine = {
  {
    sPrefabPath = "_103001/DoubleDropActRewardPanel.prefab",
    sCtrlName = "Game.UI.Activity.DoubleDrop.DoubleDropActQuestCtrl"
  }
}

function DoubleDropActQuestPanel:Awake()
end

function DoubleDropActQuestPanel:OnEnable()
end

function DoubleDropActQuestPanel:OnAfterEnter()
end

function DoubleDropActQuestPanel:OnDisable()
end

function DoubleDropActQuestPanel:OnDestroy()
end

function DoubleDropActQuestPanel:OnRelease()
end

return DoubleDropActQuestPanel
