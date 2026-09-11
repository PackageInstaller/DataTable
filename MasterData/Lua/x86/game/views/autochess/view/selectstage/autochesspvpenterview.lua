local AutoChessPVPEnterView = class("AutoChessPVPEnterView", ReduxView)

function AutoChessPVPEnterView:UIName()
	return "Widget/System/Activity_OsirisHorus/Activity_OsirisHorus_Main/Activity_OsirisHorus_PVPHomeUI"
end

function AutoChessPVPEnterView:UIParent()
	return manager.ui.uiMain.transform
end

function AutoChessPVPEnterView:Init()
	self:InitUI()

	self.context_ = {
		gameStatus = AutoChessConst.GAME_STATUS.NONE
	}
end

function AutoChessPVPEnterView:InitUI()
	self:BindCfgUI()
	self:AddListener()

	self.stageController_ = self.mainControllerEx_:GetController("Stage")
	self.cancelController_ = self.mainControllerEx_:GetController("twice")
	self.formationController_ = self.mainControllerEx_:GetController("pvpstate")
	self.lockController_ = self.mainControllerEx_:GetController("lock01")
	self.autoChessFormationItemView_ = AutoChessFormationItemView.New(self.formationItem_)
	self.labelView_ = AutoChessLabelItemView.New(self.labelGo_)
	self.headItem_ = AutoChessHeadItemView.New(self.headGo_, AutoChessConst.GAME_TYPE.PVP)
end

function AutoChessPVPEnterView:AddListener()
	self:AddBtnListener(self.startBtn_, nil, function()
		if self.context_.gameStatus == AutoChessConst.GAME_STATUS.NONE then
			AutoChessTools.StartNewGame(AutoChessConst.GAME_TYPE.PVP)
		else
			AutoChessTools.GoToGameView(AutoChessConst.GAME_TYPE.PVP)
			AutoChessAction.SetGamePause(AutoChessConst.GAME_TYPE.PVP, AutoChessConst.GAME_PAUSE_TYPE.RESUME)
		end
	end)
	self:AddBtnListener(self.illuBtn_, nil, function()
		JumpTools.OpenPageByJump("/autoChessIllustratedWindow")
		OperationRecorder.RecordButtonTouch({
			source = 2,
			button_name = "activity_autochess_illustration_homepage_touch",
			activity_id = AutoChessData:GetActivityID()
		})
	end)
	self:AddBtnListener(self.recordBtn_, nil, function()
		JumpTools.OpenPageByJump("/autoChessRecordView")
		OperationRecorder.RecordButtonTouch({
			source = 1,
			button_name = "activity_autochess_record_homepage_touch",
			activity_id = AutoChessData:GetActivityID()
		})
	end)
	self:AddBtnListener(self.rankBtn_, nil, function()
		JumpTools.OpenPageByJump("/autoChessRankView")
		OperationRecorder.RecordButtonTouch({
			button_name = "activity_autochess_rank_homepage_touch",
			activity_id = AutoChessData:GetActivityID()
		})
	end)
	self:AddBtnListener(self.cancelBtn_, nil, function()
		JumpTools.OpenPageByJump("autoChessQuitPopView", {
			gameType = AutoChessConst.GAME_TYPE.PVP,
			type = AutoChessConst.POP_TYPE.PVP_ASYNC,
			okCb = function()
				AutoChessTools.CancelGame(AutoChessConst.GAME_TYPE.PVP, true)
			end
		})
	end)
end

function AutoChessPVPEnterView:OnEnter()
	AutoChessData:SetCurGameType(AutoChessConst.GAME_TYPE.PVP)
	self.headItem_:RefreshUI()
end

function AutoChessPVPEnterView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	self:UpdateContext()
	self:RefreshAllUI()
end

function AutoChessPVPEnterView:OnExit()
	manager.windowBar:HideBar()
	self.labelView_:OnExit()
end

function AutoChessPVPEnterView:Dispose()
	self.headItem_:Dispose()
	self.autoChessFormationItemView_:Dispose()
	self.labelView_:Dispose()
	AutoChessPVPEnterView.super.Dispose(self)
end

function AutoChessPVPEnterView:UpdateContext()
	self.context_ = {
		gameStatus = AutoChessData:GetGameStatus(AutoChessConst.GAME_TYPE.PVP)
	}
end

function AutoChessPVPEnterView:RefreshAllUI()
	self:RefreshLockUI()
	self:RefreshStageUI()
	self:RefreshTeamInfo()
	self:RefreshLabel()
end

function AutoChessPVPEnterView:RefreshLockUI()
	if manager.time:GetServerTime() > ActivityData:GetActivityData(ActivityConst.ACTIVITY_AUTO_CHESS_PVP_4_8).stopTime then
		self.lockController_:SetSelectedIndex(1)
	else
		self.lockController_:SetSelectedIndex(0)
	end
end

function AutoChessPVPEnterView:RefreshStageUI()
	if self.context_.gameStatus == AutoChessConst.GAME_STATUS.NONE then
		self.stageController_:SetSelectedState("off")
		self.cancelController_:SetSelectedState("off")
		self.formationController_:SetSelectedState("state1")

		self.pvpGoText_.text = GetTips("AUTO_CHESS_BUTTON_START")

		self.waitAnim_:Play("U_huan_loop")
	else
		self.stageController_:SetSelectedState("on")
		self.cancelController_:SetSelectedState("on")

		self.curRoundText_.text = AutoChessData:GetPrepareData(AutoChessConst.GAME_TYPE.PVP):GetPlayerData().curRoundCount
		self.pvpGoText_.text = GetTips("AUTO_CHESS_BUTTON_RESUME")

		self.formationController_:SetSelectedState("state0")
		self.waitAnim_:Play("New State", 0, 0)
	end
end

function AutoChessPVPEnterView:RefreshTeamInfo()
	self.autoChessFormationItemView_:SetGameType(AutoChessConst.GAME_TYPE.PVP)
	self.autoChessFormationItemView_:SetPlayerType(AutoChessConst.PLAYER_TYPE.SELF)

	local var_20_0 = AutoChessData:GetPrepareData(AutoChessConst.GAME_TYPE.PVP)

	self.autoChessFormationItemView_:UpdatePrepareTeamInfo(var_20_0 and var_20_0:GetTeamDataList() or {})
end

function AutoChessPVPEnterView:RefreshLabel()
	local var_21_0 = AutoChessData:GetRecordDataList(AutoChessConst.RECORD_TYPE.PVP)

	if #var_21_0 > 0 then
		record = var_21_0[1]

		self.labelView_:RefreshLabelData(false, record.playerData)
	end
end

return AutoChessPVPEnterView
