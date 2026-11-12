local ReceivePropsNPCPanel = class("ReceivePropsNPCPanel", BasePanel)
ReceivePropsNPCPanel._bIsMainPanel = false
ReceivePropsNPCPanel._tbDefine = {
  {
    sPrefabPath = "ReceivePropsEx/ReceivePropsNPCPanel.prefab",
    sCtrlName = "Game.UI.ReceivePropsEx.ReceivePropsNPCCtrl"
  }
}

function ReceivePropsNPCPanel:Awake()
end

function ReceivePropsNPCPanel:OnEnable()
end

function ReceivePropsNPCPanel:OnDisable()
end

function ReceivePropsNPCPanel:OnDestroy()
end

return ReceivePropsNPCPanel
