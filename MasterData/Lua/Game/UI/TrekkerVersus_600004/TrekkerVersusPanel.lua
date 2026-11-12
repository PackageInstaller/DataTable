local TrekkerVersusPanel = class("TrekkerVersusPanel", BasePanel)
TrekkerVersusPanel._sUIResRootPath = "UI_Activity/"
TrekkerVersusPanel._tbDefine = {
  {
    sPrefabPath = "_600004/TrekkerVersus/TrekkerVersuslLevelSelect.prefab",
    sCtrlName = "Game.UI.TrekkerVersus_600004.TrekkerVersusCtrl"
  }
}

function TrekkerVersusPanel:Awake()
end

function TrekkerVersusPanel:OnEnable()
end

function TrekkerVersusPanel:OnAfterEnter()
end

function TrekkerVersusPanel:OnDisable()
end

function TrekkerVersusPanel:OnDestroy()
end

function TrekkerVersusPanel:OnRelease()
end

return TrekkerVersusPanel
