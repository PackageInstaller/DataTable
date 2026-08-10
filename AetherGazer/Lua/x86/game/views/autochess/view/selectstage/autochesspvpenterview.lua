local var_0_0 = class("AutoChessPVPEnterView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_OsirisHorus/Activity_OsirisHorus_Main/Activity_OsirisHorus_PVPHomeUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()

	arg_3_0.context_ = {
		gameStatus = AutoChessConst.GAME_STATUS.NONE
	}
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:AddListener()

	arg_4_0.stageController_ = arg_4_0.mainControllerEx_:GetController("Stage")
	arg_4_0.cancelController_ = arg_4_0.mainControllerEx_:GetController("twice")
	arg_4_0.formationController_ = arg_4_0.mainControllerEx_:GetController("pvpstate")
	arg_4_0.lockController_ = arg_4_0.mainControllerEx_:GetController("lock01")
	arg_4_0.autoChessFormationItemView_ = AutoChessFormationItemView.New(arg_4_0.formationItem_)
	arg_4_0.labelView_ = AutoChessLabelItemView.New(arg_4_0.labelGo_)
	arg_4_0.headItem_ = AutoChessHeadItemView.New(arg_4_0.headGo_, AutoChessConst.GAME_TYPE.PVP)
end

function var_0_0.AddListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.startBtn_, nil, function()
		if arg_5_0.context_.gameStatus == AutoChessConst.GAME_STATUS.NONE then
			AutoChessTools.StartNewGame(AutoChessConst.GAME_TYPE.PVP)
		else
			AutoChessTools.GoToGameView(AutoChessConst.GAME_TYPE.PVP)
			AutoChessAction.SetGamePause(AutoChessConst.GAME_TYPE.PVP, AutoChessConst.GAME_PAUSE_TYPE.RESUME)
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.illuBtn_, nil, function()
		JumpTools.OpenPageByJump("/autoChessIllustratedWindow")
		OperationRecorder.RecordButtonTouch({
			source = 2,
			button_name = "activity_autochess_illustration_homepage_touch",
			activity_id = AutoChessData:GetActivityID()
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.recordBtn_, nil, function()
		JumpTools.OpenPageByJump("/autoChessRecordView")
		OperationRecorder.RecordButtonTouch({
			source = 1,
			button_name = "activity_autochess_record_homepage_touch",
			activity_id = AutoChessData:GetActivityID()
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.rankBtn_, nil, function()
		JumpTools.OpenPageByJump("/autoChessRankView")
		OperationRecorder.RecordButtonTouch({
			button_name = "activity_autochess_rank_homepage_touch",
			activity_id = AutoChessData:GetActivityID()
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.cancelBtn_, nil, function()
		JumpTools.OpenPageByJump("autoChessQuitPopView", {
			gameType = AutoChessConst.GAME_TYPE.PVP,
			type = AutoChessConst.POP_TYPE.PVP_ASYNC,
			okCb = function()
				AutoChessTools.CancelGame(AutoChessConst.GAME_TYPE.PVP, true)
			end
		})
	end)
end

function var_0_0.OnEnter(arg_12_0)
	AutoChessData:SetCurGameType(AutoChessConst.GAME_TYPE.PVP)
	arg_12_0.headItem_:RefreshUI()
end

function var_0_0.OnTop(arg_13_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	arg_13_0:UpdateContext()
	arg_13_0:RefreshAllUI()
end

function var_0_0.OnExit(arg_14_0)
	manager.windowBar:HideBar()
	arg_14_0.labelView_:OnExit()
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0.headItem_:Dispose()
	arg_15_0.autoChessFormationItemView_:Dispose()
	arg_15_0.labelView_:Dispose()
	var_0_0.super.Dispose(arg_15_0)
end

function var_0_0.UpdateContext(arg_16_0)
	arg_16_0.context_ = {
		gameStatus = AutoChessData:GetGameStatus(AutoChessConst.GAME_TYPE.PVP)
	}
end

function var_0_0.RefreshAllUI(arg_17_0)
	arg_17_0:RefreshLockUI()
	arg_17_0:RefreshStageUI()
	arg_17_0:RefreshTeamInfo()
	arg_17_0:RefreshLabel()
end

function var_0_0.RefreshLockUI(arg_18_0)
	local var_18_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_AUTO_CHESS_PVP_4_8)

	if manager.time:GetServerTime() > var_18_0.stopTime then
		arg_18_0.lockController_:SetSelectedIndex(1)
	else
		arg_18_0.lockController_:SetSelectedIndex(0)
	end
end

function var_0_0.RefreshStageUI(arg_19_0)
	if arg_19_0.context_.gameStatus == AutoChessConst.GAME_STATUS.NONE then
		arg_19_0.stageController_:SetSelectedState("off")
		arg_19_0.cancelController_:SetSelectedState("off")
		arg_19_0.formationController_:SetSelectedState("state1")

		arg_19_0.pvpGoText_.text = GetTips("AUTO_CHESS_BUTTON_START")

		arg_19_0.waitAnim_:Play("U_huan_loop")
	else
		arg_19_0.stageController_:SetSelectedState("on")
		arg_19_0.cancelController_:SetSelectedState("on")

		local var_19_0 = AutoChessData:GetPrepareData(AutoChessConst.GAME_TYPE.PVP)

		arg_19_0.curRoundText_.text = var_19_0:GetPlayerData().curRoundCount
		arg_19_0.pvpGoText_.text = GetTips("AUTO_CHESS_BUTTON_RESUME")

		arg_19_0.formationController_:SetSelectedState("state0")
		arg_19_0.waitAnim_:Play("New State", 0, 0)
	end
end

function var_0_0.RefreshTeamInfo(arg_20_0)
	arg_20_0.autoChessFormationItemView_:SetGameType(AutoChessConst.GAME_TYPE.PVP)
	arg_20_0.autoChessFormationItemView_:SetPlayerType(AutoChessConst.PLAYER_TYPE.SELF)

	local var_20_0 = AutoChessData:GetPrepareData(AutoChessConst.GAME_TYPE.PVP)
	local var_20_1 = var_20_0 and var_20_0:GetTeamDataList() or {}

	arg_20_0.autoChessFormationItemView_:UpdatePrepareTeamInfo(var_20_1)
end

function var_0_0.RefreshLabel(arg_21_0)
	local var_21_0 = AutoChessData:GetRecordDataList(AutoChessConst.RECORD_TYPE.PVP)

	if #var_21_0 > 0 then
		record = var_21_0[1]

		arg_21_0.labelView_:RefreshLabelData(false, record.playerData)
	end
end

return var_0_0
