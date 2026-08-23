local var_0_0 = {
	DONE = 4,
	RESUME = 3,
	PAUSE = 2,
	DOING = 1,
	NONE = 0
}
local BPMAction = class("BPMAction")

function BPMAction:ctor()
	self._actionState = var_0_0.NONE
	self._bpm = nil
end

function BPMAction:reset()
	self._actionState = var_0_0.NONE

	if self._bpm then
		self._bpm:reset()
	end
end

function BPMAction:doing(arg_3_1)
	self._actionState = var_0_0.DOING
end

function BPMAction:pause(arg_4_1)
	if self._bpm then
		self._bpm:pause(arg_4_1)

		self._actionState = var_0_0.PAUSE
	end
end

function BPMAction:resume(arg_5_1)
	if self._bpm then
		self._bpm:resume(arg_5_1)

		self._actionState = var_0_0.RESUME
	end
end

function BPMAction:setBpm(arg_6_1)
	self._bpm = arg_6_1
end

function BPMAction:_onFinish()
	self._actionState = var_0_0.DONE
end

function BPMAction:isFinish()
	local var_8_0 = self._actionState == var_0_0.DONE

	if self._actionState ~= var_0_0.DONE and not self:isPause() and self._bpm then
		if self._bpm:isDone() then
			self:_onFinish()
		end
	else
		return var_8_0
	end
end

function BPMAction:isPause()
	return self._actionState == var_0_0.PAUSE
end

function BPMAction:isMatch(arg_10_1)
	return false
end

return BPMAction
