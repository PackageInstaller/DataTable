local VampireFateCardSelectPanel = class("VampireFateCardSelectPanel", BasePanel)
VampireFateCardSelectPanel._bIsMainPanel = false
VampireFateCardSelectPanel._bAddToBackHistory = false
VampireFateCardSelectPanel._tbDefine = {
  {
    sPrefabPath = "VampireBattle/VampireFateCardSelectPanel.prefab",
    sCtrlName = "Game.UI.VampireSurvivor.VampireFateCardSelect"
  }
}

function VampireFateCardSelectPanel:Awake()
end

function VampireFateCardSelectPanel:OnEnable()
end

function VampireFateCardSelectPanel:OnAfterEnter()
end

function VampireFateCardSelectPanel:OnDisable()
end

function VampireFateCardSelectPanel:OnDestroy()
end

function VampireFateCardSelectPanel:OnRelease()
end

return VampireFateCardSelectPanel
