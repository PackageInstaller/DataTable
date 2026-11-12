local DescTipsPanel = class("DescTipsPanel", BasePanel)
DescTipsPanel._bIsMainPanel = false
DescTipsPanel._bAddToBackHistory = false
DescTipsPanel._sSortingLayerName = AllEnum.SortingLayerName.UI_Top
DescTipsPanel._tbDefine = {
  {
    sPrefabPath = "CommonTipsEx/DescTips.prefab",
    sCtrlName = "Game.UI.CommonTipsEx.DescTipsCtrl"
  }
}

function DescTipsPanel:Awake()
end

function DescTipsPanel:OnEnable()
end

function DescTipsPanel:OnDisable()
end

function DescTipsPanel:OnDestroy()
end

function DescTipsPanel:OnRelease()
end

return DescTipsPanel
