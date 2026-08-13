class = var_0_10000

local var_0_0 = "PuzzleConnectMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.CMD_ACTIVITY = "PuzzleConnectMediator:cmd_activity"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.CMD_ACTIVITY, function(arg_2_0, arg_2_1)
		getProxy = var_2_10002
		ActivityProxy = var_2_10003

		local var_2_0 = var_2_10002(var_2_10003)
		local var_2_1 = var_2.getActivityByType

		ActivityConst = var_2_10004

		local var_2_2 = var_2_1(var_2_0, var_2_10004.ACTIVITY_TYPE_PUZZLE_CONNECT)
		local var_2_3 = arg_1_0
		local var_2_4 = var_3.sendNotification

		GAME = var_2_10005

		var_2_4(var_2_3, var_2_10005.ACTIVITY_OPERATION, {
			activity_id = var_2_2.id,
			cmd = arg_2_1.index,
			arg1 = arg_2_1.config_id
		})

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	local var_3_0 = {}

	ActivityProxy = var_1_10002
	var_3_0[1] = var_1_10002.ACTIVITY_OPERATION_DONE
	ActivityProxy = var_2
	var_3_0[2] = var_2.ACTIVITY_SHOW_AWARDS

	return var_3_0
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1
	local var_4_2 = arg_4_1.getBody(var_4_1)

	ActivityProxy = var_4_1

	if var_4_0 == var_4_1.ACTIVITY_OPERATION_DONE then
		local var_4_3 = arg_4_0.viewComponent

		var_4.updateActivity(var_4_3)
	else
		ActivityProxy = var_4

		if var_4_0 == var_4.ACTIVITY_SHOW_AWARDS then
			local var_4_4 = arg_4_0.viewComponent
			local var_4_5 = var_4.emit

			BaseUI = var_1_10006

			var_4_5(var_4_4, var_1_10006.ON_ACHIEVE, var_4_2.awards, var_4_2.callback)
		end
	end

	return
end

var_0_1.state_collection = 1
var_0_1.state_puzzle = 2
var_0_1.state_connection = 3
var_0_1.state_complete = 4

function var_0_1.GetPuzzleActivityState(arg_5_0, arg_5_1)
	if not arg_5_1 then
		return var_0_1.state_puzzle
	end

	local var_5_0 = arg_5_1.data1_list
	local var_5_1 = arg_5_1.data2_list
	local var_5_2 = arg_5_1.data3_list

	table = var_1_10005

	if not var_1_10005.contains(var_5_0, arg_5_0) then
		return var_0_1.state_collection
	else
		table = var_5

		if not var_5.contains(var_5_1, arg_5_0) then
			return var_0_1.state_puzzle
		else
			table = var_5

			if not var_5.contains(var_5_2, arg_5_0) then
				return var_0_1.state_connection
			else
				return var_0_1.state_complete
			end
		end
	end

	return
end

function var_0_1.GetRedTip()
	getProxy = var_1_10000
	ActivityProxy = var_1_10001

	local var_6_0 = var_1_10000(var_1_10001)
	local var_6_1 = var_0.getActivityByType

	ActivityConst = var_1_10002

	if var_6_1(var_6_0, var_1_10002.ACTIVITY_TYPE_PUZZLE_CONNECT) then
		local var_6_2 = var_0
		local var_6_3 = var_0.getConfig(var_6_2, "config_data")

		getProxy = var_6_2
		PlayerProxy = var_3

		local var_6_4 = var_6_2(var_3)
		local var_6_5 = var_0.data1_list
		local var_6_6 = var_0.data2_list
		local var_6_7 = var_0.data3_list
		local var_6_8 = var_0:getDayIndex()
		local var_6_9 = 0

		for iter_6_0 = 1, #var_6_3 do
			local var_6_10 = var_6_3[iter_6_0]

			if iter_6_0 <= var_6_8 then
				table = var_1_10013

				if not var_1_10013.contains(var_6_7, var_6_10) then
					table = var_1_10013

					if not var_1_10013.contains(var_6_5, var_6_10) and iter_6_0 == var_6_9 + 1 then
						pg = var_1_10013
						var_1_10013 = var_1_10013.activity_tolove_jigsaw[var_6_10].need[3]
						pg = var_14

						local var_6_11 = var_14.activity_tolove_jigsaw[var_6_10].need[2]
						local var_6_12 = var_6_4:getData()

						if var_1_10013 <= var_15.getResource(var_6_12, var_6_11) then
							return true
						end
					end
				else
					var_6_9 = var_6_9 < iter_6_0 and iter_6_0 or var_6_9
				end
			end
		end

		if #var_6_5 > #var_6_6 or #var_6_5 > #var_6_7 then
			return true
		end
	end

	return false
end

return var_0_1
