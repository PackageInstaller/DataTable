-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/model/claw_doll/ClawDollActivityData.lua

module("logic.extensions.welfare.model.claw_doll.ClawDollActivityData", package.seeall)

local M = class("ClawDollActivityData", ActivityWelfareData)

function M:initConfig()
	ClawDollController.instance:setActivityId(self._configId, self._id)
end

function M:getLeftTimeDayAndHour()
	local currentTime = ServerTime.now()
	local leftTime = self._endedTime - currentTime

	if leftTime <= 0 then
		return 0, 0
	end

	local day = math.floor(leftTime / 86400)
	local hour = math.ceil(leftTime / 3600 % 24)

	return day, hour
end

function M:IsDisappear()
	return
end

return M
