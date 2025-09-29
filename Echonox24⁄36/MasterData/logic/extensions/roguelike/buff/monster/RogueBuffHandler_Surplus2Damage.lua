-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/buff/monster/RogueBuffHandler_Surplus2Damage.lua

module("logic.extensions.roguelike.buff.monster.RogueBuffHandler_Surplus2Damage", package.seeall)

local M = class("RogueBuffHandler_Surplus2Damage", RogueBaseBuffHandler)

function M:onEffectTrigger(count, effectId)
	local allRoles = RogueMgr.instance:getModel():getAllRoleMos()

	for i = 1, #allRoles do
		local prop = allRoles[i].roleProp

		if not prop:getIsDeath() then
			RoguelikeAgent.instance:sendTakeEffectRequest({
				effectId
			}, prop:getRoleId(), -1, count * -1)
		end
	end
end

return M
