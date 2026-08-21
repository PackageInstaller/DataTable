-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\AchieveUpperSystems\\AchieveUpperSystemMixin.lua

local AchieveUpperSystemTrunkTask = require("Avatar/AvatarMixins/AchieveUpperSystems/AchieveUpperSystemTrunkTask")
local AchieveUpperSystemBranchTask = require("Avatar/AvatarMixins/AchieveUpperSystems/AchieveUpperSystemBranchTask")
local AchieveUpperSystemLoginTask = require("Avatar/AvatarMixins/AchieveUpperSystems/AchieveUpperSystemLoginTask")
local AchieveUpperSystemMixin = {}
local self = AchieveUpperSystemMixin

function AchieveUpperSystemMixin:initUpperSystemMixin(svrData)
	self.upperSystemDict = {
		[Const.ACHEVE_UPPER_SYSTEM_TRUNKTASK] = AchieveUpperSystemTrunkTask(svrData),
		[Const.ACHEVE_UPPER_SYSTEM_BRANCHTASK] = AchieveUpperSystemBranchTask(svrData),
		[Const.ACHEVE_UPPER_SYSTEM_LOGINTASK] = AchieveUpperSystemLoginTask(svrData)
	}
end

function AchieveUpperSystemMixin:initCheckRedDot()
	for upperSystemType, upperSystem in pairs(self.upperSystemDict) do
		if upperSystem._refreshRedDotEvent then
			upperSystem:_refreshRedDotEvent()
		end
	end
end

function AchieveUpperSystemMixin:upperSystemAchieveQualify(achieveId)
	for upperSystemType, upperSystem in pairs(self.upperSystemDict) do
		if upperSystem:isAchieveNeedCare(achieveId) then
			upperSystem:onAchieveQualify(achieveId)
		end
	end
end

function AchieveUpperSystemMixin:upperSystemAchieveGot(achieveId)
	for upperSystemType, upperSystem in pairs(self.upperSystemDict) do
		if upperSystem:isAchieveNeedCare(achieveId) then
			upperSystem:onAchieveGot(achieveId)
		end
	end
end

function AchieveUpperSystemMixin:upperSystemAchieveProgressChange(achieveId)
	for upperSystemType, upperSystem in pairs(self.upperSystemDict) do
		if upperSystem:isAchieveNeedCare(achieveId) then
			upperSystem:onAchieveProgressChanged(achieveId)
		end
	end
end

function AchieveUpperSystemMixin:getAchieveListByType(systemType)
	local upperSystem = self.upperSystemDict[systemType]

	if upperSystem and upperSystem.achieveList then
		return upperSystem.achieveList
	end
end

function AchieveUpperSystemMixin:getAchieveDictByType(systemType)
	local upperSystem = self.upperSystemDict[systemType]

	if upperSystem and upperSystem.achieveDict then
		return upperSystem.achieveDict
	end
end

return AchieveUpperSystemMixin
