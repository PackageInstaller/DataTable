local ConsumablePanel = class("ConsumablePanel", BasePanel)
ConsumablePanel._bIsMainPanel = false
ConsumablePanel._tbDefine = {
  {
    sPrefabPath = "ConsumablesPanel/ConsumablesPanel.prefab",
    sCtrlName = "Game.UI.Consumable.ConsumableCtrl"
  }
}

function ConsumablePanel:Awake()
end

function ConsumablePanel:OnEnable()
end

function ConsumablePanel:OnAfterEnter()
end

function ConsumablePanel:OnDisable()
end

function ConsumablePanel:OnDestroy()
end

function ConsumablePanel:OnRelease()
end

return ConsumablePanel
