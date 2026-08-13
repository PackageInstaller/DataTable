class = var_0_10000

local var_0_0 = "MallMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.CHANGE_SCENE = "MallMediator.CHANGE_SCENE"
var_0_1.GO_SCENE = "MallMediator.GO_SCENE"
var_0_1.GO_SUBLAYER = "MallMediator.GO_SUBLAYER"
var_0_1.OPEN_SUMMARY_BOX = "MallMediator.OPEN_SUMMARY_BOX"
var_0_1.SETTLE_ROUND = "MallMediator.SETTLE_ROUND"
var_0_1.INPUT_GOLD = "MallMediator.INPUT_GOLD"
var_0_1.GET_GOLD_AWARD = "MallMediator.GET_GOLD_AWARD"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.CHANGE_SCENE, function(arg_2_0, arg_2_1, ...)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.CHANGE_SCENE, arg_2_1, ...)

		return
	end)
	arg_1_0:bind(var_0_1.GO_SCENE, function(arg_3_0, arg_3_1, ...)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10004

		var_3_1(var_3_0, var_2_10004.GO_SCENE, arg_3_1, ...)

		return
	end)
	arg_1_0:bind(var_0_1.GO_SUBLAYER, function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_1_0

		var_3.addSubLayers(var_4_0, arg_4_1, nil, arg_4_2)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_SUMMARY_BOX, function(arg_5_0)
		local var_5_0 = arg_1_0.viewComponent

		var_1.ShowSummaryBox(var_5_0)

		return
	end)
	arg_1_0:bind(var_0_1.SETTLE_ROUND, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.sendNotification

		GAME = var_2_10004

		local var_6_2 = var_2_10004.ACTIVITY_MALL_OP
		local var_6_3 = {
			activity_id = arg_6_1
		}

		ActivityMallOPCommand = var_2_10006
		var_6_3.cmd = var_2_10006.CMD.SETTLE_ROUND

		var_6_1(var_6_0, var_6_2, var_6_3)

		return
	end)
	arg_1_0:bind(var_0_1.INPUT_GOLD, function(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = arg_1_0
		local var_7_1 = var_3.sendNotification

		GAME = var_2_10005

		local var_7_2 = var_2_10005.ACTIVITY_MALL_OP
		local var_7_3 = {
			activity_id = arg_7_1
		}

		ActivityMallOPCommand = var_2_10007
		var_7_3.cmd = var_2_10007.CMD.INPUT_GOLD
		var_7_3.arg1 = arg_7_2

		var_7_1(var_7_0, var_7_2, var_7_3)

		return
	end)
	arg_1_0:bind(var_0_1.GET_GOLD_AWARD, function(arg_8_0, arg_8_1, arg_8_2)
		local var_8_0 = arg_1_0
		local var_8_1 = var_3.sendNotification

		GAME = var_2_10005

		local var_8_2 = var_2_10005.ACTIVITY_MALL_OP
		local var_8_3 = {
			activity_id = arg_8_1
		}

		ActivityMallOPCommand = var_2_10007
		var_8_3.cmd = var_2_10007.CMD.GET_GOLD_AWARD
		var_8_3.arg_list = arg_8_2

		var_8_1(var_8_0, var_8_2, var_8_3)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_9_0)
	local var_9_0 = {}

	GAME = var_1_10002
	var_9_0[1] = var_1_10002.ACTIVITY_MALL_OP_DONE
	GAME = var_2
	var_9_0[2] = var_2.ZERO_HOUR_OP_DONE

	return var_9_0
end

function var_0_1.handleNotification(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1:getName()
	local var_10_1 = arg_10_1
	local var_10_2 = arg_10_1.getBody(var_10_1)

	GAME = var_10_1

	local var_10_3

	if var_10_0 == var_10_1.ACTIVITY_MALL_OP_DONE then
		var_10_3 = var_10_2.levels[1]

		local var_10_4 = var_10_2.levels[2]
		local var_10_5 = {}
		local var_10_6 = var_10_2.cmd

		ActivityMallOPCommand = var_1_10008

		if var_10_6 == var_1_10008.CMD.SETTLE_ROUND then
			table = var_10_6

			var_10_6.insert(var_10_5, function(arg_11_0)
				local var_11_0 = arg_10_0.viewComponent

				var_1.ShowSettleBox(var_11_0, var_10_3, arg_11_0)

				return
			end)

			if #var_10_2.awards >= 0 then
				table = var_10_6

				var_10_6.insert(var_10_5, function(arg_12_0)
					local var_12_0 = arg_10_0.viewComponent
					local var_12_1 = var_1.emit

					BaseUI = var_2_10003

					var_12_1(var_12_0, var_2_10003.ON_ACHIEVE, var_10_2.awards, arg_12_0)

					return
				end)
			end

			if var_10_4 ~= var_10_3 then
				table = var_10_6

				var_10_6.insert(var_10_5, function(arg_13_0)
					local var_13_0 = arg_10_0.viewComponent

					var_1.ShowUpgradeBox(var_13_0, var_10_3, var_10_4, arg_13_0)

					return
				end)
			end
		end

		seriesAsync = var_10_6

		var_10_6(var_10_5, function()
			local var_14_0 = arg_10_0.viewComponent

			var_0.UpdateData(var_14_0)

			local var_14_1 = arg_10_0.viewComponent

			var_0.UpdateView(var_14_1)

			return
		end)
	else
		GAME = var_10_3

		if var_10_0 == var_10_3.ZERO_HOUR_OP_DONE then
			local var_10_7 = arg_10_0.viewComponent

			var_4.UpdateData(var_10_7)

			local var_10_8 = arg_10_0.viewComponent

			var_4.UpdateView(var_10_8)
		end
	end

	return
end

return var_0_1
