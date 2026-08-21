local var_0_0 = class("TechnologySettingsMediator", import("..base.ContextMediator"))

var_0_0.CHANGE_TENDENCY = "TechnologySettingsMediator.CHANGE_TENDENCY"
var_0_0.EXIT_CALL = "TechnologySettingsMediator.EXIT_CALL"

function var_0_0.register(arg_1_0)
	arg_1_0:bindEvent()

	return
end

function var_0_0.bindEvent(arg_2_0)
	arg_2_0:bind(var_0_0.CHANGE_TENDENCY, function(arg_3_0, arg_3_1)
		arg_2_0:sendNotification(GAME.CHANGE_REFRESH_TECHNOLOGYS_TENDENCY, {
			pool_id = 2,
			tendency = arg_3_1
		})

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_4_0)
	return {
		GAME.CHANGE_REFRESH_TECHNOLOGYS_TENDENCY_DONE,
		GAME.SELECT_TEC_TARGET_CATCHUP_DONE
	}
end

function var_0_0.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()

	if var_5_0 == GAME.CHANGE_REFRESH_TECHNOLOGYS_TENDENCY_DONE then
		local var_5_1 = getProxy(TechnologyProxy):getTendency(2)

		arg_5_0.viewComponent:updateTendencyPage(var_5_1)
		arg_5_0.viewComponent:updateTendencyBtn(var_5_1)
	elseif var_5_0 == GAME.SELECT_TEC_TARGET_CATCHUP_DONE then
		arg_5_0.viewComponent:updateTargetCatchupPage(arg_5_1:getBody().tecID)
		arg_5_0.viewComponent:updateTargetCatchupBtns()
	end

	return
end

function var_0_0.remove(arg_6_0)
	arg_6_0:sendNotification(var_0_0.EXIT_CALL)

	return
end

return var_0_0
