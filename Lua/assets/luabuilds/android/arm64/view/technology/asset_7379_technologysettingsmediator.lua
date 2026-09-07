local TechnologySettingsMediator = class("TechnologySettingsMediator", import("..base.ContextMediator"))

TechnologySettingsMediator.CHANGE_TENDENCY = "TechnologySettingsMediator.CHANGE_TENDENCY"
TechnologySettingsMediator.EXIT_CALL = "TechnologySettingsMediator.EXIT_CALL"

function TechnologySettingsMediator:register()
	self:bindEvent()

	return
end

function TechnologySettingsMediator:bindEvent()
	self:bind(TechnologySettingsMediator.CHANGE_TENDENCY, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.CHANGE_REFRESH_TECHNOLOGYS_TENDENCY, {
			pool_id = 2,
			tendency = arg_3_1
		})

		return
	end)

	return
end

function TechnologySettingsMediator:listNotificationInterests()
	return {
		GAME.CHANGE_REFRESH_TECHNOLOGYS_TENDENCY_DONE,
		GAME.SELECT_TEC_TARGET_CATCHUP_DONE
	}
end

function TechnologySettingsMediator:handleNotification(arg_5_1)
	local var_5_0 = arg_5_1:getName()

	if var_5_0 == GAME.CHANGE_REFRESH_TECHNOLOGYS_TENDENCY_DONE then
		local var_5_1 = getProxy(TechnologyProxy):getTendency(2)

		self.viewComponent:updateTendencyPage(var_5_1)
		self.viewComponent:updateTendencyBtn(var_5_1)
	elseif var_5_0 == GAME.SELECT_TEC_TARGET_CATCHUP_DONE then
		self.viewComponent:updateTargetCatchupPage(arg_5_1:getBody().tecID)
		self.viewComponent:updateTargetCatchupBtns()
	end

	return
end

function TechnologySettingsMediator:remove()
	self:sendNotification(TechnologySettingsMediator.EXIT_CALL)

	return
end

return TechnologySettingsMediator
