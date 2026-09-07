local GatewayNoticeMediator = class("GatewayNoticeMediator", import("..base.ContextMediator"))

function GatewayNoticeMediator:register()
	self:updateNotices()

	return
end

function GatewayNoticeMediator:updateNotices()
	self.viewComponent:updateNotices(getProxy(GatewayNoticeProxy):getGatewayNotices(false))

	return
end

return GatewayNoticeMediator
