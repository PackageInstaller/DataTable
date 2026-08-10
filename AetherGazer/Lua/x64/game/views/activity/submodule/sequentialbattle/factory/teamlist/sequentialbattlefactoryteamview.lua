local var_0_0 = class("SequentialBattleFactoryTeamView", ReduxView)

function var_0_0.UIName(arg_1_0)
	local var_1_0 = SequentialBattleChapterCfg[arg_1_0.params_.activityID].main_id
	local var_1_1 = SequentialBattleUICfg.get_id_list_by_main_activity_id[var_1_0][1]

	return SequentialBattleUICfg[var_1_1].team_prefab
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.teamUIList_ = LuaList.New(handler(arg_3_0, arg_3_0.RefreshItem), arg_3_0.uiList_, SequentialBattleFactoryTeamItem)
	arg_3_0.needContinueController_ = arg_3_0.controllerEx_:GetController("needContinue")
	arg_3_0.finishControllerEx_ = {}

	for iter_3_0 = 1, 4 do
		table.insert(arg_3_0.finishControllerEx_, arg_3_0[string.format("finishStateControllerEx%s_", iter_3_0)]:GetController("finish"))
	end
end

function var_0_0.OnEnter(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	arg_4_0.activityID_ = arg_4_0.params_.activityID

	arg_4_0:RefreshUI()
end

function var_0_0.OnExit(arg_5_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
	arg_6_0.teamUIList_:Dispose()

	arg_6_0.teamUIList_ = nil
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.buffBtn_, nil, function()
		JumpTools.OpenPageByJump("sequentialBattleBuffInfo", {
			buffInfoActivityID = arg_7_0.activityID_
		})
	end)
	arg_7_0:AddBtnListener(arg_7_0.resetBtn_, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("SEQUENTIAL_BATTLE_RESET_TEAM"),
			OkCallback = function()
				SequentialBattleAction.ResetBattle(arg_7_0.activityID_, 0, function(arg_11_0)
					SequentialBattleData:ResetChapterTeamData(arg_7_0.activityID_)
					ReserveTools.ResetContData(ReserveConst.RESERVE_TYPE.SEQUENTIAL_BATTLE, arg_7_0.activityID_)
					arg_7_0:RefreshUI()
				end)
			end
		})
	end)
	arg_7_0:AddBtnListener(arg_7_0.exitBtn_, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("SEQUENTIAL_BATTLE_EXIT"),
			OkCallback = function()
				SequentialBattleAction.ResetBattle(arg_7_0.activityID_, 1, function(arg_14_0)
					SequentialBattleData:ResetChapterTeamData(arg_7_0.activityID_)
					arg_7_0:RefreshUI()
				end)
			end
		})
	end)
	arg_7_0:AddBtnListener(arg_7_0.battleBtn_, nil, function()
		for iter_15_0 = 1, #SequentialBattleChapterCfg[arg_7_0.activityID_].stage_id do
			local var_15_0 = SequentialBattleChapterCfg[arg_7_0.activityID_].stage_id[iter_15_0]
			local var_15_1 = ReserveParams.New(ReserveConst.RESERVE_TYPE.SEQUENTIAL_BATTLE, arg_7_0.activityID_, iter_15_0, {
				stageType = BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE,
				stageID = var_15_0,
				activityID = arg_7_0.activityID_
			})

			if ReserveTools.GetHeroList(var_15_1)[1] == 0 then
				ShowTips("SEQUENTIAL_BATTLE_TEAM_IS_NULL")

				return
			end
		end

		SequentialBattleAction.SaveAllTeam(arg_7_0.activityID_, function(arg_16_0)
			if isSuccess(arg_16_0.result) then
				local var_16_0 = arg_7_0.activityID_
				local var_16_1 = SequentialBattleData:GetCurrentFinishStageIndex(arg_7_0.activityID_) + 1
				local var_16_2 = SequentialBattleChapterCfg[arg_7_0.activityID_].stage_id[var_16_1]
				local var_16_3 = ReserveParams.New(ReserveConst.RESERVE_TYPE.SEQUENTIAL_BATTLE, var_16_0, var_16_1, {
					stageType = BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE,
					stageID = var_16_2,
					activityID = arg_7_0.activityID_
				})
				local var_16_4 = BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE, var_16_2, arg_7_0.activityID_, var_16_3)

				BattleController.GetInstance():LaunchBattle(var_16_4)
			else
				ShowTips(arg_16_0.result)
			end
		end)
	end)
end

function var_0_0.RefreshItem(arg_17_0, arg_17_1, arg_17_2)
	arg_17_2:SetData(arg_17_0.activityID_, arg_17_1)
end

function var_0_0.RefreshUI(arg_18_0)
	local var_18_0 = SequentialBattleData:GetCurrentFinishStageIndex(arg_18_0.activityID_) + 1

	arg_18_0.teamUIList_:StartScroll(#SequentialBattleChapterCfg[arg_18_0.activityID_].stage_id, var_18_0)
	arg_18_0:RefreshContinuePanel()
end

function var_0_0.RefreshContinuePanel(arg_19_0)
	local var_19_0 = SequentialBattleData:GetCurrentFinishStageIndex(arg_19_0.activityID_)

	if var_19_0 > 0 then
		arg_19_0.needContinueController_:SetSelectedState("true")

		for iter_19_0 = 1, 4 do
			if iter_19_0 <= var_19_0 then
				arg_19_0.finishControllerEx_[iter_19_0]:SetSelectedState("true")
			else
				arg_19_0.finishControllerEx_[iter_19_0]:SetSelectedState("false")
			end
		end
	else
		arg_19_0.needContinueController_:SetSelectedState("false")
	end
end

return var_0_0
