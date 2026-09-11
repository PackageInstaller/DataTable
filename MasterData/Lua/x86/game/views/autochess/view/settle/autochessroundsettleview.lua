local AutoChessRoundSettleView = class("AutoChessRoundSettleView", ReduxView)

function AutoChessRoundSettleView:UIName()
	return "Widget/System/Activity_OsirisHorus/Activity_OsirisHorus_AutoChess/Activity_OsirisHorus_POPUI_EndTurn"
end

function AutoChessRoundSettleView:UIParent()
	return manager.ui.uiPop.transform
end

function AutoChessRoundSettleView:Init()
	self:InitUI()

	self.chessItemList_ = {}
	self.opponentFormationView_ = AutoChessFormationItemView.New(self.opFormationGo_)
	self.context_ = {
		gameType = AutoChessConst.GAME_TYPE.PVE
	}
end

function AutoChessRoundSettleView:InitUI()
	self:BindCfgUI()
	self:InitHandler()
	self:AddUIListener()
	self:InitController()
	self:InitTrophyList()
	self:InitHpList()
	self:InitLabel()
end

function AutoChessRoundSettleView:InitHandler()
	self.backBtnHandler_ = handler(self, self.OnClickBackBtn)
	self.restartBtnHandler_ = handler(self, self.OnClickRestartBtn)
end

function AutoChessRoundSettleView:AddUIListener()
	self:AddBtnListener(self.backBtn_, nil, function()
		if self.isPveRestart_ or AutoChessTools.GetIsPVPGame(self.context_.gameType) then
			return
		end

		self.backBtnHandler_()
	end)
	self:AddBtnListener(self.nextBtn_, nil, self.backBtnHandler_)
	self:AddBtnListener(self.continueBtn_, nil, self.backBtnHandler_)
	self:AddBtnListener(self.restartBtn_, nil, self.restartBtnHandler_)
end

function AutoChessRoundSettleView:InitController()
	self.gameTypeController_ = self.controllerEx_:GetController("gameType")
	self.battleResultController_ = self.controllerEx_:GetController("result")
	self.restartController_ = self.controllerEx_:GetController("restart")
end

function AutoChessRoundSettleView:InitTrophyList()
	self.trophyItemList_ = {}

	for iter_9_0 = 2, self.trophyContainTrans_.childCount do
		table.insert(self.trophyItemList_, (AutoChessSettleTrophyItemView.New(self.trophyContainTrans_:GetChild(iter_9_0 - 1).gameObject)))
	end
end

function AutoChessRoundSettleView:InitHpList()
	self.hpItemList_ = {}

	for iter_10_0 = 2, self.hpContainTrans_.childCount do
		table.insert(self.hpItemList_, (AutoChessSettleHpItemView.New(self.hpContainTrans_:GetChild(iter_10_0 - 1).gameObject)))
	end
end

function AutoChessRoundSettleView:InitLabel()
	self.labelView_ = AutoChessLabelItemView.New(self.labelGo_)
end

function AutoChessRoundSettleView:Dispose()
	for iter_12_0, iter_12_1 in pairs(self.trophyItemList_) do
		iter_12_1:Dispose()
	end

	self.trophyItemList_ = nil

	for iter_12_2, iter_12_3 in pairs(self.hpItemList_) do
		iter_12_3:Dispose()
	end

	self.hpItemList_ = nil

	for iter_12_4, iter_12_5 in pairs(self.chessItemList_) do
		iter_12_5:Dispose()
	end

	self.chessItemList_ = nil
	self.context_ = nil

	if self.labelView_ then
		self.labelView_:Dispose()
	end

	AutoChessRoundSettleView.super.Dispose(self)
end

function AutoChessRoundSettleView:OnEnter()
	self:UpdateContext()
	self:UpdateGameType()
	self:UpdateBattleResult()
	self:UpdateTrophyList()
	self:UpdateHpList()

	if AutoChessTools.GetIsPVPGame(self.context_.gameType) then
		self:UpdateOpponentInfo()
		self:UpdateLabel()
	end

	self:PlayEnterAnim()
end

function AutoChessRoundSettleView:OnExit()
	AnimatorTools.Stop()

	for iter_14_0, iter_14_1 in pairs(self.hpItemList_) do
		iter_14_1:OnExit()
	end

	self.isPveRestart_ = false
	self.isClickBack_ = false

	self.labelView_:OnExit()
end

function AutoChessRoundSettleView:UpdateContext()
	self.context_.gameType = self.params_.gameType
	self.context_.prepareData = AutoChessData:GetPrepareData(self.context_.gameType)
	self.context_.battleData = AutoChessData:GetBattleData(self.context_.gameType)
	self.context_.stageId = AutoChessTools.GetCurStageId(self.context_.gameType)
	self.context_.stageCfg = AutoChessStageCfg[self.context_.stageId]
	self.context_.selfPlayerData = self.context_.battleData.selfPlayerData
	self.context_.opponentPlayerData = self.context_.battleData.oppenentPlayerData

	local var_15_0 = AutoChessData:GetGameStatus(self.context_.gameType)

	self.context_.isLastRound = var_15_0 == AutoChessConst.GAME_STATUS.TOTAL_SETTLE_WIN or var_15_0 == AutoChessConst.GAME_STATUS.TOTAL_SETTLE_LOSE

	SetActive(self.exitAnim_.gameObject, false)
end

function AutoChessRoundSettleView:UpdateGameType()
	self.gameTypeController_:SetSelectedIndex(self.context_.gameType)
end

function AutoChessRoundSettleView:UpdateBattleResult()
	self.restartController_:SetSelectedState("hide")

	if self.context_.battleData.result == AutoChessConst.BATTLE_ROUND_RESULT.WIN then
		self.battleResultController_:SetSelectedState("win")
		manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_usually_win01", "")
	elseif self.context_.battleData.result == AutoChessConst.BATTLE_ROUND_RESULT.LOSE then
		self.battleResultController_:SetSelectedState("lose")

		self.isPveRestart_ = self.context_.isLastRound and self.context_.prepareData:GetPveRestartTimes() < GameSetting.auto_chess_pve_restart_times.value[1] and self.context_.gameType == AutoChessConst.GAME_TYPE.PVE

		if self.isPveRestart_ then
			self.restartController_:SetSelectedState("show")

			self.restartText_.text = GetTips("AUTO_CHESS_REVERSE_TIPS")
			self.restartBtnText_.text = GetTips("AUTO_CHESS_ENDING_REVERSE")
			self.continueBtnText_.text = GetTips("AUTO_CHESS_ROUND_CONTINUE")
		end

		manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_usually_fail01", "")
	elseif self.context_.battleData.result == AutoChessConst.BATTLE_ROUND_RESULT.DRAW then
		self.battleResultController_:SetSelectedState("draw")
		manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_usually_flat01", "")
	end

	self:RefreshBg()
end

function AutoChessRoundSettleView:RefreshBg()
	local var_18_0, var_18_1, var_18_2 = AutoChessTools.GetStagBgPath((AutoChessTools.GetCurStageId(self.gameType_)))

	self.imgBg_.sprite = pureGetSpriteWithoutAtlas(var_18_0)
end

function AutoChessRoundSettleView:UpdateTrophyList()
	local var_19_0 = self.context_.selfPlayerData.victoryRoundCount
	local var_19_1 = self.context_.battleData.result
	local var_19_2 = #self.trophyItemList_

	var_19_2 = self.context_.gameType == AutoChessConst.GAME_TYPE.PVE and self.context_.stageCfg.win_num or GameSetting.auto_chess_win_limit.value[1]

	for iter_19_0, iter_19_1 in ipairs(self.trophyItemList_) do
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

function AutoChessRoundSettleView:UpdateHpList()
	local var_20_0 = self.context_.selfPlayerData.hp
	local var_20_1 = self.context_.battleData.result
	local var_20_2 = #self.hpItemList_

	var_20_2 = self.context_.gameType == AutoChessConst.GAME_TYPE.PVE and self.context_.stageCfg.defeat_num or GameSetting.auto_chess_lose_limit.value[1]

	for iter_20_0, iter_20_1 in ipairs(self.hpItemList_) do
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

function AutoChessRoundSettleView:UpdateLabel()
	self.labelView_:RefreshLabelData(true, self.context_.opponentPlayerData)
end

function AutoChessRoundSettleView:UpdateOpponentInfo()
	self:UpdateOpponentChessList()
	self:UpdateOpponentPlayerInfo()

	self.nextBtnText_.text = self.context_.isLastRound and GetTips("AUTO_CHESS_ROUND_CONTINUE") or GetTips("AUTO_CHESS_NEXT_ROUND")
end

function AutoChessRoundSettleView:UpdateOpponentChessList()
	for iter_23_0, iter_23_1 in pairs(self.chessItemList_) do
		iter_23_1:SetActive(false)
	end

	self.opponentFormationView_:SetPlayerType(AutoChessConst.PLAYER_TYPE.OPPONENT)

	for iter_23_2, iter_23_3 in pairs(self.context_.opponentPlayerData.chessDataDicByUniqueId) do
		self.chessItemList_[iter_23_3.index] = self.chessItemList_[iter_23_3.index] or AutoChessTeamItem.New((Object.Instantiate(self.chessItemGo_, self.chessItemGo_.transform.parent)))

		local var_23_0 = self.chessItemList_[iter_23_3.index]

		self.chessItemList_[iter_23_3.index]:SetActive(true)
		var_23_0:SetParent(self.opponentFormationView_:GetChessPanelTrans())
		var_23_0:SetLocalScale(Vector3.one)
		var_23_0:SetLocalPos(self.opponentFormationView_:GetChessPos(iter_23_3.index))
		var_23_0:SetPlayerType(AutoChessConst.PLAYER_TYPE.OPPONENT)
		var_23_0:SetData(iter_23_3)
	end
end

function AutoChessRoundSettleView:UpdateOpponentPlayerInfo()
	self.enenyIcon_.sprite = getSpriteWithoutAtlas("TextureConfig/Character/LittleIcon/" .. ItemCfg[self.context_.opponentPlayerData.icon].icon)
	self.enenyName_.text = self.context_.opponentPlayerData.nick
end

function AutoChessRoundSettleView:OnClickBackBtn()
	if self.isClickBack_ then
		return
	end

	self.isClickBack_ = true

	if self.context_.isLastRound then
		JumpTools.Back()
		AutoChessTools.GoToGameSettleView(self.context_.gameType)
	else
		SetActive(self.exitAnim_.gameObject, true)
		AnimatorTools.Stop()
		AnimatorTools.PlayAnimationWithCallback(self.exitAnim_, "UI_Activity_OsirisHorus_CutScenesPopUI_cx", function()
			AutoChessTools.ResetPrepareState()
			AutoChessTools.SettleBattle(self.context_.gameType, true)
		end, -1, 0)
		self.exitAnim_:Update(0)
	end
end

function AutoChessRoundSettleView:OnClickRestartBtn()
	if self.context_.gameType == AutoChessConst.GAME_TYPE.PVE then
		if self.context_.stageCfg.post_story and self.context_.stageCfg.post_story ~= 0 and self.context_.gameStatus == AutoChessConst.GAME_STATUS.TOTAL_SETTLE_WIN then
			manager.story:StartStoryById(self.context_.stageCfg.post_story, function(arg_28_0)
				AutoChessTools.StartNewGame(self.context_.gameType, self.context_.stageId)
			end)
		else
			AutoChessTools.StartNewGame(self.context_.gameType, self.context_.stageId)
		end
	else
		AutoChessTools.StartNewGame(self.context_.gameType, 0)
	end
end

function AutoChessRoundSettleView:PlayEnterAnim()
	if AutoChessTools.GetIsPVPGame(self.context_.gameType) then
		self.enterAnim_:Play("U_Activity_OsirisHorus_POPUI_EndTurn_pvp_cx", -1, 0)
		self.enterAnim_:Update(0)
	else
		self.enterAnim_:Play("U_Activity_OsirisHorus_POPUI_EndTurn_cx", -1, 0)
		self.enterAnim_:Update(0)
	end
end

return AutoChessRoundSettleView
