local FogNightmareCmdWaiting = class("FogNightmareCmdWaiting", (require("app.view.module.fogNightmare.model.struct.execute.FogNightmareCmdSub")))

function FogNightmareCmdWaiting:ctor(arg_1_1)
	FogNightmareCmdWaiting.super.ctor(self, arg_1_1)

	self._waitParam = arg_1_1.waiterParam
	self._subWaitCnt = arg_1_1.cnt
end

function FogNightmareCmdWaiting:onActive()
	FogNightmareCmdWaiting.super.onActive(self)

	if self._waitParam.showFunc then
		self._waitParam.showFunc(self._params)
	end
end

function FogNightmareCmdWaiting:onInactive()
	FogNightmareCmdWaiting.super.onInactive(self)

	if self._waitParam.hideFunc then
		self._waitParam.hideFunc(self._params)
	end
end

function FogNightmareCmdWaiting:execute()
	if self:_isTrigger() then
		local var_4_0 = self._cmdList[self._triggerIdx]

		self._cmdList[self._triggerIdx]:execute()

		if var_4_0:isFinish() then
			if self._subWaitCnt then
				self._subWaitCnt = self._subWaitCnt - 1
				self._subCmdFinish = self._subWaitCnt < 1
			elseif self._triggerIdx == #self._cmdList then
				self._subCmdFinish = true
			end

			var_4_0:onInactive()
			table.remove(self._cmdList, self._triggerIdx)
		end

		self._triggerIdx = nil
	end

	return true
end

return FogNightmareCmdWaiting
