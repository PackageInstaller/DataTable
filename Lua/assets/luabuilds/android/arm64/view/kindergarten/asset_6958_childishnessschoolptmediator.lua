local ChildishnessSchoolPtMediator = class("ChildishnessSchoolPtMediator", import("view.base.ContextMediator"))

ChildishnessSchoolPtMediator.EVENT_PT_OPERATION = "event pt op"

function ChildishnessSchoolPtMediator:register()
	self:bind(ChildishnessSchoolPtMediator.EVENT_PT_OPERATION, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.ACT_NEW_PT, arg_2_1)

		return
	end)

	return
end

function ChildishnessSchoolPtMediator:listNotificationInterests()
	return {
		GAME.ACT_NEW_PT_DONE
	}
end

function ChildishnessSchoolPtMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getBody()

	if arg_4_1:getName() == GAME.ACT_NEW_PT_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_4_0.awards, var_4_0.callback)
		self.viewComponent:Show()
	end

	return
end

return ChildishnessSchoolPtMediator
