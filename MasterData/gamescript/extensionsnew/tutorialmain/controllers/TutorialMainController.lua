local TutorialMainController = NewClass("TutorialMainController", BaseController)

function TutorialMainController:OnInit()
end

function TutorialMainController:OnReset()
end

function TutorialMainController:OnOpenTutorialMainView(tidGroup)
  UIManager.Instance:Reopen(Urls.TutorialMainView, tidGroup)
end

function TutorialMainController:ReqTutorialFinishRead(tid)
  TutorialDataUtils.ReqTutorialFinishRead(tid)
  self:LocalNotify(NotifyId.OnTutorialMainDataChanged)
end

function TutorialMainController:ReqTutorialFinishAllRead()
  TutorialDataUtils.ReqTutorialFinishAllRead()
  self:LocalNotify(NotifyId.OnTutorialMainDataChanged)
end

return TutorialMainController
