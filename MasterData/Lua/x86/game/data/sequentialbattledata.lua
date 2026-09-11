local var_0_0 = singletonClass("SequentialBattleData")
local cjson = require("cjson")

function var_0_0.Init(arg_1_0)
	arg_1_0.selectChapterID_ = {}
	arg_1_0.chapterData_ = {}
	arg_1_0.receiveRewardList_ = {}
end

function var_0_0:InitData(arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1.activity_info_list) do
		if SequentialBattleChapterCfg[iter_2_1.activity_id] then
			if self.chapterData_[iter_2_1.activity_id] == nil then
				self:InitChapterData(iter_2_1.activity_id)
			end

			self.chapterData_[iter_2_1.activity_id].curFinishStageIndex = iter_2_1.stage_index
			self.chapterData_[iter_2_1.activity_id].historyFinishStage = {}

			for iter_2_2, iter_2_3 in ipairs(iter_2_1.finished_stage_list) do
				table.insert(self.chapterData_[iter_2_1.activity_id].historyFinishStage, iter_2_3)
			end
		end
	end

	self.receiveRewardList_[arg_2_1.main_activity_id] = {}

	for iter_2_4, iter_2_5 in ipairs(arg_2_1.admitted_reward_list) do
		table.insert(self.receiveRewardList_[arg_2_1.main_activity_id], iter_2_5)
	end

	self:UpdateRewardRedPoint(arg_2_1.main_activity_id)
end

function var_0_0:InitChapterData(arg_3_1)
	self.chapterData_[arg_3_1] = {
		curFinishStageIndex = 0,
		historyFinishStage = {},
		rewardList = {},
		enabledBuff = {}
	}
end

function var_0_0:GetSelectChapterID(arg_4_1)
	if self.selectChapterID_[arg_4_1] == nil then
		self.selectChapterID_[arg_4_1] = getData("SequentialBattle", "activityID" .. arg_4_1) or SequentialBattleChapterCfg.get_id_list_by_main_id[arg_4_1][1]
	end

	return self.selectChapterID_[arg_4_1]
end

function var_0_0:SetSelectChapterID(arg_5_1, arg_5_2)
	self.selectChapterID_[arg_5_1] = arg_5_2

	saveData("SequentialBattle", "activityID" .. arg_5_1, arg_5_2)
end

function var_0_0:GetChapterData(arg_6_1)
	return self.chapterData_[arg_6_1]
end

function var_0_0:GetHeroTeam(arg_7_1, arg_7_2)
	if self.chapterData_[arg_7_1] and self.chapterData_[arg_7_1].team and self.chapterData_[arg_7_1].team[arg_7_2] then
		return self.chapterData_[arg_7_1].team[arg_7_2].heroList
	else
		return {}
	end
end

function var_0_0:SaveHeroTeam(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	for iter_8_0, iter_8_1 in ipairs(arg_8_3) do
		self.chapterData_[arg_8_1].team[arg_8_2].heroList[iter_8_0] = self.chapterData_[arg_8_1].team[arg_8_2].heroList[iter_8_0] or {}
		self.chapterData_[arg_8_1].team[arg_8_2].heroList[iter_8_0].heroID = iter_8_1
		self.chapterData_[arg_8_1].team[arg_8_2].heroList[iter_8_0].trialID = arg_8_4[iter_8_0]
	end
end

function var_0_0:GetHeroTeamData(arg_9_1)
	return self.chapterData_[arg_9_1].team
end

function var_0_0:SetComboSkillID(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	self.chapterData_[arg_10_1].team[arg_10_2].comboSkillID = arg_10_3
	self.chapterData_[arg_10_1].team[arg_10_2].needRefreshComboSkill = arg_10_4
end

function var_0_0:ResetChapterTeamData(arg_11_1)
	self.chapterData_[arg_11_1].curFinishStageIndex = 0
end

function var_0_0:ResetChipManager(arg_12_1, arg_12_2)
	self.chapterData_[arg_12_1].team[arg_12_2].chipList = {}
end

function var_0_0:GetCurrentFinishStageIndex(arg_13_1)
	return self.chapterData_[arg_13_1].curFinishStageIndex
end

function var_0_0:ClearStage(arg_14_1)
	self.chapterData_[arg_14_1].curFinishStageIndex = self.chapterData_[arg_14_1].curFinishStageIndex + 1

	if table.keyof(self.chapterData_[arg_14_1].historyFinishStage, SequentialBattleChapterCfg[arg_14_1].stage_id[self.chapterData_[arg_14_1].curFinishStageIndex]) == nil then
		table.insert(self.chapterData_[arg_14_1].historyFinishStage, SequentialBattleChapterCfg[arg_14_1].stage_id[self.chapterData_[arg_14_1].curFinishStageIndex])
	end

	self:UpdateRewardRedPoint(SequentialBattleChapterCfg[arg_14_1].main_id)
end

function var_0_0:GetReceiveRewardList(arg_15_1)
	return self.receiveRewardList_[arg_15_1] or {}
end

function var_0_0:UpdateReceiveRewardList(arg_16_1, arg_16_2)
	table.insertto(self.receiveRewardList_[arg_16_1], arg_16_2)
	self:UpdateRewardRedPoint(arg_16_1)
end

function var_0_0:GetFinishStageList(arg_17_1)
	if self.chapterData_[arg_17_1] == nil then
		return {}
	end

	return self.chapterData_[arg_17_1].historyFinishStage or {}
end

function var_0_0:UpdateRewardRedPoint(arg_18_1)
	local var_18_0 = 0

	if SequentialBattleRewardCfg.get_id_list_by_main_activity_id[arg_18_1] == nil then
		return
	end

	for iter_18_0, iter_18_1 in ipairs(SequentialBattleRewardCfg.get_id_list_by_main_activity_id[arg_18_1]) do
		if SequentialBattleTools.IsUnlockReward(iter_18_1) and not table.keyof(self.receiveRewardList_[arg_18_1], iter_18_1) then
			var_18_0 = 1

			break
		end
	end

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SEQUENTIAL_BATTLE_REWARD, arg_18_1), var_18_0)
end

return var_0_0
