class = var_0_10000

local var_0_0 = "AtelierMaterialDetailMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.SHOW_DETAIL = "SHOW_DETAIL"
var_0_1.GO_RECIPE = "GO_RECIPE"

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.bind

	GAME = var_1_10003

	var_1_1(var_1_0, var_1_10003.GO_SCENE, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0.viewComponent

		var_3.closeView(var_2_0)

		local var_2_1 = arg_1_0
		local var_2_2 = var_3.sendNotification

		GAME = var_2_10005

		var_2_2(var_2_1, var_2_10005.GO_SCENE, arg_2_1, arg_2_2)

		return
	end)
	arg_1_0:bind(var_0_1.GO_RECIPE, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0.viewComponent

		var_2.closeView(var_3_0)

		getProxy = var_2
		ActivityProxy = var_3_0

		local var_3_1 = var_2(var_3_0)
		local var_3_2 = var_2.getActivityByType

		ActivityConst = var_2_10004

		local var_3_3 = var_3_2(var_3_1, var_2_10004.ACTIVITY_TYPE_ATELIER_LINK)
		local var_3_4 = arg_1_0
		local var_3_5 = var_3.sendNotification

		GAME = var_2_10005

		local var_3_6 = var_2_10005.GO_SCENE

		SCENE = var_2_10006

		var_3_5(var_3_4, var_3_6, var_2_10006.ATELIER_COMPOSITE, {
			formulaId = arg_3_1,
			activityID = var_3_3.id
		})

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_4_0)
	return {}
end

function var_0_1.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	if var_5_0 == nil then
		-- block empty
	end

	return
end

function var_0_1.remove(arg_6_0)
	return
end

return var_0_1
