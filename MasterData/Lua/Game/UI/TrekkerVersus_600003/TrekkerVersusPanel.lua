local TrekkerVersusPanel = class("TrekkerVersusPanel", BasePanel)
TrekkerVersusPanel._sUIResRootPath = "UI_Activity/"
TrekkerVersusPanel._tbDefine = {
  {
    sPrefabPath = "_600003/TrekkerVersus/TrekkerVersuslLevelSelect.prefab",
    sCtrlName = "Game.UI.TrekkerVersus_600003.TrekkerVersusCtrl"
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
