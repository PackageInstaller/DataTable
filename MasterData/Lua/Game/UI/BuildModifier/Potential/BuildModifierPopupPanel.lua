local BuildModifierPopupPanel = class("BuildModifierPopupPanel", BasePanel)
BuildModifierPopupPanel._bIsMainPanel = false
BuildModifierPopupPanel._tbDefine = {
  {
    sPrefabPath = "BuildFunction/BuildModifierPopupPanel.prefab",
    sCtrlName = "Game.UI.BuildModifier.Potential.BuildModifierPopupCtrl"
  }
}

function BuildModifierPopupPanel:Awake()
end

function BuildModifierPopupPanel:OnEnable()
end

function BuildModifierPopupPanel:OnAfterEnter()
end

function BuildModifierPopupPanel:OnDisable()
end

function BuildModifierPopupPanel:OnDestroy()
end

function BuildModifierPopupPanel:OnRelease()
end

return BuildModifierPopupPanel
