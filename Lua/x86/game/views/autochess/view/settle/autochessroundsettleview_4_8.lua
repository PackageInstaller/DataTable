local var_0_0 = class("AutoChessRoundSettleView_4_8", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_AutoChess_Battle/Activity_AutoChess_PVP_POPUI_EndTurn"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()

	arg_3_0.context_ = {
		gameType = AutoChessConst.GAME_TYPE.PVE
	}
	arg_3_0.clickChessHandler_ = handler(arg_3_0, arg_3_0.OnClickChess)
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:InitHandler()
	arg_4_0:InitController()
	arg_4_0:InitHpList()
	arg_4_0:AddUIListener()

	arg_4_0.playerList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.playerListGo_, AutoChessScoreBoardPopItemView)
	arg_4_0.autoChessCountDownView_ = AutoChessCountDownView.New(arg_4_0.timerGo_)
	arg_4_0.tipsPanelView_ = AutoChessTipsPanelView.New(arg_4_0.tipsPanelGo_)
	arg_4_0.startPos_ = 104
	arg_4_0.itemHeight_ = 186
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_0.playerDataList_[arg_5_1], arg_5_0.scrollView_, true)
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.nextBtn_, nil, arg_6_0.backBtnHandler_)
	arg_6_0:AddBtnListener(arg_6_0.maskBtn_, nil, function()
		arg_6_0:OnCloseTips()
	end)
	arg_6_0.scrollView_.onValueChanged:AddListener(function()
		arg_6_0:OnCloseTips()
	end)
end

function var_0_0.InitHandler(arg_9_0)
	arg_9_0.backBtnHandler_ = handler(arg_9_0, arg_9_0.OnClickBackBtn)
end

function var_0_0.InitController(arg_10_0)
	arg_10_0.battleResultController_ = arg_10_0.controllerEx_:GetController("result")
end

function var_0_0.InitHpList(arg_11_0)
	arg_11_0.hpItemList_ = {}

	local var_11_0 = arg_11_0.hpContainTrans_.childCount

	for iter_11_0 = 2, var_11_0 do
		local var_11_1 = arg_11_0.hpContainTrans_:GetChild(iter_11_0 - 1).gameObject
		local var_11_2 = AutoChessSettleHpItemView.New(var_11_1)

		table.insert(arg_11_0.hpItemList_, var_11_2)
	end
end

function var_0_0.Dispose(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0.hpItemList_) do
		iter_12_1:Dispose()
	end

	arg_12_0.hpItemList_ = nil

	if arg_12_0.autoChessCountDownView_ then
		arg_12_0.autoChessCountDownView_:Dispose()
	end

	if arg_12_0.tipsPanelView_ then
		arg_12_0.tipsPanelView_:Dispose()
	end

	if arg_12_0.playerList_ then
		arg_12_0.playerList_:Dispose()
	end

	arg_12_0.context_ = nil

	var_0_0.super.Dispose(arg_12_0)
end

function var_0_0.OnEnter(arg_13_0)
	arg_13_0:UpdateContext()
	arg_13_0:RefreshBg()
	arg_13_0:UpdateBattleResult()
	arg_13_0:UpdatePlayerList()
	arg_13_0:UpdateTrophy()
	arg_13_0:UpdateHpList()

	if arg_13_0.context_.isLastRound then
		SetActive(arg_13_0.timerGo_, false)
	else
		SetActive(arg_13_0.timerGo_, true)
		arg_13_0.autoChessCountDownView_:UpdateCountDownTime()
	end

	arg_13_0:RegistEventListener("AUTO_CHESS_SCORE_BOARD_CHESS_CLICK", arg_13_0.clickChessHandler_)
end

function var_0_0.OnExit(arg_14_0)
	AnimatorTools.Stop()

	for iter_14_0, iter_14_1 in pairs(arg_14_0.hpItemList_) do
		iter_14_1:OnExit()
	end

	arg_14_0:OnCloseTips()

	arg_14_0.isClickBack_ = false
end

function var_0_0.UpdateContext(arg_15_0)
	arg_15_0.context_.gameType = arg_15_0.params_.gameType
	arg_15_0.context_.prepareData = AutoChessData:GetPrepareData(arg_15_0.context_.gameType)
	arg_15_0.context_.battleData = AutoChessData:GetBattleData(arg_15_0.context_.gameType)
	arg_15_0.context_.selfPlayerData = arg_15_0.context_.battleData.selfPlayerData

	local var_15_0 = AutoChessData:GetGameStatus(arg_15_0.context_.gameType)

	arg_15_0.context_.isLastRound = var_15_0 == AutoChessConst.GAME_STATUS.TOTAL_SETTLE_WIN or var_15_0 == AutoChessConst.GAME_STATUS.TOTAL_SETTLE_LOSE

	SetActive(arg_15_0.exitAnim_.gameObject, false)
end

function var_0_0.RefreshBg(arg_16_0)
	local var_16_0, var_16_1, var_16_2 = AutoChessTools.GetRandomBgPath()

	arg_16_0.imgBg_.sprite = pureGetSpriteWithoutAtlas(var_16_0)
end

function var_0_0.UpdateBattleResult(arg_17_0)
	local var_17_0 = arg_17_0.context_.battleData.result

	if var_17_0 == AutoChessConst.BATTLE_ROUND_RESULT.WIN then
		arg_17_0.battleResultController_:SetSelectedState("win")
		manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_usually_win01", "")
	elseif var_17_0 == AutoChessConst.BATTLE_ROUND_RESULT.LOSE then
		arg_17_0.battleResultController_:SetSelectedState("lose")
		manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_usually_fail01", "")
	elseif var_17_0 == AutoChessConst.BATTLE_ROUND_RESULT.DRAW then
		arg_17_0.battleResultController_:SetSelectedState("draw")
		manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_usually_flat01", "")
	end
end

function var_0_0.UpdatePlayerList(arg_18_0)
	arg_18_0.playerDataList_ = AutoChessData:GetRoundSettlePlayerDataList()

	arg_18_0.playerList_:StartScroll(#arg_18_0.playerDataList_)

	local var_18_0 = 1

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.playerDataList_) do
		if iter_18_1.isSelf then
			var_18_0 = iter_18_0

			break
		end
	end

	if var_18_0 >= 6 then
		local var_18_1 = arg_18_0.startPos_ + arg_18_0.itemHeight_ * (var_18_0 - 6)
		local var_18_2 = arg_18_0.startPos_ + arg_18_0.itemHeight_ * (#arg_18_0.playerDataList_ - 6)
		local var_18_3 = (var_18_2 - var_18_1) / var_18_2

		arg_18_0.playerList_:SetScrolledPosition(Vector2.New(0, var_18_3))
	end
end

function var_0_0.UpdateTrophy(arg_19_0)
	arg_19_0.nowScoreText_.text = arg_19_0.context_.selfPlayerData.victoryRoundCount
end

function var_0_0.UpdateHpList(arg_20_0)
	local var_20_0 = arg_20_0.context_.selfPlayerData.hp
	local var_20_1 = arg_20_0.context_.battleData.result
	local var_20_2 = GameSetting.auto_chess_lose_limit.value[1]

	for iter_20_0, iter_20_1 in ipairs(arg_20_0.hpItemList_) do
		if iter_20_0 < var_20_0 then
			iter_20_1:SetStatus(AutoChessConst.HP_STATUS.NORMAL)
		elseif iter_20_0 == var_20_0 then
			if var_20_1 == AutoChessConst.BATTLE_ROUND_RESULT.LOSE then
				iter_20_1:SetStatus(AutoChessConst.HP_STATUS.HURTING, true)
			else
				iter_20_1:SetStatus(AutoChessConst.HP_STATUS.NORMAL)
			end
		else
			iter_20_1:SetStatus(AutoChessConst.HP_STATUS.HURTED)
		end

		SetActive(iter_20_1.gameObject_, iter_20_0 <= var_20_2)
	end
end

function var_0_0.OnClickBackBtn(arg_21_0)
	if arg_21_0.isClickBack_ then
		return
	end

	arg_21_0.isClickBack_ = true

	if arg_21_0.context_.isLastRound then
		JumpTools.Back()
		AutoChessTools.GoToGameSettleView(arg_21_0.context_.gameType)
	else
		SetActive(arg_21_0.exitAnim_.gameObject, true)
		AnimatorTools.Stop()
		AnimatorTools.PlayAnimationWithCallback(arg_21_0.exitAnim_, "UI_Activity_OsirisHorus_CutScenesPopUI_cx", function()
			AutoChessTools.ResetPrepareState()
			AutoChessTools.SettleBattle(arg_21_0.context_.gameType, true)
		end, -1, 0)
		arg_21_0.exitAnim_:Update(0)
	end
end

function var_0_0.OnClickChess(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0.isShowTips_ = true

	SetActive(arg_23_0.maskBtn_.gameObject, arg_23_0.isShowTips_)
	arg_23_0.tipsPanelView_:SetActive(arg_23_0.isShowTips_)
	arg_23_0.tipsPanelView_:SetData(arg_23_1)
	arg_23_0.tipsPanelView_:SetGoldState(false)

	local var_23_0 = arg_23_2:GetPos()

	arg_23_0.tipsPanelView_:SetPos(var_23_0)
	AutoChessTools.ScreenAdapter(arg_23_2, arg_23_0.tipsPanelView_)
end

function var_0_0.OnCloseTips(arg_24_0)
	if not arg_24_0.isShowTips_ then
		return
	end

	arg_24_0.isShowTips_ = false

	SetActive(arg_24_0.maskBtn_.gameObject, false)
	arg_24_0.tipsPanelView_:SetActive(false)
end

function var_0_0.PlayEnterAnim(arg_25_0)
	if AutoChessTools.GetIsPVPGame(arg_25_0.context_.gameType) then
		arg_25_0.enterAnim_:Play("U_Activity_OsirisHorus_POPUI_EndTurn_pvp_cx", -1, 0)
		arg_25_0.enterAnim_:Update(0)
	else
		arg_25_0.enterAnim_:Play("U_Activity_OsirisHorus_POPUI_EndTurn_cx", -1, 0)
		arg_25_0.enterAnim_:Update(0)
	end
end

return var_0_0
