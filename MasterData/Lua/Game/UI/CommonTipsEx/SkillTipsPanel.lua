local SkillTipsPanel = class("SkillTipsPanel", BasePanel)
SkillTipsPanel._bIsMainPanel = false
SkillTipsPanel._bAddToBackHistory = false
SkillTipsPanel._sSortingLayerName = AllEnum.SortingLayerName.UI_Top
SkillTipsPanel._tbDefine = {
  {
    sPrefabPath = "CommonTipsEx/SkillTips.prefab",
    sCtrlName = "Game.UI.CommonTipsEx.SkillTipsCtrl"
  }
}

function SkillTipsPanel:Awake()
end

function SkillTipsPanel:OnEnable()
end

function SkillTipsPanel:OnDisable()
end

function SkillTipsPanel:OnDestroy()
end

function SkillTipsPanel:OnRelease()
end

return SkillTipsPanel
