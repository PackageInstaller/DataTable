class = var_0_10000

local var_0_0 = "MallAwardMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.INPUT_GOLD = "MallAwardMediator.INPUT_GOLD"
var_0_1.GET_PT_AWARD = "MallAwardMediator.GET_PT_AWARD"
var_0_1.SUBMIT_TASK = "MallAwardMediator.SUBMIT_TASK"
var_0_1.TASK_GO = "MallAwardMediator.TASK_GO"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.INPUT_GOLD, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0
		local var_2_1 = var_3.sendNotification

		GAME = var_2_10005

		local var_2_2 = var_2_10005.ACTIVITY_MALL_OP
		local var_2_3 = {
			activity_id = arg_2_1
		}

		ActivityMallOPCommand = var_2_10007
		var_2_3.cmd = var_2_10007.CMD.INPUT_GOLD
		var_2_3.arg1 = arg_2_2

		var_2_1(var_2_0, var_2_2, var_2_3)

		return
	end)
	arg_1_0:bind(var_0_1.GET_PT_AWARD, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10004

		var_3_1(var_3_0, var_2_10004.ACT_NEW_PT, arg_3_1)

		return
	end)
	arg_1_0:bind(var_0_1.SUBMIT_TASK, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10004

		var_4_1(var_4_0, var_2_10004.SUBMIT_TASK, arg_4_1.id)

		return
	end)
	arg_1_0:bind(var_0_1.TASK_GO, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0
		local var_5_1 = var_2.sendNotification

		GAME = var_2_10004

		var_5_1(var_5_0, var_2_10004.TASK_GO, {
			taskVO = arg_5_1
		})

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_6_0)
	local var_6_0 = {}

	ActivityProxy = var_1_10002
	var_6_0[1] = var_1_10002.ACTIVITY_UPDATED
	GAME = var_2
	var_6_0[2] = var_2.ACT_NEW_PT_DONE
	GAME = var_2
	var_6_0[3] = var_2.ACTIVITY_MALL_OP_DONE
	GAME = var_2
	var_6_0[4] = var_2.SUBMIT_TASK_AWARD_DOWN

	return var_6_0
end

function var_0_1.handleNotification(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1:getName()
	local var_7_1 = arg_7_1
	local var_7_2 = arg_7_1.getBody(var_7_1)

	GAME = var_7_1

	local var_7_3

	if var_7_0 == var_7_1.ACT_NEW_PT_DONE then
		var_1_10005 = arg_7_0

		if arg_7_0.IsAwardHandledByParent(var_1_10005) then
			var_1_10005 = arg_7_0.viewComponent

			var_7_3.UpdateView(var_1_10005)
		else
			var_1_10005 = arg_7_0.viewComponent
			var_7_3 = var_7_3.emit
			BaseUI = var_1_10006

			var_7_3(var_1_10005, var_1_10006.ON_ACHIEVE, var_7_2.awards, function()
				local var_8_0 = arg_7_0.viewComponent

				var_0.UpdateView(var_8_0)

				return
			end)
		end
	else
		GAME = var_7_3

		local var_7_4

		if var_7_0 == var_7_3.ACTIVITY_MALL_OP_DONE then
			var_7_4 = var_7_2.cmd
			ActivityMallOPCommand = var_1_10005

			if var_7_4 == var_1_10005.CMD.INPUT_GOLD then
				local var_7_5 = arg_7_0.viewComponent

				var_7_4.UpdateView(var_7_5)
			end
		else
			GAME = var_7_4

			if var_7_0 == var_7_4.SUBMIT_TASK_AWARD_DOWN then
				if arg_7_0:IsAwardHandledByParent() then
					local var_7_6 = arg_7_0.viewComponent

					var_4.UpdateView(var_7_6)
				else
					local var_7_7 = arg_7_0.viewComponent
					local var_7_8 = var_4.emit

					BaseUI = var_1_10006

					var_7_8(var_7_7, var_1_10006.ON_ACHIEVE, var_7_2.awards, function()
						local var_9_0 = arg_7_0.viewComponent

						var_0.UpdateView(var_9_0)

						return
					end)
				end
			end
		end
	end

	return
end

function var_0_1.IsAwardHandledByParent(arg_10_0)
	local var_10_0

	if arg_10_0.contextData then
		var_10_0 = arg_10_0.contextData.awardHandledByParent
	end

	return var_10_0
end

function var_0_1.remove(arg_11_0)
	return
end

return var_0_1
