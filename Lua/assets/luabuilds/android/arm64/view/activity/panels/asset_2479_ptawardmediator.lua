local PtAwardMediator = class("PtAwardMediator", import("view.base.ContextMediator"))

function PtAwardMediator:register()
	self:bind(ActivityMediator.EVENT_PT_OPERATION, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.ACT_NEW_PT, arg_2_1)

		return
	end)

	return
end

function PtAwardMediator:listNotificationInterests()
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		GAME.ACT_NEW_PT_DONE
	}
end

function PtAwardMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	if var_4_0 == nil then
		-- block empty
	elseif var_4_0 == ActivityProxy.ACTIVITY_ADDED or var_4_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_4_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_PT_BUFF and var_4_1:getDataConfig("pt") == self.contextData.ptId then
			if self.contextData.ptData then
				self.contextData.ptData:Update(var_4_1)
			else
				self.contextData.ptData = ActivityBossPtData.New(var_4_1)
			end

			self.viewComponent:UpdateView()
		end
	elseif var_4_0 == GAME.ACT_NEW_PT_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_4_1.awards)
	end

	return
end

function PtAwardMediator:remove()
	return
end

return PtAwardMediator
