local var_0_0 = class("DailySectionInfoView", import("..SectionInfoMultipleBaseView"))

function var_0_0.Init(arg_1_0)
	var_0_0.super.Init(arg_1_0)
	arg_1_0.hideStageDescController_:SetSelectedState("false")
	arg_1_0.hideDropPanelController_:SetSelectedState("false")
end

function var_0_0.OnClickBtn(arg_2_0)
	local var_2_0 = arg_2_0.stageID_

	arg_2_0:Go("/sectionSelectHero", {
		section = var_2_0,
		multiple = arg_2_0.multiple_,
		sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_DAILY
	})
end

function var_0_0.RefreshData(arg_3_0)
	local var_3_0 = BattleDailyStageCfg[arg_3_0.stageID_]

	arg_3_0.cost_ = var_3_0.cost
	arg_3_0.dropLibID_ = var_3_0.drop_lib_id
	arg_3_0.isFirstClear_ = false

	arg_3_0:RefreshLock()
	var_0_0.super.RefreshData(arg_3_0)
end

function var_0_0.RefreshLock(arg_4_0)
	local var_4_0 = BattleDailyStageCfg[arg_4_0.stageID_]
	local var_4_1 = getChapterAndSectionID(arg_4_0.stageID_)

	BattleFieldData:SetCacheStage(var_4_1, arg_4_0.stageID_)

	arg_4_0.lock_ = PlayerData:GetPlayerInfo().userLevel < var_4_0.level
	arg_4_0.lockTips_ = string.format(GetTips("PLAYER_LEVEL_UNLOCK"), var_4_0.level)

	if arg_4_0.lock_ then
		return
	end

	local var_4_2 = BattleStageData:GetStageData()

	for iter_4_0, iter_4_1 in pairs(var_4_0.pre_unlock_id_list or {}) do
		if var_4_2[iter_4_1] == nil or var_4_2[iter_4_1] and var_4_2[iter_4_1].clear_times <= 0 then
			arg_4_0.lock_ = true

			local var_4_3, var_4_4 = BattleStageTools.GetChapterSectionIndex(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_DAILY, iter_4_1)

			arg_4_0.lockTips_ = string.format(GetTips("ACTIVITY_RACE_UNLOCK"), string.format("%s-%s", GetI18NText(var_4_3), GetI18NText(var_4_4)))

			return
		end
	end

	arg_4_0.lock_ = false
end

function var_0_0.RefreshStageInfo(arg_5_0)
	var_0_0.super.RefreshStageInfo(arg_5_0)

	local var_5_0 = BattleStageTools.GetStageCfg(arg_5_0.stageType_, arg_5_0.stageID_)

	arg_5_0.storyText_.text = GetI18NText(var_5_0.tips)
end

return var_0_0
