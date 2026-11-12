local MonsterTipsPanel = class("MonsterTipsPanel", BasePanel)
MonsterTipsPanel._bIsMainPanel = false
MonsterTipsPanel._bAddToBackHistory = false
MonsterTipsPanel._sSortingLayerName = AllEnum.SortingLayerName.UI_Top
MonsterTipsPanel._tbDefine = {
  {
    sPrefabPath = "CommonTipsEx/MonsterTips.prefab",
    sCtrlName = "Game.UI.CommonTipsEx.MonsterTipsCtrl"
  }
}

function MonsterTipsPanel:Awake()
end

function MonsterTipsPanel:OnEnable()
end

function MonsterTipsPanel:OnDisable()
end

function MonsterTipsPanel:OnDestroy()
end

function MonsterTipsPanel:OnRelease()
end

return MonsterTipsPanel
