local VampireFateCardInfoPanel = class("VampireFateCardInfoPanel", BasePanel)
VampireFateCardInfoPanel._bIsMainPanel = false
VampireFateCardInfoPanel._bAddToBackHistory = false
VampireFateCardInfoPanel._tbDefine = {
  {
    sPrefabPath = "VampireLevelSelect/VampireFateCardInfoPanel.prefab",
    sCtrlName = "Game.UI.VampireLevelSelect.VampireFateCardInfo.VampireFateCardInfoCtrl"
  }
}

function VampireFateCardInfoPanel:Awake()
end

function VampireFateCardInfoPanel:OnEnable()
end

function VampireFateCardInfoPanel:OnAfterEnter()
end

function VampireFateCardInfoPanel:OnDisable()
end

function VampireFateCardInfoPanel:OnDestroy()
end

function VampireFateCardInfoPanel:OnRelease()
end

return VampireFateCardInfoPanel
