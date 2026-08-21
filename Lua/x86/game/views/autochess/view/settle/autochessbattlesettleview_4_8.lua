local var_0_0 = import("game.views.autoChess.view.settle.AutoChessBattleSettleView")
local var_0_1 = class("AutoChessBattleSettleView_4_8", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/System/Activity_Xihe/Activity_Xihe_TotalSettle"
end

function var_0_1.InitController(arg_2_0)
	var_0_1.super.InitController(arg_2_0)

	arg_2_0.textColorController_ = arg_2_0.controllerEx_:GetController("textColor")
	arg_2_0.rankScoreController_ = arg_2_0.controllerEx_:GetController("rankScore")
	arg_2_0.rankPosController_ = arg_2_0.controllerEx_:GetController("rankPos")
end

function var_0_1.AddUIListener(arg_3_0)
	var_0_1.super.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.oneMoreBtn_, nil, function()
		AutoChessTools.SettleBattle(arg_3_0.context_.gameType, false, true)
	end)
end

function var_0_1.OnEnter(arg_5_0)
	arg_5_0:UpdateContext()
	arg_5_0:UpdateBattleResult()
	arg_5_0:UpdateSelfChessList()
	arg_5_0:UpdatePlayerInfo()
	arg_5_0.chessController_:SetSelectedState("hide")
	SetActive(arg_5_0.shareBtn_, false)
	AnimatorTools.PlayAnimationWithCallback(arg_5_0.enterAnim_, arg_5_0.enterAnimName_, function()
		arg_5_0.chessController_:SetSelectedState("show")
		arg_5_0:StartFormationTween()
		arg_5_0:CreateRankTween()
	end, -1, 0)
	arg_5_0.enterAnim_:Update(0)
end

function var_0_1.UpdateContext(arg_7_0)
	var_0_1.super.UpdateContext(arg_7_0)

	arg_7_0.context_.totalSettlePlayerData_ = AutoChessData:GetTotalSettlePlayerData()
end

function var_0_1.UpdateBattleResult(arg_8_0)
	local var_8_0 = "pvpWin"

	if arg_8_0.context_.gameStatus == AutoChessConst.GAME_STATUS.TOTAL_SETTLE_WIN then
		var_8_0 = "pvpWin"
	elseif arg_8_0.context_.gameStatus == AutoChessConst.GAME_STATUS.TOTAL_SETTLE_LOSE then
		var_8_0 = "pvpLose"
	end

	arg_8_0.battleResultController_:SetSelectedState(var_8_0)

	arg_8_0.enterAnimName_ = var_8_0
	arg_8_0.reverseText_.text = GetTips("AUTO_CHESS_2_PLAY_AGAIN")
	arg_8_0.continueText_.text = GetTips("AUTO_CHESS_ENDING_CONTINUE")
end

function var_0_1.UpdatePlayerInfo(arg_9_0)
	arg_9_0:UpdateTrophyList()
	arg_9_0:UpdateRound()
	arg_9_0:UpdateHP()
	arg_9_0:UpdateLevel()
end

function var_0_1.UpdateLevel(arg_10_0)
	local var_10_0 = arg_10_0.context_.totalSettlePlayerData_
	local var_10_1 = var_10_0.rankIndex

	arg_10_0.lastScore = var_10_0.rankTotalScore or 0
	arg_10_0.changeScore = var_10_0.rankChangeScore or 0
	arg_10_0.totalScore = arg_10_0.lastScore + arg_10_0.changeScore
	arg_10_0.levelText_.text = string.format("NO.<size=120>%s</size>", var_10_1)
	arg_10_0.leveLineText_.text = string.format("NO.<size=120>%s</size>", var_10_1)
	arg_10_0.lastRankCfg, arg_10_0.lastNextRankCfg = AutoChessTools.GetRankLevelCfg(arg_10_0.lastScore)
	arg_10_0.nowRankCfg, arg_10_0.nextRankCfg = AutoChessTools.GetRankLevelCfg(arg_10_0.totalScore)
	arg_10_0.isShowRankLevel = arg_10_0.nowRankCfg.baseline ~= 0

	SetActive(arg_10_0.rankLevelGo_, arg_10_0.isShowRankLevel)

	if not arg_10_0.isShowRankLevel then
		return
	end

	arg_10_0.isChangeRankLevel = arg_10_0.lastRankCfg and arg_10_0.nowRankCfg and arg_10_0.lastRankCfg.id ~= arg_10_0.nowRankCfg.id
	arg_10_0.isChangeBigLevel = arg_10_0.lastRankCfg.big_rank ~= arg_10_0.nowRankCfg.big_rank
	arg_10_0.isUpLevel = arg_10_0.changeScore > 0
	arg_10_0.isMaxLevel = not arg_10_0.lastNextRankCfg

	if arg_10_0.isUpLevel then
		manager.audio:PlayEffect("minigame_activity_4_8", "minigame_activity_4_8_duel_energy", "")
	end

	arg_10_0.rankScoreController_:SetSelectedState(arg_10_0.isMaxLevel and "hide" or "show")

	arg_10_0.changeScoreText_.text = (arg_10_0.isUpLevel and "+" or "") .. arg_10_0.changeScore
	arg_10_0.prograssImg_.fillAmount = arg_10_0.isMaxLevel and 1 or arg_10_0.lastScore / arg_10_0.lastNextRankCfg.baseline

	local var_10_2 = arg_10_0.isChangeRankLevel and arg_10_0.lastRankCfg or arg_10_0.nowRankCfg

	arg_10_0.rankTitleText_.text = var_10_2.name
	arg_10_0.rankRomaText_.text = NumberTools.IntToRomam(var_10_2.rank_level)

	if arg_10_0.isChangeBigLevel then
		if arg_10_0.isUpLevel then
			arg_10_0.rankPosController_:SetSelectedState("up")

			arg_10_0.rankIconImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_Xihe/RankIcon/" .. arg_10_0.lastRankCfg.icon)
			arg_10_0.nextRankIconImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_Xihe/RankIcon/" .. arg_10_0.nowRankCfg.icon)
		else
			arg_10_0.rankPosController_:SetSelectedState("down")

			arg_10_0.rankIconImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_Xihe/RankIcon/" .. arg_10_0.nowRankCfg.icon)
			arg_10_0.nextRankIconImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_Xihe/RankIcon/" .. arg_10_0.lastRankCfg.icon)
		end
	else
		arg_10_0.rankPosController_:SetSelectedState("up")

		arg_10_0.rankIconImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_Xihe/RankIcon/" .. arg_10_0.nowRankCfg.icon)
	end
end

function var_0_1.CreateRankTween(arg_11_0)
	arg_11_0:RemoveTween()

	if not arg_11_0.isShowRankLevel then
		return
	end

	local var_11_0 = arg_11_0.isChangeRankLevel
	local var_11_1 = arg_11_0.isUpLevel
	local var_11_2 = arg_11_0.isMaxLevel

	if var_11_1 and var_11_2 and not var_11_0 then
		arg_11_0.rankScoreController_:SetSelectedState("hide")

		arg_11_0.prograssImg_.fillAmount = 1
	else
		local var_11_3 = arg_11_0.lastScore
		local var_11_4 = arg_11_0.totalScore
		local var_11_5 = arg_11_0.lastNextRankCfg
		local var_11_6 = arg_11_0.nextRankCfg
		local var_11_7 = arg_11_0.nowRankCfg

		local function var_11_8(arg_12_0, arg_12_1, arg_12_2)
			return arg_12_1 and arg_12_2 and (arg_12_0 - arg_12_1.baseline) / (arg_12_2.baseline - arg_12_1.baseline) or 0
		end

		local var_11_9
		local var_11_10
		local var_11_11
		local var_11_12

		if var_11_0 then
			var_11_9 = var_11_2 and 1 or var_11_8(var_11_3, var_11_5)
			var_11_10 = var_11_1 and 1 or 0
			var_11_11 = var_11_1 and 0 or 1
			var_11_12 = var_11_8(var_11_4, var_11_7, var_11_6)
		else
			var_11_9 = var_11_8(var_11_3, var_11_7, var_11_6)
			var_11_10 = var_11_8(var_11_4, var_11_7, var_11_6)
		end

		arg_11_0.firstTween_ = LeanTween.value(var_11_9, var_11_10, 1):setOnUpdate(LuaHelper.FloatAction(function(arg_13_0)
			arg_11_0.prograssImg_.fillAmount = arg_13_0
		end)):setOnComplete(LuaHelper.VoidAction(function()
			arg_11_0:RemoveTween()

			if var_11_0 then
				arg_11_0:PlayLevelAnim(var_11_1)

				arg_11_0.rankTitleText_.text = var_11_7.name

				if var_11_7.rank_level > 0 then
					arg_11_0.rankRomaText_.text = NumberTools.IntToRomam(var_11_7.rank_level)

					arg_11_0.rankScoreController_:SetSelectedState("show")
				else
					arg_11_0.rankScoreController_:SetSelectedState("hide")
				end

				arg_11_0.secondTween_ = LeanTween.value(var_11_11, var_11_12, 1):setOnUpdate(LuaHelper.FloatAction(function(arg_15_0)
					arg_11_0.prograssImg_.fillAmount = arg_15_0
				end)):setOnComplete(LuaHelper.VoidAction(function()
					arg_11_0:RemoveTween()
				end))
			end
		end))
	end
end

function var_0_1.RemoveTween(arg_17_0)
	if arg_17_0.firstTween_ then
		arg_17_0.firstTween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(arg_17_0.firstTween_.id)

		arg_17_0.firstTween_ = nil
	end

	if arg_17_0.secondTween_ then
		arg_17_0.secondTween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(arg_17_0.secondTween_.id)

		arg_17_0.secondTween_ = nil
	end
end

function var_0_1.PlayLevelAnim(arg_18_0, arg_18_1)
	if arg_18_0.isChangeRankLevel then
		if arg_18_0.isChangeBigLevel then
			arg_18_0.rankLevelAnim_:Play(arg_18_1 and "rankitem_up" or "rankitem_down", -1, 0)
		else
			arg_18_0.rankRomaAnim_:Play("rankitem02", -1, 0)
		end
	end
end

function var_0_1.OnClickBackBtn(arg_19_0)
	AutoChessTools.SettleBattle(arg_19_0.context_.gameType)
end

function var_0_1.UpdateTrophyList(arg_20_0)
	local var_20_0 = arg_20_0.context_.selfPlayerData.victoryRoundCount

	if arg_20_0.context_.gameStatus == AutoChessConst.GAME_STATUS.TOTAL_SETTLE_WIN then
		var_20_0 = var_20_0 + 1
	end

	arg_20_0.trophyNumText_.text = var_20_0
end

function var_0_1.OnExit(arg_21_0)
	arg_21_0:RemoveTween()
	var_0_1.super.OnExit(arg_21_0)
end

return var_0_1
