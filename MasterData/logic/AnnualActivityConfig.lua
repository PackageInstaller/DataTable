-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annualactivity/config/AnnualActivityConfig.lua

module("logic.extensions.annualactivity.config.AnnualActivityConfig", package.seeall)

local AnnualActivityConfig = class("AnnualActivityConfig", BaseConfig)

function AnnualActivityConfig:onInit()
	AnnualActivityConfig.super.onInit(self)

	self._activityCfgs = nil
	self._taskCfgs = nil
	self._posterCfgs = nil
	self._puzzleLightCfgs = nil
	self._puzzlePrizeCfgs = nil
end

function AnnualActivityConfig:getNames()
	return {
		"poster_jigsaw",
		"poster_jigsaw_task",
		"poster_jigsaw_poster",
		"puzzle_light",
		"puzzle_light_prize"
	}
end

function AnnualActivityConfig:handleConfig(name, content)
	if name == "poster_jigsaw" then
		self._activityCfgs = content
	elseif name == "poster_jigsaw_task" then
		self:_classificationTaskByType(content.dataList)
	elseif name == "poster_jigsaw_poster" then
		self._posterCfgs = content
	elseif name == "puzzle_light" then
		self._puzzleLightCfgs = content
	elseif name == "puzzle_light_prize" then
		self._puzzlePrizeCfgs = content
	end
end

function AnnualActivityConfig:_classificationTaskByType(data)
	self._taskCfgs = {}

	for _, cfg in pairs(data or {}) do
		if cfg and cfg.taskPlanId and checknumber(cfg.taskId) > 0 then
			if self._taskCfgs[cfg.taskPlanId] == nil then
				self._taskCfgs[cfg.taskPlanId] = {}
			end

			if self._taskCfgs[cfg.taskPlanId][cfg.showType] == nil then
				self._taskCfgs[cfg.taskPlanId][cfg.showType] = {}
			end

			table.insert(self._taskCfgs[cfg.taskPlanId][cfg.showType], cfg)
		end
	end

	for _, planList in pairs(self._taskCfgs or {}) do
		for _, typeList in pairs(planList or {}) do
			if typeList and #typeList > 1 then
				table.sort(typeList, function(a, b)
					return a.maxProgress < b.maxProgress
				end)
			end
		end
	end
end

function AnnualActivityConfig:_getActivityIdByActivityType(acType)
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(acType)

	if cfgs == nil then
		return -2
	end

	for _, item in pairs(cfgs) do
		if GameUtil.checkIsInTimePeriod(item.startTime, item.endTime) then
			return item.activityId
		end
	end

	return -3
end

function AnnualActivityConfig:getAnnualActivityCfg(actId)
	if checknumber(actId) <= 0 or self._activityCfgs == nil then
		return nil
	end

	return self._activityCfgs[actId]
end

function AnnualActivityConfig:getAnnualTaskCfgs(planId)
	if checknumber(planId) < 1 or self._taskCfgs == nil then
		return nil
	end

	return self._taskCfgs[planId]
end

function AnnualActivityConfig:getAnnualAllPosterCfgs(planId)
	if checknumber(planId) < 1 or self._posterCfgs == nil then
		return nil
	end

	return self._posterCfgs[planId]
end

function AnnualActivityConfig:getAnnualPosterCfg(planId, index)
	local list = self:GetAnnualAllPosterCfgs(planId)

	if list == nil or list[index] == nil then
		return
	end

	return list[index]
end

function AnnualActivityConfig:getOpenActivityId()
	if self._activityCfgs == nil then
		return -1
	end

	return self:_getActivityIdByActivityType(GameEnum.ActivityType.AnnualActivity)
end

function AnnualActivityConfig:getGratefulOpenActivityId()
	if self._puzzleLightCfgs == nil then
		return -1
	end

	return self:_getActivityIdByActivityType(GameEnum.ActivityType.GratefulPuzzle)
end

function AnnualActivityConfig:getGratefulActivityCfg(actId)
	if checknumber(actId) <= 0 or self._puzzleLightCfgs == nil then
		return nil
	end

	return self._puzzleLightCfgs[actId]
end

function AnnualActivityConfig:getGratefulPrizeCfgs(planId)
	if checknumber(planId) <= 0 or self._puzzlePrizeCfgs == nil then
		return nil
	end

	return self._puzzlePrizeCfgs[planId]
end

AnnualActivityConfig.instance = AnnualActivityConfig.New()

return AnnualActivityConfig
