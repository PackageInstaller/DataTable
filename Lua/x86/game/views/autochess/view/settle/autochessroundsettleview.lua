local var_0_0 = class("AutoChessRoundSettleView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_OsirisHorus/Activity_OsirisHorus_AutoChess/Activity_OsirisHorus_POPUI_EndTurn"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()

	arg_3_0.chessItemList_ = {}
	arg_3_0.opponentFormationView_ = AutoChessFormationItemView.New(arg_3_0.opFormationGo_)
	arg_3_0.context_ = {
		gameType = AutoChessConst.GAME_TYPE.PVE
	}
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:InitHandler()
	arg_4_0:AddUIListener()
	arg_4_0:InitController()
	arg_4_0:InitTrophyList()
	arg_4_0:InitHpList()
	arg_4_0:InitLabel()
end

function var_0_0.InitHandler(arg_5_0)
	arg_5_0.backBtnHandler_ = handler(arg_5_0, arg_5_0.OnClickBackBtn)
	arg_5_0.restartBtnHandler_ = handler(arg_5_0, arg_5_0.OnClickRestartBtn)
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.backBtn_, nil, function()
		if arg_6_0.isPveRestart_ or AutoChessTools.GetIsPVPGame(arg_6_0.context_.gameType) then
			return
		end

		arg_6_0.backBtnHandler_()
	end)
	arg_6_0:AddBtnListener(arg_6_0.nextBtn_, nil, arg_6_0.backBtnHandler_)
	arg_6_0:AddBtnListener(arg_6_0.continueBtn_, nil, arg_6_0.backBtnHandler_)
	arg_6_0:AddBtnListener(arg_6_0.restartBtn_, nil, arg_6_0.restartBtnHandler_)
end

function var_0_0.InitController(arg_8_0)
	arg_8_0.gameTypeController_ = arg_8_0.controllerEx_:GetController("gameType")
	arg_8_0.battleResultController_ = arg_8_0.controllerEx_:GetController("result")
	arg_8_0.restartController_ = arg_8_0.controllerEx_:GetController("restart")
end

function var_0_0.InitTrophyList(arg_9_0)
	arg_9_0.trophyItemList_ = {}

	local var_9_0 = arg_9_0.trophyContainTrans_.childCount

	for iter_9_0 = 2, var_9_0 do
		local var_9_1 = arg_9_0.trophyContainTrans_:GetChild(iter_9_0 - 1).gameObject
		local var_9_2 = AutoChessSettleTrophyItemView.New(var_9_1)

		table.insert(arg_9_0.trophyItemList_, var_9_2)
	end
end

function var_0_0.InitHpList(arg_10_0)
	arg_10_0.hpItemList_ = {}

	local var_10_0 = arg_10_0.hpContainTrans_.childCount

	for iter_10_0 = 2, var_10_0 do
		local var_10_1 = arg_10_0.hpContainTrans_:GetChild(iter_10_0 - 1).gameObject
		local var_10_2 = AutoChessSettleHpItemView.New(var_10_1)

		table.insert(arg_10_0.hpItemList_, var_10_2)
	end
end

function var_0_0.InitLabel(arg_11_0)
	arg_11_0.labelView_ = AutoChessLabelItemView.New(arg_11_0.labelGo_)
end

function var_0_0.Dispose(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0.trophyItemList_) do
		iter_12_1:Dispose()
	end

	arg_12_0.trophyItemList_ = nil

	for iter_12_2, iter_12_3 in pairs(arg_12_0.hpItemList_) do
		iter_12_3:Dispose()
	end

	arg_12_0.hpItemList_ = nil

	for iter_12_4, iter_12_5 in pairs(arg_12_0.chessItemList_) do
		iter_12_5:Dispose()
	end

	arg_12_0.chessItemList_ = nil
	arg_12_0.context_ = nil

	if arg_12_0.labelView_ then
		arg_12_0.labelView_:Dispose()
	end

	var_0_0.super.Dispose(arg_12_0)
end

function var_0_0.OnEnter(arg_13_0)
	arg_13_0:UpdateContext()
	arg_13_0:UpdateGameType()
	arg_13_0:UpdateBattleResult()
	arg_13_0:UpdateTrophyList()
	arg_13_0:UpdateHpList()

	if AutoChessTools.GetIsPVPGame(arg_13_0.context_.gameType) then
		arg_13_0:UpdateOpponentInfo()
		arg_13_0:UpdateLabel()
	end

	arg_13_0:PlayEnterAnim()
end

function var_0_0.OnExit(arg_14_0)
	AnimatorTools.Stop()

	for iter_14_0, iter_14_1 in pairs(arg_14_0.hpItemList_) do
		iter_14_1:OnExit()
	end

	arg_14_0.isPveRestart_ = false
	arg_14_0.isClickBack_ = false

	arg_14_0.labelView_:OnExit()
end

function var_0_0.UpdateContext(arg_15_0)
	arg_15_0.context_.gameType = arg_15_0.params_.gameType
	arg_15_0.context_.prepareData = AutoChessData:GetPrepareData(arg_15_0.context_.gameType)
	arg_15_0.context_.battleData = AutoChessData:GetBattleData(arg_15_0.context_.gameType)
	arg_15_0.context_.stageId = AutoChessTools.GetCurStageId(arg_15_0.context_.gameType)
	arg_15_0.context_.stageCfg = AutoChessStageCfg[arg_15_0.context_.stageId]
	arg_15_0.context_.selfPlayerData = arg_15_0.context_.battleData.selfPlayerData
	arg_15_0.context_.opponentPlayerData = arg_15_0.context_.battleData.oppenentPlayerData

	local var_15_0 = AutoChessData:GetGameStatus(arg_15_0.context_.gameType)

	arg_15_0.context_.isLastRound = var_15_0 == AutoChessConst.GAME_STATUS.TOTAL_SETTLE_WIN or var_15_0 == AutoChessConst.GAME_STATUS.TOTAL_SETTLE_LOSE

	SetActive(arg_15_0.exitAnim_.gameObject, false)
end

function var_0_0.UpdateGameType(arg_16_0)
	arg_16_0.gameTypeController_:SetSelectedIndex(arg_16_0.context_.gameType)
end

function var_0_0.UpdateBattleResult(arg_17_0)
	local var_17_0 = arg_17_0.context_.battleData.result

	arg_17_0.restartController_:SetSelectedState("hide")

	if var_17_0 == AutoChessConst.BATTLE_ROUND_RESULT.WIN then
		arg_17_0.battleResultController_:SetSelectedState("win")
		manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_usually_win01", "")
	elseif var_17_0 == AutoChessConst.BATTLE_ROUND_RESULT.LOSE then
		arg_17_0.battleResultController_:SetSelectedState("lose")

		local var_17_1 = arg_17_0.context_.prepareData:GetPveRestartTimes()
		local var_17_2 = GameSetting.auto_chess_pve_restart_times.value[1]

		arg_17_0.isPveRestart_ = arg_17_0.context_.isLastRound and var_17_1 < var_17_2 and arg_17_0.context_.gameType == AutoChessConst.GAME_TYPE.PVE

		if arg_17_0.isPveRestart_ then
			arg_17_0.restartController_:SetSelectedState("show")

			arg_17_0.restartText_.text = GetTips("AUTO_CHESS_REVERSE_TIPS")
			arg_17_0.restartBtnText_.text = GetTips("AUTO_CHESS_ENDING_REVERSE")
			arg_17_0.continueBtnText_.text = GetTips("AUTO_CHESS_ROUND_CONTINUE")
		end

		manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_usually_fail01", "")
	elseif var_17_0 == AutoChessConst.BATTLE_ROUND_RESULT.DRAW then
		arg_17_0.battleResultController_:SetSelectedState("draw")
		manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_usually_flat01", "")
	end

	arg_17_0:RefreshBg()
end

function var_0_0.RefreshBg(arg_18_0)
	local var_18_0 = AutoChessTools.GetCurStageId(arg_18_0.gameType_)
	local var_18_1, var_18_2, var_18_3 = AutoChessTools.GetStagBgPath(var_18_0)

	arg_18_0.imgBg_.sprite = pureGetSpriteWithoutAtlas(var_18_1)
end

function var_0_0.UpdateTrophyList(arg_19_0)
	local var_19_0 = arg_19_0.context_.selfPlayerData.victoryRoundCount
	local var_19_1 = arg_19_0.context_.battleData.result
	local var_19_2 = #arg_19_0.trophyItemList_

	if arg_19_0.context_.gameType == AutoChessConst.GAME_TYPE.PVE then
		var_19_2 = arg_19_0.context_.stageCfg.win_num
	else
		var_19_2 = GameSetting.auto_chess_win_limit.value[1]
	end

	for iter_19_0, iter_19_1 in ipairs(arg_19_0.trophyItemList_) do
		if iter_19_0 <= var_19_0 then
			iter_19_1:SetStatus(AutoChessConst.TROPHY_STATUS.ALREADY)
		elseif iter_19_0 == var_19_0 + 1 then
			if var_19_1 == AutoChessConst.BATTLE_ROUND_RESULT.WIN then
				iter_19_1:SetStatus(AutoChessConst.TROPHY_STATUS.NEW)
			else
				iter_19_1:SetStatus(AutoChessConst.TROPHY_STATUS.NORMAL)
			end
		else
			iter_19_1:SetStatus(AutoChessConst.TROPHY_STATUS.NORMAL)
		end

		SetActive(iter_19_1.gameObject_, iter_19_0 <= var_19_2)
	end
end

function var_0_0.UpdateHpList(arg_20_0)
	local var_20_0 = arg_20_0.context_.selfPlayerData.hp
	local var_20_1 = arg_20_0.context_.battleData.result
	local var_20_2 = #arg_20_0.hpItemList_

	if arg_20_0.context_.gameType == AutoChessConst.GAME_TYPE.PVE then
		var_20_2 = arg_20_0.context_.stageCfg.defeat_num
	else
		var_20_2 = GameSetting.auto_chess_lose_limit.value[1]
	end

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

function var_0_0.UpdateLabel(arg_21_0)
	arg_21_0.labelView_:RefreshLabelData(true, arg_21_0.context_.opponentPlayerData)
end

function var_0_0.UpdateOpponentInfo(arg_22_0)
	arg_22_0:UpdateOpponentChessList()
	arg_22_0:UpdateOpponentPlayerInfo()

	arg_22_0.nextBtnText_.text = arg_22_0.context_.isLastRound and GetTips("AUTO_CHESS_ROUND_CONTINUE") or GetTips("AUTO_CHESS_NEXT_ROUND")
end

function var_0_0.UpdateOpponentChessList(arg_23_0)
	for iter_23_0, iter_23_1 in pairs(arg_23_0.chessItemList_) do
		iter_23_1:SetActive(false)
	end

	arg_23_0.opponentFormationView_:SetPlayerType(AutoChessConst.PLAYER_TYPE.OPPONENT)

	local var_23_0 = arg_23_0.context_.opponentPlayerData.chessDataDicByUniqueId

	for iter_23_2, iter_23_3 in pairs(var_23_0) do
		local var_23_1 = iter_23_3.index

		if not arg_23_0.chessItemList_[var_23_1] then
			local var_23_2 = Object.Instantiate(arg_23_0.chessItemGo_, arg_23_0.chessItemGo_.transform.parent)

			arg_23_0.chessItemList_[var_23_1] = AutoChessTeamItem.New(var_23_2)
		end

		local var_23_3 = arg_23_0.chessItemList_[var_23_1]

		var_23_3:SetActive(true)
		var_23_3:SetParent(arg_23_0.opponentFormationView_:GetChessPanelTrans())
		var_23_3:SetLocalScale(Vector3.one)
		var_23_3:SetLocalPos(arg_23_0.opponentFormationView_:GetChessPos(iter_23_3.index))
		var_23_3:SetPlayerType(AutoChessConst.PLAYER_TYPE.OPPONENT)
		var_23_3:SetData(iter_23_3)
	end
end

function var_0_0.UpdateOpponentPlayerInfo(arg_24_0)
	arg_24_0.enenyIcon_.sprite = getSpriteWithoutAtlas("TextureConfig/Character/LittleIcon/" .. ItemCfg[arg_24_0.context_.opponentPlayerData.icon].icon)
	arg_24_0.enenyName_.text = arg_24_0.context_.opponentPlayerData.nick
end

function var_0_0.OnClickBackBtn(arg_25_0)
	if arg_25_0.isClickBack_ then
		return
	end

	arg_25_0.isClickBack_ = true

	if arg_25_0.context_.isLastRound then
		JumpTools.Back()
		AutoChessTools.GoToGameSettleView(arg_25_0.context_.gameType)
	else
		SetActive(arg_25_0.exitAnim_.gameObject, true)
		AnimatorTools.Stop()
		AnimatorTools.PlayAnimationWithCallback(arg_25_0.exitAnim_, "UI_Activity_OsirisHorus_CutScenesPopUI_cx", function()
			AutoChessTools.ResetPrepareState()
			AutoChessTools.SettleBattle(arg_25_0.context_.gameType, true)
		end, -1, 0)
		arg_25_0.exitAnim_:Update(0)
	end
end

function var_0_0.OnClickRestartBtn(arg_27_0)
	if arg_27_0.context_.gameType == AutoChessConst.GAME_TYPE.PVE then
		local var_27_0 = arg_27_0.context_.stageCfg

		if var_27_0.post_story and var_27_0.post_story ~= 0 and arg_27_0.context_.gameStatus == AutoChessConst.GAME_STATUS.TOTAL_SETTLE_WIN then
			manager.story:StartStoryById(var_27_0.post_story, function(arg_28_0)
				AutoChessTools.StartNewGame(arg_27_0.context_.gameType, arg_27_0.context_.stageId)
			end)
		else
			AutoChessTools.StartNewGame(arg_27_0.context_.gameType, arg_27_0.context_.stageId)
		end
	else
		AutoChessTools.StartNewGame(arg_27_0.context_.gameType, 0)
	end
end

function var_0_0.PlayEnterAnim(arg_29_0)
	if AutoChessTools.GetIsPVPGame(arg_29_0.context_.gameType) then
		arg_29_0.enterAnim_:Play("U_Activity_OsirisHorus_POPUI_EndTurn_pvp_cx", -1, 0)
		arg_29_0.enterAnim_:Update(0)
	else
		arg_29_0.enterAnim_:Play("U_Activity_OsirisHorus_POPUI_EndTurn_cx", -1, 0)
		arg_29_0.enterAnim_:Update(0)
	end
end

return var_0_0
