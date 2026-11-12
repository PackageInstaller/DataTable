local BdConvertBuildDetailPanel = class("BdConvertBuildDetailPanel", BasePanel)
BdConvertBuildDetailPanel._sUIResRootPath = "UI_Activity/"
BdConvertBuildDetailPanel._tbDefine = {
  {
    sPrefabPath = "_500001/BdConvertBuildDetailPanel.prefab",
    sCtrlName = "Game.UI.Activity.BdConvert._500001.BdConvertBuildDetailCtrl"
  }
}

function BdConvertBuildDetailPanel:Awake()
end

function BdConvertBuildDetailPanel:OnEnable()
end

function BdConvertBuildDetailPanel:OnDisable()
end

function BdConvertBuildDetailPanel:OnDestroy()
end

function BdConvertBuildDetailPanel:OnRelease()
end

return BdConvertBuildDetailPanel
