class = var_0_10000

local var_0_0 = "TechnologySettingsMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.CHANGE_TENDENCY = "TechnologySettingsMediator.CHANGE_TENDENCY"
var_0_1.EXIT_CALL = "TechnologySettingsMediator.EXIT_CALL"

function var_0_1.register(arg_1_0)
	arg_1_0:bindEvent()

	return
end

function var_0_1.bindEvent(arg_2_0)
	arg_2_0:bind(var_0_1.CHANGE_TENDENCY, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_2_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10004

		var_3_1(var_3_0, var_2_10004.CHANGE_REFRESH_TECHNOLOGYS_TENDENCY, {
			pool_id = 2,
			tendency = arg_3_1
		})

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_4_0)
	local var_4_0 = {}

	GAME = var_1_10002
	var_4_0[1] = var_1_10002.CHANGE_REFRESH_TECHNOLOGYS_TENDENCY_DONE
	GAME = var_2
	var_4_0[2] = var_2.SELECT_TEC_TARGET_CATCHUP_DONE

	return var_4_0
end

function var_0_1.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1
	local var_5_2 = arg_5_1.getBody(var_5_1)

	GAME = var_5_1

	local var_5_4

	if var_5_0 == var_5_1.CHANGE_REFRESH_TECHNOLOGYS_TENDENCY_DONE then
		getProxy = var_5_4
		TechnologyProxy = var_1_10005

		local var_5_3 = var_5_4(var_1_10005)

		var_5_4 = var_5_4.getTendency(var_5_3, 2)

		local var_5_5 = arg_5_0.viewComponent

		var_5.updateTendencyPage(var_5_5, var_5_4)

		local var_5_6 = arg_5_0.viewComponent

		var_5.updateTendencyBtn(var_5_6, var_5_4)
	else
		GAME = var_5_4

		if var_5_0 == var_5_4.SELECT_TEC_TARGET_CATCHUP_DONE then
			local var_5_7 = arg_5_0.viewComponent

			var_4.updateTargetCatchupPage(var_5_7, var_5_2.tecID)

			local var_5_8 = arg_5_0.viewComponent

			var_4.updateTargetCatchupBtns(var_5_8)
		end
	end

	return
end

function var_0_1.remove(arg_6_0)
	arg_6_0:sendNotification(var_0_1.EXIT_CALL)

	return
end

return var_0_1
