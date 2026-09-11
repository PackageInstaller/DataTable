local ActivityQuizSceneMainView = class("ActivityQuizSceneMainView", ReduxView)
local QuizFunction = import("game.quiz.QuizFunction")

function ActivityQuizSceneMainView:UIName()
	return ActivityQuizTools.GetActivitySceneUIName(self.params_.activityId)
end

function ActivityQuizSceneMainView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityQuizSceneMainView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityQuizSceneMainView:InitUI()
	self:BindCfgUI()

	self.stateCon_ = ControllerUtil.GetController(self.transform_, "state")
	self.rankIndexCon_ = ControllerUtil.GetController(self.transform_, "rank")
	self.rankTypeCon_ = ControllerUtil.GetController(self.transform_, "rankType")
	self.quizChoiceCon_ = ControllerUtil.GetController(self.quizInfoRect_, "choicebg")
	self.quizResultCon_ = ControllerUtil.GetController(self.quizInfoRect_, "result")
	self.quizStateCon_ = ControllerUtil.GetController(self.quizInfoRect_, "next")
	self.quizAnsCon_ = ControllerUtil.GetController(self.quizInfoRect_, "ans")
	self.quizHitCon_ = ControllerUtil.GetController(self.quizInfoRect_, "hit")
	self.heroScrollHelper_ = LuaList.New(handler(self, self.HeroIndexItem), self.heroListGo_, ActivityQuizHeroItem)
	self.rankScrollHelper_ = LuaList.New(handler(self, self.RankIndexItem), self.rankListGo_, ActivityQuizRankItem)
	self.chatStickerView_ = ChatStickerView.New(self.goSticker_)
	self.heroActionView_ = HeroActionView.New(self.goAction_)
	self.stickerBubbleView_ = StickerBubbleView.New(self.goBubble_)

	QuizGameManager:InitSticker(self.stickerGo_)
end

function ActivityQuizSceneMainView:HeroIndexItem(arg_5_1, arg_5_2)
	self.curHeroID_ = QuizFunction:GetCurHeroID()

	local var_5_0 = self.heroList_[arg_5_1]

	arg_5_2:RefreshSelect(self.heroList_[arg_5_1] == self.curHeroID_)
	arg_5_2:RefreshUI(var_5_0)
end

function ActivityQuizSceneMainView:RankIndexItem(arg_6_1, arg_6_2)
	arg_6_2:RefreshData(self.rankList_[arg_6_1], self.rankIndexList_[arg_6_1])
end

function ActivityQuizSceneMainView:AddUIListeners()
	self:AddBtnListener(self.shareBtn_, nil, function()
		manager.share:Share(function()
			self:SetShareItem(false)
		end, function()
			self:SetShareItem(true)
		end)
	end)
	self:AddBtnListener(self.stickerBtn_, nil, function()
		if self.isStickering_ then
			return
		end

		if self.isStickerOn_ then
			self:HidePanel()
		elseif self.isActionOn_ then
			self:HidePanel()
			SetActive(self.hideGo_, true)
			self.chatStickerView_:Show(true)

			self.isStickerOn_ = true
		else
			SetActive(self.hideGo_, true)
			self.chatStickerView_:Show(true)

			self.isStickerOn_ = true
		end
	end)
	self:AddBtnListener(self.actionBtn_, nil, function()
		if self.isActioning_ then
			return
		end

		if self.isActionOn_ then
			self:HidePanel()
		elseif self.isStickerOn_ then
			self:HidePanel()
			SetActive(self.hideGo_, true)
			self.heroActionView_:Show(true)

			self.isActionOn_ = true
		else
			SetActive(self.hideGo_, true)
			self.heroActionView_:Show(true)

			self.isActionOn_ = true
		end
	end)
	self:AddBtnListener(self.hideBtn_, nil, function()
		self:HidePanel()
	end)
end

function ActivityQuizSceneMainView:OnEnter()
	local var_14_0 = PlayerData:GetPlayerInfo()

	self.userID_ = tostring(var_14_0.userID)
	self.nick_.text = var_14_0.nick
	self.activityID_ = self.params_.activityId
	self.cfg_ = ActivityQuizCfg[ActivityQuizCfg.get_id_list_by_activity_id[self.activityID_][1]]
	self.isStickering_ = false
	self.isActioning_ = false
	self.isStickerOn_ = false
	self.isActionOn_ = false
	self.sendStickerHandler_ = handler(self, self.OnSendSticker)

	manager.notify:RegistListener(CHAT_SEND_STICKER, self.sendStickerHandler_)
	self.heroActionView_:OnEnter()
	self.chatStickerView_:OnEnter()
	self.stickerBubbleView_:OnEnter()

	self.hitCnt_ = 0

	self:RefreshWait()
end

function ActivityQuizSceneMainView:RefreshWait()
	SetActive(self.rankGo_, false)
	self:RefreshHeroList()
	self:StartWait()
end

function ActivityQuizSceneMainView:RefreshHeroList()
	self.heroList_ = self.cfg_.character_list

	self.heroScrollHelper_:StartScroll(#self.heroList_)
end

function ActivityQuizSceneMainView:StartWait()
	self:StopAllStateTimer()
	self.stateCon_:SetSelectedState("wait")
	self.quizHitCon_:SetSelectedState("false")

	local var_17_0 = QuizFunction:GetCurStateEndTime()
	local var_17_1 = var_17_0 - manager.time:GetServerTime()

	self.waitCnt_.text = string.format(GetTips("ACTIVITY_QUIZ_SELECT"), var_17_1)
	self.waitTimer_ = Timer.New(function()
		var_17_1 = var_17_0 - manager.time:GetServerTime()
		self.waitCnt_.text = string.format(GetTips("ACTIVITY_QUIZ_SELECT"), var_17_1)

		if var_17_1 <= 0 then
			self:StopWaitTimer()
		end
	end, 0.5, -1)

	self.waitTimer_:Start()
end

function ActivityQuizSceneMainView:OnQuizStartPrologue()
	self:StopAllStateTimer()
	self.stateCon_:SetSelectedState("prologue")

	self.prologue_.text = GetTips("ACTIVITY_QUIZ_PROLOGUE")

	local var_19_0 = QuizFunction:GetCurStateEndTime()
	local var_19_1 = var_19_0 - manager.time:GetServerTime()

	self.prologueTime_.text = math.max(var_19_1 - 1, 0) .. "s"
	self.prologueTimer_ = Timer.New(function()
		var_19_1 = var_19_0 - manager.time:GetServerTime()
		self.prologueTime_.text = math.max(var_19_1 - 1, 0) .. "s"

		if var_19_1 == 1 then
			self.stateCon_:SetSelectedState("afterPrologue")
		elseif var_19_1 <= 0 then
			self:StopPrologueTimer()
		end
	end, 0.5, -1)

	self.prologueTimer_:Start()
end

function ActivityQuizSceneMainView:OnQuizRefreshQuestion()
	self:StopAllStateTimer()
	self.stateCon_:SetSelectedState("answer")
	self.quizChoiceCon_:SetSelectedState("none")
	self.quizResultCon_:SetSelectedState("none")
	self.quizStateCon_:SetSelectedState("now")
	self.quizAnsCon_:SetSelectedState("none")
	self.quizAppearAni_:Play("Fx_answertext_cx", -1, 0)
	self.quizAppearAni_:Update(0)

	if self.hitCnt_ <= 1 then
		self.quizHitCon_:SetSelectedState("false")
	else
		self.hitAni_:Play("Fx_ComboBonus_xs", -1, 0)
	end

	SetActive(self.rankGo_, true)
	self:RefreshTitle()
	self:RefreshRank()
	self:RefreshQuizTime()
end

function ActivityQuizSceneMainView:RefreshTitle()
	local var_22_0 = QuizFunction:GetCurQuizIndex()
	local var_22_1 = ActivityQuizTableCfg[QuizFunction:GetCurQuizID()]

	self.index_.text = "<color=#FFD084>" .. var_22_0 .. "</color>" .. "/" .. self.cfg_.quiz_zone[#self.cfg_.quiz_zone][1]

	QuizFunction:ResetRandSeed((QuizFunction:GetRandSeed()))
	QuizFunction:SetRandList(#var_22_1.ans)

	local var_22_2 = QuizFunction:GetAnsList()

	self.ans_1.text = "A." .. var_22_1.ans[var_22_2[1]]
	self.ans_2.text = "B." .. var_22_1.ans[var_22_2[2]]
	self.quizDesc_.text = var_22_1.title
	self.score_.text = var_22_1.point
	self.textAni_.text = var_22_1.point

	if self.cfg_.quiz_zone[#self.cfg_.quiz_zone][1] - var_22_0 < 3 then
		self.doubleAni_:Play("Fx_textScore_cx", -1, 0)
	end
end

function ActivityQuizSceneMainView:RefreshRank()
	self.rankList_ = QuizFunction:GetPlayerList()

	self:SortRank()
	self.rankTypeCon_:SetSelectedState(#self.rankList_ > 1 and "multiplayer" or "solo")

	local var_23_0 = table.indexof(self.rankList_, self.userID_)

	self.rankIndex_.text = self.rankIndexList_[var_23_0]
	self.rankScore_.text = QuizFunction:GetRankData(self.userID_).score

	if self.rankIndexList_[var_23_0] > 3 then
		self.rankIndexCon_:SetSelectedState("other")
	else
		self.rankIndexCon_:SetSelectedState(self.rankIndexList_[var_23_0])
	end
end

function ActivityQuizSceneMainView:SortRank()
	table.sort(self.rankList_, function(arg_25_0, arg_25_1)
		return QuizFunction:GetRankData(arg_25_0).score > QuizFunction:GetRankData(arg_25_1).score
	end)

	local var_24_0 = 1

	self.rankIndexList_ = {}

	local var_24_1 = QuizFunction:GetRankData(self.rankList_[1]).score

	for iter_24_0, iter_24_1 in ipairs(self.rankList_) do
		local var_24_2 = QuizFunction:GetRankData(iter_24_1)

		if var_24_1 > var_24_2.score then
			var_24_1 = var_24_2.score
			var_24_0 = iter_24_0
		end

		table.insert(self.rankIndexList_, var_24_0)
	end

	self.rankScrollHelper_:StartScroll(#self.rankList_)
end

function ActivityQuizSceneMainView:RefreshQuizTime()
	local var_26_0 = QuizFunction:GetCurStateEndTime()
	local var_26_1 = var_26_0 - manager.time:GetServerTime()

	self.quizTime_.text = math.max(var_26_1, 0) .. "s"
	self.quizTimer_ = Timer.New(function()
		var_26_1 = var_26_0 - manager.time:GetServerTime()
		self.quizTime_.text = math.max(var_26_1, 0) .. "s"

		if var_26_1 <= 0 then
			self:StopQuizTimer()
		end
	end, 0.5, -1)

	self.quizTimer_:Start()
end

function ActivityQuizSceneMainView:OnRefreshAnswer()
	self:StopAllStateTimer()

	if QuizFunction:GetCurQuizIndex() < self.cfg_.quiz_zone[#self.cfg_.quiz_zone][1] then
		self.stateCon_:SetSelectedState("answer")
	else
		self.stateCon_:SetSelectedState("beforeResult")
	end

	self.quizStateCon_:SetSelectedState("next")

	local var_28_0 = QuizFunction:GetCurResult()

	self.heroActionView_:RefreshList(var_28_0)

	local var_28_1 = table.indexof(QuizFunction:GetAnsList(), (QuizFunction:GetCurChoose()))

	self.quizChoiceCon_:SetSelectedState(var_28_1 == 1 and "A" or "B")

	if var_28_0 == 1 then
		self.hitCnt_ = self.hitCnt_ + 1

		self.quizResultCon_:SetSelectedState("correct")
		self.quizAnsCon_:SetSelectedState(var_28_1 == 1 and "A" or "B")
	else
		self.hitCnt_ = 0

		self.quizResultCon_:SetSelectedState("error")
		self.quizAnsCon_:SetSelectedState(var_28_1 == 1 and "B" or "A")
	end

	self:RefreshRank()
	self:RefreshHit()
	self:RefreshAnsTime()
end

function ActivityQuizSceneMainView:OnQuizChooseChange(arg_29_1)
	if QuizFunction:GetState() == 3 then
		self.quizChoiceCon_:SetSelectedState(arg_29_1 == 1 and "A" or "B")
	end
end

function ActivityQuizSceneMainView:RefreshAnsTime()
	local var_30_0 = QuizFunction:GetCurStateEndTime()
	local var_30_1 = var_30_0 - manager.time:GetServerTime()

	self.ansTime_.text = math.max(var_30_1, 0) .. "s"
	self.ansTimer_ = Timer.New(function()
		var_30_1 = var_30_0 - manager.time:GetServerTime()
		self.ansTime_.text = math.max(var_30_1, 0) .. "s"

		if var_30_1 <= 0 then
			self:StopAnsTimer()
		end
	end, 0.5, -1)

	self.ansTimer_:Start()
end

function ActivityQuizSceneMainView:RefreshHit()
	if self.hitCnt_ > 0 then
		manager.audio:PlayEffect("minigame_activity_2_8", "minigame_activity_2_8_dati_dadui_" .. (self.hitCnt_ > 5 and 5 or self.hitCnt_))
	end

	if self.hitCnt_ <= 1 then
		return
	end

	self.quizHitCon_:SetSelectedState("true")
	self.hitAni_:Play("Fx_correct_cx", -1, 0)

	self.hitTxt_.text = "x" .. self.hitCnt_ - 1
	self.addTxt_.text = "+" .. (GameSetting.combo_reward.value[self.hitCnt_ - 1] or GameSetting.combo_reward.value[#GameSetting.combo_reward.value])
end

function ActivityQuizSceneMainView:OnQuizFinishGame()
	gameContext:Go("/activityQuizSceneResult", {
		activityId = self.activityID_
	})
end

function ActivityQuizSceneMainView:OnSendSticker(arg_34_1)
	self:HidePanel()
	self:StartStickerTimer()
	QuizGameManager:PlayLocalEmoji(arg_34_1)
end

function ActivityQuizSceneMainView:StartStickerTimer()
	self:StopStickerTimer()
	SetActive(self.stickerCDGo_, true)

	self.isStickering_ = true

	local var_35_0 = GameSetting.talk_time.value[1]

	self.stickerCD_.text = math.ceil(GameSetting.talk_time.value[1]) .. "s"
	self.stickerCDIcon_.fillAmount = GameSetting.talk_time.value[1] / GameSetting.talk_time.value[1]
	self.stickerTimer_ = Timer.New(function()
		var_35_0 = var_35_0 - 0.05
		self.stickerCD_.text = math.ceil(var_35_0) .. "s"
		self.stickerCDIcon_.fillAmount = var_35_0 / GameSetting.talk_time.value[1]

		if var_35_0 <= 0 then
			SetActive(self.stickerCDGo_, false)

			self.isStickering_ = false

			self:StopStickerTimer()
		end
	end, 0.05, -1)

	self.stickerTimer_:Start()
end

function ActivityQuizSceneMainView:OnQuizSendAction(arg_37_1)
	self:HidePanel()
	self:StartActionTimer()
	QuizGameManager:PlayLocalGesture(arg_37_1)
end

function ActivityQuizSceneMainView:StartActionTimer()
	self:StopActionTimer()
	SetActive(self.actionCDGo_, true)

	self.isActioning_ = true

	local var_38_0 = GameSetting.action_time.value[1]

	self.actionCD_.text = math.ceil(GameSetting.action_time.value[1]) .. "s"
	self.actionCDIcon_.fillAmount = GameSetting.action_time.value[1] / GameSetting.action_time.value[1]
	self.actionTimer_ = Timer.New(function()
		var_38_0 = var_38_0 - 0.05
		self.actionCD_.text = math.ceil(var_38_0) .. "s"
		self.actionCDIcon_.fillAmount = var_38_0 / GameSetting.talk_time.value[1]

		if var_38_0 <= 0 then
			SetActive(self.actionCDGo_, false)

			self.isActioning_ = false

			self:StopActionTimer()
		end
	end, 0.05, -1)

	self.actionTimer_:Start()
end

function ActivityQuizSceneMainView:OnPlaySticker(arg_40_1, arg_40_2)
	self.stickerBubbleView_:RefreshBubbleView(arg_40_1, arg_40_2)
end

function ActivityQuizSceneMainView:HidePanel()
	SetActive(self.hideGo_, false)
	self.chatStickerView_:Show(false)
	self.heroActionView_:Show(false)

	self.isStickerOn_ = false
	self.isActionOn_ = false
end

function ActivityQuizSceneMainView:StopWaitTimer()
	if self.waitTimer_ then
		self.waitTimer_:Stop()

		self.waitTimer_ = nil
	end
end

function ActivityQuizSceneMainView:StopPrologueTimer()
	if self.prologueTimer_ then
		self.prologueTimer_:Stop()

		self.prologueTimer_ = nil
	end
end

function ActivityQuizSceneMainView:StopQuizTimer()
	if self.quizTimer_ then
		self.quizTimer_:Stop()

		self.quizTimer_ = nil
	end
end

function ActivityQuizSceneMainView:StopAnsTimer()
	if self.ansTimer_ then
		self.ansTimer_:Stop()

		self.ansTimer_ = nil
	end
end

function ActivityQuizSceneMainView:StopAllStateTimer()
	self:StopWaitTimer()
	self:StopPrologueTimer()
	self:StopQuizTimer()
	self:StopAnsTimer()
end

function ActivityQuizSceneMainView:StopStickerTimer()
	if self.stickerTimer_ then
		self.stickerTimer_:Stop()

		self.stickerTimer_ = nil
	end
end

function ActivityQuizSceneMainView:StopActionTimer()
	if self.actionTimer_ then
		self.actionTimer_:Stop()

		self.actionTimer_ = nil
	end
end

function ActivityQuizSceneMainView:OnQuizChangeHero()
	self.heroScrollHelper_:Refresh()
end

function ActivityQuizSceneMainView:OnQuizQuitPlayer()
	self:RefreshRank()
end

function ActivityQuizSceneMainView:SetShareItem(arg_51_1)
	if arg_51_1 then
		self:SetDefaultBar()
		SetActive(self.shareBtn_.gameObject, true)
	else
		manager.windowBar:HideBar()
		SetActive(self.shareBtn_.gameObject, false)
	end
end

function ActivityQuizSceneMainView:SetDefaultBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey(ActivityQuizTools.GetHelpKey(self.activityID_))
	manager.windowBar:RegistBackCallBack(function()
		ShowMessageBox({
			isTop = true,
			content = GetTips("ACTIVITY_QUIZ_QUIT"),
			OkCallback = function()
				ActivityQuizAction.ExitRoom()
			end,
			CancelCallback = function()
				return
			end
		})
	end)
end

function ActivityQuizSceneMainView:OnTop()
	self:SetShareItem(true)
end

function ActivityQuizSceneMainView:OnExit()
	manager.notify:RemoveListener(CHAT_SEND_STICKER, self.sendStickerHandler_)
	self.heroActionView_:OnExit()
	self.chatStickerView_:OnExit()
	self.stickerBubbleView_:OnExit()
	self:StopStickerTimer()
	self:StopAllStateTimer()
	self:RemoveAllEventListener()
end

function ActivityQuizSceneMainView:Dispose()
	self:RemoveAllListeners()
	self.heroActionView_:Dispose()

	self.heroActionView_ = nil

	self.chatStickerView_:Dispose()

	self.chatStickerView_ = nil

	self.stickerBubbleView_:Dispose()

	self.stickerBubbleView_ = nil

	self.heroScrollHelper_:Dispose()
	self.rankScrollHelper_:Dispose()
	self.super.Dispose(self)
end

return ActivityQuizSceneMainView
