local BulletinBoardMediator = class("BulletinBoardMediator", import("..base.ContextMediator"))

BulletinBoardMediator.SET_STOP_REMIND = "set_stop_remind"

function BulletinBoardMediator:register()
	local var_1_0 = getProxy(ServerNoticeProxy)

	var_1_0:setStopNewTip()
	self.viewComponent:setNotices((var_1_0:getServerNotices(false)))
	self:bind(self.SET_STOP_REMIND, function(arg_2_0, arg_2_1)
		getProxy(ServerNoticeProxy):setStopRemind(arg_2_1)

		return
	end)

	return
end

function BulletinBoardMediator:listNotificationInterests()
	return {}
end

function BulletinBoardMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	return
end

return BulletinBoardMediator
