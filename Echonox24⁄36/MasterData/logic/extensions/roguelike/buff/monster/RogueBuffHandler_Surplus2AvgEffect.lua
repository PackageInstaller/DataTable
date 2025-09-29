-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/buff/monster/RogueBuffHandler_Surplus2AvgEffect.lua

module("logic.extensions.roguelike.buff.monster.RogueBuffHandler_Surplus2AvgEffect", package.seeall)

local M = class("RogueBuffHandler_Surplus2AvgEffect", RogueBaseBuffHandler)

function M:onEffectTrigger(count, effectId)
	local allRoles = RogueMgr.instance:getModel():getAllRoleMos()
	local exeMap = {}
	local curCount = 0
	local calcMap = self:caleCount(exeMap, allRoles, curCount, count)

	for k, v in pairs(calcMap) do
		RoguelikeAgent.instance:sendTakeEffectRequest({
			effectId
		}, k, -1, v * -1)
	end
end

function M:caleCount(exeMap, allRoles, curCount, count)
	if curCount < count then
		for i = 1, #allRoles do
			local prop = allRoles[i].roleProp

			if not prop:getIsDeath() and curCount < count then
				exeMap[prop:getRoleId()] = exeMap[prop:getRoleId()] or 0
				exeMap[prop:getRoleId()] = exeMap[prop:getRoleId()] + 1
				curCount = curCount + 1
			end
		end

		if curCount < count then
			return self:caleCount(exeMap, allRoles, curCount, count)
		else
			return exeMap
		end
	end
end

return M
