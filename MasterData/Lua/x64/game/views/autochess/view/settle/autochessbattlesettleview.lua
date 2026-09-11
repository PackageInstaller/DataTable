local AutoChessBattleSettleView = class("AutoChessBattleSettleView", ReduxView)

function AutoChessBattleSettleView:UIName()
	return "Widget/System/Activity_OsirisHorus/Activity_OsirisHorus_AutoChess/Activity_OsirisHorus_TotalSettle"
end

function AutoChessBattleSettleView:UIParent()
	return manager.ui.uiPop.transform
end

function AutoChessBattleSettleView:Init()
	self:InitUI()

	self.trophyItemList_ = {}
	self.chessItemList_ = {}
	self.scoreDetailItemList_ = {}
	self.selfFormationView_ = AutoChessFormationItemView.New(self.selfFormationGo_)
	self.context_ = {
		gameType = AutoChessConst.GAME_TYPE.PVP,
		gameStatus = AutoChessConst.GAME_STATUS.TOTAL_SETTLE
	}
end

function AutoChessBattleSettleView:InitUI()
	self:BindCfgUI()
	self:InitHandler()
	self:AddUIListener()
	self:InitController()
end

function AutoChessBattleSettleView:InitHandler()
	self.backBtnHandler_ = handler(self, self.OnClickBackBtn)
end

function AutoChessBattleSettleView:AddUIListener()
	self:AddBtnListener(self.comfirmBtn_, nil, self.backBtnHandler_)
	self:AddBtnListener(self.shareBtn_, nil, function()
		manager.share:Share(function()
			self.shareController_:SetSelectedState("true")
		end, function()
			self.shareController_:SetSelectedState("false")
		end, function()
			return
		end, nil, {
			cardShowUID = true,
			cardShowLv = true,
			logoPos = 2,
			cardPos = 1,
			cardShow = true
		})
	end)
end

function AutoChessBattleSettleView:InitController()
	self.battleResultController_ = self.controllerEx_:GetController("result")
	self.shareController_ = self.controllerEx_:GetController("share")
	self.chessController_ = self.controllerEx_:GetController("chess")
end

function AutoChessBattleSettleView:OnExit()
	AnimatorTools.Stop()

	if self.selfPlayTimer_ then
		self.selfPlayTimer_:Stop()

		self.selfPlayTimer_ = nil
	end

	if self.tween_ then
		self.tween_:setOnComplete(nil)
		LeanTween.cancel(self.tween_.id)

		self.tween_ = nil
	end
end

function AutoChessBattleSettleView:Dispose()
	self.selfFormationView_:Dispose()

	for iter_13_0, iter_13_1 in pairs(self.chessItemList_) do
		iter_13_1:Dispose()
	end

	self.chessItemList_ = {}

	for iter_13_2, iter_13_3 in pairs(self.trophyItemList_) do
		iter_13_3:Dispose()
	end

	self.trophyItemList_ = nil

	for iter_13_4, iter_13_5 in pairs(self.scoreDetailItemList_) do
		iter_13_5:Dispose()
	end

	self.scoreDetailItemList_ = nil
	self.context_ = nil

	AutoChessBattleSettleView.super.Dispose(self)
end

function AutoChessBattleSettleView:OnEnter()
	self:UpdateContext()
	self:UpdateBattleResult()
	self:UpdateSelfChessList()
	self:UpdatePlayerInfo()
	self.chessController_:SetSelectedState("hide")
	SetActive(self.shareBtn_, OperationData:IsOperationOpen(OperationConst.SHARE_FLAG))
	AnimatorTools.PlayAnimationWithCallback(self.enterAnim_, self.enterAnimName_, function()
		self.chessController_:SetSelectedState("show")
		self:StartFormationTween()
	end, -1, 0)
	self.enterAnim_:Update(0)
end

function AutoChessBattleSettleView:UpdateContext()
	self.context_.gameType = self.params_.gameType
	self.context_.gameStatus = AutoChessData:GetGameStatus(self.context_.gameType)
	self.context_.prepareData = AutoChessData:GetPrepareData(self.context_.gameType)
	self.context_.battleData = AutoChessData:GetBattleData(self.context_.gameType)
	self.context_.stageCfg = AutoChessStageCfg[AutoChessTools.GetCurStageId(self.context_.gameType)]
	self.context_.isTeaching_ = self.context_.stageCfg and table.indexof(AutoChessConst.TEACH_STAGE, self.context_.stageCfg.id)
	self.context_.selfPlayerData = self.context_.battleData and self.context_.battleData.selfPlayerData or self.context_.prepareData.playerData
end

function AutoChessBattleSettleView:UpdateBattleResult()
	local var_17_0

	self.enterAnimName_ = "pveWin"

	if AutoChessTools.GetIsPVPGame(self.context_.gameType) then
		if self.context_.gameStatus == AutoChessConst.GAME_STATUS.TOTAL_SETTLE_WIN then
			var_17_0 = "pvpWin"
		elseif self.context_.gameStatus == AutoChessConst.GAME_STATUS.TOTAL_SETTLE_LOSE then
			var_17_0 = "pvpLose"
		end
	elseif self.context_.gameStatus == AutoChessConst.GAME_STATUS.TOTAL_SETTLE_WIN then
		var_17_0 = "pveWin"
	elseif self.context_.gameStatus == AutoChessConst.GAME_STATUS.TOTAL_SETTLE_LOSE then
		var_17_0 = "pveLose"
	end

	self.battleResultController_:SetSelectedState(var_17_0)

	self.enterAnimName_ = var_17_0
	self.reverseText_.text = GetTips("AUTO_CHESS_ENDING_REVERSE")
	self.continueText_.text = GetTips("AUTO_CHESS_ENDING_CONTINUE")
end

function AutoChessBattleSettleView:UpdateSelfChessList()
	for iter_18_0, iter_18_1 in pairs(self.chessItemList_) do
		iter_18_1:SetActive(false)
	end

	self.chessCount_ = 0

	for iter_18_2, iter_18_3 in pairs(self.context_.selfPlayerData.chessDataDicByUniqueId) do
		self.chessCount_ = self.chessCount_ + 1
		self.chessItemList_[iter_18_3.index] = self.chessItemList_[iter_18_3.index] or AutoChessTeamItem.New((Object.Instantiate(self.chessItemGo_, self.chessItemGo_.transform.parent)))

		local var_18_0 = self.chessItemList_[iter_18_3.index]

		self.chessItemList_[iter_18_3.index]:SetActive(true)
		var_18_0:SetParent(self.selfFormationView_:GetChessPanelTrans())
		var_18_0:SetLocalScale(Vector3.one)
		var_18_0:SetLocalPos(self.selfFormationView_:GetChessPos(iter_18_3.index))
		var_18_0:SetPlayerType(AutoChessConst.PLAYER_TYPE.SELF)
		var_18_0:SetData(iter_18_3)
	end
end

function AutoChessBattleSettleView:UpdatePlayerInfo()
	self:UpdateTrophyList()
	self:UpdateRound()
	self:UpdateHP()

	if AutoChessTools.GetIsPVPGame(self.context_.gameType) then
		self:UpdateScore()
	end
end

function AutoChessBattleSettleView:UpdateTrophyList()
	local var_20_0 = self.context_.selfPlayerData.victoryRoundCount

	if self.context_.gameStatus == AutoChessConst.GAME_STATUS.TOTAL_SETTLE_WIN then
		var_20_0 = var_20_0 + 1
	end

	local var_20_1 = 0

	var_20_1 = self.context_.gameType == AutoChessConst.GAME_TYPE.PVE and self.context_.stageCfg.win_num or GameSetting.auto_chess_win_limit.value[1]
	self.trophyNumText_.text = string.format("%s/%s", math.min(var_20_0, var_20_1), var_20_1)
end

function AutoChessBattleSettleView:UpdateRound()
	self.roundText_.text = self.context_.selfPlayerData.curRoundCount
end

function AutoChessBattleSettleView:UpdateHP()
	local var_22_0 = self.context_.selfPlayerData.hp

	if self.context_.gameStatus == AutoChessConst.GAME_STATUS.TOTAL_SETTLE_LOSE then
		var_22_0 = var_22_0 - 1

		manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_perfect_over", "")
	elseif self.context_.gameStatus == AutoChessConst.GAME_STATUS.TOTAL_SETTLE_WIN then
		manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_perfect_win", "")
	end

	self.hpText_.text = var_22_0
end

function AutoChessBattleSettleView:UpdateScore()
	self.scoreText_.text = self.context_.battleData.score

	self:UpdateScoreDetail()
end

function AutoChessBattleSettleView:UpdateScoreDetail()
	local var_24_0 = self:FilterScoreDetail()

	for iter_24_0 = 1, #var_24_0 do
		self.scoreDetailItemList_[iter_24_0] = self.scoreDetailItemList_[iter_24_0] or AutoChessScoreDetailItemView.New((Object.Instantiate(self.scoreDetailItemGo_, self.scoreDetailContainerTrans_)))

		self.scoreDetailItemList_[iter_24_0]:SetActive(true)
		self.scoreDetailItemList_[iter_24_0]:SetData(var_24_0[iter_24_0])
	end

	for iter_24_1 = #var_24_0 + 1, #self.scoreDetailItemList_ do
		self.scoreDetailItemList_[iter_24_1]:SetActive(false)
	end
end

function AutoChessBattleSettleView:FilterScoreDetail()
	local var_25_0 = {}

	for iter_25_0, iter_25_1 in ipairs(self.context_.battleData.scoreDetailList) do
		if iter_25_1.score > 0 then
			table.insert(var_25_0, iter_25_1)
		end
	end

	table.sort(var_25_0, function(arg_26_0, arg_26_1)
		return arg_26_0.score > arg_26_1.score
	end)

	return var_25_0
end

function AutoChessBattleSettleView:StartFormationTween()
	if self.chessCount_ > 0 then
		self.selfChessContain_.transform.anchoredPosition = Vector2.New(self.selfChessContain_.transform.anchoredPosition.x - _G.SCREEN_WIDTH / 2, 0)

		self:PlayItemEnterAnim()

		self.tween_ = LeanTween.moveLocalX(self.selfChessContain_, self.selfChessContain_.transform.anchoredPosition.x, 1.5):setOnComplete(LuaHelper.VoidAction(function()
			self:ResetItemAnim()
			SetActive(self.shareBtn_, OperationData:IsOperationOpen(OperationConst.SHARE_FLAG))
		end))
	else
		SetActive(self.shareBtn_, OperationData:IsOperationOpen(OperationConst.SHARE_FLAG))
	end
end

function AutoChessBattleSettleView:PlayItemEnterAnim()
	local var_29_0

	if self.chessItemList_ then
		var_29_0 = #self.chessItemList_ or 0
	end

	local var_29_1 = 1

	self.selfPlayTimer_ = nil
	self.selfPlayTimer_ = Timer.New(function()
		if var_29_1 <= var_29_0 and self.chessItemList_[var_29_1] then
			self.chessItemList_[var_29_1]:PlayItemAnim("ChessItem_ruchang")

			var_29_1 = var_29_1 + 1
		end
	end, 0.03, var_29_0)

	self.selfPlayTimer_:Start()
end

function AutoChessBattleSettleView:ResetItemAnim()
	for iter_31_0, iter_31_1 in pairs(self.chessItemList_) do
		if iter_31_1 then
			iter_31_1:PlayItemAnim("ChessIdleAnim")
		end
	end
end

function AutoChessBattleSettleView:OnClickBackBtn()
	if self.context_.stageCfg and self.context_.stageCfg.post_story and self.context_.stageCfg.post_story ~= 0 and (self.context_.gameStatus == AutoChessConst.GAME_STATUS.TOTAL_SETTLE_WIN or self.context_.isTeaching_) then
		AutoChessData:SetStageStoryId(self.context_.stageCfg.post_story)
	end

	AutoChessTools.SettleBattle(self.context_.gameType)
end

return AutoChessBattleSettleView
