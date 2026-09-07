local NewEducateFSM = class("NewEducateFSM")

NewEducateFSM.SYSTEM = {
	PLAN = 5,
	MIND = 9,
	FAIL = 999,
	EVENT = 1,
	ENDING = 8,
	PHASE = 7,
	ASSESS = 6,
	MAP = 4,
	TOPIC = 3,
	CHOOSE = 10,
	TALENT = 2,
	INIT = 0
}

function NewEducateFSM:Ctor(arg_1_1, arg_1_2)
	self.systemNo = arg_1_2.system_no
	self.curNode = arg_1_2.current_node or 0

	local var_1_0 = arg_1_2.cache[1]

	self.states = {}
	self.states[NewEducateFSM.SYSTEM.INIT] = NewEducateStateBase.New()
	self.states[NewEducateFSM.SYSTEM.EVENT] = NewEducateStateBase.New()

	if #var_1_0.cache_talent > 0 then
		self.states[NewEducateFSM.SYSTEM.TALENT] = NewEducateTalentState.New(var_1_0.cache_talent[1])
	end

	self.states[NewEducateFSM.SYSTEM.CHOOSE] = NewEducateStateBase.New()

	if #var_1_0.cache_chat > 0 then
		self.states[NewEducateFSM.SYSTEM.TOPIC] = NewEducateTopicState.New(var_1_0.cache_chat[1])
	end

	if #var_1_0.cache_site > 0 then
		self.states[NewEducateFSM.SYSTEM.MAP] = NewEducateMapState.New(arg_1_1, var_1_0.cache_site[1])
	end

	self.states[NewEducateFSM.SYSTEM.PLAN] = NewEducatePlanState.New((#var_1_0.cache_plan > 0 or nil) and (var_1_0.cache_plan[1] or {}))

	if #var_1_0.cache_eval > 0 then
		self.states[NewEducateFSM.SYSTEM.ASSESS] = NewEducateAssessState.New(var_1_0.cache_eval[1])
	elseif self.systemNo == NewEducateFSM.SYSTEM.ASSESS and #var_1_0.cache_eval == 0 then
		self.states[NewEducateFSM.SYSTEM.ASSESS] = NewEducateAssessState.New({
			is_finished = 0
		})
	end

	self.states[NewEducateFSM.SYSTEM.PHASE] = NewEducateStateBase.New()

	if #var_1_0.cache_end > 0 then
		self.states[NewEducateFSM.SYSTEM.ENDING] = NewEducateEndingState.New(var_1_0.cache_end[1])
	end

	if #var_1_0.cache_mind > 0 then
		self.states[NewEducateFSM.SYSTEM.MIND] = NewEducateStateBase.New(var_1_0.cache_mind[1])
	end

	return
end

function NewEducateFSM:SetState(arg_2_1, arg_2_2)
	self.states[arg_2_1] = arg_2_2

	return
end

function NewEducateFSM:GetCurNode()
	return self.curNode
end

function NewEducateFSM:SetCurNode(arg_4_1)
	self.curNode = arg_4_1

	return
end

function NewEducateFSM:GetSystemNo()
	return self.systemNo
end

function NewEducateFSM:SetSystemNo(arg_6_1)
	self.systemNo = arg_6_1

	return
end

function NewEducateFSM:GetState(arg_7_1)
	return self.states[arg_7_1] or nil
end

function NewEducateFSM:GetCurState()
	return self.states[self.systemNo]
end

function NewEducateFSM:CheckStystem()
	warning(self.curNode, self.systemNo)

	if self.curNode ~= 0 then
		return self.systemNo
	end

	if not self.states[self.systemNo]:IsFinish() then
		return self.systemNo
	end

	return switch(self.systemNo, {
		[NewEducateFSM.SYSTEM.INIT] = function()
			return NewEducateFSM.SYSTEM.EVENT
		end,
		[NewEducateFSM.SYSTEM.EVENT] = function()
			return NewEducateFSM.SYSTEM.TALENT
		end,
		[NewEducateFSM.SYSTEM.TALENT] = function()
			return NewEducateFSM.SYSTEM.CHOOSE
		end,
		[NewEducateFSM.SYSTEM.CHOOSE] = function()
			return NewEducateFSM.SYSTEM.MAP
		end,
		[NewEducateFSM.SYSTEM.TOPIC] = function()
			return NewEducateFSM.SYSTEM.MAP
		end,
		[NewEducateFSM.SYSTEM.MAP] = function()
			return NewEducateFSM.SYSTEM.MAP
		end,
		[NewEducateFSM.SYSTEM.PLAN] = function()
			return NewEducateFSM.SYSTEM.ASSESS
		end,
		[NewEducateFSM.SYSTEM.ASSESS] = function()
			local var_17_0 = getProxy(NewEducateProxy):GetCurChar():GetRoundData()

			if var_17_0:IsEndlessFail() then
				return NewEducateFSM.SYSTEM.FAIL
			elseif not var_17_0:IsEndRound() or var_17_0:IsEndless() then
				return NewEducateFSM.SYSTEM.PHASE
			else
				return NewEducateFSM.SYSTEM.ENDING
			end

			return
		end,
		[NewEducateFSM.SYSTEM.PHASE] = function()
			return NewEducateFSM.SYSTEM.EVENT
		end,
		[NewEducateFSM.SYSTEM.ENDING] = function()
			return NewEducateFSM.SYSTEM.ENDING
		end
	}, function()
		return self.systemNo
	end)
end

function NewEducateFSM:Reset()
	for iter_21_0, iter_21_1 in pairs(self.states) do
		iter_21_1:Reset()
	end

	self.states[NewEducateFSM.SYSTEM.TALENT] = nil
	self.states[NewEducateFSM.SYSTEM.TOPIC] = nil
	self.states[NewEducateFSM.SYSTEM.MAP] = nil
	self.states[NewEducateFSM.SYSTEM.ENDING] = nil
	self.states[NewEducateFSM.SYSTEM.MIND] = nil

	return
end

NewEducateFSM.BENEFIT_PENDING = {
	NewEducateFSM.SYSTEM.PLAN,
	NewEducateFSM.SYSTEM.ASSESS,
	NewEducateFSM.SYSTEM.PHASE
}

function NewEducateFSM:IsImmediateBenefit()
	return not table.contains(NewEducateFSM.BENEFIT_PENDING, self.systemNo)
end

return NewEducateFSM
