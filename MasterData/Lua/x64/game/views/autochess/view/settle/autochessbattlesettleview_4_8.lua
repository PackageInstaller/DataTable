local AutoChessBattleSettleView_4_8 = class("AutoChessBattleSettleView_4_8", (import("game.views.autoChess.view.settle.AutoChessBattleSettleView")))

function AutoChessBattleSettleView_4_8:UIName()
	return "Widget/System/Activity_Xihe/Activity_Xihe_TotalSettle"
end

function AutoChessBattleSettleView_4_8:InitController()
	AutoChessBattleSettleView_4_8.super.InitController(self)

	self.textColorController_ = self.controllerEx_:GetController("textColor")
	self.rankScoreController_ = self.controllerEx_:GetController("rankScore")
	self.rankPosController_ = self.controllerEx_:GetController("rankPos")
end

function AutoChessBattleSettleView_4_8:AddUIListener()
	AutoChessBattleSettleView_4_8.super.AddUIListener(self)
	self:AddBtnListener(self.oneMoreBtn_, nil, function()
		AutoChessTools.SettleBattle(self.context_.gameType, false, true)
	end)
end

function AutoChessBattleSettleView_4_8:OnEnter()
	self:UpdateContext()
	self:UpdateBattleResult()
	self:UpdateSelfChessList()
	self:UpdatePlayerInfo()
	self.chessController_:SetSelectedState("hide")
	SetActive(self.shareBtn_, false)
	AnimatorTools.PlayAnimationWithCallback(self.enterAnim_, self.enterAnimName_, function()
		self.chessController_:SetSelectedState("show")
		self:StartFormationTween()
		self:CreateRankTween()
	end, -1, 0)
	self.enterAnim_:Update(0)
end

function AutoChessBattleSettleView_4_8:UpdateContext()
	AutoChessBattleSettleView_4_8.super.UpdateContext(self)

	self.context_.totalSettlePlayerData_ = AutoChessData:GetTotalSettlePlayerData()
end

function AutoChessBattleSettleView_4_8:UpdateBattleResult()
	local var_8_0 = "pvpWin"

	if self.context_.gameStatus == AutoChessConst.GAME_STATUS.TOTAL_SETTLE_WIN then
		var_8_0 = "pvpWin"
	elseif self.context_.gameStatus == AutoChessConst.GAME_STATUS.TOTAL_SETTLE_LOSE then
		var_8_0 = "pvpLose"
	end

	self.battleResultController_:SetSelectedState(var_8_0)

	self.enterAnimName_ = var_8_0
	self.reverseText_.text = GetTips("AUTO_CHESS_2_PLAY_AGAIN")
	self.continueText_.text = GetTips("AUTO_CHESS_ENDING_CONTINUE")
end

function AutoChessBattleSettleView_4_8:UpdatePlayerInfo()
	self:UpdateTrophyList()
	self:UpdateRound()
	self:UpdateHP()
	self:UpdateLevel()
end

function AutoChessBattleSettleView_4_8:UpdateLevel()
	self.lastScore = self.context_.totalSettlePlayerData_.rankTotalScore or 0
	self.changeScore = self.context_.totalSettlePlayerData_.rankChangeScore or 0
	self.totalScore = self.lastScore + self.changeScore
	self.levelText_.text = string.format("NO.<size=120>%s</size>", self.context_.totalSettlePlayerData_.rankIndex)
	self.leveLineText_.text = string.format("NO.<size=120>%s</size>", self.context_.totalSettlePlayerData_.rankIndex)
	self.lastRankCfg, self.lastNextRankCfg = AutoChessTools.GetRankLevelCfg(self.lastScore)
	self.nowRankCfg, self.nextRankCfg = AutoChessTools.GetRankLevelCfg(self.totalScore)
	self.isShowRankLevel = self.nowRankCfg.baseline ~= 0

	SetActive(self.rankLevelGo_, self.isShowRankLevel)

	if not self.isShowRankLevel then
		return
	end

	self.isChangeRankLevel = self.lastRankCfg and self.nowRankCfg and self.lastRankCfg.id ~= self.nowRankCfg.id
	self.isChangeBigLevel = self.lastRankCfg.big_rank ~= self.nowRankCfg.big_rank
	self.isUpLevel = self.changeScore > 0
	self.isMaxLevel = not self.lastNextRankCfg

	if self.isUpLevel then
		manager.audio:PlayEffect("minigame_activity_4_8", "minigame_activity_4_8_duel_energy", "")
	end

	self.rankScoreController_:SetSelectedState(self.isMaxLevel and "hide" or "show")

	self.changeScoreText_.text = (self.isUpLevel and "+" or "") .. self.changeScore
	self.prograssImg_.fillAmount = self.isMaxLevel and 1 or self.lastScore / self.lastNextRankCfg.baseline

	local var_10_0

	if self.isChangeRankLevel then
		var_10_0 = self.lastRankCfg or self.nowRankCfg
	end

	self.rankTitleText_.text = var_10_0.name
	self.rankRomaText_.text = NumberTools.IntToRomam(var_10_0.rank_level)

	if self.isChangeBigLevel then
		if self.isUpLevel then
			self.rankPosController_:SetSelectedState("up")

			self.rankIconImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_Xihe/RankIcon/" .. self.lastRankCfg.icon)
			self.nextRankIconImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_Xihe/RankIcon/" .. self.nowRankCfg.icon)
		else
			self.rankPosController_:SetSelectedState("down")

			self.rankIconImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_Xihe/RankIcon/" .. self.nowRankCfg.icon)
			self.nextRankIconImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_Xihe/RankIcon/" .. self.lastRankCfg.icon)
		end
	else
		self.rankPosController_:SetSelectedState("up")

		self.rankIconImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_Xihe/RankIcon/" .. self.nowRankCfg.icon)
	end
end

function AutoChessBattleSettleView_4_8:CreateRankTween()
	self:RemoveTween()

	if not self.isShowRankLevel then
		return
	end

	local var_11_0 = self.isChangeRankLevel
	local var_11_1 = self.isUpLevel

	if self.isUpLevel and self.isMaxLevel and not var_11_0 then
		self.rankScoreController_:SetSelectedState("hide")

		self.prograssImg_.fillAmount = 1
	else
		local var_11_2 = self.lastScore
		local var_11_3 = self.totalScore
		local var_11_4 = self.nextRankCfg
		local var_11_5 = self.nowRankCfg

		local function var_11_6(arg_12_0, arg_12_1, arg_12_2)
			return (arg_12_1 and arg_12_2 or nil) and ((arg_12_0 - arg_12_1.baseline) / (arg_12_2.baseline - arg_12_1.baseline) or 0)
		end

		local var_11_7
		local var_11_8
		local var_11_9
		local var_11_10

		if var_11_0 then
			var_11_7 = self.isMaxLevel and 1 or var_11_6(var_11_2, self.lastNextRankCfg)
			var_11_8 = var_11_1 and 1 or 0
			var_11_9 = var_11_1 and 0 or 1
			var_11_10 = var_11_6(var_11_3, var_11_5, var_11_4)
		else
			var_11_7 = var_11_6(var_11_2, var_11_5, var_11_4)
			var_11_8 = var_11_6(var_11_3, var_11_5, var_11_4)
		end

		self.firstTween_ = LeanTween.value(var_11_7, var_11_8, 1):setOnUpdate(LuaHelper.FloatAction(function(arg_13_0)
			self.prograssImg_.fillAmount = arg_13_0
		end)):setOnComplete(LuaHelper.VoidAction(function()
			self:RemoveTween()

			if var_11_0 then
				self:PlayLevelAnim(var_11_1)

				self.rankTitleText_.text = var_11_5.name

				if var_11_5.rank_level > 0 then
					self.rankRomaText_.text = NumberTools.IntToRomam(var_11_5.rank_level)

					self.rankScoreController_:SetSelectedState("show")
				else
					self.rankScoreController_:SetSelectedState("hide")
				end

				self.secondTween_ = LeanTween.value(var_11_9, var_11_10, 1):setOnUpdate(LuaHelper.FloatAction(function(arg_15_0)
					self.prograssImg_.fillAmount = arg_15_0
				end)):setOnComplete(LuaHelper.VoidAction(function()
					self:RemoveTween()
				end))
			end
		end))
	end
end

function AutoChessBattleSettleView_4_8:RemoveTween()
	if self.firstTween_ then
		self.firstTween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.firstTween_.id)

		self.firstTween_ = nil
	end

	if self.secondTween_ then
		self.secondTween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.secondTween_.id)

		self.secondTween_ = nil
	end
end

function AutoChessBattleSettleView_4_8:PlayLevelAnim(arg_18_1)
	if self.isChangeRankLevel then
		if self.isChangeBigLevel then
			self.rankLevelAnim_:Play(arg_18_1 and "rankitem_up" or "rankitem_down", -1, 0)
		else
			self.rankRomaAnim_:Play("rankitem02", -1, 0)
		end
	end
end

function AutoChessBattleSettleView_4_8:OnClickBackBtn()
	AutoChessTools.SettleBattle(self.context_.gameType)
end

function AutoChessBattleSettleView_4_8:UpdateTrophyList()
	local var_20_0 = self.context_.selfPlayerData.victoryRoundCount

	if self.context_.gameStatus == AutoChessConst.GAME_STATUS.TOTAL_SETTLE_WIN then
		var_20_0 = var_20_0 + 1
	end

	self.trophyNumText_.text = var_20_0
end

function AutoChessBattleSettleView_4_8:OnExit()
	self:RemoveTween()
	AutoChessBattleSettleView_4_8.super.OnExit(self)
end

return AutoChessBattleSettleView_4_8
