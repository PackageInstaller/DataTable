local RogueCardGameView = class("RogueCardGameView", ReduxView)

function RogueCardGameView:UIName()
	return "Widget/System/Activity_JokerCard/Gameplay/Activity_JokerCard_PlayUI"
end

function RogueCardGameView:UIParent()
	return manager.ui.uiMain.transform
end

function RogueCardGameView:Init()
	self:InitUI()
	self:AddUIListener()
end

function RogueCardGameView:InitUI()
	self:BindCfgUI()

	self.onCheckTeamMessageHandler = handler(self, self.OnCheckTeamMessage)
	self.onCheckFinishMessageHandler = handler(self, self.OnCheckFinishMessage)
	self.onSettleHandler = handler(self, self.OnSettle)
	self.messageTimer_ = nil
end

function RogueCardGameView:AddUIListener()
	self:AddBtnListener(self.battleInfoBtn_, nil, function()
		local var_6_0, var_6_1 = manager.guide:IsPlaying()

		if var_6_0 and var_6_1 == 241 then
			RogueCard.RogueCardGameMain.Instance:HideTips()
			JumpTools.OpenPageByJump("rogueCardGameBattleInfoView")
		end
	end)
	self.guide_event_deck:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_7_0, arg_7_1)
		local var_7_0, var_7_1 = manager.guide:IsPlaying()

		if var_7_0 and var_7_1 == 241 then
			RogueCardGameBridge.OpenDeckInfo()
		end
	end))
end

function RogueCardGameView:OnEnter()
	manager.notify:RegistListener(ROGUE_CARD_GAME_CHECK_TEAM_MESSAGE, self.onCheckTeamMessageHandler)
	manager.notify:RegistListener(ROGUE_CARD_GAME_FINISH_MESSAGE, self.onCheckFinishMessageHandler)
	manager.notify:RegistListener(ROGUE_CARD_GAME_SETTLE_MESSAGE, self.onSettleHandler)
end

function RogueCardGameView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if RogueCard.RogueCardGameMain.Instance and not RogueCard.RogueCardGameMain.CheckDisableInput() then
			RogueCard.RogueCardGameMain.Instance:HideTips()
			JumpTools.OpenPageByJump("rogueCardGameTwicePopView")
		end
	end)
	self:UpdateTimeTxt()
	self:StopTimer()

	self.timer = Timer.New(function()
		self:UpdateTimeTxt()
	end, 1, -1)

	self.timer:Start()
end

function RogueCardGameView:UpdateTimeTxt()
	local var_12_0 = os.time()
	local var_12_1 = os.date("!*t", var_12_0 + os.difftime(var_12_0, os.time(os.date("!*t", var_12_0))))

	self.dayText_.text = string.format("%s/%s", var_12_1.month, var_12_1.day)
	self.timeText_.text = manager.time:GetTwelveHourClockTimeText()
end

function RogueCardGameView:OnCheckTeamMessage(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	for iter_13_0, iter_13_1 in ipairs(RogueCardMessageCfg.all) do
		local var_13_0 = RogueCardMessageCfg[iter_13_1]

		if RogueCardMessageCfg[iter_13_1].stage_id == arg_13_1 and var_13_0.stage_type == arg_13_3 and var_13_0.round == arg_13_2 and var_13_0.condition == arg_13_4 then
			self:StopMessageTimer()
			SetActive(self.messageGo_, true)
			SetActive(self.messageRoleGo_, true)
			SetActive(self.messageDeckGo_, false)
			SetActive(self.messageDiffGo_, false)
			self.messageAni_:Play("UI_Com_JokerCard_InformTips_cx", -1, 0)

			local var_13_1 = OathCollectionContentData:GetOathCustomNickName(var_13_0.hero)

			if var_13_1 == nil or var_13_1 == "" then
				var_13_1 = var_13_0.name
			end

			self.messageNameText_.text = var_13_1
			self.messageDescText_.text = var_13_0.word
			self.messageHeadImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/avatar_s/rogue_card_" .. var_13_0.hero)
			self.messageTimer_ = Timer.New(function()
				self.messageAni_:Play("UI_Com_JokerCard_InformTips_xs", -1, 0)
			end, var_13_0.closetime, 1)

			self.messageTimer_:Start()

			break
		end
	end
end

function RogueCardGameView:OnCheckFinishMessage(arg_15_1, arg_15_2, arg_15_3)
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

	self:StopMessageTimer()
	SetActive(self.messageGo_, true)
	SetActive(self.messageRoleGo_, false)
	SetActive(self.messageDeckGo_, false)
	SetActive(self.messageDiffGo_, false)

	if var_15_0 then
		SetActive(self.messageDiffGo_, true)

		self.messageDiffText_.text = string.format(GetTips("ROGUE_CARD_DIFFICULTY_UNLOCKED"), RogueCardDeckCfg[arg_15_2].name, var_15_1)
	end

	if var_15_2 then
		SetActive(self.messageDeckGo_, true)

		self.messageDeckText_.text = string.format(GetTips("ROGUE_CARD_DECK_UNLOCKED"), RogueCardDeckCfg[var_15_3].name)
		self.messageDeckImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/itembg/rogue_card_back_" .. var_15_3)
	end

	self.messageAni_:Play("UI_Com_JokerCard_InformTips_cx", -1, 0)

	self.messageTimer_ = Timer.New(function()
		self.messageAni_:Play("UI_Com_JokerCard_InformTips_xs", -1, 0)
	end, 3, 1)

	self.messageTimer_:Start()
end

function RogueCardGameView:OnSettle(arg_17_1)
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

function RogueCardGameView:StopTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end
end

function RogueCardGameView:Cacheable()
	return false
end

function RogueCardGameView:StopMessageTimer()
	SetActive(self.messageGo_, false)

	if self.messageTimer_ then
		self.messageTimer_:Stop()

		self.messageTimer_ = nil
	end
end

function RogueCardGameView:OnExit()
	manager.notify:RemoveListener(ROGUE_CARD_GAME_CHECK_TEAM_MESSAGE, self.onCheckTeamMessageHandler)
	manager.notify:RemoveListener(ROGUE_CARD_GAME_FINISH_MESSAGE, self.onCheckFinishMessageHandler)
	manager.notify:RemoveListener(ROGUE_CARD_GAME_SETTLE_MESSAGE, self.onSettleHandler)
	manager.windowBar:HideBar()
	self:StopTimer()
	self:StopMessageTimer()
end

function RogueCardGameView:Dispose()
	manager.notify:RemoveListener(ROGUE_CARD_GAME_CHECK_TEAM_MESSAGE, self.onCheckTeamMessageHandler)
	manager.notify:RemoveListener(ROGUE_CARD_GAME_FINISH_MESSAGE, self.onCheckFinishMessageHandler)
	manager.notify:RemoveListener(ROGUE_CARD_GAME_SETTLE_MESSAGE, self.onSettleHandler)
	RogueCardGameView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return RogueCardGameView
