class = var_0_10000

local var_0_0 = "MallOrderMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.START_ORDER = "MallOrderMediator.START_ORDER"
var_0_1.COMPLETE_ORDER = "MallOrderMediator.COMPLETE_ORDER"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.START_ORDER, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		local var_2_0 = arg_1_0
		local var_2_1 = var_4.sendNotification

		GAME = var_2_10007

		local var_2_2 = var_2_10007.ACTIVITY_MALL_OP
		local var_2_3 = {
			activity_id = arg_2_1
		}

		ActivityMallOPCommand = var_2_10009
		var_2_3.cmd = var_2_10009.CMD.START_ORDER
		var_2_3.arg1 = arg_2_2
		var_2_3.arg_list = arg_2_3

		var_2_1(var_2_0, var_2_2, var_2_3)

		return
	end)
	arg_1_0:bind(var_0_1.COMPLETE_ORDER, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = arg_1_0
		local var_3_1 = var_3.sendNotification

		GAME = var_2_10006

		local var_3_2 = var_2_10006.ACTIVITY_MALL_OP
		local var_3_3 = {
			activity_id = arg_3_1
		}

		ActivityMallOPCommand = var_2_10008
		var_3_3.cmd = var_2_10008.CMD.COMPLETE_ORDER
		var_3_3.arg1 = arg_3_2

		var_3_1(var_3_0, var_3_2, var_3_3)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_4_0)
	local var_4_0 = {}

	GAME = var_1_10002
	var_4_0[1] = var_1_10002.ACTIVITY_MALL_OP_DONE
	GAME = var_2
	var_4_0[2] = var_2.ZERO_HOUR_OP_DONE

	return var_4_0
end

function var_0_1.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1
	local var_5_1 = arg_5_1.getName(var_5_0)
	local var_5_2 = arg_5_1:getBody()

	GAME = var_5_0

	local var_5_3

	if var_5_1 == var_5_0.ACTIVITY_MALL_OP_DONE then
		var_5_3 = var_5_2.levels[1]

		local var_5_4 = var_5_2.levels[2]
		local var_5_5 = {}
		local var_5_6 = var_5_2.cmd

		ActivityMallOPCommand = var_1_10008

		if var_5_6 == var_1_10008.CMD.COMPLETE_ORDER then
			local var_5_7 = arg_5_0.viewComponent

			var_5_6.ClearSelectedIds(var_5_7)

			table = var_5_6

			var_5_6.insert(var_5_5, function(arg_6_0)
				local var_6_0 = arg_5_0.viewComponent

				var_1.ShowCompleteDialogue(var_6_0, arg_6_0)

				return
			end)

			pg = var_5_6

			if var_5_6.activity_mall_custom_order[var_5_2.completeOrderId].story_unlock ~= "" then
				table = var_8

				var_8.insert(var_5_5, function(arg_7_0)
					pg = var_2_10001

					local var_7_0 = var_2_10001.NewStoryMgr.GetInstance()

					var_1.Play(var_7_0, var_5_6, arg_7_0)

					return
				end)
			end

			if #var_5_2.awards >= 0 then
				table = var_8

				var_8.insert(var_5_5, function(arg_8_0)
					local var_8_0 = arg_5_0.viewComponent
					local var_8_1 = var_1.emit

					BaseUI = var_2_10004

					var_8_1(var_8_0, var_2_10004.ON_ACHIEVE, var_5_2.awards, arg_8_0)

					return
				end)
			end

			if var_5_4 ~= var_5_3 then
				table = var_8

				var_8.insert(var_5_5, function(arg_9_0)
					local var_9_0 = arg_5_0.viewComponent

					var_1.ShowUpgradeBox(var_9_0, var_5_3, var_5_4, arg_9_0)

					return
				end)
			end
		end

		seriesAsync = var_5_6

		var_5_6(var_5_5, function()
			local var_10_0 = arg_5_0.viewComponent

			var_0.UpdateData(var_10_0)

			local var_10_1 = arg_5_0.viewComponent

			var_0.UpdateView(var_10_1)

			return
		end)
	else
		GAME = var_5_3

		if var_5_1 == var_5_3.ZERO_HOUR_OP_DONE then
			local var_5_8 = arg_5_0.viewComponent

			var_4.UpdateData(var_5_8)

			local var_5_9 = arg_5_0.viewComponent

			var_4.UpdateView(var_5_9)
		end
	end

	return
end

return var_0_1
