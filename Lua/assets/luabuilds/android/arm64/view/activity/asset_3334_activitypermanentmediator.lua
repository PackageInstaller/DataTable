local ActivityPermanentMediator = class("ActivityPermanentMediator", import("..base.ContextMediator"))

ActivityPermanentMediator.START_SELECT = "ActivityPermanentMediator.START_SELECT"

function ActivityPermanentMediator:register()
	self:bind(ActivityPermanentMediator.START_SELECT, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.ACTIVITY_PERMANENT_START, {
			activity_id = arg_2_1
		})

		return
	end)
	self.viewComponent:setActivitys(getProxy(ActivityPermanentProxy):getActivityIdsByType(ActivityPermanentProxy.TYPE_NORMAL_ACTIVITY))

	return
end

function ActivityPermanentMediator:listNotificationInterests()
	return {
		GAME.ACTIVITY_PERMANENT_START_DONE,
		GAME.ACTIVITY_PERMANENT_FINISH_DONE
	}
end

function ActivityPermanentMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()
	local var_4_2

	if var_4_1 then
		::label_4_0::

		var_4_2 = var_4_1.id or var_4_1.activity_id
	end

	if var_4_0 == GAME.ACTIVITY_PERMANENT_START_DONE or var_4_0 == GAME.ACTIVITY_PERMANENT_FINISH_DONE then
		if not getProxy(ActivityPermanentProxy):IsNormalActivityId(var_4_2) then
			return
		end

		self.viewComponent:closeView()
	end

	return
end

return ActivityPermanentMediator
