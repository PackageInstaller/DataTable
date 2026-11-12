local FillMaterialPanel = class("FillMaterialPanel", BasePanel)
FillMaterialPanel._bIsMainPanel = false
FillMaterialPanel._tbDefine = {
  {
    sPrefabPath = "FillMaterial/FillMaterialPanel.prefab",
    sCtrlName = "Game.UI.FillMaterial.FillMaterialCtrl"
  }
}

function FillMaterialPanel:Awake()
end

function FillMaterialPanel:OnEnable()
end

function FillMaterialPanel:OnDisable()
end

function FillMaterialPanel:OnDestroy()
end

return FillMaterialPanel
