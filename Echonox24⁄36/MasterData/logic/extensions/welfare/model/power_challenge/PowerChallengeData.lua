-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/model/power_challenge/PowerChallengeData.lua

module("logic.extensions.welfare.model.power_challenge.PowerChallengeData", package.seeall)

local M = class("PowerChallengeData", ActivityWelfareData)

function M:ctor(ActivityNO)
	M.super.ctor(self, ActivityNO)
end

function M:getConditionOpen()
	if not WelfareUtil.isSystemOpen() then
		return false
	end

	local isOpen = SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.PowerChallenge) or false

	return isOpen
end

function M:getStartTime()
	return self._startedTime
end

return M
