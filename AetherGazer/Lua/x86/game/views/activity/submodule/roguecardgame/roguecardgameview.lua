local var_0_0 = class("RogueCardGameView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_JokerCard/Gameplay/Activity_JokerCard_PlayUI"
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

	arg_4_0.onCheckTeamMessageHandler = handler(arg_4_0, arg_4_0.OnCheckTeamMessage)
	arg_4_0.onCheckFinishMessageHandler = handler(arg_4_0, arg_4_0.OnCheckFinishMessage)
	arg_4_0.onSettleHandler = handler(arg_4_0, arg_4_0.OnSettle)
	arg_4_0.messageTimer_ = nil
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.battleInfoBtn_, nil, function()
		local var_6_0, var_6_1 = manager.guide:IsPlaying()

		if var_6_0 and var_6_1 == 241 then
			RogueCard.RogueCardGameMain.Instance:HideTips()
			JumpTools.OpenPageByJump("rogueCardGameBattleInfoView")
		end
	end)
	arg_5_0.guide_event_deck:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_7_0, arg_7_1)
		local var_7_0, var_7_1 = manager.guide:IsPlaying()

		if var_7_0 and var_7_1 == 241 then
			RogueCardGameBridge.OpenDeckInfo()
		end
	end))
end

function var_0_0.OnEnter(arg_8_0)
	manager.notify:RegistListener(ROGUE_CARD_GAME_CHECK_TEAM_MESSAGE, arg_8_0.onCheckTeamMessageHandler)
	manager.notify:RegistListener(ROGUE_CARD_GAME_FINISH_MESSAGE, arg_8_0.onCheckFinishMessageHandler)
	manager.notify:RegistListener(ROGUE_CARD_GAME_SETTLE_MESSAGE, arg_8_0.onSettleHandler)
end

function var_0_0.OnTop(arg_9_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if RogueCard.RogueCardGameMain.Instance and not RogueCard.RogueCardGameMain.CheckDisableInput() then
			RogueCard.RogueCardGameMain.Instance:HideTips()
			JumpTools.OpenPageByJump("rogueCardGameTwicePopView")
		end
	end)
	arg_9_0:UpdateTimeTxt()
	arg_9_0:StopTimer()

	arg_9_0.timer = Timer.New(function()
		arg_9_0:UpdateTimeTxt()
	end, 1, -1)

	arg_9_0.timer:Start()
end

function var_0_0.UpdateTimeTxt(arg_12_0)
	local var_12_0 = os.time()
	local var_12_1 = os.difftime(var_12_0, os.time(os.date("!*t", var_12_0)))
	local var_12_2 = os.date("!*t", var_12_0 + var_12_1)

	arg_12_0.dayText_.text = string.format("%s/%s", var_12_2.month, var_12_2.day)
	arg_12_0.timeText_.text = manager.time:GetTwelveHourClockTimeText()
end

function var_0_0.OnCheckTeamMessage(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	for iter_13_0, iter_13_1 in ipairs(RogueCardMessageCfg.all) do
		local var_13_0 = RogueCardMessageCfg[iter_13_1]

		if var_13_0.stage_id == arg_13_1 and var_13_0.stage_type == arg_13_3 and var_13_0.round == arg_13_2 and var_13_0.condition == arg_13_4 then
			arg_13_0:StopMessageTimer()
			SetActive(arg_13_0.messageGo_, true)
			SetActive(arg_13_0.messageRoleGo_, true)
			SetActive(arg_13_0.messageDeckGo_, false)
			SetActive(arg_13_0.messageDiffGo_, false)
			arg_13_0.messageAni_:Play("UI_Com_JokerCard_InformTips_cx", -1, 0)

			local var_13_1 = OathCollectionContentData:GetOathCustomNickName(var_13_0.hero)

			if var_13_1 == nil or var_13_1 == "" then
				var_13_1 = var_13_0.name
			end

			arg_13_0.messageNameText_.text = var_13_1
			arg_13_0.messageDescText_.text = var_13_0.word
			arg_13_0.messageHeadImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/avatar_s/rogue_card_" .. var_13_0.hero)
			arg_13_0.messageTimer_ = Timer.New(function()
				arg_13_0.messageAni_:Play("UI_Com_JokerCard_InformTips_xs", -1, 0)
			end, var_13_0.closetime, 1)

			arg_13_0.messageTimer_:Start()

			break
		end
	end
end

function var_0_0.OnCheckFinishMessage(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = false
	local var_15_1 = 0
	local var_15_2 = false
	local var_15_3 = 0

	if arg_15_1 == 106 and arg_15_3 + 1 <= #RogueCardDifficultyCfg.all and RogueCardGameTools.IsUnlockDiff(arg_15_2, 1) == false then
		var_15_0 = true
		var_15_1 = 1
	end

	if arg_15_1 == 201 and arg_15_3 + 1 <= #RogueCardDifficultyCfg.all and RogueCardGameTools.IsUnlockDiff(arg_15_2, arg_15_3 + 1) == false then
		var_15_0 = true
		var_15_1 = arg_15_3 + 1
	end

	if not RogueCardGameTools.IsUnlockDeck(2) and arg_15_1 == 106 then
		var_15_2 = true
		var_15_3 = 2
	end

	if not RogueCardGameTools.IsUnlockDeck(3) and arg_15_1 == 201 and arg_15_2 == 2 and arg_15_3 >= 1 then
		var_15_2 = true
		var_15_3 = 3
	end

	if not RogueCardGameTools.IsUnlockDeck(4) and arg_15_1 == 201 and arg_15_2 == 3 and arg_15_3 >= 1 then
		var_15_2 = true
		var_15_3 = 4
	end

	if not var_15_0 and not var_15_2 then
		return
	end

	arg_15_0:StopMessageTimer()
	SetActive(arg_15_0.messageGo_, true)
	SetActive(arg_15_0.messageRoleGo_, false)
	SetActive(arg_15_0.messageDeckGo_, false)
	SetActive(arg_15_0.messageDiffGo_, false)

	if var_15_0 then
		SetActive(arg_15_0.messageDiffGo_, true)

		arg_15_0.messageDiffText_.text = string.format(GetTips("ROGUE_CARD_DIFFICULTY_UNLOCKED"), RogueCardDeckCfg[arg_15_2].name, var_15_1)
	end

	if var_15_2 then
		SetActive(arg_15_0.messageDeckGo_, true)

		arg_15_0.messageDeckText_.text = string.format(GetTips("ROGUE_CARD_DECK_UNLOCKED"), RogueCardDeckCfg[var_15_3].name)
		arg_15_0.messageDeckImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/itembg/rogue_card_back_" .. var_15_3)
	end

	arg_15_0.messageAni_:Play("UI_Com_JokerCard_InformTips_cx", -1, 0)

	arg_15_0.messageTimer_ = Timer.New(function()
		arg_15_0.messageAni_:Play("UI_Com_JokerCard_InformTips_xs", -1, 0)
	end, 3, 1)

	arg_15_0.messageTimer_:Start()
end

function var_0_0.OnSettle(arg_17_0, arg_17_1)
	if arg_17_1 then
		manager.windowBar:HideBar()
	else
		manager.windowBar:SwitchBar({
			BACK_BAR
		})
		manager.windowBar:RegistBackCallBack(function()
			if RogueCard.RogueCardGameMain.Instance and not RogueCard.RogueCardGameMain.CheckDisableInput() then
				RogueCard.RogueCardGameMain.Instance:HideTips()
				JumpTools.OpenPageByJump("rogueCardGameTwicePopView")
			end
		end)
	end
end

function var_0_0.StopTimer(arg_19_0)
	if arg_19_0.timer then
		arg_19_0.timer:Stop()

		arg_19_0.timer = nil
	end
end

function var_0_0.Cacheable(arg_20_0)
	return false
end

function var_0_0.StopMessageTimer(arg_21_0)
	SetActive(arg_21_0.messageGo_, false)

	if arg_21_0.messageTimer_ then
		arg_21_0.messageTimer_:Stop()

		arg_21_0.messageTimer_ = nil
	end
end

function var_0_0.OnExit(arg_22_0)
	manager.notify:RemoveListener(ROGUE_CARD_GAME_CHECK_TEAM_MESSAGE, arg_22_0.onCheckTeamMessageHandler)
	manager.notify:RemoveListener(ROGUE_CARD_GAME_FINISH_MESSAGE, arg_22_0.onCheckFinishMessageHandler)
	manager.notify:RemoveListener(ROGUE_CARD_GAME_SETTLE_MESSAGE, arg_22_0.onSettleHandler)
	manager.windowBar:HideBar()
	arg_22_0:StopTimer()
	arg_22_0:StopMessageTimer()
end

function var_0_0.Dispose(arg_23_0)
	manager.notify:RemoveListener(ROGUE_CARD_GAME_CHECK_TEAM_MESSAGE, arg_23_0.onCheckTeamMessageHandler)
	manager.notify:RemoveListener(ROGUE_CARD_GAME_FINISH_MESSAGE, arg_23_0.onCheckFinishMessageHandler)
	manager.notify:RemoveListener(ROGUE_CARD_GAME_SETTLE_MESSAGE, arg_23_0.onSettleHandler)
	var_0_0.super.Dispose(arg_23_0)
	Object.Destroy(arg_23_0.gameObject_)
end

return var_0_0
