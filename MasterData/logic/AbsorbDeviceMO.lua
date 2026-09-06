-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/model/AbsorbDeviceMO.lua

module("logic.extensions.petzoo.model.AbsorbDeviceMO", package.seeall)

local AbsorbDeviceMO = class("AbsorbDeviceMO")

function AbsorbDeviceMO:ctor()
	self.absorbBuddyId = 0
	self.absorbStartTime = 0
	self.absorbCdEndTime = 0
	self.absorbAccumulateTime = 0
end

function AbsorbDeviceMO:getAbsorbedTime()
	if self.absorbStartTime == 0 then
		return self.absorbAccumulateTime
	end

	local maxAbsorbTime = ZooConfig.instance:getMaxAbsorbTime()

	return ServerTime.now() - self.absorbStartTime + self.absorbAccumulateTime
end

function AbsorbDeviceMO:getAbsorbedRemainTime()
	local maxAbsorbTime = ZooConfig.instance:getMaxAbsorbTime()

	return math.max(0, maxAbsorbTime - self:getAbsorbedTime())
end

return AbsorbDeviceMO
