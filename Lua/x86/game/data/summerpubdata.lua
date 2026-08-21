local var_0_0 = require("game.config.SummerPubLevelCfg")
local var_0_1 = require("game.config.SummerPubHeroCfg")
local var_0_2 = singletonClass("SummerPubData")

function var_0_2.Init(arg_1_0)
	arg_1_0.timeStateIndex = 1
	arg_1_0.levelClearInfoList = {}
	arg_1_0.pinballClearInfoList = {}
	arg_1_0.cookClearInfoList = {}
	arg_1_0.partnerInfoList = {}
	arg_1_0.stageIdToLevelID = {}
	arg_1_0.waitCookID = 0
	arg_1_0.waitPartner = 0
	arg_1_0.illustrationInfo = {}

	for iter_1_0, iter_1_1 in ipairs(var_0_0.all) do
		local var_1_0 = var_0_0[iter_1_1]

		if var_1_0.type == SummerPubConst.STAGE_TYPE.BATTLE then
			arg_1_0.stageIdToLevelID[var_1_0.stage_id[1]] = var_1_0.id
		end
	end

	for iter_1_2, iter_1_3 in ipairs(var_0_1.all) do
		arg_1_0.partnerInfoList[iter_1_3] = SummerPubConst.PARTNER_STATE.NO_FIND
	end
end

function var_0_2.initData(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1.cook_stage_list) do
		if iter_2_1.state ~= SummerPubConst.COOK_STATE.VIEW_CG then
			arg_2_0.waitCookID = iter_2_1.stage_id
		end

		table.insert(arg_2_0.cookClearInfoList, iter_2_1.stage_id, iter_2_1.state)
	end

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.battle_stage_list) do
		table.insert(arg_2_0.levelClearInfoList, iter_2_3, 1)
	end

	for iter_2_4, iter_2_5 in ipairs(arg_2_1.stage_list) do
		table.insert(arg_2_0.pinballClearInfoList, iter_2_5, 1)

		local var_2_0 = SummerPubPinBallSkillCfg[iter_2_5]
	end

	for iter_2_6, iter_2_7 in ipairs(arg_2_1.illustrated) do
		arg_2_0.illustrationInfo[iter_2_7.illustrated_id] = iter_2_7.view_state
	end

	for iter_2_8, iter_2_9 in ipairs(var_0_1.all) do
		local var_2_1 = var_0_1[iter_2_9]

		if var_2_1.recruit_level ~= 0 then
			if arg_2_0:GetClearNumByStageID(var_2_1.recruit_level, SummerPubConst.PIN_BALL_STAGE_TYPE.NORMAL) > 0 then
				arg_2_0.partnerInfoList[iter_2_9] = SummerPubConst.PARTNER_STATE.FIND
			elseif var_2_1.resume_level ~= 0 and arg_2_0:GetClearNumByStageID(var_2_1.resume_level, SummerPubConst.PIN_BALL_STAGE_TYPE.NORMAL) > 0 then
				arg_2_0.partnerInfoList[iter_2_9] = SummerPubConst.PARTNER_STATE.WAIT
				arg_2_0.waitPartner = var_2_1.id
			end
		end
	end

	for iter_2_10, iter_2_11 in ipairs(SummerPubCookCfg.all) do
		local var_2_2 = SummerPubCookCfg[iter_2_11]
		local var_2_3 = 0

		for iter_2_12, iter_2_13 in ipairs(var_2_2.unlocked_by_level) do
			if arg_2_0:GetClearNumByStageID(iter_2_13, SummerPubConst.PIN_BALL_STAGE_TYPE.NORMAL) <= 0 then
				var_2_3 = 1

				break
			end
		end

		if var_2_3 == 0 and arg_2_0:GetCookClearNumByStageID(iter_2_11) <= 0 then
			arg_2_0.waitCookID = iter_2_11
		end
	end

	arg_2_0.timeStateIndex = arg_2_1.time_state

	for iter_2_14 = 1, 3 do
		arg_2_0:UpdatePinballRedPoint(iter_2_14)
	end

	arg_2_0:UpdateIlluRedPoint()
	arg_2_0:UpdatePartnerRedPoint()
end

function var_0_2.isUnlockPartner(arg_3_0, arg_3_1)
	return arg_3_0.partnerInfoList[arg_3_1] == SummerPubConst.PARTNER_STATE.FIND
end

function var_0_2.GetLevelIDByStageID(arg_4_0, arg_4_1)
	if arg_4_0.stageIdToLevelID[arg_4_1] then
		return arg_4_0.stageIdToLevelID[arg_4_1]
	elseif arg_4_1 == SummerPubConst.STAGE_5270208 then
		return SummerPubConst.LEVEL_ID_4030307
	else
		error(arg_4_1, "没有对应的系统ID")
	end
end

function var_0_2.SetTimeState(arg_5_0, arg_5_1)
	arg_5_0.timeStateIndex = arg_5_1
end

function var_0_2.GetTimeState(arg_6_0)
	return arg_6_0.timeStateIndex
end

function var_0_2.getWaitPartner(arg_7_0)
	return arg_7_0.waitPartner
end

function var_0_2.getWaitCook(arg_8_0)
	return arg_8_0.waitCookID
end

function var_0_2.getFindPartner(arg_9_0)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(arg_9_0.partnerInfoList) do
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

function var_0_2.updateCookState(arg_12_0, arg_12_1)
	local var_12_0 = SummerPubCookCfg.get_id_list_by_unlocked_by_level[arg_12_1]

	if var_12_0 and var_12_0[1] and arg_12_0:GetCookClearNumByStageID(var_12_0[1]) <= 0 then
		arg_12_0.waitCookID = var_12_0[1]
	end
end

function var_0_2.isFindPartner(arg_13_0, arg_13_1)
	return arg_13_0.partnerInfoList[arg_13_1] and arg_13_0.partnerInfoList[arg_13_1] == SummerPubConst.PARTNER_STATE.FIND or false
end

function var_0_2.updatePartnerState(arg_14_0, arg_14_1)
	local var_14_0 = var_0_1.get_id_list_by_recruit_level[arg_14_1]

	if var_14_0 then
		for iter_14_0, iter_14_1 in ipairs(var_14_0) do
			if arg_14_0.partnerInfoList[iter_14_1] < SummerPubConst.PARTNER_STATE.FIND then
				arg_14_0.partnerInfoList[iter_14_1] = SummerPubConst.PARTNER_STATE.FIND
			end
		end
	end

	local var_14_1 = var_0_1.get_id_list_by_resume_level[arg_14_1]

	if var_14_1 then
		for iter_14_2, iter_14_3 in ipairs(var_14_1) do
			if arg_14_0.partnerInfoList[iter_14_3] < SummerPubConst.PARTNER_STATE.WAIT then
				arg_14_0.partnerInfoList[iter_14_3] = SummerPubConst.PARTNER_STATE.WAIT
				arg_14_0.waitPartner = iter_14_3
			end
		end
	end

	for iter_14_4, iter_14_5 in ipairs(var_0_1.all) do
		if arg_14_0.partnerInfoList[iter_14_5] ~= SummerPubConst.PARTNER_STATE.FIND then
			return
		end
	end

	arg_14_0.waitPartner = 0
end

function var_0_2.updateIllInfo(arg_15_0, arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		table:insert(arg_15_0.illustrationInfo, iter_15_1)
	end
end

function var_0_2.PassLevel(arg_16_0, arg_16_1)
	if arg_16_0.levelClearInfoList[arg_16_1] then
		arg_16_0.levelClearInfoList[arg_16_1] = arg_16_0.levelClearInfoList[arg_16_1] + 1
	else
		arg_16_0.levelClearInfoList[arg_16_1] = 1
	end

	arg_16_0:updatePartnerState(arg_16_1)
	arg_16_0:updateCookState(arg_16_1)
end

function var_0_2.FinishPinBall(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	if arg_17_4 == 1 then
		if arg_17_0.pinballClearInfoList[arg_17_2] then
			arg_17_0.pinballClearInfoList[arg_17_2] = arg_17_0.pinballClearInfoList[arg_17_2] + 1
		else
			arg_17_0.pinballClearInfoList[arg_17_2] = 1
		end

		arg_17_0:updatePartnerState(arg_17_1)
		arg_17_0:updateCookState(arg_17_1)

		for iter_17_0, iter_17_1 in ipairs(arg_17_3 or {}) do
			if not arg_17_0.illustrationInfo[iter_17_1] then
				arg_17_0.illustrationInfo[iter_17_1] = 1
			end
		end

		local var_17_0 = var_0_0[arg_17_1]

		for iter_17_2 = 1, var_17_0.area do
			arg_17_0:UpdatePinballRedPoint(var_17_0.area)
		end

		arg_17_0:UpdateIlluRedPoint()
	end

	if arg_17_4 == 2 then
		-- block empty
	end
end

function var_0_2.FinishCook(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0.cookClearInfoList[arg_18_1] = arg_18_2

	if arg_18_2 == SummerPubConst.COOK_STATE.VIEW_CG then
		if arg_18_0.waitCookID == arg_18_1 then
			arg_18_0.waitCookID = 0
		end

		local var_18_0 = var_0_0.get_id_list_by_stage_id[arg_18_1]

		if var_18_0 and var_18_0[1] then
			arg_18_0:updatePartnerState(var_18_0[1])
		end

		arg_18_0:UpdateIlluRedPoint()

		for iter_18_0 = 1, 3 do
			arg_18_0:UpdatePinballRedPoint(iter_18_0)
		end
	end
end

function var_0_2.GetClearInfo(arg_19_0)
	return arg_19_0.levelClearInfoList
end

function var_0_2.GetClearNumByStageID(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = var_0_0[arg_20_1]

	if var_20_0.type == SummerPubConst.STAGE_TYPE.BALL then
		local var_20_1 = var_0_0[arg_20_1].stage_id[arg_20_2]

		return arg_20_0:GetPinballClearNumByStageID(var_20_1)
	end

	if var_20_0.type == SummerPubConst.STAGE_TYPE.COOK then
		local var_20_2 = var_20_0.stage_id[1]

		return arg_20_0:GetCookClearNumByStageID(var_20_2)
	end

	return arg_20_0.levelClearInfoList[arg_20_1] or 0
end

function var_0_2.GetLevelIDIsOpen(arg_21_0, arg_21_1)
	local var_21_0 = var_0_0[arg_21_1]

	if var_21_0.prev_id == 0 then
		return true
	end

	local var_21_1 = var_0_0[var_21_0.prev_id]
	local var_21_2

	if var_21_1.type == SummerPubConst.STAGE_TYPE.BALL then
		var_21_2 = SummerPubConst.PIN_BALL_STAGE_TYPE.NORMAL
	end

	if arg_21_0:GetClearNumByStageID(var_21_0.prev_id, var_21_2) > 0 then
		return true
	end

	return false
end

function var_0_2.GetPinballClearNumByStageID(arg_22_0, arg_22_1)
	return arg_22_0.pinballClearInfoList[arg_22_1] or 0
end

function var_0_2.GetCookClearNumByStageID(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0.cookClearInfoList[arg_23_1]

	if var_23_0 and var_23_0 == SummerPubConst.COOK_STATE.VIEW_CG then
		return 1
	end

	return 0
end

function var_0_2.GetCookStateByStageID(arg_24_0, arg_24_1)
	return arg_24_0.cookClearInfoList[arg_24_1] or 0
end

function var_0_2.SetCookMenuIndex(arg_25_0, arg_25_1)
	saveData("summerCookMenuView", "cookMenuIndex", arg_25_1)
end

function var_0_2.GetCookMenuIndex(arg_26_0)
	return getData("summerCookMenuView", "cookMenuIndex") or 1
end

function var_0_2.GetIlluInfo(arg_27_0)
	return arg_27_0.illustrationInfo
end

function var_0_2.UpdateIlluViewStage(arg_28_0, arg_28_1, arg_28_2)
	if arg_28_0.illustrationInfo[arg_28_1] then
		arg_28_0.illustrationInfo[arg_28_1] = arg_28_2
	end
end

function var_0_2.InitRedPointGroup(arg_29_0)
	local var_29_0 = RedPointConst.SUMMER_PUB_ACTIVITY_MAIN .. ActivityConst.ACTIVITY_NYA_SUMMER_PUB
	local var_29_1 = RedPointConst.SUMMER_PUB_LIMIT_TASK .. ActivityConst.ACTIVITY_NYA_SUMMER_PUB_ACCUMULATE_TASK
	local var_29_2 = ActivityCfg[ActivityConst.ACTIVITY_NYA_SUMMER_PUB_ACCUMULATE_TASK]
	local var_29_3 = {
		RedPointConst.SUMMER_PUB_LIMIT_TASK_TAG .. ActivityConst.ACTIVITY_NYA_SUMMER_PUB_ACCUMULATE_TASK
	}

	for iter_29_0, iter_29_1 in pairs(var_29_2.sub_activity_list) do
		local var_29_4 = RedPointConst.SUMMER_PUB_LIMIT_TASK_TAG .. iter_29_1

		table.insert(var_29_3, var_29_4)
	end

	manager.redPoint:addGroup(var_29_1, var_29_3)
	manager.notify:RegistListener(OSIRIS_TASK_UPDATE, function()
		var_0_2:UpdateTaskRedPoint()
	end)

	local var_29_5 = RedPointConst.SUMMER_PUB_RESIDENT_TASK .. ActivityConst.ACTIVITY_NYA_SUMMER_PUB
	local var_29_6 = ActivityConst.ACTIVITY_NYA_SUMMER_PUB
	local var_29_7 = {}

	for iter_29_2, iter_29_3 in ipairs(BilliardIllustrationsCfg.get_id_list_by_activity_id_type[var_29_6][1]) do
		table.insert(var_29_7, string.format("%s_%s", RedPointConst.SUMMER_PUB_ILLUSTRATION, iter_29_3))
	end

	local var_29_8 = {}

	for iter_29_4, iter_29_5 in ipairs(BilliardIllustrationsCfg.get_id_list_by_activity_id_type[var_29_6][2]) do
		table.insert(var_29_8, string.format("%s_%s", RedPointConst.SUMMER_PUB_ILLUSTRATION, iter_29_5))
	end

	manager.redPoint:addGroup(RedPointConst.SUMMER_PUB_ILLUSTRATION_MON, var_29_7)
	manager.redPoint:addGroup(RedPointConst.SUMMER_PUB_ILLUSTRATION_BORGAN, var_29_8)
	manager.redPoint:addGroup(RedPointConst.SUMMER_PUB_ILLUSTRATION, {
		RedPointConst.SUMMER_PUB_ILLUSTRATION_MON,
		RedPointConst.SUMMER_PUB_ILLUSTRATION_BORGAN
	})

	local var_29_9 = RedPointConst.SUMMER_PUB_RESIDENT_EXPLORE
	local var_29_10 = {
		RedPointConst.SUMMER_PUB_ILLUSTRATION
	}

	for iter_29_6 = 1, 3 do
		local var_29_11 = RedPointConst.SUMMER_PUB_STAGE_AREA .. iter_29_6
		local var_29_12 = var_0_0.get_id_list_by_area[iter_29_6]
		local var_29_13 = {}

		for iter_29_7, iter_29_8 in ipairs(var_29_12) do
			local var_29_14 = RedPointConst.SUMMER_PUB_STAGE_ITEM .. iter_29_8

			table.insert(var_29_13, var_29_14)
		end

		manager.redPoint:addGroup(var_29_11, var_29_13)
		table.insert(var_29_10, var_29_11)
	end

	local var_29_15 = RedPointConst.SUMMER_PUB_SKIN_DLC_GIFT .. ActivityConst.ACTIVITY_NYA_SUMMER_PUB_SKIN_DLC

	if SummerPubData:getWaitCook() ~= 0 and SummerPubData:GetClearNumByStageID(SummerPubConst.SECOND_LEVEL_ID) > 0 then
		manager.redPoint:delGroup(var_29_9, var_29_10)
	else
		manager.redPoint:addGroup(var_29_9, var_29_10)
	end

	manager.redPoint:addGroup(RedPointConst.SUMMER_PUB_GO_BTN, {
		var_29_1,
		var_29_5,
		var_29_9,
		var_29_15,
		RedPointConst.SUMMER_PUB_RECRUIT
	})
	manager.redPoint:addGroup(var_29_0, {
		RedPointConst.SUMMER_PUB_GO_BTN
	})
end

function var_0_2.UpdateTaskRedPoint(arg_31_0)
	local var_31_0 = ActivityCfg[ActivityConst.ACTIVITY_NYA_SUMMER_PUB_ACCUMULATE_TASK]

	arg_31_0:TaskRedSet(var_31_0.sub_activity_list, RedPointConst.SUMMER_PUB_LIMIT_TASK_TAG)
	arg_31_0:TaskRedSet({
		ActivityConst.ACTIVITY_NYA_SUMMER_PUB_ACCUMULATE_TASK
	}, RedPointConst.SUMMER_PUB_LIMIT_TASK_TAG)
	arg_31_0:TaskRedSet({
		ActivityConst.ACTIVITY_NYA_SUMMER_PUB
	}, RedPointConst.SUMMER_PUB_RESIDENT_TASK)
	arg_31_0:TaskRedSet({
		ActivityConst.ACTIVITY_NYA_SUMMER_PUB_SKIN_DLC
	}, RedPointConst.SUMMER_PUB_SKIN_DLC_GIFT)
end

function var_0_2.TaskRedSet(arg_32_0, arg_32_1, arg_32_2)
	for iter_32_0, iter_32_1 in pairs(arg_32_1) do
		local var_32_0 = ActivityData:GetActivityIsOpen(iter_32_1)

		for iter_32_2, iter_32_3 in pairs(AssignmentCfg.get_id_list_by_activity_id[iter_32_1]) do
			local var_32_1 = arg_32_2 .. iter_32_1

			if var_32_0 then
				local var_32_2 = TaskData2:GetTaskProgress(iter_32_3)
				local var_32_3 = AssignmentCfg[iter_32_3]

				if TaskData2:GetTaskComplete(iter_32_3) then
					manager.redPoint:setTip(var_32_1, 0)
				elseif var_32_2 >= var_32_3.need then
					manager.redPoint:setTip(var_32_1, 1)

					break
				else
					manager.redPoint:setTip(var_32_1, 0)
				end
			else
				manager.redPoint:setTip(var_32_1, 0)
			end
		end
	end
end

function var_0_2.UpdatePinballRedPoint(arg_33_0, arg_33_1)
	local var_33_0 = var_0_0.get_id_list_by_area[arg_33_1]

	for iter_33_0, iter_33_1 in ipairs(var_33_0) do
		local var_33_1 = RedPointConst.SUMMER_PUB_STAGE_ITEM .. iter_33_1

		manager.redPoint:setTip(var_33_1, 0)
	end
end

function var_0_2.UpdateIlluRedPoint(arg_34_0)
	for iter_34_0, iter_34_1 in pairs(arg_34_0.illustrationInfo) do
		if iter_34_1 == 1 and arg_34_0.waitCookID == 0 then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SUMMER_PUB_ILLUSTRATION, iter_34_0), 1)
		else
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SUMMER_PUB_ILLUSTRATION, iter_34_0), 0)
		end
	end
end

function var_0_2.UpdatePartnerRedPoint(arg_35_0)
	local var_35_0 = arg_35_0.waitPartner
	local var_35_1 = getData("summer_pub_main", "look_recruit" .. var_35_0) or 0

	if var_35_0 ~= 0 and var_35_1 == 0 then
		manager.redPoint:setTip(RedPointConst.SUMMER_PUB_RECRUIT, 1)
	else
		manager.redPoint:setTip(RedPointConst.SUMMER_PUB_RECRUIT, 0)
	end
end

return var_0_2
