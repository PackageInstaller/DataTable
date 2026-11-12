local BtnTipsPanel = class("BtnTipsPanel", BasePanel)
BtnTipsPanel._bIsMainPanel = false
BtnTipsPanel._bAddToBackHistory = false
BtnTipsPanel._sSortingLayerName = AllEnum.SortingLayerName.UI_Top
BtnTipsPanel._tbDefine = {
  {
    sPrefabPath = "CommonTipsEx/ButtonTips.prefab",
    sCtrlName = "Game.UI.CommonTipsEx.BtnTipsCtrl"
  }
}

function BtnTipsPanel:Awake()
end

function BtnTipsPanel:OnEnable()
end

function BtnTipsPanel:OnDisable()
end

function BtnTipsPanel:OnDestroy()
end

function BtnTipsPanel:OnRelease()
end

return BtnTipsPanel
