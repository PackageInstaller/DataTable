local CharConsumablePanel = class("CharConsumablePanel", BasePanel)
CharConsumablePanel._bIsMainPanel = false
CharConsumablePanel._tbDefine = {
  {
    sPrefabPath = "CharConsumablePanel/CharConsumablePanel.prefab",
    sCtrlName = "Game.UI.CharConsumable.CharConsumableCtrl"
  }
}

function CharConsumablePanel:Awake()
end

function CharConsumablePanel:OnEnable()
end

function CharConsumablePanel:OnAfterEnter()
end

function CharConsumablePanel:OnDisable()
end

function CharConsumablePanel:OnDestroy()
end

function CharConsumablePanel:OnRelease()
end

return CharConsumablePanel
