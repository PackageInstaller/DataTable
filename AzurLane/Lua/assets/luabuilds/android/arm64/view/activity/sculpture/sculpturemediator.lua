class = var_0_10000

local var_0_0 = "SculptureMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.ON_UNLOCK_SCULPTURE = "SculptureMediator:ON_UNLOCK_SCULPTURE"
var_0_1.ON_DRAW_SCULPTURE = "SculptureMediator:ON_DRAW_SCULPTURE"
var_0_1.ON_JOINT_SCULPTURE = "SculptureMediator:ON_JOINT_SCULPTURE"
var_0_1.ON_FINSIH_SCULPTURE = "SculptureMediator:ON_FINSIH_SCULPTURE"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_FINSIH_SCULPTURE, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_2_2 = var_2_10005.SCULPTURE_ACT_OP
		local var_2_3 = {
			id = arg_2_1
		}

		SculptureActivity = var_2_10007
		var_2_3.state = var_2_10007.STATE_FINSIH

		var_2_1(var_2_0, var_2_2, var_2_3)

		return
	end)
	arg_1_0:bind(var_0_1.ON_JOINT_SCULPTURE, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_3_2 = var_2_10005.SCULPTURE_ACT_OP
		local var_3_3 = {
			id = arg_3_1
		}

		SculptureActivity = var_2_10007
		var_3_3.state = var_2_10007.STATE_JOINT

		var_3_1(var_3_0, var_3_2, var_3_3)

		return
	end)
	arg_1_0:bind(var_0_1.ON_UNLOCK_SCULPTURE, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_4_2 = var_2_10005.SCULPTURE_ACT_OP
		local var_4_3 = {
			id = arg_4_1
		}

		SculptureActivity = var_2_10007
		var_4_3.state = var_2_10007.STATE_UNLOCK

		var_4_1(var_4_0, var_4_2, var_4_3)

		return
	end)

	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.ON_DRAW_SCULPTURE, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0
		local var_5_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_5_2 = var_2_10005.SCULPTURE_ACT_OP
		local var_5_3 = {
			id = arg_5_1
		}

		SculptureActivity = var_2_10007
		var_5_3.state = var_2_10007.STATE_DRAW

		var_5_1(var_5_0, var_5_2, var_5_3)

		return
	end)

	getProxy = var_1
	ActivityProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = var_1.getActivityByType

	ActivityConst = var_4

	local var_1_3 = var_1_2(var_1_1, var_4.ACTIVITY_TYPE_SCULPTURE)
	local var_1_4 = arg_1_0.viewComponent

	var_2.SetActivity(var_1_4, var_1_3)

	return
end

function var_0_1.listNotificationInterests(arg_6_0)
	local var_6_0 = {}

	GAME = var_1_10002
	var_6_0[1] = var_1_10002.SCULPTURE_ACT_OP_DONE

	return var_6_0
end

function var_0_1.handleNotification(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1
	local var_7_1 = arg_7_1.getName(var_7_0)
	local var_7_2 = arg_7_1:getBody()

	GAME = var_7_0

	if var_7_1 == var_7_0.SCULPTURE_ACT_OP_DONE then
		local var_7_3 = arg_7_0.viewComponent

		var_4.OnUpdateActivity(var_7_3, var_7_2.state, var_7_2.id, var_7_2.activity)

		if #var_7_2.awards > 0 then
			local var_7_4 = arg_7_0.viewComponent
			local var_7_5 = var_4.emit

			BaseUI = var_7

			var_7_5(var_7_4, var_7.ON_ACHIEVE, var_7_2.awards)
		end
	end

	return
end

return var_0_1
