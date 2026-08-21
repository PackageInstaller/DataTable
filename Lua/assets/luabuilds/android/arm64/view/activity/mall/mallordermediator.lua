local var_0_0 = class("MallOrderMediator", import("view.base.ContextMediator"))

var_0_0.START_ORDER = "MallOrderMediator.START_ORDER"
var_0_0.COMPLETE_ORDER = "MallOrderMediator.COMPLETE_ORDER"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.START_ORDER, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		arg_1_0:sendNotification(GAME.ACTIVITY_MALL_OP, {
			activity_id = arg_2_1,
			cmd = ActivityMallOPCommand.CMD.START_ORDER,
			arg1 = arg_2_2,
			arg_list = arg_2_3
		})

		return
	end)
	arg_1_0:bind(var_0_0.COMPLETE_ORDER, function(arg_3_0, arg_3_1, arg_3_2)
		arg_1_0:sendNotification(GAME.ACTIVITY_MALL_OP, {
			activity_id = arg_3_1,
			cmd = ActivityMallOPCommand.CMD.COMPLETE_ORDER,
			arg1 = arg_3_2
		})

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_4_0)
	return {
		GAME.ACTIVITY_MALL_OP_DONE,
		GAME.ZERO_HOUR_OP_DONE
	}
end

function var_0_0.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	if var_5_0 == GAME.ACTIVITY_MALL_OP_DONE then
		local var_5_2 = var_5_1.levels[1]
		local var_5_3 = var_5_1.levels[2]

		if var_5_1.cmd == ActivityMallOPCommand.CMD.COMPLETE_ORDER then
			arg_5_0.viewComponent:ClearSelectedIds()
			table.insert({}, function(arg_6_0)
				arg_5_0.viewComponent:ShowCompleteDialogue(arg_6_0)

				return
			end)

			if pg.activity_mall_custom_order[var_5_1.completeOrderId].story_unlock ~= "" then
				table.insert({}, function(arg_7_0)
					pg.NewStoryMgr.GetInstance():Play(var_0, arg_7_0)

					return
				end)
			end

			if #var_5_1.awards >= 0 then
				table.insert({}, function(arg_8_0)
					arg_5_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_5_1.awards, arg_8_0)

					return
				end)
			end

			if var_5_1.levels[2] ~= var_5_1.levels[1] then
				table.insert({}, function(arg_9_0)
					arg_5_0.viewComponent:ShowUpgradeBox(var_5_2, var_5_3, arg_9_0)

					return
				end)
			end
		end

		seriesAsync({}, function()
			arg_5_0.viewComponent:UpdateData()
			arg_5_0.viewComponent:UpdateView()

			return
		end)
	elseif var_5_0 == GAME.ZERO_HOUR_OP_DONE then
		arg_5_0.viewComponent:UpdateData()
		arg_5_0.viewComponent:UpdateView()
	end

	return
end

return var_0_0
