local PuzzleConnectMediator = class("PuzzleConnectMediator", import("..base.ContextMediator"))

PuzzleConnectMediator.CMD_ACTIVITY = "PuzzleConnectMediator:cmd_activity"

function PuzzleConnectMediator:register()
	self:bind(PuzzleConnectMediator.CMD_ACTIVITY, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.ACTIVITY_OPERATION, {
			activity_id = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_PUZZLE_CONNECT).id,
			cmd = arg_2_1.index,
			arg1 = arg_2_1.config_id
		})

		return
	end)

	return
end

function PuzzleConnectMediator:listNotificationInterests()
	return {
		ActivityProxy.ACTIVITY_OPERATION_DONE,
		ActivityProxy.ACTIVITY_SHOW_AWARDS
	}
end

function PuzzleConnectMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	if var_4_0 == ActivityProxy.ACTIVITY_OPERATION_DONE then
		self.viewComponent:updateActivity()
	elseif var_4_0 == ActivityProxy.ACTIVITY_SHOW_AWARDS then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_4_1.awards, var_4_1.callback)
	end

	return
end

PuzzleConnectMediator.state_collection = 1
PuzzleConnectMediator.state_puzzle = 2
PuzzleConnectMediator.state_connection = 3
PuzzleConnectMediator.state_complete = 4

function PuzzleConnectMediator:GetPuzzleActivityState(arg_5_1)
	if not arg_5_1 then
		return PuzzleConnectMediator.state_puzzle
	end

	if not table.contains(arg_5_1.data1_list, self) then
		return PuzzleConnectMediator.state_collection
	elseif not table.contains(arg_5_1.data2_list, self) then
		return PuzzleConnectMediator.state_puzzle
	elseif not table.contains(arg_5_1.data3_list, self) then
		return PuzzleConnectMediator.state_connection
	else
		return PuzzleConnectMediator.state_complete
	end

	return
end

function PuzzleConnectMediator.GetRedTip()
	local var_6_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_PUZZLE_CONNECT)

	if var_6_0 then
		local var_6_1 = var_6_0:getConfig("config_data")
		local var_6_2 = getProxy(PlayerProxy)
		local var_6_3 = var_6_0:getDayIndex()

		for iter_6_0 = 1, #var_6_1 do
			if iter_6_0 <= var_6_3 then
				if not table.contains(var_6_0.data3_list, var_6_1[iter_6_0]) then
					if not table.contains(var_6_0.data1_list, var_6_1[iter_6_0]) and iter_6_0 == 0 + 1 then
						if pg.activity_tolove_jigsaw[var_6_1[iter_6_0]].need[3] <= var_6_2:getData():getResource(pg.activity_tolove_jigsaw[var_6_1[iter_6_0]].need[2]) then
							return true
						end
					end
				else
					-- block empty
				end
			end
		end

		if #var_6_0.data1_list > #var_6_0.data2_list or #var_6_0.data1_list > #var_6_0.data3_list then
			return true
		end
	end

	return false
end

return PuzzleConnectMediator
