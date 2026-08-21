-- chunkname: @IQIGame\\Module\\Util\\CustomCoroutine\\CustomCoroutine.lua

local CustomCoroutine = class({
	isComplete = false,
	elapsedTime = 0
})

function CustomCoroutine:CheckIsComplete()
	if self.customWait then
		self.customWait:Update()

		if self.customWait.waitType == "WaitForSeconds" then
			if self.elapsedTime > self.customWait.duration then
				return true
			end

			self.elapsedTime = self.elapsedTime + UnityEngine.Time.deltaTime
		elseif self.customWait.waitType == "WaitForEndOfFrame" then
			-- block empty
		elseif self.customWait.waitType == "YieldReturnNull" then
			if self.elapsedTime > 0 then
				return true
			end

			self.elapsedTime = self.elapsedTime + UnityEngine.Time.deltaTime
		else
			return self.customWait.isComplete
		end
	end

	if self.coroutine and coroutine.status(self.coroutine) == "dead" then
		return true
	end

	return false
end

function CustomCoroutine:Update()
	if not self.isComplete then
		self.isComplete = self:CheckIsComplete()
	end

	if self.isComplete then
		self.isNeedToRemove = true

		self:StopInternal()
	end
end

function CustomCoroutine:StopInternal()
	CoroutineUtility.current = nil

	if self.coroutine ~= nil and coroutine.status(self.coroutine) == "running" then
		coroutine.yield(self.coroutine)

		self.coroutine = nil
	end

	if self.parent and self.parent.coroutine then
		CoroutineUtility.current = self.parent

		if coroutine.status(self.parent.coroutine) ~= "dead" and not self.parent.isComplete then
			local succeed, errorInfo = coroutine.resume(self.parent.coroutine)

			if not succeed then
				logError(errorInfo)
				Log.Error(debug.traceback(self.parent.coroutine))
			end
		end
	end
end

function CustomCoroutine:Start()
	CoroutineUtility.current = self

	if coroutine.status(self.coroutine) == "suspended" then
		local succeed, errorInfo = coroutine.resume(self.coroutine, self.parameters)

		if not succeed then
			logError(errorInfo)
		end
	end
end

function CustomCoroutine:Stop()
	if self.child ~= nil and not self.isComplete then
		self.child:Stop()
	end

	if self.customWait and self.customWait.waitType == "WaitAll" then
		local waitAll = self.customWait

		for _, subCoroutine in pairs(waitAll.subCoroutines) do
			subCoroutine:Stop()
		end
	end

	self.isComplete = true
	self.isNeedToRemove = true
end

function CustomCoroutine:StopImmediately()
	if self.child ~= nil and not self.isComplete then
		self.child:Stop()
	end

	self.isComplete = true
	self.isNeedToRemove = true

	self:StopInternal()

	for i = #CoroutineUtility.coroutines, 1, -1 do
		local customCoroutine = CoroutineUtility.coroutines[i]

		if self == customCoroutine and customCoroutine.isNeedToRemove then
			table.remove(CoroutineUtility.coroutines, i)

			CoroutineUtility.customCoroutineToIndex[customCoroutine] = nil

			break
		end
	end
end

return CustomCoroutine
