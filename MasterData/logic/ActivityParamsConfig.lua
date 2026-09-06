-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/spriteladder/config/ActivityParamsConfig.lua

module("logic.extensions.spriteladder.config.ActivityParamsConfig", package.seeall)

local ActivityParamsConfig = class("ActivityParamsConfig", BaseConfig)

function ActivityParamsConfig:onInit()
	ActivityParamsConfig.super.onInit(self)

	self.activityCfgs = nil
end

function ActivityParamsConfig:getNames()
	return {
		"activity_params"
	}
end

function ActivityParamsConfig:handleConfig(name, content)
	if name == "activity_params" then
		self.activityCfgs = content
	end
end

function ActivityParamsConfig:getCfgByTypeAndId(typeId, id)
	if self.activityCfgs[typeId] then
		return self.activityCfgs[typeId][id]
	end

	return nil
end

function ActivityParamsConfig:getSpriteLadderCfgById(id)
	return self.activityCfgs[1][id]
end

function ActivityParamsConfig:getSignInCfgByKey(key)
	return self.activityCfgs[6][key]
end

function ActivityParamsConfig:GetActivitySignCfgs()
	if self.activityCfgs == nil or self.activityCfgs[6] == nil then
		return
	end

	return self.activityCfgs[6]
end

function ActivityParamsConfig:getOnlineTimeCfgs()
	return self.activityCfgs[5]
end

function ActivityParamsConfig:getOnlineTimeCfgByKey(key)
	return self.activityCfgs[5][key].value
end

function ActivityParamsConfig:getHuangjinshenglongCfgs()
	return self:getCfgList(9)
end

function ActivityParamsConfig:getCfgList(key)
	if not self.activityCfgs[key] then
		local list = {}

		for _, v in pairs(self.activityCfgs[key]) do
			table.insert(list, v)
		end

		return list
	end
end

ActivityParamsConfig.instance = ActivityParamsConfig.New()

return ActivityParamsConfig
