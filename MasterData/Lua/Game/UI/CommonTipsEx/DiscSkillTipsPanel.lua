local DiscSkillTipsPanel = class("DiscSkillTipsPanel", BasePanel)
DiscSkillTipsPanel._bIsMainPanel = false
DiscSkillTipsPanel._bAddToBackHistory = false
DiscSkillTipsPanel._sSortingLayerName = AllEnum.SortingLayerName.UI_Top
DiscSkillTipsPanel._tbDefine = {
  {
    sPrefabPath = "CommonTipsEx/DiscSkillTips.prefab",
    sCtrlName = "Game.UI.CommonTipsEx.DiscSkillTipsCtrl"
  }
}

function DiscSkillTipsPanel:Awake()
end

function DiscSkillTipsPanel:OnEnable()
end

function DiscSkillTipsPanel:OnDisable()
end

function DiscSkillTipsPanel:OnDestroy()
end

function DiscSkillTipsPanel:OnRelease()
end

return DiscSkillTipsPanel
