local var_0_0 = class("AutoChessBattleSettleView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_OsirisHorus/Activity_OsirisHorus_AutoChess/Activity_OsirisHorus_TotalSettle"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()

	arg_3_0.trophyItemList_ = {}
	arg_3_0.chessItemList_ = {}
	arg_3_0.scoreDetailItemList_ = {}
	arg_3_0.selfFormationView_ = AutoChessFormationItemView.New(arg_3_0.selfFormationGo_)
	arg_3_0.context_ = {
		gameType = AutoChessConst.GAME_TYPE.PVP,
		gameStatus = AutoChessConst.GAME_STATUS.TOTAL_SETTLE
	}
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:InitHandler()
	arg_4_0:AddUIListener()
	arg_4_0:InitController()
end

function var_0_0.InitHandler(arg_5_0)
	arg_5_0.backBtnHandler_ = handler(arg_5_0, arg_5_0.OnClickBackBtn)
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.comfirmBtn_, nil, arg_6_0.backBtnHandler_)
	arg_6_0:AddBtnListener(arg_6_0.shareBtn_, nil, function()
		local var_7_0 = {
			cardShowUID = true,
			cardShowLv = true,
			logoPos = 2,
			cardPos = 1,
			cardShow = true
		}

		manager.share:Share(function()
			arg_6_0.shareController_:SetSelectedState("true")
		end, function()
			arg_6_0.shareController_:SetSelectedState("false")
		end, function()
			return
		end, nil, var_7_0)
	end)
end

function var_0_0.InitController(arg_11_0)
	arg_11_0.battleResultController_ = arg_11_0.controllerEx_:GetController("result")
	arg_11_0.shareController_ = arg_11_0.controllerEx_:GetController("share")
	arg_11_0.chessController_ = arg_11_0.controllerEx_:GetController("chess")
end

function var_0_0.OnExit(arg_12_0)
	AnimatorTools.Stop()

	if arg_12_0.selfPlayTimer_ then
		arg_12_0.selfPlayTimer_:Stop()

		arg_12_0.selfPlayTimer_ = nil
	end

	if arg_12_0.tween_ then
		arg_12_0.tween_:setOnComplete(nil)
		LeanTween.cancel(arg_12_0.tween_.id)

		arg_12_0.tween_ = nil
	end
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0.selfFormationView_:Dispose()

	for iter_13_0, iter_13_1 in pairs(arg_13_0.chessItemList_) do
		iter_13_1:Dispose()
	end

	arg_13_0.chessItemList_ = {}

	for iter_13_2, iter_13_3 in pairs(arg_13_0.trophyItemList_) do
		iter_13_3:Dispose()
	end

	arg_13_0.trophyItemList_ = nil

	for iter_13_4, iter_13_5 in pairs(arg_13_0.scoreDetailItemList_) do
		iter_13_5:Dispose()
	end

	arg_13_0.scoreDetailItemList_ = nil
	arg_13_0.context_ = nil

	var_0_0.super.Dispose(arg_13_0)
end

function var_0_0.OnEnter(arg_14_0)
	arg_14_0:UpdateContext()
	arg_14_0:UpdateBattleResult()
	arg_14_0:UpdateSelfChessList()
	arg_14_0:UpdatePlayerInfo()
	arg_14_0.chessController_:SetSelectedState("hide")
	SetActive(arg_14_0.shareBtn_, OperationData:IsOperationOpen(OperationConst.SHARE_FLAG))
	AnimatorTools.PlayAnimationWithCallback(arg_14_0.enterAnim_, arg_14_0.enterAnimName_, function()
		arg_14_0.chessController_:SetSelectedState("show")
		arg_14_0:StartFormationTween()
	end, -1, 0)
	arg_14_0.enterAnim_:Update(0)
end

function var_0_0.UpdateContext(arg_16_0)
	arg_16_0.context_.gameType = arg_16_0.params_.gameType
	arg_16_0.context_.gameStatus = AutoChessData:GetGameStatus(arg_16_0.context_.gameType)
	arg_16_0.context_.prepareData = AutoChessData:GetPrepareData(arg_16_0.context_.gameType)
	arg_16_0.context_.battleData = AutoChessData:GetBattleData(arg_16_0.context_.gameType)
	arg_16_0.context_.stageCfg = AutoChessStageCfg[AutoChessTools.GetCurStageId(arg_16_0.context_.gameType)]
	arg_16_0.context_.isTeaching_ = arg_16_0.context_.stageCfg and table.indexof(AutoChessConst.TEACH_STAGE, arg_16_0.context_.stageCfg.id)

	if arg_16_0.context_.battleData then
		arg_16_0.context_.selfPlayerData = arg_16_0.context_.battleData.selfPlayerData
	else
		arg_16_0.context_.selfPlayerData = arg_16_0.context_.prepareData.playerData
	end
end

function var_0_0.UpdateBattleResult(arg_17_0)
	local var_17_0

	arg_17_0.enterAnimName_ = "pveWin"

	if AutoChessTools.GetIsPVPGame(arg_17_0.context_.gameType) then
		if arg_17_0.context_.gameStatus == AutoChessConst.GAME_STATUS.TOTAL_SETTLE_WIN then
			var_17_0 = "pvpWin"
		elseif arg_17_0.context_.gameStatus == AutoChessConst.GAME_STATUS.TOTAL_SETTLE_LOSE then
			var_17_0 = "pvpLose"
		end
	elseif arg_17_0.context_.gameStatus == AutoChessConst.GAME_STATUS.TOTAL_SETTLE_WIN then
		var_17_0 = "pveWin"
	elseif arg_17_0.context_.gameStatus == AutoChessConst.GAME_STATUS.TOTAL_SETTLE_LOSE then
		var_17_0 = "pveLose"
	end

	arg_17_0.battleResultController_:SetSelectedState(var_17_0)

	arg_17_0.enterAnimName_ = var_17_0
	arg_17_0.reverseText_.text = GetTips("AUTO_CHESS_ENDING_REVERSE")
	arg_17_0.continueText_.text = GetTips("AUTO_CHESS_ENDING_CONTINUE")
end

function var_0_0.UpdateSelfChessList(arg_18_0)
	for iter_18_0, iter_18_1 in pairs(arg_18_0.chessItemList_) do
		iter_18_1:SetActive(false)
	end

	local var_18_0 = arg_18_0.context_.selfPlayerData.chessDataDicByUniqueId

	arg_18_0.chessCount_ = 0

	for iter_18_2, iter_18_3 in pairs(var_18_0) do
		arg_18_0.chessCount_ = arg_18_0.chessCount_ + 1

		local var_18_1 = iter_18_3.index

		if not arg_18_0.chessItemList_[var_18_1] then
			local var_18_2 = Object.Instantiate(arg_18_0.chessItemGo_, arg_18_0.chessItemGo_.transform.parent)

			arg_18_0.chessItemList_[var_18_1] = AutoChessTeamItem.New(var_18_2)
		end

		local var_18_3 = arg_18_0.chessItemList_[var_18_1]

		var_18_3:SetActive(true)
		var_18_3:SetParent(arg_18_0.selfFormationView_:GetChessPanelTrans())
		var_18_3:SetLocalScale(Vector3.one)
		var_18_3:SetLocalPos(arg_18_0.selfFormationView_:GetChessPos(iter_18_3.index))
		var_18_3:SetPlayerType(AutoChessConst.PLAYER_TYPE.SELF)
		var_18_3:SetData(iter_18_3)
	end
end

function var_0_0.UpdatePlayerInfo(arg_19_0)
	arg_19_0:UpdateTrophyList()
	arg_19_0:UpdateRound()
	arg_19_0:UpdateHP()

	if AutoChessTools.GetIsPVPGame(arg_19_0.context_.gameType) then
		arg_19_0:UpdateScore()
	end
end

function var_0_0.UpdateTrophyList(arg_20_0)
	local var_20_0 = arg_20_0.context_.selfPlayerData.victoryRoundCount

	if arg_20_0.context_.gameStatus == AutoChessConst.GAME_STATUS.TOTAL_SETTLE_WIN then
		var_20_0 = var_20_0 + 1
	end

	local var_20_1 = 0

	if arg_20_0.context_.gameType == AutoChessConst.GAME_TYPE.PVE then
		var_20_1 = arg_20_0.context_.stageCfg.win_num
	else
		var_20_1 = GameSetting.auto_chess_win_limit.value[1]
	end

	local var_20_2 = math.min(var_20_0, var_20_1)

	arg_20_0.trophyNumText_.text = string.format("%s/%s", var_20_2, var_20_1)
end

function var_0_0.UpdateRound(arg_21_0)
	arg_21_0.roundText_.text = arg_21_0.context_.selfPlayerData.curRoundCount
end

function var_0_0.UpdateHP(arg_22_0)
	local var_22_0 = arg_22_0.context_.selfPlayerData.hp

	if arg_22_0.context_.gameStatus == AutoChessConst.GAME_STATUS.TOTAL_SETTLE_LOSE then
		var_22_0 = var_22_0 - 1

		manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_perfect_over", "")
	elseif arg_22_0.context_.gameStatus == AutoChessConst.GAME_STATUS.TOTAL_SETTLE_WIN then
		manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_perfect_win", "")
	end

	arg_22_0.hpText_.text = var_22_0
end

function var_0_0.UpdateScore(arg_23_0)
	arg_23_0.scoreText_.text = arg_23_0.context_.battleData.score

	arg_23_0:UpdateScoreDetail()
end

function var_0_0.UpdateScoreDetail(arg_24_0)
	local var_24_0 = arg_24_0:FilterScoreDetail()

	for iter_24_0 = 1, #var_24_0 do
		local var_24_1 = var_24_0[iter_24_0]

		if not arg_24_0.scoreDetailItemList_[iter_24_0] then
			local var_24_2 = Object.Instantiate(arg_24_0.scoreDetailItemGo_, arg_24_0.scoreDetailContainerTrans_)

			arg_24_0.scoreDetailItemList_[iter_24_0] = AutoChessScoreDetailItemView.New(var_24_2)
		end

		arg_24_0.scoreDetailItemList_[iter_24_0]:SetActive(true)
		arg_24_0.scoreDetailItemList_[iter_24_0]:SetData(var_24_1)
	end

	for iter_24_1 = #var_24_0 + 1, #arg_24_0.scoreDetailItemList_ do
		arg_24_0.scoreDetailItemList_[iter_24_1]:SetActive(false)
	end
end

function var_0_0.FilterScoreDetail(arg_25_0)
	local var_25_0 = {}

	for iter_25_0, iter_25_1 in ipairs(arg_25_0.context_.battleData.scoreDetailList) do
		if iter_25_1.score > 0 then
			table.insert(var_25_0, iter_25_1)
		end
	end

	table.sort(var_25_0, function(arg_26_0, arg_26_1)
		return arg_26_0.score > arg_26_1.score
	end)

	return var_25_0
end

function var_0_0.StartFormationTween(arg_27_0)
	if arg_27_0.chessCount_ > 0 then
		local var_27_0 = arg_27_0.selfChessContain_.transform.anchoredPosition.x

		arg_27_0.selfChessContain_.transform.anchoredPosition = Vector2.New(var_27_0 - _G.SCREEN_WIDTH / 2, 0)

		arg_27_0:PlayItemEnterAnim()

		arg_27_0.tween_ = LeanTween.moveLocalX(arg_27_0.selfChessContain_, var_27_0, 1.5):setOnComplete(LuaHelper.VoidAction(function()
			arg_27_0:ResetItemAnim()
			SetActive(arg_27_0.shareBtn_, OperationData:IsOperationOpen(OperationConst.SHARE_FLAG))
		end))
	else
		SetActive(arg_27_0.shareBtn_, OperationData:IsOperationOpen(OperationConst.SHARE_FLAG))
	end
end

function var_0_0.PlayItemEnterAnim(arg_29_0)
	local var_29_0 = arg_29_0.chessItemList_ and #arg_29_0.chessItemList_ or 0
	local var_29_1 = 1

	arg_29_0.selfPlayTimer_ = nil
	arg_29_0.selfPlayTimer_ = Timer.New(function()
		if var_29_1 <= var_29_0 and arg_29_0.chessItemList_[var_29_1] then
			arg_29_0.chessItemList_[var_29_1]:PlayItemAnim("ChessItem_ruchang")

			var_29_1 = var_29_1 + 1
		end
	end, 0.03, var_29_0)

	arg_29_0.selfPlayTimer_:Start()
end

function var_0_0.ResetItemAnim(arg_31_0)
	for iter_31_0, iter_31_1 in pairs(arg_31_0.chessItemList_) do
		if iter_31_1 then
			iter_31_1:PlayItemAnim("ChessIdleAnim")
		end
	end
end

function var_0_0.OnClickBackBtn(arg_32_0)
	local var_32_0 = arg_32_0.context_.stageCfg

	if var_32_0 and var_32_0.post_story and var_32_0.post_story ~= 0 and (arg_32_0.context_.gameStatus == AutoChessConst.GAME_STATUS.TOTAL_SETTLE_WIN or arg_32_0.context_.isTeaching_) then
		AutoChessData:SetStageStoryId(var_32_0.post_story)
	end

	AutoChessTools.SettleBattle(arg_32_0.context_.gameType)
end

return var_0_0
