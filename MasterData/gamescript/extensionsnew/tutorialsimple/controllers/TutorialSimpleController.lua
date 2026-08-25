local TutorialSimpleController = NewClass("TutorialSimpleController", BaseController)

function TutorialSimpleController:OnInit()
end

function TutorialSimpleController:OnReset()
end

function TutorialSimpleController:OnOpenTutorialSimpleView(tutorialTid)
  UIManager.Instance:Reopen(Urls.TutorialSimpleView, tutorialTid)
end

return TutorialSimpleController
