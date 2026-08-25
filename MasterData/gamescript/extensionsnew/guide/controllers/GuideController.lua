local GuideController = NewClass("GuideController", BaseController)

function GuideController:OnInit()
end

function GuideController:OnReset()
end

function GuideController:OnOpenGuideView()
  UIManager.Instance:Reopen(Urls.GuideView)
end

function GuideController:CloseGuideView()
  UIManager.Instance:CloseByUrl(Urls.GuideView)
end

return GuideController
