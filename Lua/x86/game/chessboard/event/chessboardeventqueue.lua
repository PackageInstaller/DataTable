local var_0_0 = require("game/chess/ChessEventQueue")
local var_0_1 = class("ChessBoardEventQueue", var_0_0)

function var_0_1.InsertNewEventQueue(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = arg_1_0:GetCurTiming()
	local var_1_1 = {
		eventP = 1,
		timing = arg_1_1,
		list = {},
		gridData = arg_1_2
	}

	for iter_1_0, iter_1_1 in ipairs(arg_1_3) do
		if not ChessBoardEventConfig[iter_1_1.eventID] then
			-- block empty
		end

		var_1_1.list[#var_1_1.list + 1] = {
			eventID = iter_1_1.eventID,
			func = ChessBoardEventConfig[iter_1_1.eventID][arg_1_1] or ChessBoardEventConfig[iter_1_1.eventID][ChessBoardConst.TIMING.ALL],
			params = iter_1_1.params
		}
	end

	table.insert(arg_1_0.eventQueue_, var_1_1)

	return #arg_1_3
end

function var_0_1.InsertCurEventQueue(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0.eventQueue_[arg_2_0.eventQueueP_]
	local var_2_1 = var_2_0.list
	local var_2_2 = var_2_0.eventP

	for iter_2_0 = #var_2_1, var_2_2, -1 do
		var_2_1[iter_2_0 + #arg_2_1] = var_2_1[iter_2_0]
	end

	local var_2_3 = var_2_0.timing
	local var_2_4 = 1

	for iter_2_1 = var_2_2, var_2_2 + #arg_2_1 - 1 do
		local var_2_5 = arg_2_1[var_2_4]

		var_2_1[iter_2_1] = {
			eventID = var_2_5.eventID,
			func = NewChessEventConfig[var_2_5.eventID][var_2_3] or NewChessEventConfig[var_2_5.eventID][NewChessConst.TIMING_ALL],
			params = var_2_5.params
		}
		var_2_4 = var_2_4 + 1
	end
end

function var_0_1.IsEmpty(arg_3_0)
	if next(arg_3_0.eventQueue_) == nil and arg_3_0.eventQueueP_ == 0 then
		return true
	else
		return false
	end
end

return var_0_1
