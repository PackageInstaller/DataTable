local VampireSurvivorSettlelPanel = class("VampireSurvivorSettlelPanel", BasePanel)
VampireSurvivorSettlelPanel._bAddToBackHistory = false
VampireSurvivorSettlelPanel._tbDefine = {
  {
    sPrefabPath = "VampireBattle/VampireSettle.prefab",
    sCtrlName = "Game.UI.VampireSurvivor.VampireSettleCtrl"
  }
}

function VampireSurvivorSettlelPanel:Awake()
end

function VampireSurvivorSettlelPanel:OnEnable()
end

function VampireSurvivorSettlelPanel:OnAfterEnter()
end

function VampireSurvivorSettlelPanel:OnDisable()
end

function VampireSurvivorSettlelPanel:OnDestroy()
end

function VampireSurvivorSettlelPanel:OnRelease()
end

return VampireSurvivorSettlelPanel
