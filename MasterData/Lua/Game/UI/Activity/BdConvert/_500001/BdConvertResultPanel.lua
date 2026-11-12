local BdConvertQuestPanel = class("BdConvertQuestPanel", BasePanel)
BdConvertQuestPanel._bIsMainPanel = false
BdConvertQuestPanel._sSortingLayerName = AllEnum.SortingLayerName.UI
BdConvertQuestPanel._sUIResRootPath = "UI_Activity/"
BdConvertQuestPanel._nSnapshotPrePanel = 1
BdConvertQuestPanel._tbDefine = {
  {
    sPrefabPath = "_500001/BdConvertResultPanel.prefab",
    sCtrlName = "Game.UI.Activity.BdConvert._500001.BdConvertResultCtrl"
  }
}

function BdConvertQuestPanel:Awake()
end

function BdConvertQuestPanel:OnEnable()
end

function BdConvertQuestPanel:OnAfterEnter()
end

function BdConvertQuestPanel:OnDisable()
end

function BdConvertQuestPanel:OnDestroy()
end

function BdConvertQuestPanel:OnRelease()
end

return BdConvertQuestPanel
