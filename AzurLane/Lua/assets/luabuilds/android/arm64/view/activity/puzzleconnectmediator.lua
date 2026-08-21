local var_0_0 = class("PuzzleConnectMediator", import("..base.ContextMediator"))

var_0_0.CMD_ACTIVITY = "PuzzleConnectMediator:cmd_activity"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.CMD_ACTIVITY, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.ACTIVITY_OPERATION, {
			activity_id = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_PUZZLE_CONNECT).id,
			cmd = arg_2_1.index,
			arg1 = arg_2_1.config_id
		})

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_3_0)
	return {
		ActivityProxy.ACTIVITY_OPERATION_DONE,
		ActivityProxy.ACTIVITY_SHOW_AWARDS
	}
end

function var_0_0.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	if var_4_0 == ActivityProxy.ACTIVITY_OPERATION_DONE then
		arg_4_0.viewComponent:updateActivity()
	elseif var_4_0 == ActivityProxy.ACTIVITY_SHOW_AWARDS then
		arg_4_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_4_1.awards, var_4_1.callback)
	end

	return
end

var_0_0.state_collection = 1
var_0_0.state_puzzle = 2
var_0_0.state_connection = 3
var_0_0.state_complete = 4

function var_0_0.GetPuzzleActivityState(arg_5_0, arg_5_1)
	if not arg_5_1 then
		return var_0_0.state_puzzle
	end

	if not table.contains(arg_5_1.data1_list, arg_5_0) then
		return var_0_0.state_collection
	elseif not table.contains(arg_5_1.data2_list, arg_5_0) then
		return var_0_0.state_puzzle
	elseif not table.contains(arg_5_1.data3_list, arg_5_0) then
		return var_0_0.state_connection
	else
		return var_0_0.state_complete
	end

	return
end

function var_0_0.GetRedTip()
	local var_6_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_PUZZLE_CONNECT)

	if var_6_0 then
		local var_6_1 = var_6_0:getConfig("config_data")
		local var_6_2 = getProxy(PlayerProxy)
		local var_6_3 = var_6_0:getDayIndex()

		for iter_6_0 = 1, #var_6_1 do
			local var_6_5

			if iter_6_0 <= var_6_3 then
				if not table.contains(var_6_0.data3_list, var_6_1[iter_6_0]) then
					if not table.contains(var_6_0.data1_list, var_6_1[iter_6_0]) and iter_6_0 == 0 + 1 then
						local var_6_4 = var_6_2:getData()

						if pg.activity_tolove_jigsaw[var_6_1[iter_6_0]].need[3] <= var_6_4:getResource(pg.activity_tolove_jigsaw[var_6_1[iter_6_0]].need[2]) then
							return true
						end
					end
				else
					var_6_5 = 0 < iter_6_0 and iter_6_0 or 0
				end
			end
		end

		if #var_6_0.data1_list > #var_6_0.data2_list or #var_6_0.data1_list > #var_6_0.data3_list then
			return true
		end
	end

	return false
end

return var_0_0
