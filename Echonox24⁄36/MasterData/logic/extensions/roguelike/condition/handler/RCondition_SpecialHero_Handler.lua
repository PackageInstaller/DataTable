-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/condition/handler/RCondition_SpecialHero_Handler.lua

module("logic.extensions.roguelike.condition.handler.RCondition_SpecialHero_Handler", package.seeall)

local M = class("RCondition_SpecialHero_Handler")

function M:judgeCondition(params)
	local roleId = tonumber(params)
	local allRoles = RogueMgr.instance:getModel():getAllRoleMos()

	for k, v in pairs(allRoles) do
		if v.roleProp:getRoleId() == roleId then
			return true
		end
	end

	return false
end

return M
