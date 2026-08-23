local WeeklyCompetitionConst = require("app.view.module.weeklyCompetition.const.WeeklyCompetitionConst")
local WeeklyCompetitionData = require("app.view.module.weeklyCompetition.model.WeeklyCompetitionData")
local WeeklyCompetitionMgrData = class("WeeklyCompetitionMgrData")

function WeeklyCompetitionMgrData:ctor()
	self:initData()
end

function WeeklyCompetitionMgrData:initData()
	self._dataDict = {}
	self._baseIdToActiveId = {}
end

function WeeklyCompetitionMgrData:hasWeeklyCompetitionActivity(arg_3_1)
	if arg_3_1 then
		return self._dataDict[arg_3_1] and self._dataDict[arg_3_1]:hasWeeklyCompetitionActivity()
	else
		for iter_3_0, iter_3_1 in pairs(self._dataDict) do
			if iter_3_1:hasWeeklyCompetitionActivity() then
				return true
			end
		end

		return false
	end
end

function WeeklyCompetitionMgrData:hasWeeklyCompetitionActivityByBaseId(arg_4_1)
	local var_4_0 = self._baseIdToActiveId[arg_4_1] or 0
	local var_4_1 = self._dataDict[var_4_0]

	if self._dataDict[var_4_0] then
		return var_4_1:hasWeeklyCompetitionActivity(), var_4_1:getCurBaseInfo() and var_4_1:getCurBaseInfo().activityInfo.local_end_time or 0
	end

	return false, 0
end

function WeeklyCompetitionMgrData:setGiftDirty(arg_5_1)
	if self._dataDict[arg_5_1] then
		self._dataDict[arg_5_1]:setGiftDirty()
	end
end

function WeeklyCompetitionMgrData:hasReqInfo(arg_6_1)
	if arg_6_1 then
		return self._dataDict[arg_6_1] and self._dataDict[arg_6_1]:hasReqInfo()
	else
		for iter_6_0, iter_6_1 in pairs(self._dataDict) do
			if iter_6_1:hasReqInfo() then
				return true
			end
		end

		return false
	end
end

function WeeklyCompetitionMgrData:isOpen(arg_7_1)
	local var_7_0 = false

	for iter_7_0, iter_7_1 in ipairs(self._actList) do
		if iter_7_1.actId == arg_7_1 then
			var_7_0 = self:_checkOneActIsOpen(iter_7_1)

			break
		elseif not arg_7_1 and self:_checkOneActIsOpen(iter_7_1) then
			var_7_0 = true

			break
		end
	end

	return var_7_0
end

function WeeklyCompetitionMgrData:getActDataByBaseId(arg_8_1)
	return self:getActData(self._baseIdToActiveId[arg_8_1] or 0)
end

function WeeklyCompetitionMgrData:getActData(arg_9_1)
	return self._dataDict[arg_9_1]
end

function WeeklyCompetitionMgrData:isNewActivity(arg_10_1)
	if arg_10_1.actId and arg_10_1.actId > 0 then
		return self._dataDict[arg_10_1.actId] and self._dataDict[arg_10_1.actId]:isNewActivity()
	elseif arg_10_1.actValue and arg_10_1.actValue > 0 then
		return (self._dataDict[self._baseIdToActiveId[arg_10_1.actValue] or 0] or nil) and self._dataDict[self._baseIdToActiveId[arg_10_1.actValue] or 0]:isNewActivity()
	else
		for iter_10_0, iter_10_1 in pairs(self._dataDict) do
			if iter_10_1:isNewActivity() then
				return true
			end
		end

		return false
	end
end

function WeeklyCompetitionMgrData:saveNewActivity(arg_11_1)
	if self._dataDict[arg_11_1] then
		self._dataDict[arg_11_1]:saveNewActivity()
	end
end

function WeeklyCompetitionMgrData:checkAndLoadActivityCache(arg_12_1)
	if self._dataDict[arg_12_1] then
		self._dataDict[arg_12_1]:checkAndLoadActivityCache()
	end
end

function WeeklyCompetitionMgrData:canGetBoxReward(arg_13_1)
	if arg_13_1.actId and arg_13_1.actId > 0 then
		return self._dataDict[arg_13_1.actId] and self._dataDict[arg_13_1.actId]:canGetBoxReward()
	elseif arg_13_1.actValue and arg_13_1.actValue > 0 then
		return (self._dataDict[self._baseIdToActiveId[arg_13_1.actValue] or 0] or nil) and self._dataDict[self._baseIdToActiveId[arg_13_1.actValue] or 0]:canGetBoxReward()
	else
		for iter_13_0, iter_13_1 in pairs(self._dataDict) do
			if iter_13_1:canGetBoxReward() then
				return true
			end
		end

		return false
	end
end

function WeeklyCompetitionMgrData:onS2CWeeklyCompetitionInfo(arg_14_1)
	for iter_14_0, iter_14_1 in ipairs(arg_14_1.activity or {}) do
		if not self._dataDict[iter_14_1.activity_id] then
			self._dataDict[iter_14_1.activity_id] = WeeklyCompetitionData.new()
			self._baseIdToActiveId[iter_14_1.sub_id] = iter_14_1.activity_id
		end

		self._dataDict[iter_14_1.activity_id]:onWeeklyCompetitionActivity(iter_14_1)
	end

	for iter_14_2, iter_14_3 in ipairs(arg_14_1.user_act or {}) do
		if self._dataDict[iter_14_3.activity_id] then
			self._dataDict[iter_14_3.activity_id]:onWeeklyCompetitionUserData(iter_14_3)
		end
	end
end

function WeeklyCompetitionMgrData:onS2CWeeklyCompetitionEnter(arg_15_1)
	if self._dataDict[arg_15_1.activity_id] then
		self._dataDict[arg_15_1.activity_id]:onS2CWeeklyCompetitionEnter(arg_15_1)
	end
end

function WeeklyCompetitionMgrData:onS2CWeeklyCompetitionScoreAward(arg_16_1)
	if self._dataDict[arg_16_1.activity_id] then
		self._dataDict[arg_16_1.activity_id]:onS2CWeeklyCompetitionScoreAward(arg_16_1)
	end
end

function WeeklyCompetitionMgrData:onS2CWeeklyCompetitionGetServerInfos(arg_17_1)
	return
end

return WeeklyCompetitionMgrData
