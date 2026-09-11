local SummerPubLevelCfg = require("game.config.SummerPubLevelCfg")
local SummerPubHeroCfg = require("game.config.SummerPubHeroCfg")
local var_0_2 = singletonClass("SummerPubData")

function var_0_2:Init()
	self.timeStateIndex = 1
	self.levelClearInfoList = {}
	self.pinballClearInfoList = {}
	self.cookClearInfoList = {}
	self.partnerInfoList = {}
	self.stageIdToLevelID = {}
	self.waitCookID = 0
	self.waitPartner = 0
	self.illustrationInfo = {}

	for iter_1_0, iter_1_1 in ipairs(SummerPubLevelCfg.all) do
		if SummerPubLevelCfg[iter_1_1].type == SummerPubConst.STAGE_TYPE.BATTLE then
			self.stageIdToLevelID[SummerPubLevelCfg[iter_1_1].stage_id[1]] = SummerPubLevelCfg[iter_1_1].id
		end
	end

	for iter_1_2, iter_1_3 in ipairs(SummerPubHeroCfg.all) do
		self.partnerInfoList[iter_1_3] = SummerPubConst.PARTNER_STATE.NO_FIND
	end
end

function var_0_2:initData(arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1.cook_stage_list) do
		if iter_2_1.state ~= SummerPubConst.COOK_STATE.VIEW_CG then
			self.waitCookID = iter_2_1.stage_id
		end

		table.insert(self.cookClearInfoList, iter_2_1.stage_id, iter_2_1.state)
	end

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.battle_stage_list) do
		table.insert(self.levelClearInfoList, iter_2_3, 1)
	end

	for iter_2_4, iter_2_5 in ipairs(arg_2_1.stage_list) do
		table.insert(self.pinballClearInfoList, iter_2_5, 1)
	end

	for iter_2_6, iter_2_7 in ipairs(arg_2_1.illustrated) do
		self.illustrationInfo[iter_2_7.illustrated_id] = iter_2_7.view_state
	end

	for iter_2_8, iter_2_9 in ipairs(SummerPubHeroCfg.all) do
		if SummerPubHeroCfg[iter_2_9].recruit_level ~= 0 then
			if self:GetClearNumByStageID(SummerPubHeroCfg[iter_2_9].recruit_level, SummerPubConst.PIN_BALL_STAGE_TYPE.NORMAL) > 0 then
				self.partnerInfoList[iter_2_9] = SummerPubConst.PARTNER_STATE.FIND
			elseif SummerPubHeroCfg[iter_2_9].resume_level ~= 0 and self:GetClearNumByStageID(SummerPubHeroCfg[iter_2_9].resume_level, SummerPubConst.PIN_BALL_STAGE_TYPE.NORMAL) > 0 then
				self.partnerInfoList[iter_2_9] = SummerPubConst.PARTNER_STATE.WAIT
				self.waitPartner = SummerPubHeroCfg[iter_2_9].id
			end
		end
	end

	for iter_2_10, iter_2_11 in ipairs(SummerPubCookCfg.all) do
		local var_2_1 = 0

		for iter_2_12, iter_2_13 in ipairs(SummerPubCookCfg[iter_2_11].unlocked_by_level) do
			if self:GetClearNumByStageID(iter_2_13, SummerPubConst.PIN_BALL_STAGE_TYPE.NORMAL) <= 0 then
				var_2_1 = 1

				break
			end
		end

		if var_2_1 == 0 and self:GetCookClearNumByStageID(iter_2_11) <= 0 then
			self.waitCookID = iter_2_11
		end
	end

	self.timeStateIndex = arg_2_1.time_state

	for iter_2_14 = 1, 3 do
		self:UpdatePinballRedPoint(iter_2_14)
	end

	self:UpdateIlluRedPoint()
	self:UpdatePartnerRedPoint()
end

function var_0_2:isUnlockPartner(arg_3_1)
	return self.partnerInfoList[arg_3_1] == SummerPubConst.PARTNER_STATE.FIND
end

function var_0_2:GetLevelIDByStageID(arg_4_1)
	if self.stageIdToLevelID[arg_4_1] then
		return self.stageIdToLevelID[arg_4_1]
	elseif arg_4_1 == SummerPubConst.STAGE_5270208 then
		return SummerPubConst.LEVEL_ID_4030307
	else
		error(arg_4_1, "没有对应的系统ID")
	end
end

function var_0_2.SetTimeState(arg_5_0, arg_5_1)
	arg_5_0.timeStateIndex = arg_5_1
end

function var_0_2:GetTimeState()
	return self.timeStateIndex
end

function var_0_2:getWaitPartner()
	return self.waitPartner
end

function var_0_2:getWaitCook()
	return self.waitCookID
end

function var_0_2:getFindPartner()
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(self.partnerInfoList) do
		if iter_9_1 == SummerPubConst.PARTNER_STATE.FIND then
			table.insert(var_9_0, iter_9_0)
		end
	end

	return var_9_0
end

function var_0_2.SetStageAreaIndex(arg_10_0, arg_10_1)
	saveData("summer_pub_stage_area", "last_stage", arg_10_1)
end

function var_0_2.GetStageAreaIndex(arg_11_0)
	return getData("summer_pub_stage_area", "last_stage") or SummerPubConst.FIRST_LEVEL_ID
end

function var_0_2:updateCookState(arg_12_1)
	if SummerPubCookCfg.get_id_list_by_unlocked_by_level[arg_12_1] and SummerPubCookCfg.get_id_list_by_unlocked_by_level[arg_12_1][1] and self:GetCookClearNumByStageID(SummerPubCookCfg.get_id_list_by_unlocked_by_level[arg_12_1][1]) <= 0 then
		self.waitCookID = SummerPubCookCfg.get_id_list_by_unlocked_by_level[arg_12_1][1]
	end
end

function var_0_2:isFindPartner(arg_13_1)
	return self.partnerInfoList[arg_13_1] and self.partnerInfoList[arg_13_1] == SummerPubConst.PARTNER_STATE.FIND or false
end

function var_0_2:updatePartnerState(arg_14_1)
	if SummerPubHeroCfg.get_id_list_by_recruit_level[arg_14_1] then
		for iter_14_0, iter_14_1 in ipairs(SummerPubHeroCfg.get_id_list_by_recruit_level[arg_14_1]) do
			if self.partnerInfoList[iter_14_1] < SummerPubConst.PARTNER_STATE.FIND then
				self.partnerInfoList[iter_14_1] = SummerPubConst.PARTNER_STATE.FIND
			end
		end
	end

	if SummerPubHeroCfg.get_id_list_by_resume_level[arg_14_1] then
		for iter_14_2, iter_14_3 in ipairs(SummerPubHeroCfg.get_id_list_by_resume_level[arg_14_1]) do
			if self.partnerInfoList[iter_14_3] < SummerPubConst.PARTNER_STATE.WAIT then
				self.partnerInfoList[iter_14_3] = SummerPubConst.PARTNER_STATE.WAIT
				self.waitPartner = iter_14_3
			end
		end
	end

	for iter_14_4, iter_14_5 in ipairs(SummerPubHeroCfg.all) do
		if self.partnerInfoList[iter_14_5] ~= SummerPubConst.PARTNER_STATE.FIND then
			return
		end
	end

	self.waitPartner = 0
end

function var_0_2:updateIllInfo(arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		table:insert(self.illustrationInfo, iter_15_1)
	end
end

function var_0_2:PassLevel(arg_16_1)
	self.levelClearInfoList[arg_16_1] = self.levelClearInfoList[arg_16_1] and self.levelClearInfoList[arg_16_1] + 1 or 1

	self:updatePartnerState(arg_16_1)
	self:updateCookState(arg_16_1)
end

function var_0_2:FinishPinBall(arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	if arg_17_4 == 1 then
		self.pinballClearInfoList[arg_17_2] = self.pinballClearInfoList[arg_17_2] and self.pinballClearInfoList[arg_17_2] + 1 or 1

		self:updatePartnerState(arg_17_1)
		self:updateCookState(arg_17_1)

		for iter_17_0, iter_17_1 in ipairs(arg_17_3 or {}) do
			self.illustrationInfo[iter_17_1] = self.illustrationInfo[iter_17_1] or 1
		end

		for iter_17_2 = 1, SummerPubLevelCfg[arg_17_1].area do
			self:UpdatePinballRedPoint(SummerPubLevelCfg[arg_17_1].area)
		end

		self:UpdateIlluRedPoint()
	end

	if arg_17_4 == 2 then
		-- block empty
	end
end

function var_0_2:FinishCook(arg_18_1, arg_18_2)
	self.cookClearInfoList[arg_18_1] = arg_18_2

	if arg_18_2 == SummerPubConst.COOK_STATE.VIEW_CG then
		if self.waitCookID == arg_18_1 then
			self.waitCookID = 0
		end

		local var_18_0 = SummerPubLevelCfg.get_id_list_by_stage_id[arg_18_1]

		if SummerPubLevelCfg.get_id_list_by_stage_id[arg_18_1] and var_18_0[1] then
			self:updatePartnerState(var_18_0[1])
		end

		self:UpdateIlluRedPoint()

		for iter_18_0 = 1, 3 do
			self:UpdatePinballRedPoint(iter_18_0)
		end
	end
end

function var_0_2:GetClearInfo()
	return self.levelClearInfoList
end

function var_0_2:GetClearNumByStageID(arg_20_1, arg_20_2)
	if SummerPubLevelCfg[arg_20_1].type == SummerPubConst.STAGE_TYPE.BALL then
		return self:GetPinballClearNumByStageID(SummerPubLevelCfg[arg_20_1].stage_id[arg_20_2])
	end

	if SummerPubLevelCfg[arg_20_1].type == SummerPubConst.STAGE_TYPE.COOK then
		return self:GetCookClearNumByStageID(SummerPubLevelCfg[arg_20_1].stage_id[1])
	end

	return self.levelClearInfoList[arg_20_1] or 0
end

function var_0_2:GetLevelIDIsOpen(arg_21_1)
	if SummerPubLevelCfg[arg_21_1].prev_id == 0 then
		return true
	end

	if self:GetClearNumByStageID(SummerPubLevelCfg[arg_21_1].prev_id, (SummerPubLevelCfg[SummerPubLevelCfg[arg_21_1].prev_id].type == SummerPubConst.STAGE_TYPE.BALL or nil) and SummerPubConst.PIN_BALL_STAGE_TYPE.NORMAL) > 0 then
		return true
	end

	return false
end

function var_0_2:GetPinballClearNumByStageID(arg_22_1)
	return self.pinballClearInfoList[arg_22_1] or 0
end

function var_0_2:GetCookClearNumByStageID(arg_23_1)
	if self.cookClearInfoList[arg_23_1] and self.cookClearInfoList[arg_23_1] == SummerPubConst.COOK_STATE.VIEW_CG then
		return 1
	end

	return 0
end

function var_0_2:GetCookStateByStageID(arg_24_1)
	return self.cookClearInfoList[arg_24_1] or 0
end

function var_0_2.SetCookMenuIndex(arg_25_0, arg_25_1)
	saveData("summerCookMenuView", "cookMenuIndex", arg_25_1)
end

function var_0_2.GetCookMenuIndex(arg_26_0)
	return getData("summerCookMenuView", "cookMenuIndex") or 1
end

function var_0_2:GetIlluInfo()
	return self.illustrationInfo
end

function var_0_2:UpdateIlluViewStage(arg_28_1, arg_28_2)
	if self.illustrationInfo[arg_28_1] then
		self.illustrationInfo[arg_28_1] = arg_28_2
	end
end

function var_0_2.InitRedPointGroup(arg_29_0)
	local var_29_0 = RedPointConst.SUMMER_PUB_ACTIVITY_MAIN .. ActivityConst.ACTIVITY_NYA_SUMMER_PUB
	local var_29_1 = RedPointConst.SUMMER_PUB_LIMIT_TASK .. ActivityConst.ACTIVITY_NYA_SUMMER_PUB_ACCUMULATE_TASK
	local var_29_2 = {
		RedPointConst.SUMMER_PUB_LIMIT_TASK_TAG .. ActivityConst.ACTIVITY_NYA_SUMMER_PUB_ACCUMULATE_TASK
	}

	for iter_29_0, iter_29_1 in pairs(ActivityCfg[ActivityConst.ACTIVITY_NYA_SUMMER_PUB_ACCUMULATE_TASK].sub_activity_list) do
		table.insert(var_29_2, RedPointConst.SUMMER_PUB_LIMIT_TASK_TAG .. iter_29_1)
	end

	manager.redPoint:addGroup(var_29_1, var_29_2)
	manager.notify:RegistListener(OSIRIS_TASK_UPDATE, function()
		var_0_2:UpdateTaskRedPoint()
	end)

	local var_29_3 = RedPointConst.SUMMER_PUB_RESIDENT_TASK .. ActivityConst.ACTIVITY_NYA_SUMMER_PUB
	local var_29_4 = {}

	for iter_29_2, iter_29_3 in ipairs(BilliardIllustrationsCfg.get_id_list_by_activity_id_type[ActivityConst.ACTIVITY_NYA_SUMMER_PUB][1]) do
		table.insert(var_29_4, string.format("%s_%s", RedPointConst.SUMMER_PUB_ILLUSTRATION, iter_29_3))
	end

	local var_29_5 = {}

	for iter_29_4, iter_29_5 in ipairs(BilliardIllustrationsCfg.get_id_list_by_activity_id_type[ActivityConst.ACTIVITY_NYA_SUMMER_PUB][2]) do
		table.insert(var_29_5, string.format("%s_%s", RedPointConst.SUMMER_PUB_ILLUSTRATION, iter_29_5))
	end

	manager.redPoint:addGroup(RedPointConst.SUMMER_PUB_ILLUSTRATION_MON, var_29_4)
	manager.redPoint:addGroup(RedPointConst.SUMMER_PUB_ILLUSTRATION_BORGAN, var_29_5)
	manager.redPoint:addGroup(RedPointConst.SUMMER_PUB_ILLUSTRATION, {
		RedPointConst.SUMMER_PUB_ILLUSTRATION_MON,
		RedPointConst.SUMMER_PUB_ILLUSTRATION_BORGAN
	})

	local var_29_6 = RedPointConst.SUMMER_PUB_RESIDENT_EXPLORE
	local var_29_7 = {
		RedPointConst.SUMMER_PUB_ILLUSTRATION
	}

	for iter_29_6 = 1, 3 do
		local var_29_8 = {}

		for iter_29_7, iter_29_8 in ipairs(SummerPubLevelCfg.get_id_list_by_area[iter_29_6]) do
			table.insert(var_29_8, RedPointConst.SUMMER_PUB_STAGE_ITEM .. iter_29_8)
		end

		manager.redPoint:addGroup(RedPointConst.SUMMER_PUB_STAGE_AREA .. iter_29_6, var_29_8)
		table.insert(var_29_7, RedPointConst.SUMMER_PUB_STAGE_AREA .. iter_29_6)
	end

	local var_29_9 = RedPointConst.SUMMER_PUB_SKIN_DLC_GIFT .. ActivityConst.ACTIVITY_NYA_SUMMER_PUB_SKIN_DLC

	if SummerPubData:getWaitCook() ~= 0 and SummerPubData:GetClearNumByStageID(SummerPubConst.SECOND_LEVEL_ID) > 0 then
		manager.redPoint:delGroup(var_29_6, var_29_7)
	else
		manager.redPoint:addGroup(var_29_6, var_29_7)
	end

	manager.redPoint:addGroup(RedPointConst.SUMMER_PUB_GO_BTN, {
		var_29_1,
		var_29_3,
		var_29_6,
		var_29_9,
		RedPointConst.SUMMER_PUB_RECRUIT
	})
	manager.redPoint:addGroup(var_29_0, {
		RedPointConst.SUMMER_PUB_GO_BTN
	})
end

function var_0_2:UpdateTaskRedPoint()
	self:TaskRedSet(ActivityCfg[ActivityConst.ACTIVITY_NYA_SUMMER_PUB_ACCUMULATE_TASK].sub_activity_list, RedPointConst.SUMMER_PUB_LIMIT_TASK_TAG)
	self:TaskRedSet({
		ActivityConst.ACTIVITY_NYA_SUMMER_PUB_ACCUMULATE_TASK
	}, RedPointConst.SUMMER_PUB_LIMIT_TASK_TAG)
	self:TaskRedSet({
		ActivityConst.ACTIVITY_NYA_SUMMER_PUB
	}, RedPointConst.SUMMER_PUB_RESIDENT_TASK)
	self:TaskRedSet({
		ActivityConst.ACTIVITY_NYA_SUMMER_PUB_SKIN_DLC
	}, RedPointConst.SUMMER_PUB_SKIN_DLC_GIFT)
end

function var_0_2.TaskRedSet(arg_32_0, arg_32_1, arg_32_2)
	for iter_32_0, iter_32_1 in pairs(arg_32_1) do
		local var_32_0 = ActivityData:GetActivityIsOpen(iter_32_1)

		for iter_32_2, iter_32_3 in pairs(AssignmentCfg.get_id_list_by_activity_id[iter_32_1]) do
			if var_32_0 then
				local var_32_1 = TaskData2:GetTaskProgress(iter_32_3)

				if TaskData2:GetTaskComplete(iter_32_3) then
					manager.redPoint:setTip(arg_32_2 .. iter_32_1, 0)
				elseif var_32_1 >= AssignmentCfg[iter_32_3].need then
					manager.redPoint:setTip(arg_32_2 .. iter_32_1, 1)

					break
				else
					manager.redPoint:setTip(arg_32_2 .. iter_32_1, 0)
				end
			else
				manager.redPoint:setTip(arg_32_2 .. iter_32_1, 0)
			end
		end
	end
end

function var_0_2.UpdatePinballRedPoint(arg_33_0, arg_33_1)
	for iter_33_0, iter_33_1 in ipairs(SummerPubLevelCfg.get_id_list_by_area[arg_33_1]) do
		manager.redPoint:setTip(RedPointConst.SUMMER_PUB_STAGE_ITEM .. iter_33_1, 0)
	end
end

function var_0_2:UpdateIlluRedPoint()
	for iter_34_0, iter_34_1 in pairs(self.illustrationInfo) do
		if iter_34_1 == 1 and self.waitCookID == 0 then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SUMMER_PUB_ILLUSTRATION, iter_34_0), 1)
		else
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SUMMER_PUB_ILLUSTRATION, iter_34_0), 0)
		end
	end
end

function var_0_2:UpdatePartnerRedPoint()
	if self.waitPartner ~= 0 and (getData("summer_pub_main", "look_recruit" .. self.waitPartner) or 0) == 0 then
		manager.redPoint:setTip(RedPointConst.SUMMER_PUB_RECRUIT, 1)
	else
		manager.redPoint:setTip(RedPointConst.SUMMER_PUB_RECRUIT, 0)
	end
end

return var_0_2
