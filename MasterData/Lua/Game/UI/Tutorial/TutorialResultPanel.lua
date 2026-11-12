local TutorialResultPanel = class("TutorialResultPanel", BasePanel)
TutorialResultPanel._bAddToBackHistory = false
TutorialResultPanel._tbDefine = {
  {
    sPrefabPath = "Tutorial/TutorialResultPanel.prefab",
    sCtrlName = "Game.UI.Tutorial.TutorialResultCtrl"
  }
}

function TutorialResultPanel:Awake()
end

function TutorialResultPanel:OnEnable()
end

function TutorialResultPanel:OnAfterEnter()
end

function TutorialResultPanel:OnDisable()
end

function TutorialResultPanel:OnDestroy()
end

function TutorialResultPanel:OnRelease()
end

return TutorialResultPanel
