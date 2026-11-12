local ReceivePropsPanel = class("ReceivePropsPanel", BasePanel)
ReceivePropsPanel._bIsMainPanel = false
ReceivePropsPanel._tbDefine = {
  {
    sPrefabPath = "ReceivePropsEx/ReceivePropsPanel.prefab",
    sCtrlName = "Game.UI.ReceivePropsEx.ReceivePropsCtrl"
  }
}

function ReceivePropsPanel:Awake()
end

function ReceivePropsPanel:OnEnable()
end

function ReceivePropsPanel:OnDisable()
end

function ReceivePropsPanel:OnDestroy()
end

return ReceivePropsPanel
