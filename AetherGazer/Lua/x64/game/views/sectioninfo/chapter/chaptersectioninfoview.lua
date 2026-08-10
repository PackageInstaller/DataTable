local var_0_0 = class("ChapterSectionInfoView", import("..SectionInfoBaseView"))

function var_0_0.Init(arg_1_0)
	var_0_0.super.Init(arg_1_0)

	arg_1_0.sectionInfoThreeStarBar_ = SectionInfoThreeStarBar.New(arg_1_0.threeStarGo_)

	arg_1_0.hideStageNumController_:SetSelectedState("false")
	arg_1_0.hideThreeStarController_:SetSelectedState("false")
	arg_1_0.hideDropPanelController_:SetSelectedState("false")
end

function var_0_0.Dispose(arg_2_0)
	arg_2_0.sectionInfoThreeStarBar_:Dispose()

	arg_2_0.sectionInfoThreeStarBar_ = nil

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
	arg_4_0:RefreshThreeStarData()
end

function var_0_0.RefreshLock(arg_5_0)
	local var_5_0 = BattleChapterStageCfg[arg_5_0.stageID_]
	local var_5_1 = getChapterAndSectionID(arg_5_0.stageID_)

	BattleFieldData:SetCacheStage(var_5_1, arg_5_0.stageID_)

	local var_5_2 = ChapterTools.GetChapterActivity(var_5_1)
	local var_5_3, var_5_4 = ActivityTools.GetActivityIsSuspended(var_5_2)

	if var_5_3 then
		arg_5_0.lock_, arg_5_0.lockTips_ = true, GetTips(var_5_4)
	elseif ActivityData:GetActivityIsOpen(var_5_2) then
		arg_5_0.lock_ = false
	else
		arg_5_0.lock_ = PlayerData:GetPlayerInfo().userLevel < var_5_0.level
		arg_5_0.lockTips_ = string.format(GetTips("PLAYER_LEVEL_UNLOCK"), var_5_0.level)
	end

	if arg_5_0.lock_ then
		return
	end

	local var_5_5 = BattleStageData:GetStageData()

	if not var_5_5[arg_5_0.stageID_] then
		for iter_5_0, iter_5_1 in pairs(var_5_0.pre_unlock_id_list or {}) do
			if var_5_5[iter_5_1] == nil or var_5_5[iter_5_1] and var_5_5[iter_5_1].clear_times <= 0 then
				arg_5_0.lock_ = true

				local var_5_6 = getChapterDifficulty(iter_5_1)
				local var_5_7 = getChapterClientCfgByStageID(iter_5_1).toggle
				local var_5_8, var_5_9 = BattleStageTools.GetChapterSectionIndex(var_5_7, iter_5_1)

				arg_5_0.lockTips_ = string.format(GetTips("MISSION_PROGRESS_UNLOCK"), var_5_6, GetI18NText(var_5_8), GetI18NText(var_5_9))

				return
			end
		end
	end

	arg_5_0.lock_ = false
end

function var_0_0.RefreshThreeStarData(arg_6_0)
	arg_6_0.threeStarDataList_ = {}

	local var_6_0 = BattleChapterStageCfg[arg_6_0.stageID_]
	local var_6_1 = BattleStageData:GetStageData()[arg_6_0.stageID_]

	for iter_6_0 = 1, 3 do
		arg_6_0.threeStarDataList_[iter_6_0] = {
			var_6_1 and var_6_1.stars[iter_6_0] == 1 or false,
			var_6_0.three_star_need[iter_6_0]
		}
	end
end

function var_0_0.RefreshUI(arg_7_0)
	var_0_0.super.RefreshUI(arg_7_0)
	arg_7_0.sectionInfoThreeStarBar_:SetData(arg_7_0.threeStarDataList_)
end

function var_0_0.OnClickBtn(arg_8_0)
	local var_8_0 = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT
	local var_8_1 = BattleChapterStageCfg[arg_8_0.stageID_]

	if BattleStageTools.SkipSectionSelectHero(var_8_0, arg_8_0.stageID_) then
		local var_8_2 = BattleStageFactory.Produce(var_8_0, arg_8_0.stageID_)

		BattleController.GetInstance():LaunchBattle(var_8_2)

		return
	end

	if StageTools.NeedShowContinueBattleWindow(var_8_0, arg_8_0.stageID_) then
		JumpTools.OpenPopUp("continueBattleCostPop", {
			stageType = var_8_0,
			stageID = arg_8_0.stageID_,
			callback = function()
				ChapterTools.DoReadyBattle(var_8_0, arg_8_0.stageID_)
			end
		})
	else
		ChapterTools.DoReadyBattle(var_8_0, arg_8_0.stageID_)
	end
end

return var_0_0
