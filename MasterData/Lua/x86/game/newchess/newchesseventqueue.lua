local NewChessEventQueue = class("NewChessEventQueue", (require("game/chess/ChessEventQueue")))

function NewChessEventQueue:InsertNewEventQueue(arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = self:GetCurTiming()
	local var_1_1 = {
		eventP = 1,
		gridData = arg_1_3,
		timing = arg_1_2,
		list = {}
	}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1) do
		if not NewChessEventConfig[iter_1_1.eventID] then
			-- block empty
		end

		local var_1_2 = {
			eventID = iter_1_1.eventID
		}

		var_1_2.func = NewChessEventConfig[iter_1_1.eventID][arg_1_2] or NewChessEventConfig[iter_1_1.eventID][NewChessConst.TIMING_ALL]
		var_1_2.params = iter_1_1.params
		var_1_1.list[#var_1_1.list + 1] = var_1_2
	end

	table.insert(self.eventQueue_, var_1_1)

	return #arg_1_1
end

function NewChessEventQueue:InsertCurEventQueue(arg_2_1)
	for iter_2_0 = #self.eventQueue_[self.eventQueueP_].list, self.eventQueue_[self.eventQueueP_].eventP, -1 do
		self.eventQueue_[self.eventQueueP_].list[iter_2_0 + #arg_2_1] = self.eventQueue_[self.eventQueueP_].list[iter_2_0]
	end

	for iter_2_1 = self.eventQueue_[self.eventQueueP_].eventP, self.eventQueue_[self.eventQueueP_].eventP + #arg_2_1 - 1 do
		local var_2_0 = {
			eventID = arg_2_1[1].eventID
		}

		var_2_0.func = NewChessEventConfig[arg_2_1[1].eventID][self.eventQueue_[self.eventQueueP_].timing] or NewChessEventConfig[arg_2_1[1].eventID][NewChessConst.TIMING_ALL]
		var_2_0.params = arg_2_1[1].params
		self.eventQueue_[self.eventQueueP_].list[iter_2_1] = var_2_0
	end
end

function NewChessEventQueue:IsEmpty()
	if next(self.eventQueue_) == nil and self.eventQueueP_ == 0 then
		return true
	else
		return false
	end
end

return NewChessEventQueue
