local var_0_0 = g.core.config.achievement_info
local var_0_1 = g.core.config.achievement_reward_info
local var_0_2 = g.core.const.ConstMgr
local var_0_3 = g.core.const.ConstMgr.AchievementConst
local var_0_4 = g.core.const.ConstMgr.AchievementConst.RECEIVE_STATE
local var_0_5 = g.core.common.ModuleUnlock
local AchievementItemDataStruct = import(".AchievementItemDataStruct")
local AchievementAwardDataStruct = import(".AchievementAwardDataStruct")
local AchievementData = class("AchievementData")

function AchievementData:ctor()
	self:initData()
end

function AchievementData:initData()
	self._achievementInfoReceived = false
	self._jsonDict = nil
	self._newReachAchievementTargetArr = {}
	self._finishArr = {}
	self._receivedTotalProgAwardIdArr = {}
	self._hideAchieveDict = {}
	self._achieveDictArr = {}
	self._awardDataStructArr = {}
	self._achieveStatus = {}
	self._sendHideIdMap = {}

	self:_initAchievementInfo()
	self:_initAwardDataStructArr()
end

function AchievementData:_initAchievementInfo()
	self._achieveDictArr = {}

	for iter_3_0, iter_3_1 in var_0_0.ipairs() do
		local var_3_0 = AchievementItemDataStruct.new(iter_3_1)

		if iter_3_1.achievement_type == var_0_3.Type.HIDE then
			self._hideAchieveDict[iter_3_1.target] = self._hideAchieveDict[iter_3_1.target] or {}

			table.insert(self._hideAchieveDict[iter_3_1.target], var_3_0)
		else
			local var_3_1 = iter_3_1.show_type

			if not self._achieveDictArr[iter_3_1.show_type] then
				self._achieveDictArr[var_3_1] = {}
			end

			self._achieveDictArr[var_3_1][iter_3_1.target] = self._achieveDictArr[var_3_1][iter_3_1.target] or {}

			table.insert(self._achieveDictArr[var_3_1][iter_3_1.target], var_3_0)
		end
	end
end

function AchievementData:_initAwardDataStructArr()
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in var_0_1.ipairs() do
		var_4_0[iter_4_0] = AchievementAwardDataStruct.new(iter_4_1)
	end

	self._awardDataStructArr = var_4_0
end

function AchievementData:onS2CAchievementInfo(arg_5_1)
	self._achievementInfoReceived = true
	self._finishArr = arg_5_1.finish or {}

	self:_setAchieveStatusArr(arg_5_1.status)
	self:_updateAchieveMap()
	self:_setReceivedTotalProgAwardIdArr(arg_5_1.reward)
	self:_checkHideAchieveAutoGetAward()

	if not g.core.guide.GuideProxy:isGuideRunning() and var_0_5:isModuleUnlock(var_0_2.FUNCTION_TYPE.ACHIEVEMENT) and #self._newReachAchievementTargetArr > 0 then
		for iter_5_0, iter_5_1 in ipairs(self._newReachAchievementTargetArr) do
			self:_checkNormalNewReachOnAchievementInfoRet(iter_5_1)
		end

		self._newReachAchievementTargetArr = {}
	end
end

function AchievementData:onS2CFlushRedPoint(arg_6_1)
	if not arg_6_1.achievement_hint then
		return
	end

	self:onS2CAchievementInfo(arg_6_1.achievement_hint)
end

function AchievementData:onS2CAchievementFinish(arg_7_1)
	if arg_7_1.id and var_0_0.get(arg_7_1.id).achievement_type == var_0_3.Type.HIDE then
		local var_7_0 = g.core.module.ModuleManager:getCurModule()

		if var_7_0 and var_7_0.module ~= g.view.entrance.ACHIEVEMENT then
			g.core.module.ModuleManager:awardSummary(arg_7_1.awards, true)
		end
	end

	self._finishArr = arg_7_1.finish

	self:_updateAchieveMap()
end

function AchievementData:onS2CAchievementFinishOneKey(arg_8_1)
	self._finishArr = arg_8_1.finish

	self:_updateAchieveMap()
	self:_setReceivedTotalProgAwardIdArr(arg_8_1.reward)

	local var_8_0 = arg_8_1.id and arg_8_1.id[1]

	if var_8_0 and var_0_0.get(var_8_0).achievement_type == var_0_3.Type.HIDE then
		local var_8_1 = g.core.module.ModuleManager:getCurModule()

		if var_8_1 and var_8_1.module ~= g.view.entrance.ACHIEVEMENT then
			g.core.module.ModuleManager:awardSummary(arg_8_1.awards, true)
		end
	end
end

function AchievementData:onS2CAchievementReward(arg_9_1)
	self:_setReceivedTotalProgAwardIdArr(arg_9_1.reward)
end

function AchievementData:onS2CAchievementRewardOneKey(arg_10_1)
	self:_setReceivedTotalProgAwardIdArr(arg_10_1.reward)
end

function AchievementData:reqGetProgressAwardOneKey()
	local var_11_0 = self:getOneKeyGetProgressRewardIds()

	if #var_11_0 > 0 then
		g.core.network.GameNetProxy:send_C2S_Achievement_Reward_OneKey({
			id = var_11_0
		})
	end
end

function AchievementData:reqGetAchieveRewardOneKey()
	local var_12_0 = self:getOneKeyGetAchieveRewardIds()

	if #var_12_0 > 0 then
		g.core.network.GameNetProxy:send_C2S_Achievement_Finish_OneKey({
			id = var_12_0
		})
	else
		self:reqGetProgressAwardOneKey()
	end
end

function AchievementData:_updateAchieveMap()
	for iter_13_0, iter_13_1 in ipairs(self._achieveStatus) do
		self:_updateAchieveMapWithTargetCurNum(iter_13_1.id, iter_13_1.status)
	end
end

function AchievementData:_updateAchieveMapWithTargetCurNum(arg_14_1, arg_14_2)
	local function var_14_0(arg_15_0)
		if arg_15_0 then
			for iter_15_0, iter_15_1 in ipairs(arg_15_0) do
				iter_15_1:setCurNum(arg_14_2)
				iter_15_1:setFinish((self:_checkFinish(iter_15_1:getInfo().id)))
			end
		end
	end

	for iter_14_0, iter_14_1 in pairs(self._achieveDictArr) do
		var_14_0(iter_14_1[arg_14_1])
	end

	var_14_0(self._hideAchieveDict[arg_14_1])
end

function AchievementData:_setReceivedTotalProgAwardIdArr(arg_16_1)
	arg_16_1 = arg_16_1 or {}
	self._receivedTotalProgAwardIdArr = arg_16_1

	for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
		for iter_16_2, iter_16_3 in ipairs(self._awardDataStructArr) do
			if iter_16_3:getId() == iter_16_1 then
				iter_16_3:setFinish(true)

				break
			end
		end
	end
end

function AchievementData:_checkFinish(arg_17_1)
	for iter_17_0, iter_17_1 in ipairs(self._finishArr) do
		if math.uint64_equal(iter_17_1, arg_17_1) then
			return true
		end
	end

	return false
end

function AchievementData:_isTotalProgAwardReceived(arg_18_1)
	for iter_18_0, iter_18_1 in ipairs(self._receivedTotalProgAwardIdArr) do
		if math.uint64_equal(iter_18_1, arg_18_1) then
			return true
		end
	end

	return false
end

function AchievementData:_getSortRuleByStateAndTargetNum()
	return function(arg_20_0, arg_20_1)
		local var_20_0 = arg_20_0:getState()
		local var_20_1 = arg_20_1:getState()

		if var_20_0 == var_20_1 then
			return arg_20_0:getInfo().num < arg_20_1:getInfo().num
		else
			return var_20_0 < var_20_1
		end
	end
end

function AchievementData:onS2CActionStatusFlush(arg_21_1)
	local var_21_0 = arg_21_1.status
	local var_21_1

	for iter_21_0, iter_21_1 in pairs(self._achieveStatus) do
		if iter_21_1.id == arg_21_1.id then
			var_21_1 = iter_21_0

			break
		end
	end

	if var_21_1 then
		self._achieveStatus[var_21_1].status = var_21_0
	else
		table.insert(self._achieveStatus, {
			id = arg_21_1.id,
			status = var_21_0
		})
	end

	if self._achievementInfoReceived then
		self:_checkNewAchievementReach(arg_21_1.id, var_21_0)
		self:_updateAchieveMapWithTargetCurNum(arg_21_1.id, var_21_0)
	else
		table.insert(self._newReachAchievementTargetArr, arg_21_1.id)
	end
end

function AchievementData:_checkNewAchievementReach(arg_22_1, arg_22_2)
	if g.core.guide.GuideProxy:isGuideRunning() then
		return
	elseif not var_0_5:isModuleUnlock(var_0_2.FUNCTION_TYPE.ACHIEVEMENT) then
		return
	end

	local function var_22_0(arg_23_0)
		if not arg_23_0 then
			return
		end

		local var_23_0 = {}

		for iter_23_0 = 1, #arg_23_0 do
			if arg_23_0[iter_23_0]:isNewReachWithNum(arg_22_2) and arg_23_0[iter_23_0]:getState() == var_0_4.CAN_RECEIVE then
				local var_23_1 = arg_23_0[iter_23_0]:getInfo()

				if arg_23_0[iter_23_0]:isHideAchievement() then
					table.insert(var_23_0, var_23_1.id)
				end

				if arg_23_0[iter_23_0]:isPromptOnReach() then
					self:_setAchievementPrompt(var_23_1.id)
					g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, {
						achievement = arg_23_0[iter_23_0]
					})
				end
			end
		end

		if #var_23_0 > 0 then
			self:_filterHideId(var_23_0)
			g.core.network.GameNetProxy:send_C2S_Achievement_Finish_OneKey({
				id = var_23_0
			})
		end
	end

	var_22_0(self._hideAchieveDict[arg_22_1])

	for iter_22_0, iter_22_1 in pairs(self._achieveDictArr) do
		var_22_0(iter_22_1[arg_22_1])
	end

	self:_saveJson()
end

function AchievementData:_checkNormalNewReachOnAchievementInfoRet(arg_24_1)
	for iter_24_0, iter_24_1 in pairs(self._achieveDictArr) do
		local var_24_0 = iter_24_1[arg_24_1] or {}

		for iter_24_2 = #var_24_0, 1, -1 do
			local var_24_1 = var_24_0[iter_24_2]:getState()

			if var_24_1 == var_0_4.CAN_RECEIVE then
				if var_24_0[iter_24_2]:isPromptOnReach() then
					local var_24_2 = var_24_0[iter_24_2]:getInfo()

					if not self:_isAchievementPrompt(var_24_2.id) then
						self:_setAchievementPrompt(var_24_2.id)
						self:_saveJson()
						g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, {
							achievement = var_24_0[iter_24_2]
						})
					end
				end

				break
			elseif var_24_1 == var_0_4.HAS_RECEIVED then
				break
			end
		end
	end
end

function AchievementData:_filterHideId(arg_25_1)
	local var_25_0 = {}

	for iter_25_0, iter_25_1 in ipairs(arg_25_1) do
		if not self._sendHideIdMap[iter_25_1] then
			table.insert(var_25_0, iter_25_1)

			self._sendHideIdMap[iter_25_1] = true
		end
	end

	arg_25_1 = var_25_0
end

function AchievementData:_checkHideAchieveAutoGetAward()
	if g.core.guide.GuideProxy:isGuideRunning() then
		return
	elseif not var_0_5:isModuleUnlock(var_0_2.FUNCTION_TYPE.ACHIEVEMENT) then
		return
	end

	local var_26_0 = {}

	for iter_26_0, iter_26_1 in pairs(self._hideAchieveDict) do
		for iter_26_2, iter_26_3 in ipairs(iter_26_1) do
			if iter_26_3:getState() == var_0_4.CAN_RECEIVE then
				local var_26_1 = iter_26_3:getInfo()

				if iter_26_3:isPromptOnReach() then
					if not self:_isAchievementPrompt(var_26_1.id) then
						self:_setAchievementPrompt(var_26_1.id)
					end

					g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, {
						achievement = iter_26_3
					})
				end

				table.insert(var_26_0, var_26_1.id)
			end
		end
	end

	if #var_26_0 > 0 then
		self:_filterHideId(var_26_0)
		g.core.network.GameNetProxy:send_C2S_Achievement_Finish_OneKey({
			id = var_26_0
		})
	end

	self:_saveJson()
end

function AchievementData:getAwardDataStructArr()
	return self._awardDataStructArr
end

function AchievementData:getAchieveDictArr()
	return self._achieveDictArr
end

function AchievementData:getShowedHideAchieveArr()
	local var_29_0 = {}

	for iter_29_0, iter_29_1 in pairs(self._hideAchieveDict) do
		for iter_29_2, iter_29_3 in pairs(iter_29_1) do
			if iter_29_3:getState() == var_0_4.HAS_RECEIVED then
				table.insert(var_29_0, iter_29_3)
			end
		end
	end

	return var_29_0
end

function AchievementData:getAchieveMapWithPage(arg_30_1)
	return self._achieveDictArr[arg_30_1] or {}
end

function AchievementData:getAchieveListWithPageTarget(arg_31_1, arg_31_2)
	return self._achieveDictArr[arg_31_1][arg_31_2]
end

function AchievementData:getShowAchievementItemDataStruct(arg_32_1, arg_32_2)
	local var_32_0 = self:getAchieveListWithPageTarget(arg_32_1, arg_32_2)

	for iter_32_0 = 1, #var_32_0 - 1 do
		if var_32_0[iter_32_0]:getState() ~= var_0_4.HAS_RECEIVED then
			return var_32_0[iter_32_0]
		end
	end

	return var_32_0[#var_32_0]
end

function AchievementData:getCurTotalProgAwardDataStruct()
	for iter_33_0, iter_33_1 in ipairs(self._awardDataStructArr) do
		if iter_33_1:getState() ~= var_0_4.HAS_RECEIVED then
			return self._awardDataStructArr[iter_33_0]
		end
	end

	return self._awardDataStructArr[#self._awardDataStructArr]
end

function AchievementData:getInfo(arg_34_1, arg_34_2)
	local var_34_0 = self:getAchieveListWithPageTarget(arg_34_1, arg_34_2)[1]

	if var_34_0 then
		return var_34_0:getInfo()
	end
end

function AchievementData:getOneKeyGetProgressRewardIds()
	local var_35_0 = {}

	for iter_35_0, iter_35_1 in ipairs((self:getAwardDataStructArr())) do
		if iter_35_1:getState() == var_0_4.CAN_RECEIVE then
			table.insert(var_35_0, (iter_35_1:getId()))
		end
	end

	return var_35_0
end

function AchievementData:getOneKeyGetAchieveRewardIds()
	local var_36_0 = {}

	local function var_36_1(arg_37_0)
		for iter_37_0, iter_37_1 in ipairs(arg_37_0) do
			if iter_37_1:getState() == var_0_4.CAN_RECEIVE then
				table.insert(var_36_0, iter_37_1:getInfo().id)
			end
		end
	end

	for iter_36_0, iter_36_1 in pairs(self._achieveDictArr) do
		for iter_36_2, iter_36_3 in pairs(iter_36_1) do
			var_36_1(iter_36_3)
		end
	end

	return var_36_0
end

function AchievementData:isExistAwardWithPage(arg_38_1)
	for iter_38_0, iter_38_1 in pairs((self:getAchieveMapWithPage(arg_38_1))) do
		for iter_38_2, iter_38_3 in ipairs(iter_38_1) do
			if iter_38_3:getState() == var_0_4.CAN_RECEIVE then
				return true
			end
		end
	end

	return false
end

function AchievementData:isExistAchieveReward(arg_39_1)
	if not arg_39_1.page then
		for iter_39_0 in pairs(self._achieveDictArr) do
			if self:isExistAwardWithPage(iter_39_0) then
				return true
			end
		end
	elseif not arg_39_1.target then
		return self:isExistAwardWithPage(arg_39_1.page)
	else
		for iter_39_1, iter_39_2 in pairs((self:getAchieveListWithPageTarget(arg_39_1.page, arg_39_1.target))) do
			if iter_39_2:getState() == var_0_4.CAN_RECEIVE then
				return true
			end
		end
	end
end

function AchievementData:isExistOneKeyGeAchieveReward()
	if var_0_5:isModuleUnlock(var_0_2.FUNCTION_TYPE.ACHIEVEMENT_ONE_KEY_AWARD) then
		for iter_40_0 in pairs(self._achieveDictArr) do
			if self:isExistAwardWithPage(iter_40_0) then
				return true
			end
		end
	end
end

function AchievementData:isExistProgressReward()
	local var_41_0 = self:getCurTotalProgAwardDataStruct()

	if var_41_0 then
		return var_41_0:getState() == var_0_3.RECEIVE_STATE.CAN_RECEIVE
	end

	return false
end

function AchievementData:isExistOneKeyGetProgressReward()
	return var_0_5:isModuleUnlock(var_0_2.FUNCTION_TYPE.ACHIEVEMENT_ONE_KEY_AWARD) and self:isExistProgressReward()
end

function AchievementData:_isAchievementPrompt(arg_43_1)
	return self:_getJsonDict()[self:_getSaveKey(arg_43_1)] == 1
end

function AchievementData:_setAchievementPrompt(arg_44_1)
	self:_getJsonDict()[self:_getSaveKey(arg_44_1)] = 1
end

function AchievementData:_saveJson()
	g.core.common.Storage:save(var_0_3.JSON_NAME, (self:_getJsonDict()))
end

function AchievementData:_getJsonDict()
	local var_46_0 = self._jsonDict

	if not self._jsonDict then
		var_46_0 = g.core.common.Storage:load(var_0_3.JSON_NAME) or {}
		self._jsonDict = var_46_0
	end

	return var_46_0
end

function AchievementData:_getSaveKey(arg_47_1)
	return tostring(arg_47_1)
end

function AchievementData:_setAchieveStatusArr(arg_48_1)
	arg_48_1 = arg_48_1 or {}

	local var_48_0 = {}

	for iter_48_0, iter_48_1 in ipairs(arg_48_1) do
		var_48_0[iter_48_1.id] = iter_48_1.status
	end

	if not var_48_0[var_0_3.GUILD_CONTINUOUS_PERFECT_CHARGE] then
		table.insert(arg_48_1, {
			status = 0,
			id = var_0_3.GUILD_CONTINUOUS_PERFECT_CHARGE
		})
	end

	if not var_48_0[var_0_3.GUILD_CONTINUOUS_MIN_CHARGE] then
		table.insert(arg_48_1, {
			status = 0,
			id = var_0_3.GUILD_CONTINUOUS_MIN_CHARGE
		})
	end

	self._achieveStatus = arg_48_1
end

return AchievementData
