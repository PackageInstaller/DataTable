local AutoChessLookFormationView = class("AutoChessLookFormationView", ReduxView)

function AutoChessLookFormationView:UIName()
	return "Widget/System/Activity_OsirisHorus/Activity_OsirisHorus_AutoChess/Activity_OsirisHorus_CheckFormationUI"
end

function AutoChessLookFormationView:UIParent()
	return manager.ui.uiMain.transform
end

function AutoChessLookFormationView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function AutoChessLookFormationView:InitUI()
	self:BindCfgUI()

	self.autoChessFormationItemView_ = AutoChessFormationItemView.New(self.formationItem_)
	self.playerInfoView_ = AutoChessPlayerInfoView.New(self.playerInfoGo_)
	self.tipsPanelView_ = AutoChessTipsPanelView.New(self.tipsPanelGo_)
end

function AutoChessLookFormationView:AddUIListeners()
	self:AddBtnListener(self.btnBack_, nil, function()
		self.Back()
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		self.tipsPanelView_:SetActive(false)
		SetActive(self.maskBtn_.gameObject, false)
	end)
end

function AutoChessLookFormationView:OnEnter()
	self.prepareData_ = AutoChessData:GetPrepareData(AutoChessConst.GAME_TYPE.PVE)

	self:RefreshBg()
	self:UpdateEnemyInfo()
end

function AutoChessLookFormationView:RefreshBg()
	local var_9_0, var_9_1, var_9_2 = AutoChessTools.GetStagBgPath((AutoChessTools.GetCurStageId(self.gameType_)))

	self.imgBg_.sprite = pureGetSpriteWithoutAtlas(var_9_0)
	self.imgMachine_.sprite = pureGetSpriteWithoutAtlas(var_9_1)
	self.imgFuzzy_.sprite = pureGetSpriteWithoutAtlas(var_9_2)
end

function AutoChessLookFormationView:UpdateEnemyInfo()
	self:UpdateTeamInfo()
	self:UpdateUserInfo()
end

function AutoChessLookFormationView:UpdateTeamInfo()
	self.autoChessFormationItemView_:SetGameType(AutoChessConst.GAME_TYPE.PVE)
	self.autoChessFormationItemView_:SetPlayerType(AutoChessConst.PLAYER_TYPE.OPPONENT)
	self.autoChessFormationItemView_:UpdatePrepareTeamInfo(self.prepareData_:GetEnemyData():GetTeamDataList())

	for iter_11_0, iter_11_1 in pairs((self.autoChessFormationItemView_:GetChessItemList())) do
		iter_11_1:RegisterEvent("PointerClick", handler(self, self.OnPointerClick))
	end
end

function AutoChessLookFormationView:UpdateUserInfo()
	self.playerInfoView_:SetGameType(AutoChessConst.GAME_TYPE.PVE)
	self.playerInfoView_:SetData(self.prepareData_:GetEnemyData())
	self.playerInfoView_:SetHideData(true)
end

function AutoChessLookFormationView:OnPointerClick(arg_13_1, arg_13_2)
	self.clickChessItemData_ = arg_13_1

	if arg_13_1.chessId then
		SetActive(self.maskBtn_.gameObject, true)
		self.tipsPanelView_:SetData(arg_13_1)
		self.tipsPanelView_:SetGoldState(false)
		self.tipsPanelView_:SetPos((arg_13_2:GetPos()))
		AutoChessTools.ScreenAdapter(arg_13_2, self.tipsPanelView_)
		OperationRecorder.RecordButtonTouch({
			type = 2,
			button_name = "activity_autochess_combat_chess_touch",
			activity_id = AutoChessData:GetActivityID(),
			polyhedron_id_str = self.prepareData_:GetEnemyData().battleUID,
			other_data = AutoChessTools.GetChessTrackingPointStr(arg_13_1)
		})
	else
		SetActive(self.maskBtn_.gameObject, false)
		self.tipsPanelView_:SetActive(false)
	end
end

function AutoChessLookFormationView:Dispose()
	self.autoChessFormationItemView_:Dispose()
	self.playerInfoView_:Dispose()
	self.tipsPanelView_:Dispose()
	AutoChessLookFormationView.super.Dispose(self)
end

return AutoChessLookFormationView
