local var_0_0 = class("Chapter19SectionInfoView", import("..SectionInfoBaseView"))

function var_0_0.Init(arg_1_0)
	var_0_0.super.Init(arg_1_0)
	arg_1_0.hideStageNumController_:SetSelectedState("true")
	arg_1_0.hideStageDescController_:SetSelectedState("false")
	arg_1_0.hideDropPanelController_:SetSelectedState("true")
	arg_1_0.showTipsController_:SetSelectedState("true")
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.OnTop(arg_3_0)
	arg_3_0:UpdateBar()
end

function var_0_0.RefreshData(arg_4_0)
	var_0_0.super.RefreshData(arg_4_0)

	local var_4_0 = BattleChapterStageCfg[arg_4_0.stageID_]

	arg_4_0.dropLibID_ = var_4_0.drop_lib_id

	local var_4_1 = BattleStageData:GetStageData()[arg_4_0.stageID_]

	if var_4_1 then
		arg_4_0.isFirstClear_ = var_4_1.clear_times <= 0
	else
		arg_4_0.isFirstClear_ = true
	end

	if arg_4_0.isFirstClear_ then
		arg_4_0.cost_ = var_4_0.cost or 0
	else
		arg_4_0.cost_ = 0
	end

	arg_4_0:RefreshLock()
end

function var_0_0.RefreshLock(arg_5_0)
	local var_5_0 = BattleChapterStageCfg[arg_5_0.stageID_]
	local var_5_1 = getChapterAndSectionID(arg_5_0.stageID_)

	BattleFieldData:SetCacheStage(var_5_1, arg_5_0.stageID_)

	if ActivityData:GetActivityIsOpen(ChapterCfg[var_5_1].activity_id) then
		arg_5_0.lock_ = false
	else
		arg_5_0.lock_ = PlayerData:GetPlayerInfo().userLevel < var_5_0.level
		arg_5_0.lockTips_ = string.format(GetTips("PLAYER_LEVEL_UNLOCK"), var_5_0.level)

		if arg_5_0.lock_ then
			return
		end
	end

	local var_5_2 = BattleStageData:GetStageData()

	for iter_5_0, iter_5_1 in pairs(var_5_0.pre_unlock_id_list or {}) do
		if var_5_2[iter_5_1] == nil or var_5_2[iter_5_1] and var_5_2[iter_5_1].clear_times <= 0 then
			arg_5_0.lock_ = true

			local var_5_3 = getChapterDifficulty(iter_5_1)
			local var_5_4 = getChapterClientCfgByStageID(iter_5_1).toggle
			local var_5_5, var_5_6 = BattleStageTools.GetChapterSectionIndex(var_5_4, iter_5_1)

			arg_5_0.lockTips_ = string.format(GetTips("MISSION_PROGRESS_UNLOCK"), var_5_3, GetI18NText(var_5_5), GetI18NText(var_5_6))

			return
		end
	end

	arg_5_0.lock_ = false
end

function var_0_0.RefreshStageInfo(arg_6_0)
	var_0_0.super.RefreshStageInfo(arg_6_0)

	local var_6_0 = BattleStageTools.GetStageCfg(arg_6_0.stageType_, arg_6_0.stageID_)

	arg_6_0.storyText_.text = GetI18NText(var_6_0.tips)
end

function var_0_0.OnClickBtn(arg_7_0)
	local var_7_0 = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT

	ChapterTools.DoReadyBattle(var_7_0, arg_7_0.stageID_)
end

return var_0_0
