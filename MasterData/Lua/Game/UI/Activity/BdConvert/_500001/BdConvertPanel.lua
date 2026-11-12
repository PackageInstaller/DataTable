local BdConvertPanel = class("BdConvertPanel", BasePanel)
BdConvertPanel._bIsMainPanel = true
BdConvertPanel._sSortingLayerName = AllEnum.SortingLayerName.UI
BdConvertPanel._sUIResRootPath = "UI_Activity/"
BdConvertPanel._tbDefine = {
  {
    sPrefabPath = "_500001/BdConvertPanel.prefab",
    sCtrlName = "Game.UI.Activity.BdConvert._500001.BdConvertCtrl"
  }
}

function BdConvertPanel:Awake()
  self.nTab = nil
end

function BdConvertPanel:OnEnable()
end

function BdConvertPanel:OnAfterEnter()
end

function BdConvertPanel:OnDisable()
end

function BdConvertPanel:OnDestroy()
end

function BdConvertPanel:OnRelease()
end

return BdConvertPanel
