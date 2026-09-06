-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/athenabless/config/AthenaBlessConfig.lua

module("logic.extensions.athenabless.config.AthenaBlessConfig", package.seeall)

local AthenaBlessConfig = class("AthenaBlessConfig", BaseConfig)

function AthenaBlessConfig:onInit()
	AthenaBlessConfig.super.onInit(self)

	self.athena_bless_activity = nil
	self.athena_bless_level = nil
	self.athena_bless_progress_prize = nil
	self.athena_bless_task = nil
	self.athena_bless_const = nil
end

function AthenaBlessConfig:getNames()
	return {
		"athena_bless_activity",
		"athena_bless_level",
		"athena_bless_progress_prize",
		"athena_bless_task",
		"athena_bless_const"
	}
end

function AthenaBlessConfig:handleConfig(name, content)
	if name == "athena_bless_activity" then
		self.athena_bless_activity = content
	elseif name == "athena_bless_level" then
		self.athena_bless_level = content
	elseif name == "athena_bless_progress_prize" then
		self.athena_bless_progress_prize = content
	elseif name == "athena_bless_task" then
		self.athena_bless_task = content
	elseif name == "athena_bless_const" then
		self.athena_bless_const = content
	end
end

function AthenaBlessConfig:getActivityCfg(activityId)
	return self.athena_bless_activity[activityId]
end

function AthenaBlessConfig:getLevelCfgList(planId)
	return self.athena_bless_level[planId]
end

function AthenaBlessConfig:getLevelCfg(planId, level)
	if self.athena_bless_level[planId] then
		return self.athena_bless_level[planId][level]
	end

	return nil
end

function AthenaBlessConfig:getProgressPrizeCfgList(planId)
	return self.athena_bless_progress_prize[planId]
end

function AthenaBlessConfig:getProgressPrizeCfg(planId, prizeId)
	if self.athena_bless_progress_prize[planId] then
		return self.athena_bless_progress_prize[planId][prizeId]
	end

	return nil
end

function AthenaBlessConfig:getTaskCfgList(planId)
	return self.athena_bless_task[planId]
end

function AthenaBlessConfig:getTaskCfg(planId, taskId)
	if self.athena_bless_task[planId] then
		return self.athena_bless_task[planId][taskId]
	end

	return nil
end

function AthenaBlessConfig:getConstValue(key)
	if self.athena_bless_const[key] then
		return self.athena_bless_const[key].value
	end

	return ""
end

AthenaBlessConfig.instance = AthenaBlessConfig.New()

return AthenaBlessConfig
