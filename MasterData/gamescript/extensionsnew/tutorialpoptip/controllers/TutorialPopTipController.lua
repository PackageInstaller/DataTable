local TutorialPopTipController = NewClass("TutorialPopTipController", BaseController)

function TutorialPopTipController:OnInit()
end

function TutorialPopTipController:OnReset()
end

function TutorialPopTipController:OnOpenTutorialPopTipView(tidGroup)
  UIManager.Instance:Reopen(Urls.TutorialPopTipView, tidGroup)
end

return TutorialPopTipController
