local AAAPanel = class("AAAPanel", BasePanel)
AAAPanel._tbDefine = {
  {
    sPrefabPath = "AAA/AAAUI.prefab",
    sCtrlName = "Game.UI.AAA.AAACtrl"
  }
}

function AAAPanel:Awake()
end

function AAAPanel:OnEnable()
end

function AAAPanel:OnAfterEnter()
end

function AAAPanel:OnDisable()
end

function AAAPanel:OnDestroy()
end

function AAAPanel:OnRelease()
end

return AAAPanel
