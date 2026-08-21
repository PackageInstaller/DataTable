local var_0_0 = class("MallMediator", import("view.base.ContextMediator"))

var_0_0.CHANGE_SCENE = "MallMediator.CHANGE_SCENE"
var_0_0.GO_SCENE = "MallMediator.GO_SCENE"
var_0_0.GO_SUBLAYER = "MallMediator.GO_SUBLAYER"
var_0_0.OPEN_SUMMARY_BOX = "MallMediator.OPEN_SUMMARY_BOX"
var_0_0.SETTLE_ROUND = "MallMediator.SETTLE_ROUND"
var_0_0.INPUT_GOLD = "MallMediator.INPUT_GOLD"
var_0_0.GET_GOLD_AWARD = "MallMediator.GET_GOLD_AWARD"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.CHANGE_SCENE, function(arg_2_0, arg_2_1, ...)
		arg_1_0:sendNotification(GAME.CHANGE_SCENE, arg_2_1, ...)

		return
	end)
	arg_1_0:bind(var_0_0.GO_SCENE, function(arg_3_0, arg_3_1, ...)
		arg_1_0:sendNotification(GAME.GO_SCENE, arg_3_1, ...)

		return
	end)
	arg_1_0:bind(var_0_0.GO_SUBLAYER, function(arg_4_0, arg_4_1, arg_4_2)
		arg_1_0:addSubLayers(arg_4_1, nil, arg_4_2)

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_SUMMARY_BOX, function(arg_5_0)
		arg_1_0.viewComponent:ShowSummaryBox()

		return
	end)
	arg_1_0:bind(var_0_0.SETTLE_ROUND, function(arg_6_0, arg_6_1)
		arg_1_0:sendNotification(GAME.ACTIVITY_MALL_OP, {
			activity_id = arg_6_1,
			cmd = ActivityMallOPCommand.CMD.SETTLE_ROUND
		})

		return
	end)
	arg_1_0:bind(var_0_0.INPUT_GOLD, function(arg_7_0, arg_7_1, arg_7_2)
		arg_1_0:sendNotification(GAME.ACTIVITY_MALL_OP, {
			activity_id = arg_7_1,
			cmd = ActivityMallOPCommand.CMD.INPUT_GOLD,
			arg1 = arg_7_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.GET_GOLD_AWARD, function(arg_8_0, arg_8_1, arg_8_2)
		arg_1_0:sendNotification(GAME.ACTIVITY_MALL_OP, {
			activity_id = arg_8_1,
			cmd = ActivityMallOPCommand.CMD.GET_GOLD_AWARD,
			arg_list = arg_8_2
		})

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_9_0)
	return {
		GAME.ACTIVITY_MALL_OP_DONE,
		GAME.ZERO_HOUR_OP_DONE
	}
end

function var_0_0.handleNotification(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1:getName()
	local var_10_1 = arg_10_1:getBody()

	if var_10_0 == GAME.ACTIVITY_MALL_OP_DONE then
		local var_10_2 = var_10_1.levels[1]
		local var_10_3 = var_10_1.levels[2]

		if var_10_1.cmd == ActivityMallOPCommand.CMD.SETTLE_ROUND then
			table.insert({}, function(arg_11_0)
				arg_10_0.viewComponent:ShowSettleBox(var_10_2, arg_11_0)

				return
			end)

			if #var_10_1.awards >= 0 then
				table.insert({}, function(arg_12_0)
					arg_10_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_10_1.awards, arg_12_0)

					return
				end)
			end

			if var_10_1.levels[2] ~= var_10_1.levels[1] then
				table.insert({}, function(arg_13_0)
					arg_10_0.viewComponent:ShowUpgradeBox(var_10_2, var_10_3, arg_13_0)

					return
				end)
			end
		end

		seriesAsync({}, function()
			arg_10_0.viewComponent:UpdateData()
			arg_10_0.viewComponent:UpdateView()

			return
		end)
	elseif var_10_0 == GAME.ZERO_HOUR_OP_DONE then
		arg_10_0.viewComponent:UpdateData()
		arg_10_0.viewComponent:UpdateView()
	end

	return
end

return var_0_0
