local var_0_0 = class("ChessEventQueue")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.eventQueue_ = {}
	arg_1_0.eventQueueP_ = 0
end

function var_0_0.Clear(arg_2_0)
	arg_2_0.eventQueue_ = {}
	arg_2_0.eventQueueP_ = 0
end

function var_0_0.GetCurFunc(arg_3_0)
	local var_3_0 = arg_3_0.eventQueue_[arg_3_0.eventQueueP_]
	local var_3_1 = var_3_0.list
	local var_3_2 = var_3_0.eventP
	local var_3_3 = var_3_1[var_3_2].params

	return var_3_1[var_3_2].func, var_3_3
end

function var_0_0.PromoteCurEventProgress(arg_4_0)
	local var_4_0 = arg_4_0.eventQueue_[arg_4_0.eventQueueP_]

	var_4_0.eventP = var_4_0.eventP + 1
end

function var_0_0.PromoteToNextEvent(arg_5_0)
	if arg_5_0.eventQueueP_ == #arg_5_0.eventQueue_ then
		return false
	end

	arg_5_0.eventQueueP_ = arg_5_0.eventQueueP_ + 1

	return true
end

function var_0_0.IsEventEnd(arg_6_0)
	if #arg_6_0.eventQueue_ == 0 then
		return true
	end

	local var_6_0 = arg_6_0.eventQueue_[arg_6_0.eventQueueP_]

	return var_6_0.eventP > #var_6_0.list
end

function var_0_0.GetCurTiming(arg_7_0)
	if not arg_7_0.eventQueue_[arg_7_0.eventQueueP_] then
		return 0
	end

	return arg_7_0.eventQueue_[arg_7_0.eventQueueP_].timing
end

function var_0_0.GetExecutingChess(arg_8_0)
	for iter_8_0 = arg_8_0.eventQueueP_, 1, -1 do
		if arg_8_0.eventQueue_[iter_8_0].gridData then
			return arg_8_0.eventQueue_[iter_8_0].gridData
		end
	end
end

function var_0_0.InsertNewEventQueue(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = arg_9_0:GetCurTiming()
	local var_9_1 = {
		eventP = 1,
		gridData = arg_9_3,
		timing = arg_9_2,
		list = {}
	}

	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		if not ChessEventConfig[iter_9_1.eventID] then
			-- block empty
		end

		var_9_1.list[#var_9_1.list + 1] = {
			eventID = iter_9_1.eventID,
			func = ChessEventConfig[iter_9_1.eventID][arg_9_2] or ChessEventConfig[iter_9_1.eventID][ChessConst.TIMING_ALL],
			params = iter_9_1.params
		}
	end

	table.insert(arg_9_0.eventQueue_, var_9_1)

	return #arg_9_1
end

function var_0_0.InsertCurEventQueue(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.eventQueue_[arg_10_0.eventQueueP_]
	local var_10_1 = var_10_0.list
	local var_10_2 = var_10_0.eventP

	for iter_10_0 = #var_10_1, var_10_2, -1 do
		var_10_1[iter_10_0 + #arg_10_1] = var_10_1[iter_10_0]
	end

	local var_10_3 = var_10_0.timing
	local var_10_4 = 1

	for iter_10_1 = var_10_2, var_10_2 + #arg_10_1 - 1 do
		local var_10_5 = arg_10_1[var_10_4]

		var_10_1[iter_10_1] = {
			eventID = var_10_5.eventID,
			func = ChessEventConfig[var_10_5.eventID][var_10_3] or ChessEventConfig[var_10_5.eventID][ChessConst.TIMING_ALL],
			params = var_10_5.params
		}
		var_10_4 = var_10_4 + 1
	end
end

function var_0_0.LastEventID(arg_11_0)
	if arg_11_0.eventQueueP_ == 0 then
		return nil
	end

	local var_11_0 = arg_11_0.eventQueue_[arg_11_0.eventQueueP_]

	if var_11_0.eventP == 1 then
		return nil
	end

	return var_11_0.list[var_11_0.eventP - 1].eventID
end

function var_0_0.CurEventTiming(arg_12_0)
	if not arg_12_0.eventQueue_[arg_12_0.eventQueueP_] then
		return nil
	end

	return arg_12_0.eventQueue_[arg_12_0.eventQueueP_].timing
end

return var_0_0
