local RogueCardGameChallengeSelectView = class("RogueCardGameChallengeSelectView", ReduxView)

function RogueCardGameChallengeSelectView:UIName()
	return "Widget/System/Activity_JokerCard/Activity_JokerCard_ChallengeSelectUI"
end

function RogueCardGameChallengeSelectView:UIParent()
	return manager.ui.uiMain.transform
end

function RogueCardGameChallengeSelectView:Init()
	self:InitUI()
	self:AddUIListener()
end

function RogueCardGameChallengeSelectView:InitUI()
	self:BindCfgUI()

	self.subtractCon_ = self.subtractController_:GetController("gray")
	self.addCon_ = self.addController_:GetController("gray")
	self.rightBtnCon_ = self.btnController_:GetController("icon")
	self.lockCon_ = self.controller_:GetController("lock")
	self.btnCon_ = self.controller_:GetController("btn")
	self.indexCon_ = self.controller_:GetController("active")
	self.stateStarCon_ = self.starController_:GetController("statestar")
	self.onInterruptHandler = handler(self, self.OnInterrupt)
	self.rollingText_ = self.rollingGo_:GetComponent("RollingNumber")
	self.itemList_ = {}
end

function RogueCardGameChallengeSelectView:AddUIListener()
	self:AddBtnListener(self.btnSubtract_, nil, function()
		if self.diff == 1 then
			return
		end

		self.diff = self.diff - 1

		self:RefreshView()
	end)
	self:AddBtnListener(self.btnAdd_, nil, function()
		if self.diff == 6 then
			return
		end

		self.diff = self.diff + 1

		self:RefreshView()
	end)
	self:AddBtnListener(self.btnLeft_, nil, function()
		self.deck = self.deck == 1 and 4 or self.deck - 1
		self.diff = 1

		self:RefreshView()
	end)
	self:AddBtnListener(self.btnRight_, nil, function()
		self.deck = self.deck == 4 and 1 or self.deck + 1
		self.diff = 1

		self:RefreshView()
	end)
	self:AddBtnListener(self.btnGo_, nil, function()
		RogueCardGameTools.SetChallengeDeckDiff(self.deck, self.diff)
		RogueCardGameTools.SetCurPostingId(201)

		if RogueCardGameTools.IsUnlockDeck(self.deck) then
			RogueCardGameBridge.EnterRogueCardGame(201, self.deck, self.diff, false)
		elseif self.deck == 1 and self.diff == 1 then
			RogueCardGameBridge.EnterRogueCardGame(201, self.deck, self.diff, false)
		else
			ShowTips("UNLOCK_BY_COMPLETE_PRE_STAGE")
		end
	end)
	self:AddBtnListener(self.btnRank_, nil, function()
		JumpTools.OpenPageByJump("/rogueCardGameRankView")
	end)
	self:AddBtnListener(self.btnContinue_, nil, function()
		RogueCardGameTools.SetCurPostingId(201)
		RogueCardGameTools.SetChallengeDeckDiff(self.deck, self.diff)
		RogueCardGameAction.ContinueProgressPost(201)
	end)
	self:AddBtnListener(self.btnTerminate_, nil, function()
		local var_13_0 = 1

		if table.length(RogueCardGameData:GetAllData()) > 0 then
			var_13_0 = RogueCardGameData:GetAllData().cur_round
		end

		local var_13_1

		do
			var_13_0 = RogueCardGameData:GetSaveData(201).cur_round
			var_13_1 = {
				isTop = true,
				title = GetTips("PROMPT")
			}
		end

		var_13_1.content = string.format(GetTips("ROGUE_CARD_STOP_CHALLENGE"), var_13_0, RogueCardStageCfg[201].round)

		function var_13_1.OkCallback()
			RogueCardGameTools.SetChallengeDeckDiff(self.deck, self.diff)
			RogueCardGameAction.InterruptPost(201)
		end

		ShowMessageBox(var_13_1)
	end)
	self:AddBtnListener(self.lockBtn_, nil, function()
		if RogueCardGameTools.IsUnlockDeck(self.deck) then
			ShowTips("ROGUE_CARD_DIFFICULTY_LOCKED")
		else
			ShowTips("ROGUE_CARD_DECK_LOCKED")
		end
	end)
end

function RogueCardGameChallengeSelectView:StopUpdateTimer()
	if self.updateTimer then
		self.updateTimer:Stop()

		self.updateTimer = nil
	end
end

function RogueCardGameChallengeSelectView:UpdateTimeTxt()
	local var_17_0 = os.time()
	local var_17_1 = os.date("!*t", var_17_0 + os.difftime(var_17_0, os.time(os.date("!*t", var_17_0))))

	self.dayText_.text = string.format("%s/%s", var_17_1.month, var_17_1.day)
	self.timeText_.text = manager.time:GetTwelveHourClockTimeText()
end

function RogueCardGameChallengeSelectView:OnEnter()
	manager.notify:RegistListener(ROGUE_CARD_GAME_INTERRUPT_SUCCESS, self.onInterruptHandler)

	self.challengeState = RogueCardGameData:GetChallengeState()

	if self.challengeState == 0 then
		local var_18_0, var_18_1 = RogueCardGameTools.GetChallengeDeckDiff()

		if var_18_0 and var_18_0 > 0 and var_18_1 and var_18_1 > 0 then
			self.deck = var_18_0
			self.diff = var_18_1
		else
			self.deck = RogueCardGameData:GetDeck() == 0 and 1 or RogueCardGameData:GetDeck()
			self.diff = RogueCardGameData:GetDiff() == 0 and 1 or RogueCardGameData:GetDiff()
		end
	else
		self.deck = RogueCardGameData:GetDeck() == 0 and 1 or RogueCardGameData:GetDeck()
		self.diff = RogueCardGameData:GetDiff() == 0 and 1 or RogueCardGameData:GetDiff()
		self.challengeBattleId = RogueCardGameData:GetChallengeBattleId()
	end

	RankAction.QueryActivityAllRank(ActivityConst.ACTIVITY_ROGUECARD_RANK, function()
		RankAction.QueryActivityRankWitchCallBack(ActivityConst.ACTIVITY_ROGUECARD_RANK, 0, function()
			local var_20_0 = RankData:GetActivityRank(ActivityConst.ACTIVITY_ROGUECARD_RANK)

			if var_20_0 then
				local var_20_1, var_20_2 = var_20_0:GetCurRankDes()

				self.rankText_.text = string.format(GetTips("TEST_CHALLENGE_TIPS_7"), var_20_1)
			else
				self.rankText_.text = ""
			end
		end)
	end)
	self:RefreshView()
end

function RogueCardGameChallengeSelectView:RefreshView()
	self.rollingText_:ScrollTo(RogueCardDeckCfg[self.deck].score_rate * RogueCardDifficultyCfg[self.diff].score_rate / 100)
	self.indexCon_:SetSelectedIndex(self.deck - 1)
	self.addCon_:SetSelectedIndex(self.diff >= 6 and 1 or 0)

	self.levelText_.text = self.diff

	if RogueCardGameTools.IsUnlockDeck(self.deck) then
		self.lockCon_:SetSelectedIndex(1)

		if RogueCardGameTools.IsUnlockDiff(self.deck, self.diff) then
			SetActive(self.bottomGo_, self.challengeState ~= 0)

			if self.challengeState ~= 0 then
				self.settle_data = table.length(RogueCardGameData:GetAllData()) > 0 and RogueCardGameData:GetAllData() or RogueCardGameData:GetSaveData(201)

				if self.settle_data then
					SetActive(self.bottomGo_, self.settle_data.deck_id == self.deck)

					local var_21_0 = self.settle_data.cur_round or 1

					self.bottemText_.text = string.format(GetTips("ROGUE_CARD_PROGRESS"), var_21_0 <= 6 and var_21_0 .. "/" .. 6 or var_21_0, GetI18NText(RogueCardStageCfg[201].name))
				else
					SetActive(self.bottomGo_, false)
				end
			end

			self.stateStarCon_:SetSelectedIndex(0)
		else
			if self.diff > 1 then
				self.bottemText_.text = string.format(GetTips("ROGUE_CARD_DIFFICULTY_LOCKED_DESC"), self.diff - 1)

				SetActive(self.bottomGo_, true)
			else
				SetActive(self.bottomGo_, false)
			end

			self.stateStarCon_:SetSelectedIndex(1)
		end
	else
		SetActive(self.bottomGo_, false)
		self.lockCon_:SetSelectedIndex(0)
		self.stateStarCon_:SetSelectedIndex(1)

		self.lockTips_.text = GetI18NText(ConditionCfg[RogueCardDeckCfg[self.deck].condition].desc)
	end

	if self.deck == RogueCardGameData:GetDeck() and self.diff == RogueCardGameData:GetDiff() then
		self.btnCon_:SetSelectedIndex(1)
	else
		self.btnCon_:SetSelectedIndex(0)
	end

	self.cardName_.text = GetI18NText(RogueCardDeckCfg[self.deck].name)
	self.cardDesc_.text = GetI18NText(RogueCardDeckCfg[self.deck].desc)
	self.cardIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/itembg/" .. RogueCardDeckCfg[self.deck].pic)

	self:RefreshDesc()
	self.subtractCon_:SetSelectedIndex(self.diff == 1 and 1 or 0)
	self.btnCon_:SetSelectedIndex(RogueCardGameData:GetChallengeState() == 1 and 1 or 0)
	SetActive(self.btnSubtract_.gameObject, RogueCardGameData:GetChallengeState() == 0)
	SetActive(self.btnAdd_.gameObject, RogueCardGameData:GetChallengeState() == 0)
	SetActive(self.btnLeft_.gameObject, RogueCardGameData:GetChallengeState() == 0)
	SetActive(self.btnRight_.gameObject, RogueCardGameData:GetChallengeState() == 0)
	SetActive(self.ndorderGo_.gameObject, RogueCardGameData:GetChallengeState() == 0)
end

function RogueCardGameChallengeSelectView:RefreshDesc()
	for iter_22_0 = 1, 6 do
		self.itemList_[iter_22_0] = self.itemList_[iter_22_0] or RogueCardGameChallengeDescItem.New((Object.Instantiate(self.descItem_, self.descTrs_)))

		self.itemList_[iter_22_0]:Show(true)
		self.itemList_[iter_22_0]:RefreshData(self.deck, iter_22_0)
	end

	for iter_22_1 = self.diff + 1, #self.itemList_ do
		self.itemList_[iter_22_1]:Show(false)
	end
end

function RogueCardGameChallengeSelectView:OnInterrupt()
	self:RefreshView()
	SetActive(self.bottomGo_, false)
end

function RogueCardGameChallengeSelectView:OnTop()
	self:UpdateTimeTxt()
	self:StopUpdateTimer()

	self.updateTimer = Timer.New(function()
		self:UpdateTimeTxt()
	end, 1, -1)

	self.updateTimer:Start()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})

	local var_24_0 = GameSetting.rogue_card_desc2.value

	manager.windowBar:RegistInfoCallBack(function()
		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = var_24_0
		})
	end)
end

function RogueCardGameChallengeSelectView:OnExit()
	manager.notify:RemoveListener(ROGUE_CARD_GAME_INTERRUPT_SUCCESS, self.onInterruptHandler)
	self:StopUpdateTimer()
	manager.windowBar:HideBar()
end

function RogueCardGameChallengeSelectView:Dispose()
	if self.itemList_ then
		for iter_28_0, iter_28_1 in ipairs(self.itemList_) do
			iter_28_1:Dispose()
		end

		self.itemList_ = nil
	end

	RogueCardGameChallengeSelectView.super.Dispose(self)
end

return RogueCardGameChallengeSelectView
