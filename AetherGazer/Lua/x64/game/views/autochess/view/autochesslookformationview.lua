local var_0_0 = class("AutoChessLookFormationView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_OsirisHorus/Activity_OsirisHorus_AutoChess/Activity_OsirisHorus_CheckFormationUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.autoChessFormationItemView_ = AutoChessFormationItemView.New(arg_4_0.formationItem_)
	arg_4_0.playerInfoView_ = AutoChessPlayerInfoView.New(arg_4_0.playerInfoGo_)
	arg_4_0.tipsPanelView_ = AutoChessTipsPanelView.New(arg_4_0.tipsPanelGo_)
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btnBack_, nil, function()
		arg_5_0.Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0.tipsPanelView_:SetActive(false)
		SetActive(arg_5_0.maskBtn_.gameObject, false)
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.prepareData_ = AutoChessData:GetPrepareData(AutoChessConst.GAME_TYPE.PVE)

	arg_8_0:RefreshBg()
	arg_8_0:UpdateEnemyInfo()
end

function var_0_0.RefreshBg(arg_9_0)
	local var_9_0 = AutoChessTools.GetCurStageId(arg_9_0.gameType_)
	local var_9_1, var_9_2, var_9_3 = AutoChessTools.GetStagBgPath(var_9_0)

	arg_9_0.imgBg_.sprite = pureGetSpriteWithoutAtlas(var_9_1)
	arg_9_0.imgMachine_.sprite = pureGetSpriteWithoutAtlas(var_9_2)
	arg_9_0.imgFuzzy_.sprite = pureGetSpriteWithoutAtlas(var_9_3)
end

function var_0_0.UpdateEnemyInfo(arg_10_0)
	arg_10_0:UpdateTeamInfo()
	arg_10_0:UpdateUserInfo()
end

function var_0_0.UpdateTeamInfo(arg_11_0)
	arg_11_0.autoChessFormationItemView_:SetGameType(AutoChessConst.GAME_TYPE.PVE)
	arg_11_0.autoChessFormationItemView_:SetPlayerType(AutoChessConst.PLAYER_TYPE.OPPONENT)
	arg_11_0.autoChessFormationItemView_:UpdatePrepareTeamInfo(arg_11_0.prepareData_:GetEnemyData():GetTeamDataList())

	local var_11_0 = arg_11_0.autoChessFormationItemView_:GetChessItemList()

	for iter_11_0, iter_11_1 in pairs(var_11_0) do
		iter_11_1:RegisterEvent("PointerClick", handler(arg_11_0, arg_11_0.OnPointerClick))
	end
end

function var_0_0.UpdateUserInfo(arg_12_0)
	arg_12_0.playerInfoView_:SetGameType(AutoChessConst.GAME_TYPE.PVE)
	arg_12_0.playerInfoView_:SetData(arg_12_0.prepareData_:GetEnemyData())
	arg_12_0.playerInfoView_:SetHideData(true)
end

function var_0_0.OnPointerClick(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0.clickChessItemData_ = arg_13_1

	if arg_13_1.chessId then
		SetActive(arg_13_0.maskBtn_.gameObject, true)
		arg_13_0.tipsPanelView_:SetData(arg_13_1)
		arg_13_0.tipsPanelView_:SetGoldState(false)

		local var_13_0 = arg_13_2:GetPos()

		arg_13_0.tipsPanelView_:SetPos(var_13_0)
		AutoChessTools.ScreenAdapter(arg_13_2, arg_13_0.tipsPanelView_)
		OperationRecorder.RecordButtonTouch({
			type = 2,
			button_name = "activity_autochess_combat_chess_touch",
			activity_id = AutoChessData:GetActivityID(),
			polyhedron_id_str = arg_13_0.prepareData_:GetEnemyData().battleUID,
			other_data = AutoChessTools.GetChessTrackingPointStr(arg_13_1)
		})
	else
		SetActive(arg_13_0.maskBtn_.gameObject, false)
		arg_13_0.tipsPanelView_:SetActive(false)
	end
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0.autoChessFormationItemView_:Dispose()
	arg_14_0.playerInfoView_:Dispose()
	arg_14_0.tipsPanelView_:Dispose()
	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
