local ItemTipsPanel = class("ItemTipsPanel", BasePanel)
ItemTipsPanel._bIsMainPanel = false
ItemTipsPanel._bAddToBackHistory = false
ItemTipsPanel._sSortingLayerName = AllEnum.SortingLayerName.UI_Top
ItemTipsPanel._tbDefine = {
  {
    sPrefabPath = "CommonTipsEx/ItemTips.prefab",
    sCtrlName = "Game.UI.CommonTipsEx.ItemTipsCtrl"
  }
}

function ItemTipsPanel:Awake()
end

function ItemTipsPanel:OnEnable()
end

function ItemTipsPanel:OnDisable()
end

function ItemTipsPanel:OnDestroy()
end

function ItemTipsPanel:OnRelease()
end

return ItemTipsPanel
