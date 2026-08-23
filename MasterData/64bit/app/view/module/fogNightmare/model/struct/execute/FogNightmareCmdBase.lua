local FogNightmareCmdBase = class("FogNightmareCmdBase")
local var_0_1 = 1

function FogNightmareCmdBase:ctor(arg_1_1)
	self._id = var_0_1
	var_0_1 = var_0_1 + 1
	self._executeTimes = arg_1_1.executeTimes or 1
	self._cmdTriggerCondition = arg_1_1.trigger
	self._cmdFinishCondition = arg_1_1.finish
	self._executeFunc = arg_1_1.execute
	self._executeParams = arg_1_1.executeParams
	self._executeParamsEx = {}
	self._executed = false
	self._params = arg_1_1
	self._quickTrigger = false
end

function FogNightmareCmdBase:setId(arg_2_1)
	self._id = arg_2_1
end

function FogNightmareCmdBase:getId()
	return self._id
end

function FogNightmareCmdBase:setQuickTrigger(arg_4_1)
	self._quickTrigger = arg_4_1
end

function FogNightmareCmdBase:isQuickTrigger()
	return self._quickTrigger
end

function FogNightmareCmdBase:onActive()
	return
end

function FogNightmareCmdBase:onInactive()
	return
end

function FogNightmareCmdBase:getId()
	return self._id
end

function FogNightmareCmdBase:reset()
	return
end

function FogNightmareCmdBase:execute()
	if self:_isTrigger() and self._executeTimes > 0 then
		self._executeParamsEx = self:_onExecuteSelf()

		if self._executeFunc then
			self._executeFunc(self._executeParams, self._executeParamsEx)
		end

		self._executeTimes = self._executeTimes - 1
		self._executed = true
	end

	return true
end

function FogNightmareCmdBase:_isTrigger(arg_11_1)
	return (self._cmdTriggerCondition or nil) and self._cmdTriggerCondition(arg_11_1)
end

function FogNightmareCmdBase:_onExecuteSelf()
	return
end

function FogNightmareCmdBase:isFinish()
	return (self._cmdFinishCondition or nil) and self._cmdFinishCondition() and self._executed
end

return FogNightmareCmdBase
