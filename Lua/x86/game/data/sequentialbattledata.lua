local var_0_0 = singletonClass("SequentialBattleData")
local var_0_1 = require("cjson")

function var_0_0.Init(arg_1_0)
	arg_1_0.selectChapterID_ = {}
	arg_1_0.chapterData_ = {}
	arg_1_0.receiveRewardList_ = {}
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1.activity_info_list) do
		local var_2_0 = iter_2_1.activity_id

		if SequentialBattleChapterCfg[var_2_0] then
			if arg_2_0.chapterData_[var_2_0] == nil then
				arg_2_0:InitChapterData(var_2_0)
			end

			arg_2_0.chapterData_[var_2_0].curFinishStageIndex = iter_2_1.stage_index
			arg_2_0.chapterData_[var_2_0].historyFinishStage = {}

			for iter_2_2, iter_2_3 in ipairs(iter_2_1.finished_stage_list) do
				table.insert(arg_2_0.chapterData_[var_2_0].historyFinishStage, iter_2_3)
			end
		end
	end

	local var_2_1 = arg_2_1.main_activity_id

	arg_2_0.receiveRewardList_[var_2_1] = {}

	for iter_2_4, iter_2_5 in ipairs(arg_2_1.admitted_reward_list) do
		table.insert(arg_2_0.receiveRewardList_[var_2_1], iter_2_5)
	end

	arg_2_0:UpdateRewardRedPoint(var_2_1)
end

function var_0_0.InitChapterData(arg_3_0, arg_3_1)
	arg_3_0.chapterData_[arg_3_1] = {
		curFinishStageIndex = 0,
		historyFinishStage = {},
		rewardList = {},
		enabledBuff = {}
	}
end

function var_0_0.GetSelectChapterID(arg_4_0, arg_4_1)
	if arg_4_0.selectChapterID_[arg_4_1] == nil then
		arg_4_0.selectChapterID_[arg_4_1] = getData("SequentialBattle", "activityID" .. arg_4_1) or SequentialBattleChapterCfg.get_id_list_by_main_id[arg_4_1][1]
	end

	return arg_4_0.selectChapterID_[arg_4_1]
end

function var_0_0.SetSelectChapterID(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.selectChapterID_[arg_5_1] = arg_5_2

	saveData("SequentialBattle", "activityID" .. arg_5_1, arg_5_2)
end

function var_0_0.GetChapterData(arg_6_0, arg_6_1)
	return arg_6_0.chapterData_[arg_6_1]
end

function var_0_0.GetHeroTeam(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0.chapterData_[arg_7_1] and arg_7_0.chapterData_[arg_7_1].team and arg_7_0.chapterData_[arg_7_1].team[arg_7_2] then
		return arg_7_0.chapterData_[arg_7_1].team[arg_7_2].heroList
	else
		return {}
	end
end

function var_0_0.SaveHeroTeam(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	for iter_8_0, iter_8_1 in ipairs(arg_8_3) do
		arg_8_0.chapterData_[arg_8_1].team[arg_8_2].heroList[iter_8_0] = arg_8_0.chapterData_[arg_8_1].team[arg_8_2].heroList[iter_8_0] or {}
		arg_8_0.chapterData_[arg_8_1].team[arg_8_2].heroList[iter_8_0].heroID = iter_8_1
		arg_8_0.chapterData_[arg_8_1].team[arg_8_2].heroList[iter_8_0].trialID = arg_8_4[iter_8_0]
	end
end

function var_0_0.GetHeroTeamData(arg_9_0, arg_9_1)
	return arg_9_0.chapterData_[arg_9_1].team
end

function var_0_0.SetComboSkillID(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	arg_10_0.chapterData_[arg_10_1].team[arg_10_2].comboSkillID = arg_10_3
	arg_10_0.chapterData_[arg_10_1].team[arg_10_2].needRefreshComboSkill = arg_10_4
end

function var_0_0.ResetChapterTeamData(arg_11_0, arg_11_1)
	arg_11_0.chapterData_[arg_11_1].curFinishStageIndex = 0
end

function var_0_0.ResetChipManager(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0.chapterData_[arg_12_1].team[arg_12_2].chipList = {}
end

function var_0_0.GetCurrentFinishStageIndex(arg_13_0, arg_13_1)
	return arg_13_0.chapterData_[arg_13_1].curFinishStageIndex
end

function var_0_0.ClearStage(arg_14_0, arg_14_1)
	arg_14_0.chapterData_[arg_14_1].curFinishStageIndex = arg_14_0.chapterData_[arg_14_1].curFinishStageIndex + 1

	local var_14_0 = SequentialBattleChapterCfg[arg_14_1]
	local var_14_1 = var_14_0.stage_id[arg_14_0.chapterData_[arg_14_1].curFinishStageIndex]

	if table.keyof(arg_14_0.chapterData_[arg_14_1].historyFinishStage, var_14_1) == nil then
		table.insert(arg_14_0.chapterData_[arg_14_1].historyFinishStage, var_14_1)
	end

	arg_14_0:UpdateRewardRedPoint(var_14_0.main_id)
end

function var_0_0.GetReceiveRewardList(arg_15_0, arg_15_1)
	return arg_15_0.receiveRewardList_[arg_15_1] or {}
end

function var_0_0.UpdateReceiveRewardList(arg_16_0, arg_16_1, arg_16_2)
	table.insertto(arg_16_0.receiveRewardList_[arg_16_1], arg_16_2)
	arg_16_0:UpdateRewardRedPoint(arg_16_1)
end

function var_0_0.GetFinishStageList(arg_17_0, arg_17_1)
	if arg_17_0.chapterData_[arg_17_1] == nil then
		return {}
	end

	return arg_17_0.chapterData_[arg_17_1].historyFinishStage or {}
end

function var_0_0.UpdateRewardRedPoint(arg_18_0, arg_18_1)
	local var_18_0 = 0

	if SequentialBattleRewardCfg.get_id_list_by_main_activity_id[arg_18_1] == nil then
		return
	end

	for iter_18_0, iter_18_1 in ipairs(SequentialBattleRewardCfg.get_id_list_by_main_activity_id[arg_18_1]) do
		local var_18_1 = SequentialBattleRewardCfg[iter_18_1]

		if SequentialBattleTools.IsUnlockReward(iter_18_1) and not table.keyof(arg_18_0.receiveRewardList_[arg_18_1], iter_18_1) then
			var_18_0 = 1

			break
		end
	end

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SEQUENTIAL_BATTLE_REWARD, arg_18_1), var_18_0)
end

return var_0_0
