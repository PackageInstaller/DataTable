local AutoChessRoundSettleView_4_8 = class("AutoChessRoundSettleView_4_8", ReduxView)

function AutoChessRoundSettleView_4_8:UIName()
	return "Widget/System/Activity_AutoChess_Battle/Activity_AutoChess_PVP_POPUI_EndTurn"
end

function AutoChessRoundSettleView_4_8:UIParent()
	return manager.ui.uiPop.transform
end

function AutoChessRoundSettleView_4_8:Init()
	self:InitUI()

	self.context_ = {
		gameType = AutoChessConst.GAME_TYPE.PVE
	}
	self.clickChessHandler_ = handler(self, self.OnClickChess)
end

function AutoChessRoundSettleView_4_8:InitUI()
	self:BindCfgUI()
	self:InitHandler()
	self:InitController()
	self:InitHpList()
	self:AddUIListener()

	self.playerList_ = LuaList.New(handler(self, self.IndexItem), self.playerListGo_, AutoChessScoreBoardPopItemView)
	self.autoChessCountDownView_ = AutoChessCountDownView.New(self.timerGo_)
	self.tipsPanelView_ = AutoChessTipsPanelView.New(self.tipsPanelGo_)
	self.startPos_ = 104
	self.itemHeight_ = 186
end

function AutoChessRoundSettleView_4_8:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.playerDataList_[arg_5_1], self.scrollView_, true)
end

function AutoChessRoundSettleView_4_8:AddUIListener()
	self:AddBtnListener(self.nextBtn_, nil, self.backBtnHandler_)
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:OnCloseTips()
	end)
	self.scrollView_.onValueChanged:AddListener(function()
		self:OnCloseTips()
	end)
end

function AutoChessRoundSettleView_4_8:InitHandler()
	self.backBtnHandler_ = handler(self, self.OnClickBackBtn)
end

function AutoChessRoundSettleView_4_8:InitController()
	self.battleResultController_ = self.controllerEx_:GetController("result")
end

function AutoChessRoundSettleView_4_8:InitHpList()
	self.hpItemList_ = {}

	for iter_11_0 = 2, self.hpContainTrans_.childCount do
		table.insert(self.hpItemList_, (AutoChessSettleHpItemView.New(self.hpContainTrans_:GetChild(iter_11_0 - 1).gameObject)))
	end
end

function AutoChessRoundSettleView_4_8:Dispose()
	for iter_12_0, iter_12_1 in pairs(self.hpItemList_) do
		iter_12_1:Dispose()
	end

	self.hpItemList_ = nil

	if self.autoChessCountDownView_ then
		self.autoChessCountDownView_:Dispose()
	end

	if self.tipsPanelView_ then
		self.tipsPanelView_:Dispose()
	end

	if self.playerList_ then
		self.playerList_:Dispose()
	end

	self.context_ = nil

	AutoChessRoundSettleView_4_8.super.Dispose(self)
end

function AutoChessRoundSettleView_4_8:OnEnter()
	self:UpdateContext()
	self:RefreshBg()
	self:UpdateBattleResult()
	self:UpdatePlayerList()
	self:UpdateTrophy()
	self:UpdateHpList()

	if self.context_.isLastRound then
		SetActive(self.timerGo_, false)
	else
		SetActive(self.timerGo_, true)
		self.autoChessCountDownView_:UpdateCountDownTime()
	end

	self:RegistEventListener("AUTO_CHESS_SCORE_BOARD_CHESS_CLICK", self.clickChessHandler_)
end

function AutoChessRoundSettleView_4_8:OnExit()
	AnimatorTools.Stop()

	for iter_14_0, iter_14_1 in pairs(self.hpItemList_) do
		iter_14_1:OnExit()
	end

	self:OnCloseTips()

	self.isClickBack_ = false
end

function AutoChessRoundSettleView_4_8:UpdateContext()
	self.context_.gameType = self.params_.gameType
	self.context_.prepareData = AutoChessData:GetPrepareData(self.context_.gameType)
	self.context_.battleData = AutoChessData:GetBattleData(self.context_.gameType)
	self.context_.selfPlayerData = self.context_.battleData.selfPlayerData

	local var_15_0 = AutoChessData:GetGameStatus(self.context_.gameType)

	self.context_.isLastRound = var_15_0 == AutoChessConst.GAME_STATUS.TOTAL_SETTLE_WIN or var_15_0 == AutoChessConst.GAME_STATUS.TOTAL_SETTLE_LOSE

	SetActive(self.exitAnim_.gameObject, false)
end

function AutoChessRoundSettleView_4_8:RefreshBg()
	local var_16_0, var_16_1, var_16_2 = AutoChessTools.GetRandomBgPath()

	self.imgBg_.sprite = pureGetSpriteWithoutAtlas(var_16_0)
end

function AutoChessRoundSettleView_4_8:UpdateBattleResult()
	if self.context_.battleData.result == AutoChessConst.BATTLE_ROUND_RESULT.WIN then
		self.battleResultController_:SetSelectedState("win")
		manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_usually_win01", "")
	elseif self.context_.battleData.result == AutoChessConst.BATTLE_ROUND_RESULT.LOSE then
		self.battleResultController_:SetSelectedState("lose")
		manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_usually_fail01", "")
	elseif self.context_.battleData.result == AutoChessConst.BATTLE_ROUND_RESULT.DRAW then
		self.battleResultController_:SetSelectedState("draw")
		manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_usually_flat01", "")
	end
end

function AutoChessRoundSettleView_4_8:UpdatePlayerList()
	self.playerDataList_ = AutoChessData:GetRoundSettlePlayerDataList()

	self.playerList_:StartScroll(#self.playerDataList_)

	local var_18_0 = 1

	for iter_18_0, iter_18_1 in ipairs(self.playerDataList_) do
		if iter_18_1.isSelf then
			var_18_0 = iter_18_0

			break
		end
	end

	if var_18_0 >= 6 then
		self.playerList_:SetScrolledPosition(Vector2.New(0, (self.startPos_ + self.itemHeight_ * (#self.playerDataList_ - 6) - (self.startPos_ + self.itemHeight_ * (var_18_0 - 6))) / (self.startPos_ + self.itemHeight_ * (#self.playerDataList_ - 6))))
	end
end

function AutoChessRoundSettleView_4_8:UpdateTrophy()
	self.nowScoreText_.text = self.context_.selfPlayerData.victoryRoundCount
end

function AutoChessRoundSettleView_4_8:UpdateHpList()
	local var_20_0 = GameSetting.auto_chess_lose_limit.value[1]

	for iter_20_0, iter_20_1 in ipairs(self.hpItemList_) do
		if iter_20_0 < self.context_.selfPlayerData.hp then
			iter_20_1:SetStatus(AutoChessConst.HP_STATUS.NORMAL)
		elseif iter_20_0 == self.context_.selfPlayerData.hp then
			if self.context_.battleData.result == AutoChessConst.BATTLE_ROUND_RESULT.LOSE then
				iter_20_1:SetStatus(AutoChessConst.HP_STATUS.HURTING, true)
			else
				iter_20_1:SetStatus(AutoChessConst.HP_STATUS.NORMAL)
			end
		else
			iter_20_1:SetStatus(AutoChessConst.HP_STATUS.HURTED)
		end

		SetActive(iter_20_1.gameObject_, iter_20_0 <= var_20_0)
	end
end

function AutoChessRoundSettleView_4_8:OnClickBackBtn()
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

function AutoChessRoundSettleView_4_8:OnClickChess(arg_23_1, arg_23_2)
	self.isShowTips_ = true

	SetActive(self.maskBtn_.gameObject, self.isShowTips_)
	self.tipsPanelView_:SetActive(self.isShowTips_)
	self.tipsPanelView_:SetData(arg_23_1)
	self.tipsPanelView_:SetGoldState(false)
	self.tipsPanelView_:SetPos((arg_23_2:GetPos()))
	AutoChessTools.ScreenAdapter(arg_23_2, self.tipsPanelView_)
end

function AutoChessRoundSettleView_4_8:OnCloseTips()
	if not self.isShowTips_ then
		return
	end

	self.isShowTips_ = false

	SetActive(self.maskBtn_.gameObject, false)
	self.tipsPanelView_:SetActive(false)
end

function AutoChessRoundSettleView_4_8:PlayEnterAnim()
	if AutoChessTools.GetIsPVPGame(self.context_.gameType) then
		self.enterAnim_:Play("U_Activity_OsirisHorus_POPUI_EndTurn_pvp_cx", -1, 0)
		self.enterAnim_:Update(0)
	else
		self.enterAnim_:Play("U_Activity_OsirisHorus_POPUI_EndTurn_cx", -1, 0)
		self.enterAnim_:Update(0)
	end
end

return AutoChessRoundSettleView_4_8
