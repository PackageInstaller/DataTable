local StateMachine = class("StateMachine", (import("..BehaviourBase")))

StateMachine.VERSION = "2.2.0"
StateMachine.SUCCEEDED = 1
StateMachine.NOTRANSITION = 2
StateMachine.CANCELLED = 3
StateMachine.PENDING = 4
StateMachine.FAILURE = 5
StateMachine.INVALID_TRANSITION_ERROR = "INVALID_TRANSITION_ERROR"
StateMachine.PENDING_TRANSITION_ERROR = "PENDING_TRANSITION_ERROR"
StateMachine.INVALID_CALLBACK_ERROR = "INVALID_CALLBACK_ERROR"
StateMachine.WILDCARD = "*"
StateMachine.ASYNC = "ASYNC"

function StateMachine:Ctor()
	StateMachine.super.Ctor(self, "StateMachine")
end

function StateMachine:SetupState(arg_2_1, arg_2_2)
	self.initial_ = type(arg_2_1.initial) == "string" and {
		state = arg_2_1.initial
	} or clone(arg_2_1.initial)
	self.terminal_ = arg_2_1.terminal or arg_2_1.final
	self.events_ = arg_2_1.events or {}
	self.callbacks_ = arg_2_1.callbacks
	self.map_ = {}
	self.exceptMap_ = {}
	self.current_ = "none"
	self.inTransition_ = false

	if self.initial_ then
		self.initial_.event = self.initial_.event or "startup"

		self:AddEvent_({
			from = "none",
			name = self.initial_.event,
			to = self.initial_.state
		})
	end

	for iter_2_0, iter_2_1 in ipairs(self.events_) do
		self:AddEvent_(iter_2_1)
	end

	if self.callbacks_ == nil and arg_2_2 then
		self:AutoDetectCallbacks_()
	end

	self.callbacks_ = self.callbacks_ or {}

	if self.initial_ and not self.initial_.defer then
		self:DoEvent(self.initial_.event)
	end

	return self.target_
end

function StateMachine:AutoDetectCallbacks_()
	self.callbacks_ = {}

	local var_3_0 = {}
	local var_3_1 = {}
	local var_3_2 = false
	local var_3_3 = false
	local var_3_4 = self.target_

	for iter_3_0, iter_3_1 in pairs(self.map_) do
		if var_3_4["onbefore" .. iter_3_0] then
			self.callbacks_["onbefore" .. iter_3_0] = handler(var_3_4, var_3_4["onbefore" .. iter_3_0])
		end

		if var_3_4["onafter" .. iter_3_0] then
			self.callbacks_["onafter" .. iter_3_0] = handler(var_3_4, var_3_4["onafter" .. iter_3_0])
		end

		for iter_3_2, iter_3_3 in pairs(iter_3_1) do
			if iter_3_2 == StateMachine.WILDCARD then
				var_3_2 = true
			else
				local var_3_7 = "onleave" .. iter_3_2

				if var_3_4["onleave" .. iter_3_2] and self.callbacks_[var_3_7] == nil then
					self.callbacks_[var_3_7] = handler(var_3_4, var_3_4["onleave" .. iter_3_2])
				end

				local var_3_8 = iter_3_2 .. "event"

				if var_3_4[iter_3_2 .. "event"] and self.callbacks_[var_3_8] == nil then
					self.callbacks_[var_3_8] = handler(var_3_4, var_3_4[iter_3_2 .. "event"])
				end

				table.insert(var_3_0, iter_3_2)
			end

			if iter_3_3 == StateMachine.WILDCARD then
				var_3_3 = true
			else
				local var_3_9 = "onenter" .. iter_3_3

				if var_3_4["onenter" .. iter_3_3] and self.callbacks_[var_3_9] == nil then
					self.callbacks_[var_3_9] = handler(var_3_4, var_3_4["onenter" .. iter_3_3])
				end

				table.insert(var_3_1, iter_3_3)
			end
		end
	end

	if var_3_2 then
		for iter_3_4 = 1, #var_3_1 do
			if var_3_4["onleave" .. var_3_1[iter_3_4]] and self.callbacks_["onleave" .. var_3_1[iter_3_4]] == nil then
				self.callbacks_["onleave" .. var_3_1[iter_3_4]] = handler(var_3_4, var_3_4["onleave" .. var_3_1[iter_3_4]])
			end

			local var_3_10 = var_3_1[iter_3_4] .. "event"

			if var_3_4[var_3_1[iter_3_4] .. "event"] and self.callbacks_[var_3_10] == nil then
				self.callbacks_[var_3_10] = handler(var_3_4, var_3_4[var_3_1[iter_3_4] .. "event"])
			end
		end
	end

	if var_3_3 then
		for iter_3_5 = 1, #var_3_0 do
			if var_3_4["onenter" .. var_3_0[iter_3_5]] and self.callbacks_["onenter" .. var_3_0[iter_3_5]] == nil then
				self.callbacks_["onenter" .. var_3_0[iter_3_5]] = handler(var_3_4, var_3_4["onenter" .. var_3_0[iter_3_5]])
			end
		end
	end

	if var_3_4.allstateevent then
		self.callbacks_.allstateevent = handler(var_3_4, var_3_4.allstateevent)
	end

	if var_3_4.onleavestate then
		self.callbacks_.onleavestate = handler(var_3_4, var_3_4.onleavestate)
	end

	if var_3_4.onenterstate then
		self.callbacks_.onenterstate = handler(var_3_4, var_3_4.onenterstate)
	end

	if var_3_4.onchangestate then
		self.callbacks_.onchangestate = handler(var_3_4, var_3_4.onchangestate)
	end

	if var_3_4.onafterevent then
		self.callbacks_.onafterevent = handler(var_3_4, var_3_4.onafterevent)
	end
end

function StateMachine:IsReady()
	return self.current_ ~= "none"
end

function StateMachine:GetState()
	return self.current_
end

function StateMachine:IsState(arg_6_1)
	if type(arg_6_1) == "table" then
		for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
			if iter_6_1 == self.current_ then
				return true
			end
		end

		return false
	else
		return self.current_ == arg_6_1
	end
end

function StateMachine:CanDoEvent(arg_7_1)
	return not self.inTransition_ and (self.map_[arg_7_1][self.current_] ~= nil or self.map_[arg_7_1][StateMachine.WILDCARD] ~= nil) and not self.exceptMap_[arg_7_1][self.current_]
end

function StateMachine:IsFinishedState()
	return self:IsState(self.terminal_)
end

function StateMachine:DoEvent(arg_9_1, arg_9_2)
	local var_9_0 = self.map_[arg_9_1][self.current_] or self.map_[arg_9_1][StateMachine.WILDCARD] or self.current_
	local var_9_1 = {
		name = arg_9_1,
		from = self.current_,
		to = var_9_0,
		args = arg_9_2
	}

	if self.inTransition_ then
		self:OnError_(var_9_1, StateMachine.PENDING_TRANSITION_ERROR, "event " .. arg_9_1 .. " inappropriate because previous transition did not complete")

		return StateMachine.FAILURE
	end

	if not self:CanDoEvent(arg_9_1) then
		return StateMachine.FAILURE
	end

	if not self:OnEvent_(var_9_1) then
		return StateMachine.CANCELLED
	end

	if var_9_1.to == StateMachine.WILDCARD then
		var_9_0 = self.current_
		var_9_1.to = self.current_
	else
		var_9_0 = var_9_1.to
	end

	if self.current_ == var_9_0 then
		self:AfterEvent_(var_9_1)

		return StateMachine.NOTRANSITION
	end

	function var_9_1.transition()
		self.inTransition_ = false
		self.current_ = var_9_0

		self:EnterState_(var_9_1)
		self:ChangeState_(var_9_1)
		self:AfterEvent_(var_9_1)

		return StateMachine.SUCCEEDED
	end

	self.inTransition_ = true

	local var_9_2 = self:LeaveState_(var_9_1)

	if var_9_2 == false then
		var_9_1.transition = nil
		self.inTransition_ = false

		return StateMachine.CANCELLED
	elseif string.upper(tostring(var_9_2)) == StateMachine.ASYNC then
		return StateMachine.PENDING
	elseif var_9_1.transition then
		return var_9_1.transition()
	else
		self.inTransition_ = false
	end
end

function StateMachine:OnBind_()
	self:ExportMethods_({
		"SetupState",
		"IsReady",
		"GetState",
		"IsState",
		"CanDoEvent",
		"IsFinishedState",
		"DoEvent"
	})

	return self.target_
end

function StateMachine:OnUnbind_()
	return
end

function StateMachine:AddEvent_(arg_13_1)
	local var_13_0 = {}

	if type(arg_13_1.from) == "table" then
		for iter_13_0, iter_13_1 in ipairs(arg_13_1.from) do
			var_13_0[iter_13_1] = true
		end
	elseif arg_13_1.from then
		var_13_0[arg_13_1.from] = true
	else
		var_13_0[StateMachine.WILDCARD] = true
	end

	self.map_[arg_13_1.name] = self.map_[arg_13_1.name] or {}

	for iter_13_2, iter_13_3 in pairs(var_13_0) do
		self.map_[arg_13_1.name][iter_13_2] = arg_13_1.to or StateMachine.WILDCARD
	end

	self.exceptMap_[arg_13_1.name] = self.exceptMap_[arg_13_1.name] or {}

	if type(arg_13_1.except) == "table" then
		for iter_13_4, iter_13_5 in ipairs(arg_13_1.except) do
			self.exceptMap_[arg_13_1.name][iter_13_5] = true
		end
	elseif arg_13_1.except then
		self.exceptMap_[arg_13_1.name][arg_13_1.except] = true
	end
end

local function var_0_1(arg_14_0, arg_14_1)
	if arg_14_0 then
		return arg_14_0(arg_14_1)
	end
end

function StateMachine:OnAllEvent_(arg_15_1)
	return var_0_1(self.callbacks_.allstateevent, arg_15_1)
end

function StateMachine:AfterAnyEvent_(arg_16_1)
	return var_0_1(self.callbacks_.onafterevent, arg_16_1)
end

function StateMachine:LeaveAnyState_(arg_17_1)
	return var_0_1(self.callbacks_.onleavestate, arg_17_1)
end

function StateMachine:EnterAnyState_(arg_18_1)
	return var_0_1(self.callbacks_.onenterstate, arg_18_1)
end

function StateMachine:ChangeState_(arg_19_1)
	return var_0_1(self.callbacks_.onchangestate, arg_19_1)
end

function StateMachine:AfterThisEvent_(arg_20_1)
	return var_0_1(self.callbacks_["onafter" .. arg_20_1.name], arg_20_1)
end

function StateMachine:OnThisEvent_(arg_21_1)
	return var_0_1(self.callbacks_[arg_21_1.from .. "event"], arg_21_1)
end

function StateMachine:LeaveThisState_(arg_22_1)
	return var_0_1(self.callbacks_["onleave" .. arg_22_1.from], arg_22_1)
end

function StateMachine:EnterThisState_(arg_23_1)
	return var_0_1(self.callbacks_["onenter" .. arg_23_1.to], arg_23_1)
end

function StateMachine:OnEvent_(arg_24_1)
	local var_24_0 = self:OnThisEvent_(arg_24_1)
	local var_24_1 = self:OnAllEvent_(arg_24_1)

	if var_24_0 == nil then
		if var_24_1 == nil then
			return true
		else
			return var_24_1
		end
	elseif var_24_1 == nil then
		return var_24_0
	else
		return var_24_0 or var_24_1
	end
end

function StateMachine:AfterEvent_(arg_25_1)
	self:AfterThisEvent_(arg_25_1)
	self:AfterAnyEvent_(arg_25_1)
end

function StateMachine:LeaveState_(arg_26_1, arg_26_2)
	local var_26_0 = self:LeaveThisState_(arg_26_1, arg_26_2)
	local var_26_1 = self:LeaveAnyState_(arg_26_1, arg_26_2)

	if var_26_0 == false or var_26_1 == false then
		return false
	elseif string.upper(tostring(var_26_0)) == StateMachine.ASYNC or string.upper(tostring(var_26_1)) == StateMachine.ASYNC then
		return StateMachine.ASYNC
	end
end

function StateMachine:EnterState_(arg_27_1)
	self:EnterThisState_(arg_27_1)
	self:EnterAnyState_(arg_27_1)
end

function StateMachine:Reset()
	return
end

function StateMachine:OnError_(arg_29_1, arg_29_2, arg_29_3)
	printError("%s [StateMachine] ERROR: error %s, event %s, from %s to %s", tostring(self.target_), tostring(arg_29_2), arg_29_1.name, arg_29_1.from, arg_29_1.to)
end

return StateMachine
