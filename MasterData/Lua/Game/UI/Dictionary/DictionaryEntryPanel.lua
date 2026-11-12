local DictionaryEntryPanel = class("DictionaryEntryPanel", BasePanel)
DictionaryEntryPanel._bIsMainPanel = false
DictionaryEntryPanel._sSortingLayerName = AllEnum.SortingLayerName.UI_Top
DictionaryEntryPanel._tbDefine = {
  {
    sPrefabPath = "Dictionary/DictionaryEntryPanel.prefab",
    sCtrlName = "Game.UI.Dictionary.DictionaryEntryCtrl"
  }
}

function DictionaryEntryPanel:Awake()
end

function DictionaryEntryPanel:OnEnable()
end

function DictionaryEntryPanel:OnDisable()
end

function DictionaryEntryPanel:OnDestroy()
end

return DictionaryEntryPanel
