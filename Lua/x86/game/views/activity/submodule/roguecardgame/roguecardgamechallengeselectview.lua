local var_0_0 = class("RogueCardGameChallengeSelectView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_JokerCard/Activity_JokerCard_ChallengeSelectUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.subtractCon_ = arg_4_0.subtractController_:GetController("gray")
	arg_4_0.addCon_ = arg_4_0.addController_:GetController("gray")
	arg_4_0.rightBtnCon_ = arg_4_0.btnController_:GetController("icon")
	arg_4_0.lockCon_ = arg_4_0.controller_:GetController("lock")
	arg_4_0.btnCon_ = arg_4_0.controller_:GetController("btn")
	arg_4_0.indexCon_ = arg_4_0.controller_:GetController("active")
	arg_4_0.stateStarCon_ = arg_4_0.starController_:GetController("statestar")
	arg_4_0.onInterruptHandler = handler(arg_4_0, arg_4_0.OnInterrupt)
	arg_4_0.rollingText_ = arg_4_0.rollingGo_:GetComponent("RollingNumber")
	arg_4_0.itemList_ = {}
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btnSubtract_, nil, function()
		if arg_5_0.diff == 1 then
			return
		end

		arg_5_0.diff = arg_5_0.diff - 1

		arg_5_0:RefreshView()
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnAdd_, nil, function()
		if arg_5_0.diff == 6 then
			return
		end

		arg_5_0.diff = arg_5_0.diff + 1

		arg_5_0:RefreshView()
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnLeft_, nil, function()
		if arg_5_0.deck == 1 then
			arg_5_0.deck = 4
		else
			arg_5_0.deck = arg_5_0.deck - 1
		end

		arg_5_0.diff = 1

		arg_5_0:RefreshView()
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnRight_, nil, function()
		if arg_5_0.deck == 4 then
			arg_5_0.deck = 1
		else
			arg_5_0.deck = arg_5_0.deck + 1
		end

		arg_5_0.diff = 1

		arg_5_0:RefreshView()
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnGo_, nil, function()
		RogueCardGameTools.SetChallengeDeckDiff(arg_5_0.deck, arg_5_0.diff)
		RogueCardGameTools.SetCurPostingId(201)

		if RogueCardGameTools.IsUnlockDeck(arg_5_0.deck) then
			RogueCardGameBridge.EnterRogueCardGame(201, arg_5_0.deck, arg_5_0.diff, false)
		elseif arg_5_0.deck == 1 and arg_5_0.diff == 1 then
			RogueCardGameBridge.EnterRogueCardGame(201, arg_5_0.deck, arg_5_0.diff, false)
		else
			ShowTips("UNLOCK_BY_COMPLETE_PRE_STAGE")
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnRank_, nil, function()
		JumpTools.OpenPageByJump("/rogueCardGameRankView")
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnContinue_, nil, function()
		RogueCardGameTools.SetCurPostingId(201)
		RogueCardGameTools.SetChallengeDeckDiff(arg_5_0.deck, arg_5_0.diff)
		RogueCardGameAction.ContinueProgressPost(201)
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnTerminate_, nil, function()
		local var_13_0 = 1

		if table.length(RogueCardGameData:GetAllData()) > 0 then
			var_13_0 = RogueCardGameData:GetAllData().cur_round
		else
			var_13_0 = RogueCardGameData:GetSaveData(201).cur_round
		end

		local var_13_1 = RogueCardStageCfg[201].round

		ShowMessageBox({
			isTop = true,
			title = GetTips("PROMPT"),
			content = string.format(GetTips("ROGUE_CARD_STOP_CHALLENGE"), var_13_0, var_13_1),
			OkCallback = function()
				RogueCardGameTools.SetChallengeDeckDiff(arg_5_0.deck, arg_5_0.diff)
				RogueCardGameAction.InterruptPost(201)
			end
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.lockBtn_, nil, function()
		if RogueCardGameTools.IsUnlockDeck(arg_5_0.deck) then
			ShowTips("ROGUE_CARD_DIFFICULTY_LOCKED")
		else
			ShowTips("ROGUE_CARD_DECK_LOCKED")
		end
	end)
end

function var_0_0.StopUpdateTimer(arg_16_0)
	if arg_16_0.updateTimer then
		arg_16_0.updateTimer:Stop()

		arg_16_0.updateTimer = nil
	end
end

function var_0_0.UpdateTimeTxt(arg_17_0)
	local var_17_0 = os.time()
	local var_17_1 = os.difftime(var_17_0, os.time(os.date("!*t", var_17_0)))
	local var_17_2 = os.date("!*t", var_17_0 + var_17_1)

	arg_17_0.dayText_.text = string.format("%s/%s", var_17_2.month, var_17_2.day)
	arg_17_0.timeText_.text = manager.time:GetTwelveHourClockTimeText()
end

function var_0_0.OnEnter(arg_18_0)
	manager.notify:RegistListener(ROGUE_CARD_GAME_INTERRUPT_SUCCESS, arg_18_0.onInterruptHandler)

	arg_18_0.challengeState = RogueCardGameData:GetChallengeState()

	if arg_18_0.challengeState == 0 then
		local var_18_0, var_18_1 = RogueCardGameTools.GetChallengeDeckDiff()

		if var_18_0 and var_18_0 > 0 and var_18_1 and var_18_1 > 0 then
			arg_18_0.deck = var_18_0
			arg_18_0.diff = var_18_1
		else
			arg_18_0.deck = RogueCardGameData:GetDeck() == 0 and 1 or RogueCardGameData:GetDeck()
			arg_18_0.diff = RogueCardGameData:GetDiff() == 0 and 1 or RogueCardGameData:GetDiff()
		end
	else
		arg_18_0.deck = RogueCardGameData:GetDeck() == 0 and 1 or RogueCardGameData:GetDeck()
		arg_18_0.diff = RogueCardGameData:GetDiff() == 0 and 1 or RogueCardGameData:GetDiff()
		arg_18_0.challengeBattleId = RogueCardGameData:GetChallengeBattleId()
	end

	RankAction.QueryActivityAllRank(ActivityConst.ACTIVITY_ROGUECARD_RANK, function()
		RankAction.QueryActivityRankWitchCallBack(ActivityConst.ACTIVITY_ROGUECARD_RANK, 0, function()
			local var_20_0 = RankData:GetActivityRank(ActivityConst.ACTIVITY_ROGUECARD_RANK)

			if var_20_0 then
				local var_20_1, var_20_2 = var_20_0:GetCurRankDes()

				arg_18_0.rankText_.text = string.format(GetTips("TEST_CHALLENGE_TIPS_7"), var_20_1)
			else
				arg_18_0.rankText_.text = ""
			end
		end)
	end)
	arg_18_0:RefreshView()
end

function var_0_0.RefreshView(arg_21_0)
	local var_21_0 = RogueCardDeckCfg[arg_21_0.deck].score_rate * RogueCardDifficultyCfg[arg_21_0.diff].score_rate / 100

	arg_21_0.rollingText_:ScrollTo(var_21_0)
	arg_21_0.indexCon_:SetSelectedIndex(arg_21_0.deck - 1)
	arg_21_0.addCon_:SetSelectedIndex(arg_21_0.diff >= 6 and 1 or 0)

	arg_21_0.levelText_.text = arg_21_0.diff

	if RogueCardGameTools.IsUnlockDeck(arg_21_0.deck) then
		arg_21_0.lockCon_:SetSelectedIndex(1)

		if RogueCardGameTools.IsUnlockDiff(arg_21_0.deck, arg_21_0.diff) then
			SetActive(arg_21_0.bottomGo_, arg_21_0.challengeState ~= 0)

			if arg_21_0.challengeState ~= 0 then
				if table.length(RogueCardGameData:GetAllData()) > 0 then
					arg_21_0.settle_data = RogueCardGameData:GetAllData()
				else
					arg_21_0.settle_data = RogueCardGameData:GetSaveData(201)
				end

				if arg_21_0.settle_data then
					SetActive(arg_21_0.bottomGo_, arg_21_0.settle_data.deck_id == arg_21_0.deck)

					local var_21_1 = arg_21_0.settle_data.cur_round or 1
					local var_21_2 = ""

					if var_21_1 <= 6 then
						var_21_2 = var_21_1 .. "/" .. 6
					else
						var_21_2 = var_21_1
					end

					arg_21_0.bottemText_.text = string.format(GetTips("ROGUE_CARD_PROGRESS"), var_21_2, GetI18NText(RogueCardStageCfg[201].name))
				else
					SetActive(arg_21_0.bottomGo_, false)
				end
			end

			arg_21_0.stateStarCon_:SetSelectedIndex(0)
		else
			if arg_21_0.diff > 1 then
				arg_21_0.bottemText_.text = string.format(GetTips("ROGUE_CARD_DIFFICULTY_LOCKED_DESC"), arg_21_0.diff - 1)

				SetActive(arg_21_0.bottomGo_, true)
			else
				SetActive(arg_21_0.bottomGo_, false)
			end

			arg_21_0.stateStarCon_:SetSelectedIndex(1)
		end
	else
		SetActive(arg_21_0.bottomGo_, false)
		arg_21_0.lockCon_:SetSelectedIndex(0)
		arg_21_0.stateStarCon_:SetSelectedIndex(1)

		local var_21_3 = RogueCardDeckCfg[arg_21_0.deck]
		local var_21_4 = ConditionCfg[var_21_3.condition]

		arg_21_0.lockTips_.text = GetI18NText(var_21_4.desc)
	end

	if arg_21_0.deck == RogueCardGameData:GetDeck() and arg_21_0.diff == RogueCardGameData:GetDiff() then
		arg_21_0.btnCon_:SetSelectedIndex(1)
	else
		arg_21_0.btnCon_:SetSelectedIndex(0)
	end

	arg_21_0.cardName_.text = GetI18NText(RogueCardDeckCfg[arg_21_0.deck].name)
	arg_21_0.cardDesc_.text = GetI18NText(RogueCardDeckCfg[arg_21_0.deck].desc)
	arg_21_0.cardIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/itembg/" .. RogueCardDeckCfg[arg_21_0.deck].pic)

	arg_21_0:RefreshDesc()
	arg_21_0.subtractCon_:SetSelectedIndex(arg_21_0.diff == 1 and 1 or 0)
	arg_21_0.btnCon_:SetSelectedIndex(RogueCardGameData:GetChallengeState() == 1 and 1 or 0)
	SetActive(arg_21_0.btnSubtract_.gameObject, RogueCardGameData:GetChallengeState() == 0)
	SetActive(arg_21_0.btnAdd_.gameObject, RogueCardGameData:GetChallengeState() == 0)
	SetActive(arg_21_0.btnLeft_.gameObject, RogueCardGameData:GetChallengeState() == 0)
	SetActive(arg_21_0.btnRight_.gameObject, RogueCardGameData:GetChallengeState() == 0)
	SetActive(arg_21_0.ndorderGo_.gameObject, RogueCardGameData:GetChallengeState() == 0)
end

function var_0_0.RefreshDesc(arg_22_0)
	for iter_22_0 = 1, 6 do
		if not arg_22_0.itemList_[iter_22_0] then
			local var_22_0 = Object.Instantiate(arg_22_0.descItem_, arg_22_0.descTrs_)

			arg_22_0.itemList_[iter_22_0] = RogueCardGameChallengeDescItem.New(var_22_0)
		end

		arg_22_0.itemList_[iter_22_0]:Show(true)
		arg_22_0.itemList_[iter_22_0]:RefreshData(arg_22_0.deck, iter_22_0)
	end

	for iter_22_1 = arg_22_0.diff + 1, #arg_22_0.itemList_ do
		arg_22_0.itemList_[iter_22_1]:Show(false)
	end
end

function var_0_0.OnInterrupt(arg_23_0)
	arg_23_0:RefreshView()
	SetActive(arg_23_0.bottomGo_, false)
end

function var_0_0.OnTop(arg_24_0)
	arg_24_0:UpdateTimeTxt()
	arg_24_0:StopUpdateTimer()

	arg_24_0.updateTimer = Timer.New(function()
		arg_24_0:UpdateTimeTxt()
	end, 1, -1)

	arg_24_0.updateTimer:Start()
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

function var_0_0.OnExit(arg_27_0)
	manager.notify:RemoveListener(ROGUE_CARD_GAME_INTERRUPT_SUCCESS, arg_27_0.onInterruptHandler)
	arg_27_0:StopUpdateTimer()
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_28_0)
	if arg_28_0.itemList_ then
		for iter_28_0, iter_28_1 in ipairs(arg_28_0.itemList_) do
			iter_28_1:Dispose()
		end

		arg_28_0.itemList_ = nil
	end

	var_0_0.super.Dispose(arg_28_0)
end

return var_0_0
