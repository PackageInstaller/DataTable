-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\ClientAchieves\\ClientAchieveMixin.lua

local ClientAchieveTestClass = require("Avatar/AvatarMixins/ClientAchieves/ClientAchieveTestClass")
local ClientAchieveMixin = {}
local self = ClientAchieveMixin

function ClientAchieveMixin:initClientAchieveMixin(achieveProgressData, achieveAwardGot, achieveQualify)
	self.achieveProgressData = achieveProgressData
	self.achieveAwardGot = achieveAwardGot
	self.achieveQualify = achieveQualify
	self.clientAchieveDict = {}
end

function ClientAchieveMixin:isClientAcheve(achieveType)
	return self.clientAchieveDict[achieveType] ~= nil
end

function ClientAchieveMixin:initChientAchieveData(achieveType, achieveId, achieveValue, achieveExtraValue)
	local clientAchieve = self.clientAchieveDict[achieveType]

	if not clientAchieve then
		return
	end

	clientAchieve:initAchieveData(achieveId, achieveValue, achieveExtraValue)
end

return ClientAchieveMixin
