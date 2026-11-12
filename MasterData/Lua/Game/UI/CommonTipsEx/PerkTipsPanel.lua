local PerkTipsPanel = class("PerkTipsPanel", BasePanel)
PerkTipsPanel._bIsMainPanel = false
PerkTipsPanel._bAddToBackHistory = false
PerkTipsPanel._sSortingLayerName = AllEnum.SortingLayerName.UI_Top
PerkTipsPanel._tbDefine = {
  {
    sPrefabPath = "CommonTipsEx/PerkTips.prefab",
    sCtrlName = "Game.UI.CommonTipsEx.PerkTipsCtrl"
  }
}

function PerkTipsPanel:Awake()
end

function PerkTipsPanel:OnEnable()
end

function PerkTipsPanel:OnDisable()
end

function PerkTipsPanel:OnDestroy()
end

function PerkTipsPanel:OnRelease()
end

return PerkTipsPanel
