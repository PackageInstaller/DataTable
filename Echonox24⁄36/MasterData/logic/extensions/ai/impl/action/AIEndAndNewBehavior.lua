-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ai/impl/action/AIEndAndNewBehavior.lua

module("logic.extensions.ai.impl.action.AIEndAndNewBehavior", package.seeall)

local M = class("AIEndAndNewBehavior", AINode)

function M:ctor(context)
	M.super.ctor(self, context)
end

function M:initFromConfig(aiConfigData)
	M.super.initFromConfig(self, aiConfigData)
end

function M:onStart()
	M.super.onStart(self)

	local unit = self:getContext():getUnit()

	unit.behaviorMgr:endCurrBehaviorAndNew()

	return self:onEnd(AIConst.AIStatus.SUCCESS)
end

return M
