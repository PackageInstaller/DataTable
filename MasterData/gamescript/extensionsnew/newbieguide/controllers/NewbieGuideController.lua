local NewbieGuideController = NewClass("NewbieGuideController", BaseController)

function NewbieGuideController:OnInit()
end

function NewbieGuideController:OnReset()
end

function NewbieGuideController:OnOpenNewbieGuideView(guideTid, guideIndex, guideCfg, closeCb)
  UIManager.Instance:Reopen(Urls.NewbieGuideView, guideTid, guideIndex, guideCfg, closeCb)
end

function NewbieGuideController:CloseNewbieGuideView()
  UIManager.Instance:CloseByUrl(Urls.NewbieGuideView)
end

return NewbieGuideController
