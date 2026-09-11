local ChessEventQueue = class("ChessEventQueue")

function ChessEventQueue:Ctor()
	self.eventQueue_ = {}
	self.eventQueueP_ = 0
end

function ChessEventQueue:Clear()
	self.eventQueue_ = {}
	self.eventQueueP_ = 0
end

function ChessEventQueue:GetCurFunc()
	return self.eventQueue_[self.eventQueueP_].list[self.eventQueue_[self.eventQueueP_].eventP].func, self.eventQueue_[self.eventQueueP_].list[self.eventQueue_[self.eventQueueP_].eventP].params
end

function ChessEventQueue:PromoteCurEventProgress()
	self.eventQueue_[self.eventQueueP_].eventP = self.eventQueue_[self.eventQueueP_].eventP + 1
end

function ChessEventQueue:PromoteToNextEvent()
	if self.eventQueueP_ == #self.eventQueue_ then
		return false
	end

	self.eventQueueP_ = self.eventQueueP_ + 1

	return true
end

function ChessEventQueue:IsEventEnd()
	local var_6_0

	if #self.eventQueue_ == 0 then
		do return true end

		var_6_0 = self.eventQueue_[self.eventQueueP_].eventP
	end

	return var_6_0 > #self.eventQueue_[self.eventQueueP_].list
end

function ChessEventQueue:GetCurTiming()
	if not self.eventQueue_[self.eventQueueP_] then
		return 0
	end

	return self.eventQueue_[self.eventQueueP_].timing
end

function ChessEventQueue:GetExecutingChess()
	for iter_8_0 = self.eventQueueP_, 1, -1 do
		if self.eventQueue_[iter_8_0].gridData then
			return self.eventQueue_[iter_8_0].gridData
		end
	end
end

function ChessEventQueue:InsertNewEventQueue(arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = self:GetCurTiming()
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

		local var_9_2 = {
			eventID = iter_9_1.eventID
		}

		var_9_2.func = ChessEventConfig[iter_9_1.eventID][arg_9_2] or ChessEventConfig[iter_9_1.eventID][ChessConst.TIMING_ALL]
		var_9_2.params = iter_9_1.params
		var_9_1.list[#var_9_1.list + 1] = var_9_2
	end

	table.insert(self.eventQueue_, var_9_1)

	return #arg_9_1
end

function ChessEventQueue:InsertCurEventQueue(arg_10_1)
	for iter_10_0 = #self.eventQueue_[self.eventQueueP_].list, self.eventQueue_[self.eventQueueP_].eventP, -1 do
		self.eventQueue_[self.eventQueueP_].list[iter_10_0 + #arg_10_1] = self.eventQueue_[self.eventQueueP_].list[iter_10_0]
	end

	for iter_10_1 = self.eventQueue_[self.eventQueueP_].eventP, self.eventQueue_[self.eventQueueP_].eventP + #arg_10_1 - 1 do
		local var_10_0 = {
			eventID = arg_10_1[1].eventID
		}

		var_10_0.func = ChessEventConfig[arg_10_1[1].eventID][self.eventQueue_[self.eventQueueP_].timing] or ChessEventConfig[arg_10_1[1].eventID][ChessConst.TIMING_ALL]
		var_10_0.params = arg_10_1[1].params
		self.eventQueue_[self.eventQueueP_].list[iter_10_1] = var_10_0
	end
end

function ChessEventQueue:LastEventID()
	if self.eventQueueP_ == 0 then
		return nil
	end

	local var_11_0 = self.eventQueue_[self.eventQueueP_]

	if self.eventQueue_[self.eventQueueP_].eventP == 1 then
		return nil
	end

	return var_11_0.list[var_11_0.eventP - 1].eventID
end

function ChessEventQueue:CurEventTiming()
	if not self.eventQueue_[self.eventQueueP_] then
		return nil
	end

	return self.eventQueue_[self.eventQueueP_].timing
end

return ChessEventQueue
