_class("UIExtendLogic", UIBase)
UIExtendLogic = UIExtendLogic

function UIExtendLogic:Constructor()
  Log.debug("[UIExtend] UIExtendLogic:Constructor")
end

function UIExtendLogic:Dispose()
  self:OnDestroy()
  Log.debug("[UIExtend] UIExtendLogic:Dispose")
  UIExtendLogic.super.Hide(self)
  UIExtendLogic.super.UnLoad(self)
  UIExtendLogic.super.Dispose(self)
end

function UIExtendLogic:OnCreate()
end

function UIExtendLogic:OnDestroy()
end
