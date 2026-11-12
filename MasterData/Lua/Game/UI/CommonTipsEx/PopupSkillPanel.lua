local PopupSkillPanel = class("PopupSkillPanel", BasePanel)
PopupSkillPanel._bIsMainPanel = false
PopupSkillPanel._bAddToBackHistory = false
PopupSkillPanel._sSortingLayerName = AllEnum.SortingLayerName.UI_Top
PopupSkillPanel._tbDefine = {
  {
    sPrefabPath = "CommonTipsEx/PopupSkillPanel/PopupSkillPanel.prefab",
    sCtrlName = "Game.UI.CommonTipsEx.PopupSkillCtrl"
  }
}

function PopupSkillPanel:Awake()
end

function PopupSkillPanel:OnEnable()
end

function PopupSkillPanel:OnDisable()
end

function PopupSkillPanel:OnDestroy()
end

function PopupSkillPanel:OnRelease()
end

return PopupSkillPanel
