local LampNoticePanel = class("LampNoticePanel", BasePanel)
LampNoticePanel._bIsMainPanel = false
LampNoticePanel._sSortingLayerName = AllEnum.SortingLayerName.Overlay
LampNoticePanel._tbDefine = {
  {
    sPrefabPath = "LampNotice/LampNoticePanel.prefab",
    sCtrlName = "Game.UI.LampNotice.LampNoticeCtrl"
  }
}

function LampNoticePanel:Awake()
end

function LampNoticePanel:OnEnable()
end

function LampNoticePanel:OnAfterEnter()
end

function LampNoticePanel:OnDisable()
end

function LampNoticePanel:OnDestroy()
end

function LampNoticePanel:OnRelease()
end

return LampNoticePanel
