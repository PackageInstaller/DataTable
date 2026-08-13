class = var_0_10000

local var_0_0 = "EducateScheduleMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".base.EducateContextMediator"))

var_0_1.GET_PLANS = "GET_PLANS"
var_0_1.OPEN_FILTER_LAYER = "OPEN_FILTER_LAYER"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.GET_PLANS, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_2_2 = var_2_10005.EDUCATE_GET_PLANS
		local var_2_3 = {}

		EducatePlanProxy = var_2_10007
		var_2_3.plans = var_2_10007.GridData2ProtData(arg_2_1.gridData)
		var_2_3.isSkip = arg_2_1.isSkip
		var_2_3.isSkipEvent = arg_2_1.isSkipEvent

		function var_2_3.callback()
			return
		end

		var_2_1(var_2_0, var_2_2, var_2_3)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_FILTER_LAYER, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_4_2 = var_2_10005.New
		local var_4_3 = {}

		EducateScheduleFilterLayer = var_2_10008
		var_4_3.viewComponent = var_2_10008
		EducateScheduleFilterMediator = var_2_10008
		var_4_3.mediator = var_2_10008
		var_4_3.data = arg_4_1

		var_4_1(var_4_0, var_4_2(var_4_3))

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_5_0)
	local var_5_0 = {}

	GAME = var_1_10002
	var_5_0[1] = var_1_10002.EDUCATE_REFRESH_DONE

	return var_5_0
end

function var_0_1.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1
	local var_6_1 = arg_6_1.getName(var_6_0)
	local var_6_2 = arg_6_1:getBody()

	GAME = var_6_0

	if var_6_1 == var_6_0.EDUCATE_REFRESH_DONE then
		local var_6_3 = arg_6_0.viewComponent
		local var_6_4 = var_4.emit

		EducateBaseUI = var_1_10007

		local var_6_5 = var_1_10007.EDUCATE_CHANGE_SCENE

		SCENE = var_1_10008

		var_6_4(var_6_3, var_6_5, var_1_10008.EDUCATE)
	end

	return
end

return var_0_1
