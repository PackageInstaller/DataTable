local GoldenSpyBuffTipsPanel = class("GoldenSpyBuffTipsPanel", BasePanel)
GoldenSpyBuffTipsPanel._bIsMainPanel = false
GoldenSpyBuffTipsPanel._bAddToBackHistory = false
GoldenSpyBuffTipsPanel._sSortingLayerName = AllEnum.SortingLayerName.UI_Top
GoldenSpyBuffTipsPanel._sUIResRootPath = "UI_Activity/"
GoldenSpyBuffTipsPanel._tbDefine = {
  {
    sPrefabPath = "_400017/GoldenSpyBuffTips.prefab",
    sCtrlName = "Game.UI.Activity.GoldenSpy.GoldenSpyBuffTipsCtrl"
  }
}

function GoldenSpyBuffTipsPanel:Awake()
end

function GoldenSpyBuffTipsPanel:OnEnable()
end

function GoldenSpyBuffTipsPanel:OnAfterEnter()
end

function GoldenSpyBuffTipsPanel:OnDisable()
end

function GoldenSpyBuffTipsPanel:OnDestroy()
end

function GoldenSpyBuffTipsPanel:OnRelease()
end

return GoldenSpyBuffTipsPanel
