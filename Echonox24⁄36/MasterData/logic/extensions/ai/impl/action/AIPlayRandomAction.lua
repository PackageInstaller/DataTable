-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ai/impl/action/AIPlayRandomAction.lua

module("logic.extensions.ai.impl.action.AIPlayRandomAction", package.seeall)

local M = class("AIPlayRandomAction", AINode)

function M:ctor(context)
	M.super.ctor(self, context)

	self._waitForComplete = true
	self._arrayActionName = nil
	self._isLoop = false
	self._endActionTime = -1
end

function M:initFromConfig(aiConfigData)
	M.super.initFromConfig(self, aiConfigData)

	self._arrayActionName = string.split(aiConfigData.actionNames, "|")
	self._isLoop = aiConfigData.isLoop
	self._waitForComplete = not self._isLoop

	if string.nilorempty(aiConfigData.actionNames) then
		printError("没有配动作名")
	end
end

function M:_getRandomAction(unit)
	local animaList = {}

	for _, animaName in ipairs(self._arrayActionName) do
		if unit.meshModel:containsAnimation(animaName) then
			table.insert(animaList, animaName)
		end
	end

	if #animaList == 1 then
		return animaList[1]
	elseif #animaList > 1 then
		local idx = math.random(1, #animaList)

		return animaList[idx]
	end

	return ""
end

function M:onStart()
	M.super.onStart(self)

	local unit = self:getContext():getUnit()

	self._playAnimState = self:_getRandomAction(unit)

	if string.nilorempty(self._playAnimState) then
		return self:onEnd(AIConst.AIStatus.FAILD)
	end

	unit.navMesh:setNavMeshAgentStatus(false)
	unit.meshModel:play(self._playAnimState, self._isLoop, true)

	self._endActionTime = Time.time + unit.meshModel:getAnimationDuration(self._playAnimState)

	if self._waitForComplete then
		return self
	end

	return self:onEnd(AIConst.AIStatus.SUCCESS)
end

function M:_resetUnitState()
	if self._endActionTime > 0 then
		local unit = self:getContext():getUnit()

		unit.navMesh:setNavMeshAgentStatus(true)
	end
end

function M:onUpdate()
	if self._waitForComplete and self._endActionTime > 0 and Time.time > self._endActionTime then
		self._endActionTime = -1

		local unit = self:getContext():getUnit()

		unit.navMesh:setNavMeshAgentStatus(true)

		return self:onEnd(AIConst.AIStatus.SUCCESS)
	end

	return self
end

function M:handleEnd()
	return
end

function M:onReset()
	self:_resetUnitState()
	M.super.onReset(self)

	self._endActionTime = -1
end

function M:onReuse(context)
	M.super.onReuse(self, context)
end

function M:onRecycle()
	self:_resetUnitState()
	M.super.onRecycle(self)

	self._arrayActionName = nil
	self._isLoop = false
	self._waitForComplete = true
	self._endActionTime = -1
end

function M:onDestroy()
	M.super.onDestroy(self)

	self._arrayActionName = nil
	self._isLoop = false
	self._waitForComplete = true
	self._endActionTime = nil
end

return M
