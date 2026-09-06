-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/answerfunc/config/AnswerFuncConfig.lua

module("logic.extensions.answerfunc.config.AnswerFuncConfig", package.seeall)

local AnswerFuncConfig = class("AnswerFuncConfig", BaseConfig)

function AnswerFuncConfig:onInit()
	AnswerFuncConfig.super.onInit(self)

	self._activityCfgs = nil
	self._stageCfgs = nil
	self._problemCfgs = nil
end

function AnswerFuncConfig:getNames()
	return {
		"answer_problem_plot",
		"answer_problem_type",
		"answer_problem_plot_stage",
		"answer_problem_plot_problem"
	}
end

function AnswerFuncConfig:handleConfig(name, content)
	if name == "answer_problem_plot" then
		self._activityCfgs = content
	elseif name == "answer_problem_plot_stage" then
		self:_setAnswerStageCfgs(content.dataList)
	elseif name == "answer_problem_type" then
		self._typeCfgs = content
	elseif name == "answer_problem_plot_problem" then
		self._problemCfgs = content
	end
end

function AnswerFuncConfig:_getActivityIdByActivityType(acType)
	if self._activityCfgs == nil or acType == nil then
		return -1
	end

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

function AnswerFuncConfig:getAnswerFuncActivityId()
	return self:_getActivityIdByActivityType(GameEnum.ActivityType.AnswerFunc)
end

function AnswerFuncConfig:getAnswerActivityCfg(actId)
	actId = checknumber(actId)

	if self._activityCfgs == nil or self._activityCfgs[actId] == nil then
		return
	end

	return self._activityCfgs[actId]
end

function AnswerFuncConfig:_setAnswerStageCfgs(data)
	self._stageCfgs = {}

	for _, cfg in pairs(data or {}) do
		if cfg and cfg.onlyId then
			self._stageCfgs[cfg.plotPlanId] = self._stageCfgs[cfg.plotPlanId] or {}
			self._stageCfgs[cfg.plotPlanId][cfg.chapterId] = self._stageCfgs[cfg.plotPlanId][cfg.chapterId] or {}

			table.insert(self._stageCfgs[cfg.plotPlanId][cfg.chapterId], cfg)
		end
	end

	for _, crList in pairs(self._stageCfgs) do
		for id, seList in pairs(crList or {}) do
			if seList and #seList > 1 then
				table.sort(seList, function(a, b)
					return a.stageId < b.stageId
				end)
			end
		end
	end
end

function AnswerFuncConfig:getAnswerStageCfgs(planId, chapterId)
	planId = checknumber(planId)

	if self._stageCfgs == nil or self._stageCfgs[planId] == nil then
		return
	end

	local list = self._stageCfgs[planId]

	if chapterId == nil or list[chapterId] == nil then
		return list
	end

	return list[chapterId]
end

function AnswerFuncConfig:getAnswerProblemCfgs(planId, problemId)
	planId = checknumber(planId)

	if self._problemCfgs == nil or self._problemCfgs[planId] == nil then
		return nil
	end

	local list = self._problemCfgs[planId]

	return list[checknumber(problemId)]
end

function AnswerFuncConfig:getAnswerProblemCfgsByType(activityId, typeId)
	local typeData = self:getTypeData(activityId, typeId)

	if typeData then
		if not typeData.problemPlanId then
			local problemPlanId = 0

			return self._problemCfgs[problemPlanId]
		end
	end
end

function AnswerFuncConfig:getAnswerProblemDataByType(activityId, typeId, type)
	local cfg = self:getAnswerProblemCfgsByType(activityId, typeId)

	return cfg and cfg[type]
end

function AnswerFuncConfig:getTypeCfg(activityId)
	local actCfg = self:getAnswerActivityCfg(activityId)

	return actCfg and self._typeCfgs[actCfg.typePlanId]
end

function AnswerFuncConfig:getTypeData(activityId, typeId)
	local typeCfg = self:getTypeCfg(activityId)

	return typeCfg and typeCfg[typeId]
end

function AnswerFuncConfig:getProblemPlanId(activityId, typeId)
	local data = self:getTypeData(activityId, typeId)

	return (data or nil) and (data.problemPlanId or 0)
end

AnswerFuncConfig.instance = AnswerFuncConfig.New()

return AnswerFuncConfig
