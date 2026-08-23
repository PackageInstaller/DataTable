local var_0_0 = g.core.config.competition_task_info
local var_0_1 = g.core.const.ConstMgr.CompetitionConst
local CommonCompetitionData = require("app.view.module.competition.common.model.CommonCompetitionData")
local CommonCompetitionDataManager = class("CommonCompetitionDataManager", require("app.core.model.BaseData"))

function CommonCompetitionDataManager:ctor()
	self:initData()
end

function CommonCompetitionDataManager:initData()
	self._isEnterActivityDict = {}
	self._dataDict = {}
	self._activityIdDict = {}
	self._taskGroupActIdDict = {}
	self._taskTypeGroupDict = {}
	self._taskGroupInfoDict = {}

	self:initTaskData()
end

function CommonCompetitionDataManager:initTaskData()
	for iter_3_0, iter_3_1 in var_0_0.ipairs() do
		self._taskTypeGroupDict[iter_3_1.task_type .. "_" .. iter_3_1.key] = self._taskTypeGroupDict[iter_3_1.task_type .. "_" .. iter_3_1.key] or iter_3_1.group
		self._taskGroupInfoDict[iter_3_1.group] = self._taskGroupInfoDict[iter_3_1.group] or {}

		table.insert(self._taskGroupInfoDict[iter_3_1.group], iter_3_1)
	end
end

function CommonCompetitionDataManager:_getOrCreateData(arg_4_1)
	local var_4_0 = self._dataDict[arg_4_1]

	if not self._dataDict[arg_4_1] then
		var_4_0 = CommonCompetitionData.new(arg_4_1)
		self._dataDict[arg_4_1] = var_4_0

		local var_4_1 = var_4_0:getTaskGroup()

		var_4_0:setTaskInfoList(self._taskGroupInfoDict[var_4_1])

		self._taskGroupActIdDict[var_4_1] = self._taskGroupActIdDict[var_4_1] or {}

		table.insert(self._taskGroupActIdDict[var_4_1], arg_4_1)
	end

	return var_4_0
end

function CommonCompetitionDataManager:onS2CGetInfo(arg_5_1)
	self:_getOrCreateData(arg_5_1.activity.activity_sub_id):updateGetInfoData(arg_5_1.activity)
end

function CommonCompetitionDataManager:isEnterActivityByKey(arg_6_1)
	if not next(self._isEnterActivityDict) then
		self._isEnterActivityDict = g.core.common.Storage:load("common_competition_enter_subId.json", true) or {}
	end

	return checkbool(self._isEnterActivityDict[arg_6_1])
end

function CommonCompetitionDataManager:onS2CRedInfo(arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_1.infos or {}) do
		self:_getOrCreateData(iter_7_1.activity_sub_id):updateRedData(iter_7_1)
	end
end

function CommonCompetitionDataManager:onS2CTaskData(arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(self._taskGroupActIdDict[self._taskTypeGroupDict[arg_8_1.status.id .. "_" .. arg_8_1.status.key]] or {}) do
		self:getDataById(iter_8_1):updateTaskData({
			arg_8_1.status
		})
	end
end

function CommonCompetitionDataManager:onS2CGetTaskAwardInfo(arg_9_1)
	self:_getOrCreateData(arg_9_1.activity_sub_id):updateTaskGetData(arg_9_1.task_id)
end

function CommonCompetitionDataManager:onS2CGetScoreAwardInfo(arg_10_1)
	self:_getOrCreateData(arg_10_1.activity_sub_id):updateScoreGetData(arg_10_1.id)
end

function CommonCompetitionDataManager:getDataById(arg_11_1)
	if arg_11_1 == var_0_1.IGNORE_COMMON_ID then
		return g.core.model.User.competitionData
	end

	return self:_getOrCreateData(arg_11_1)
end

function CommonCompetitionDataManager:saveEnterActivityLayer(arg_12_1)
	if not self:isEnterActivityByKey("activity_sub_id_" .. arg_12_1) then
		self._isEnterActivityDict["activity_sub_id_" .. arg_12_1] = 1

		g.core.common.Storage:save("common_competition_enter_subId.json", self._isEnterActivityDict, true)
	end
end

function CommonCompetitionDataManager:isEnterActivity(arg_13_1)
	return self:isEnterActivityByKey("activity_sub_id_" .. arg_13_1)
end

function CommonCompetitionDataManager:hasTaskAwardCanGet(arg_14_1)
	local var_14_0 = arg_14_1.subId or arg_14_1.actValue

	if var_14_0 then
		return self:getDataById(var_14_0):isHaveCanGetAwardTask(arg_14_1)
	else
		for iter_14_0, iter_14_1 in pairs(self._dataDict) do
			if iter_14_1:isHaveCanGetAwardTask(arg_14_1) then
				return true
			end
		end
	end

	return false
end

function CommonCompetitionDataManager:hasScoreAwardCanGet(arg_15_1)
	local var_15_0 = arg_15_1.subId or arg_15_1.actValue

	if var_15_0 then
		return self:getDataById(var_15_0):isHaveCanGetAwardScore(arg_15_1)
	else
		for iter_15_0, iter_15_1 in pairs(self._dataDict) do
			if iter_15_1:isHaveCanGetAwardScore(arg_15_1) then
				return true
			end
		end
	end

	return false
end

function CommonCompetitionDataManager:isNewOpenRank(arg_16_1)
	local var_16_0 = arg_16_1.subId or arg_16_1.actValue

	if var_16_0 then
		return self:getDataById(var_16_0):isOpenCompetitionRank()
	else
		for iter_16_0, iter_16_1 in pairs(self._dataDict) do
			if iter_16_1:isOpenCompetitionRank() then
				return true
			end
		end
	end

	return false
end

function CommonCompetitionDataManager:getAllShowCompetitionActivity()
	local var_17_0 = {}

	for iter_17_0, iter_17_1 in pairs(self._dataDict) do
		local var_17_1 = iter_17_1:getActivityData()

		if var_17_1 and var_17_1:isShow() then
			table.insert(var_17_0, iter_17_1)
		end
	end

	return var_17_0
end

function CommonCompetitionDataManager:isNewOpenActivity(arg_18_1)
	local var_18_0 = arg_18_1.subId or arg_18_1.actValue

	if var_18_0 then
		return not self:isEnterActivity(var_18_0)
	else
		for iter_18_0, iter_18_1 in pairs(self._dataDict) do
			if not self:isEnterActivity(iter_18_0) then
				return true
			end
		end
	end

	return false
end

return CommonCompetitionDataManager
