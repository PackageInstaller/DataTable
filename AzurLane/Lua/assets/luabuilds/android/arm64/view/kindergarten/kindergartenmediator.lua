class = var_0_10000

local var_0_0 = "KindergartenMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.GO_SCENE = "KindergartenMediator.GO_SCENE"
var_0_1.GO_SUBLAYER = "KindergartenMediator.GO_SUBLAYER"
var_0_1.ON_EXTRA_RANK = "KindergartenMediator.ON_EXTRA_RANK"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.GO_SCENE, function(arg_2_0, arg_2_1, ...)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.GO_SCENE, arg_2_1, ...)

		return
	end)
	arg_1_0:bind(var_0_1.GO_SUBLAYER, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = arg_1_0

		var_3.addSubLayers(var_3_0, arg_3_1, nil, arg_3_2)

		return
	end)
	arg_1_0:bind(var_0_1.ON_EXTRA_RANK, function(arg_4_0)
		local var_4_0 = arg_1_0
		local var_4_1 = var_1.sendNotification

		GAME = var_2_10004

		local var_4_2 = var_2_10004.GO_SCENE

		SCENE = var_2_10005

		local var_4_3 = var_2_10005.BILLBOARD
		local var_4_4 = {}

		PowerRank = var_2_10007
		var_4_4.page = var_2_10007.TYPE_BOSSRUSH

		var_4_1(var_4_0, var_4_2, var_4_3, var_4_4)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_5_0)
	local var_5_0 = {}

	ActivityProxy = var_1_10002
	var_5_0[1] = var_1_10002.ACTIVITY_UPDATED
	GAME = var_2
	var_5_0[2] = var_2.SUBMIT_ACTIVITY_TASK_DONE

	return var_5_0
end

function var_0_1.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1
	local var_6_1 = arg_6_1.getName(var_6_0)
	local var_6_2 = arg_6_1
	local var_6_3 = arg_6_1.getBody(var_6_2)

	ActivityProxy = var_6_0

	local var_6_4

	if var_6_1 == var_6_0.ACTIVITY_UPDATED then
		var_6_4 = var_6_3.id
		ActivityConst = var_6_2

		if var_6_4 == var_6_2.ALVIT_PT_ACT_ID then
			local var_6_5 = arg_6_0.viewComponent

			var_5.UpdatePt(var_6_5)
		end
	else
		GAME = var_6_4

		if var_6_1 == var_6_4.SUBMIT_ACTIVITY_TASK_DONE then
			local var_6_6 = arg_6_0.viewComponent

			var_4.UpdateTask(var_6_6)
		end
	end

	return
end

return var_0_1
