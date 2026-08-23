local EchoLabConst = require("app.view.module.echoLab.const.EchoLabConst")
local EchoLabCollectBuildStruct = class("EchoLabCollectBuildStruct")

function EchoLabCollectBuildStruct:ctor(arg_1_1, arg_1_2)
	self._buildType = arg_1_1
	self._cfgList = {}
	self._cardTypeList = {}
	self._cardIndexDict = {}
	self._level = 1
	self._lastLevel = 1
	self._curExp = 0
	self._curCfg = nil
	self._hangUpList = {}
	self._hangUpDict = {}
	self._isReceiveNetInfo = false
	self._dailyActiveCardInfoDict = {}

	self:_init(arg_1_2)
end

function EchoLabCollectBuildStruct:_init(arg_2_1)
	self._cfgList = arg_2_1

	table.sort(self._cfgList, function(arg_3_0, arg_3_1)
		return arg_3_0.build_grade < arg_3_1.build_grade
	end)

	self._curCfg = self._cfgList[self._level]
end

function EchoLabCollectBuildStruct:clearCardList()
	self._cardTypeList = {}
	self._cardIndexDict = {}
end

function EchoLabCollectBuildStruct:addCardToList(arg_5_1, arg_5_2)
	local var_5_0 = arg_5_1:getCardType()
	local var_5_1 = self._cardIndexDict[var_5_0]

	if not self._cardIndexDict[var_5_0] then
		table.insert(self._cardTypeList, {})

		var_5_1 = #self._cardTypeList
		self._cardIndexDict[var_5_0] = #self._cardTypeList
	end

	self._cardTypeList[var_5_1][#self._cardTypeList[var_5_1] + 1] = arg_5_1

	if arg_5_2 then
		self:sortCardList()
	end
end

function EchoLabCollectBuildStruct:removeCard(arg_6_1, arg_6_2, arg_6_3)
	if not self._cardIndexDict[arg_6_1] then
		return
	end

	local var_6_0 = self._cardTypeList[self._cardIndexDict[arg_6_1]]

	for iter_6_0, iter_6_1 in ipairs(self._cardTypeList[self._cardIndexDict[arg_6_1]]) do
		if arg_6_2 == iter_6_1:getAdvanceId() then
			table.remove(var_6_0, iter_6_0)

			self._cardIndexDict[arg_6_1 .. "_" .. arg_6_2] = nil

			break
		end
	end

	if arg_6_3 then
		self:sortCardList()
	end
end

function EchoLabCollectBuildStruct:sortCardList()
	table.sort(self._cardTypeList, function(arg_8_0, arg_8_1)
		return arg_8_0[1]:getCardType() < arg_8_1[1]:getCardType()
	end)

	for iter_7_0, iter_7_1 in ipairs(self._cardTypeList) do
		self._cardIndexDict[iter_7_1[1]:getCardType()] = iter_7_0
	end

	self:_updateDailyActiveInfoDict()
end

function EchoLabCollectBuildStruct:_updateDailyActiveInfoDict()
	for iter_9_0, iter_9_1 in pairs(EchoLabConst.COLLECT_DAILY_MAX_ACTIVE_COUNT_IDS) do
		if self._cardIndexDict[iter_9_0] then
			local var_9_0 = self._dailyActiveCardInfoDict[iter_9_0] or {}

			var_9_0.activeMaxCount = g.core.config.parameter_info.get(iter_9_1).parameter
			var_9_0.activeCount = var_9_0.activeCount or 0
			self._dailyActiveCardInfoDict[iter_9_0] = var_9_0
		end
	end
end

function EchoLabCollectBuildStruct:getBuildType()
	return self._buildType
end

function EchoLabCollectBuildStruct:getBuildName()
	return g.core.lang:get(408900 + self._buildType)
end

function EchoLabCollectBuildStruct:setLevel(arg_12_1)
	self._lastLevel = self._level
	self._level = arg_12_1
	self._curCfg = self._cfgList[self._level]

	self:onReceiveNetInfo()
end

function EchoLabCollectBuildStruct:resetLastLevel()
	self._lastLevel = self._level
end

function EchoLabCollectBuildStruct:getLastLevel()
	return self._lastLevel
end

function EchoLabCollectBuildStruct:getLevel()
	return self._level
end

function EchoLabCollectBuildStruct:setCurExp(arg_16_1)
	self._curExp = arg_16_1
end

function EchoLabCollectBuildStruct:addExp(arg_17_1)
	self._curExp = self._curExp + arg_17_1
end

function EchoLabCollectBuildStruct:getExpInfo()
	local var_18_0 = self._curExp
	local var_18_1 = self:getNextLevelCfg()

	if var_18_1 then
		var_18_0 = var_18_1.build_exp
	end

	return {
		startExp = self._curCfg.build_exp,
		needExp = var_18_0 - self._curCfg.build_exp,
		cur = self._curExp,
		max = var_18_0
	}
end

function EchoLabCollectBuildStruct:setHangupInfo(arg_19_1)
	self._hangUpList = {}
	self._hangUpDict = {}

	if #arg_19_1 < 1 then
		arg_19_1 = {
			arg_19_1
		}
	end

	for iter_19_0, iter_19_1 in ipairs(arg_19_1) do
		self:addOneHangUpInfo(iter_19_1)
	end
end

function EchoLabCollectBuildStruct:addOneHangUpInfo(arg_20_1)
	table.insert(self._hangUpList, arg_20_1)

	for iter_20_0, iter_20_1 in ipairs(arg_20_1.awards or {}) do
		self._hangUpDict[iter_20_1.type .. "_" .. iter_20_1.value] = self._hangUpDict[iter_20_1.type .. "_" .. iter_20_1.value] or 0
		self._hangUpDict[iter_20_1.type .. "_" .. iter_20_1.value] = self._hangUpDict[iter_20_1.type .. "_" .. iter_20_1.value] + iter_20_1.size
	end

	self:onReceiveNetInfo()
end

function EchoLabCollectBuildStruct:getHangUpInfoList()
	return self._hangUpList
end

function EchoLabCollectBuildStruct:getHangUpInfoDict()
	return self._hangUpDict
end

function EchoLabCollectBuildStruct:canGetHangupAwards()
	if next(self._hangUpDict) then
		return true
	end

	local var_23_1 = self:getHangupTimeInfoList()

	return (#var_23_1 > 0 or nil) and g.core.config.parameter_info.get(20212).parameter < var_23_1[1].totalTimeTab.time
end

function EchoLabCollectBuildStruct:getHangupTimeInfoList()
	local var_24_0 = {
		time = 0
	}
	local var_24_1 = {}

	for iter_24_0, iter_24_1 in ipairs(self._hangUpList) do
		if not iter_24_1.start_time then
			break
		end

		local var_24_2 = iter_24_1.end_time
		local var_24_3

		if not iter_24_1.end_time then
			var_24_2 = g.core.common.ServerTime:getTime()
			var_24_3 = {
				startTime = iter_24_1.start_time,
				endTime = var_24_2,
				hangUpTime = var_24_2 - iter_24_1.start_time,
				totalTimeTab = var_24_0
			}
		end

		var_24_0.time = var_24_0.time + (var_24_2 - iter_24_1.start_time)

		table.insert(var_24_1, var_24_3)
	end

	return var_24_1
end

function EchoLabCollectBuildStruct:getHangupOutInfo(arg_25_1)
	local var_25_0 = self:getCfgByLevel(arg_25_1 or self._level)

	return {
		type = var_25_0.output_type,
		value = var_25_0.output_value,
		size = var_25_0.output_size
	}
end

function EchoLabCollectBuildStruct:getReward()
	return {
		type = self._curCfg.reward_type,
		value = self._curCfg.reward_value,
		size = self._curCfg.reward_size
	}
end

function EchoLabCollectBuildStruct:getTalent()
	return self._curCfg.build_talent
end

function EchoLabCollectBuildStruct:_getOneTalentAttrInfo(arg_28_1)
	local var_28_0 = {}
	local var_28_1 = {}
	local var_28_2 = g.core.config.talent_skill_info.get(arg_28_1)
	local var_28_3 = 1

	while g.core.config.talent_skill_info.hasKey("affect_type_" .. 1) do
		if var_28_2["affect_type_" .. 1] > 0 then
			local var_28_4 = {
				type = var_28_2["affect_type_" .. 1],
				value = var_28_2["affect_value_" .. var_28_3]
			}

			table.insert(var_28_1, var_28_4)

			var_28_0[var_28_2["affect_type_" .. 1]] = var_28_0[var_28_2["affect_type_" .. 1]] or 0
			var_28_0[var_28_2["affect_type_" .. 1]] = var_28_0[var_28_2["affect_type_" .. 1]] + var_28_4.value
		end

		var_28_3 = var_28_3 + 1
	end

	return var_28_0, var_28_1
end

function EchoLabCollectBuildStruct:getTalentAttrList(arg_29_1)
	local var_29_0 = {}

	for iter_29_0, iter_29_1 in pairs((self:getAllTalentAttrDict(arg_29_1))) do
		table.insert(var_29_0, {
			type = iter_29_0,
			value = iter_29_1
		})
	end

	return var_29_0
end

function EchoLabCollectBuildStruct:getAllTalentAttrDict(arg_30_1, arg_30_2)
	arg_30_1 = arg_30_1 or self._level
	arg_30_2 = arg_30_2 or {}

	for iter_30_0 = 1, arg_30_1 do
		self:getTalentAttrDictByOneLevel(iter_30_0, arg_30_2)
	end

	return arg_30_2
end

function EchoLabCollectBuildStruct:getTalentAttrDictByOneLevel(arg_31_1, arg_31_2)
	arg_31_1 = arg_31_1 or self._level
	arg_31_2 = arg_31_2 or {}

	if self._cfgList[arg_31_1].build_talent ~= 0 then
		for iter_31_0, iter_31_1 in pairs((self:_getOneTalentAttrInfo(self._cfgList[arg_31_1].build_talent))) do
			arg_31_2[iter_31_0] = arg_31_2[iter_31_0] or 0
			arg_31_2[iter_31_0] = arg_31_2[iter_31_0] + iter_31_1
		end
	end

	return arg_31_2
end

function EchoLabCollectBuildStruct:getNextLevelCfg()
	return self:getCfgByLevel(self._level + 1)
end

function EchoLabCollectBuildStruct:getCfgByLevel(arg_33_1)
	return self._cfgList[arg_33_1]
end

function EchoLabCollectBuildStruct:getDes()
	return self._curCfg.reward_des
end

function EchoLabCollectBuildStruct:getCardStructByCardTypeAndAdvanceId(arg_35_1, arg_35_2)
	return self._cardIndexDict[arg_35_1 .. "_" .. arg_35_2]
end

function EchoLabCollectBuildStruct:getCardListByType(arg_36_1)
	if self._cardIndexDict[arg_36_1] then
		return self._cardTypeList[self._cardIndexDict[arg_36_1]]
	end
end

function EchoLabCollectBuildStruct:getCardTypeList()
	return self._cardTypeList
end

function EchoLabCollectBuildStruct:getCardIndexDict()
	return self._cardIndexDict
end

function EchoLabCollectBuildStruct:getAllCardAttrDict(arg_39_1)
	arg_39_1 = arg_39_1 or {}

	for iter_39_0, iter_39_1 in ipairs(self._cardTypeList) do
		for iter_39_2, iter_39_3 in ipairs(iter_39_1) do
			if iter_39_3:isActive() then
				for iter_39_4, iter_39_5 in pairs(iter_39_3:getAttrInfo().dict) do
					arg_39_1[iter_39_4] = arg_39_1[iter_39_4] or 0
					arg_39_1[iter_39_4] = arg_39_1[iter_39_4] + iter_39_5
				end
			end
		end
	end

	return arg_39_1
end

function EchoLabCollectBuildStruct:getAllCardAttrInfoList()
	local var_40_0 = self:getAllCardAttrDict()
	local var_40_1 = {}

	for iter_40_0, iter_40_1 in pairs(var_40_0) do
		table.insert(var_40_1, {
			type = iter_40_0,
			value = iter_40_1
		})
	end

	return var_40_1, var_40_0
end

function EchoLabCollectBuildStruct:updateDailyActiveInfoByNet(arg_41_1)
	self:updateOneDailyActiveInfo(arg_41_1.type, arg_41_1)
end

function EchoLabCollectBuildStruct:updateOneDailyActiveInfo(arg_42_1, arg_42_2)
	if not self._dailyActiveCardInfoDict[arg_42_1] then
		return
	end

	if arg_42_2.daily_actived_cnt then
		self._dailyActiveCardInfoDict[arg_42_1].activeCount = arg_42_2.daily_actived_cnt
	end

	if arg_42_2.daily_active_cnt then
		self._dailyActiveCardInfoDict[arg_42_1].activeCount = arg_42_2.daily_active_cnt
	end

	if arg_42_2.last_active_time then
		self._dailyActiveCardInfoDict[arg_42_1].lastTime = arg_42_2.last_active_time
	end
end

function EchoLabCollectBuildStruct:getDailyActiveInfo(arg_43_1)
	return self._dailyActiveCardInfoDict[arg_43_1]
end

function EchoLabCollectBuildStruct:onReceiveNetInfo()
	self._isReceiveNetInfo = true
end

function EchoLabCollectBuildStruct:isReceiveNetInfo()
	return self._isReceiveNetInfo
end

return EchoLabCollectBuildStruct
