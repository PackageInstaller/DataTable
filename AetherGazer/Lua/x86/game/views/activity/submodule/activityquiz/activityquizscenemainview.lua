local var_0_0 = class("ActivityQuizSceneMainView", ReduxView)
local var_0_1 = import("game.quiz.QuizFunction")

function var_0_0.UIName(arg_1_0)
	return ActivityQuizTools.GetActivitySceneUIName(arg_1_0.params_.activityId)
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.stateCon_ = ControllerUtil.GetController(arg_4_0.transform_, "state")
	arg_4_0.rankIndexCon_ = ControllerUtil.GetController(arg_4_0.transform_, "rank")
	arg_4_0.rankTypeCon_ = ControllerUtil.GetController(arg_4_0.transform_, "rankType")
	arg_4_0.quizChoiceCon_ = ControllerUtil.GetController(arg_4_0.quizInfoRect_, "choicebg")
	arg_4_0.quizResultCon_ = ControllerUtil.GetController(arg_4_0.quizInfoRect_, "result")
	arg_4_0.quizStateCon_ = ControllerUtil.GetController(arg_4_0.quizInfoRect_, "next")
	arg_4_0.quizAnsCon_ = ControllerUtil.GetController(arg_4_0.quizInfoRect_, "ans")
	arg_4_0.quizHitCon_ = ControllerUtil.GetController(arg_4_0.quizInfoRect_, "hit")
	arg_4_0.heroScrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.HeroIndexItem), arg_4_0.heroListGo_, ActivityQuizHeroItem)
	arg_4_0.rankScrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.RankIndexItem), arg_4_0.rankListGo_, ActivityQuizRankItem)
	arg_4_0.chatStickerView_ = ChatStickerView.New(arg_4_0.goSticker_)
	arg_4_0.heroActionView_ = HeroActionView.New(arg_4_0.goAction_)
	arg_4_0.stickerBubbleView_ = StickerBubbleView.New(arg_4_0.goBubble_)

	QuizGameManager:InitSticker(arg_4_0.stickerGo_)
end

function var_0_0.HeroIndexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.curHeroID_ = var_0_1:GetCurHeroID()

	local var_5_0 = arg_5_0.heroList_[arg_5_1]

	arg_5_2:RefreshSelect(var_5_0 == arg_5_0.curHeroID_)
	arg_5_2:RefreshUI(var_5_0)
end

function var_0_0.RankIndexItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:RefreshData(arg_6_0.rankList_[arg_6_1], arg_6_0.rankIndexList_[arg_6_1])
end

function var_0_0.AddUIListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.shareBtn_, nil, function()
		manager.share:Share(function()
			arg_7_0:SetShareItem(false)
		end, function()
			arg_7_0:SetShareItem(true)
		end)
	end)
	arg_7_0:AddBtnListener(arg_7_0.stickerBtn_, nil, function()
		if arg_7_0.isStickering_ then
			return
		end

		if arg_7_0.isStickerOn_ then
			arg_7_0:HidePanel()
		elseif arg_7_0.isActionOn_ then
			arg_7_0:HidePanel()
			SetActive(arg_7_0.hideGo_, true)
			arg_7_0.chatStickerView_:Show(true)

			arg_7_0.isStickerOn_ = true
		else
			SetActive(arg_7_0.hideGo_, true)
			arg_7_0.chatStickerView_:Show(true)

			arg_7_0.isStickerOn_ = true
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.actionBtn_, nil, function()
		if arg_7_0.isActioning_ then
			return
		end

		if arg_7_0.isActionOn_ then
			arg_7_0:HidePanel()
		elseif arg_7_0.isStickerOn_ then
			arg_7_0:HidePanel()
			SetActive(arg_7_0.hideGo_, true)
			arg_7_0.heroActionView_:Show(true)

			arg_7_0.isActionOn_ = true
		else
			SetActive(arg_7_0.hideGo_, true)
			arg_7_0.heroActionView_:Show(true)

			arg_7_0.isActionOn_ = true
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.hideBtn_, nil, function()
		arg_7_0:HidePanel()
	end)
end

function var_0_0.OnEnter(arg_14_0)
	local var_14_0 = PlayerData:GetPlayerInfo()

	arg_14_0.userID_ = tostring(var_14_0.userID)
	arg_14_0.nick_.text = var_14_0.nick
	arg_14_0.activityID_ = arg_14_0.params_.activityId
	arg_14_0.cfg_ = ActivityQuizCfg[ActivityQuizCfg.get_id_list_by_activity_id[arg_14_0.activityID_][1]]
	arg_14_0.isStickering_ = false
	arg_14_0.isActioning_ = false
	arg_14_0.isStickerOn_ = false
	arg_14_0.isActionOn_ = false
	arg_14_0.sendStickerHandler_ = handler(arg_14_0, arg_14_0.OnSendSticker)

	manager.notify:RegistListener(CHAT_SEND_STICKER, arg_14_0.sendStickerHandler_)
	arg_14_0.heroActionView_:OnEnter()
	arg_14_0.chatStickerView_:OnEnter()
	arg_14_0.stickerBubbleView_:OnEnter()

	arg_14_0.hitCnt_ = 0

	arg_14_0:RefreshWait()
end

function var_0_0.RefreshWait(arg_15_0)
	SetActive(arg_15_0.rankGo_, false)
	arg_15_0:RefreshHeroList()
	arg_15_0:StartWait()
end

function var_0_0.RefreshHeroList(arg_16_0)
	arg_16_0.heroList_ = arg_16_0.cfg_.character_list

	arg_16_0.heroScrollHelper_:StartScroll(#arg_16_0.heroList_)
end

function var_0_0.StartWait(arg_17_0)
	arg_17_0:StopAllStateTimer()
	arg_17_0.stateCon_:SetSelectedState("wait")
	arg_17_0.quizHitCon_:SetSelectedState("false")

	local var_17_0 = manager.time:GetServerTime()
	local var_17_1 = var_0_1:GetCurStateEndTime()
	local var_17_2 = var_17_1 - var_17_0

	arg_17_0.waitCnt_.text = string.format(GetTips("ACTIVITY_QUIZ_SELECT"), var_17_2)
	arg_17_0.waitTimer_ = Timer.New(function()
		var_17_2 = var_17_1 - manager.time:GetServerTime()
		arg_17_0.waitCnt_.text = string.format(GetTips("ACTIVITY_QUIZ_SELECT"), var_17_2)

		if var_17_2 <= 0 then
			arg_17_0:StopWaitTimer()
		end
	end, 0.5, -1)

	arg_17_0.waitTimer_:Start()
end

function var_0_0.OnQuizStartPrologue(arg_19_0)
	arg_19_0:StopAllStateTimer()
	arg_19_0.stateCon_:SetSelectedState("prologue")

	arg_19_0.prologue_.text = GetTips("ACTIVITY_QUIZ_PROLOGUE")

	local var_19_0 = manager.time:GetServerTime()
	local var_19_1 = var_0_1:GetCurStateEndTime()
	local var_19_2 = var_19_1 - var_19_0

	arg_19_0.prologueTime_.text = math.max(var_19_2 - 1, 0) .. "s"
	arg_19_0.prologueTimer_ = Timer.New(function()
		var_19_2 = var_19_1 - manager.time:GetServerTime()
		arg_19_0.prologueTime_.text = math.max(var_19_2 - 1, 0) .. "s"

		if var_19_2 == 1 then
			arg_19_0.stateCon_:SetSelectedState("afterPrologue")
		elseif var_19_2 <= 0 then
			arg_19_0:StopPrologueTimer()
		end
	end, 0.5, -1)

	arg_19_0.prologueTimer_:Start()
end

function var_0_0.OnQuizRefreshQuestion(arg_21_0)
	arg_21_0:StopAllStateTimer()
	arg_21_0.stateCon_:SetSelectedState("answer")
	arg_21_0.quizChoiceCon_:SetSelectedState("none")
	arg_21_0.quizResultCon_:SetSelectedState("none")
	arg_21_0.quizStateCon_:SetSelectedState("now")
	arg_21_0.quizAnsCon_:SetSelectedState("none")
	arg_21_0.quizAppearAni_:Play("Fx_answertext_cx", -1, 0)
	arg_21_0.quizAppearAni_:Update(0)

	if arg_21_0.hitCnt_ <= 1 then
		arg_21_0.quizHitCon_:SetSelectedState("false")
	else
		arg_21_0.hitAni_:Play("Fx_ComboBonus_xs", -1, 0)
	end

	SetActive(arg_21_0.rankGo_, true)
	arg_21_0:RefreshTitle()
	arg_21_0:RefreshRank()
	arg_21_0:RefreshQuizTime()
end

function var_0_0.RefreshTitle(arg_22_0)
	local var_22_0 = var_0_1:GetCurQuizID()
	local var_22_1 = var_0_1:GetCurQuizIndex()
	local var_22_2 = ActivityQuizTableCfg[var_22_0]
	local var_22_3 = arg_22_0.cfg_.quiz_zone[#arg_22_0.cfg_.quiz_zone][1]

	arg_22_0.index_.text = "<color=#FFD084>" .. var_22_1 .. "</color>" .. "/" .. var_22_3

	local var_22_4 = var_0_1:GetRandSeed()

	var_0_1:ResetRandSeed(var_22_4)
	var_0_1:SetRandList(#var_22_2.ans)

	local var_22_5 = var_0_1:GetAnsList()

	arg_22_0.ans_1.text = "A." .. var_22_2.ans[var_22_5[1]]
	arg_22_0.ans_2.text = "B." .. var_22_2.ans[var_22_5[2]]
	arg_22_0.quizDesc_.text = var_22_2.title
	arg_22_0.score_.text = var_22_2.point
	arg_22_0.textAni_.text = var_22_2.point

	if var_22_3 - var_22_1 < 3 then
		arg_22_0.doubleAni_:Play("Fx_textScore_cx", -1, 0)
	end
end

function var_0_0.RefreshRank(arg_23_0)
	arg_23_0.rankList_ = var_0_1:GetPlayerList()

	arg_23_0:SortRank()
	arg_23_0.rankTypeCon_:SetSelectedState(#arg_23_0.rankList_ > 1 and "multiplayer" or "solo")

	local var_23_0 = table.indexof(arg_23_0.rankList_, arg_23_0.userID_)
	local var_23_1 = var_0_1:GetRankData(arg_23_0.userID_)

	arg_23_0.rankIndex_.text = arg_23_0.rankIndexList_[var_23_0]
	arg_23_0.rankScore_.text = var_23_1.score

	if arg_23_0.rankIndexList_[var_23_0] > 3 then
		arg_23_0.rankIndexCon_:SetSelectedState("other")
	else
		arg_23_0.rankIndexCon_:SetSelectedState(arg_23_0.rankIndexList_[var_23_0])
	end
end

function var_0_0.SortRank(arg_24_0)
	table.sort(arg_24_0.rankList_, function(arg_25_0, arg_25_1)
		local var_25_0 = var_0_1:GetRankData(arg_25_0)
		local var_25_1 = var_0_1:GetRankData(arg_25_1)

		return var_25_0.score > var_25_1.score
	end)

	local var_24_0 = 1

	arg_24_0.rankIndexList_ = {}

	local var_24_1 = var_0_1:GetRankData(arg_24_0.rankList_[1]).score

	for iter_24_0, iter_24_1 in ipairs(arg_24_0.rankList_) do
		local var_24_2 = var_0_1:GetRankData(iter_24_1)

		if var_24_1 > var_24_2.score then
			var_24_1 = var_24_2.score
			var_24_0 = iter_24_0
		end

		table.insert(arg_24_0.rankIndexList_, var_24_0)
	end

	arg_24_0.rankScrollHelper_:StartScroll(#arg_24_0.rankList_)
end

function var_0_0.RefreshQuizTime(arg_26_0)
	local var_26_0 = manager.time:GetServerTime()
	local var_26_1 = var_0_1:GetCurStateEndTime()
	local var_26_2 = var_26_1 - var_26_0

	arg_26_0.quizTime_.text = math.max(var_26_2, 0) .. "s"
	arg_26_0.quizTimer_ = Timer.New(function()
		var_26_2 = var_26_1 - manager.time:GetServerTime()
		arg_26_0.quizTime_.text = math.max(var_26_2, 0) .. "s"

		if var_26_2 <= 0 then
			arg_26_0:StopQuizTimer()
		end
	end, 0.5, -1)

	arg_26_0.quizTimer_:Start()
end

function var_0_0.OnRefreshAnswer(arg_28_0)
	arg_28_0:StopAllStateTimer()

	if var_0_1:GetCurQuizIndex() < arg_28_0.cfg_.quiz_zone[#arg_28_0.cfg_.quiz_zone][1] then
		arg_28_0.stateCon_:SetSelectedState("answer")
	else
		arg_28_0.stateCon_:SetSelectedState("beforeResult")
	end

	arg_28_0.quizStateCon_:SetSelectedState("next")

	local var_28_0 = var_0_1:GetCurResult()

	arg_28_0.heroActionView_:RefreshList(var_28_0)

	local var_28_1 = var_0_1:GetAnsList()
	local var_28_2 = var_0_1:GetCurChoose()
	local var_28_3 = table.indexof(var_28_1, var_28_2)

	arg_28_0.quizChoiceCon_:SetSelectedState(var_28_3 == 1 and "A" or "B")

	if var_28_0 == 1 then
		arg_28_0.hitCnt_ = arg_28_0.hitCnt_ + 1

		arg_28_0.quizResultCon_:SetSelectedState("correct")
		arg_28_0.quizAnsCon_:SetSelectedState(var_28_3 == 1 and "A" or "B")
	else
		arg_28_0.hitCnt_ = 0

		arg_28_0.quizResultCon_:SetSelectedState("error")
		arg_28_0.quizAnsCon_:SetSelectedState(var_28_3 == 1 and "B" or "A")
	end

	arg_28_0:RefreshRank()
	arg_28_0:RefreshHit()
	arg_28_0:RefreshAnsTime()
end

function var_0_0.OnQuizChooseChange(arg_29_0, arg_29_1)
	if var_0_1:GetState() == 3 then
		arg_29_0.quizChoiceCon_:SetSelectedState(arg_29_1 == 1 and "A" or "B")
	end
end

function var_0_0.RefreshAnsTime(arg_30_0)
	local var_30_0 = manager.time:GetServerTime()
	local var_30_1 = var_0_1:GetCurStateEndTime()
	local var_30_2 = var_30_1 - var_30_0

	arg_30_0.ansTime_.text = math.max(var_30_2, 0) .. "s"
	arg_30_0.ansTimer_ = Timer.New(function()
		var_30_2 = var_30_1 - manager.time:GetServerTime()
		arg_30_0.ansTime_.text = math.max(var_30_2, 0) .. "s"

		if var_30_2 <= 0 then
			arg_30_0:StopAnsTimer()
		end
	end, 0.5, -1)

	arg_30_0.ansTimer_:Start()
end

function var_0_0.RefreshHit(arg_32_0)
	if arg_32_0.hitCnt_ > 0 then
		local var_32_0 = arg_32_0.hitCnt_ > 5 and 5 or arg_32_0.hitCnt_

		manager.audio:PlayEffect("minigame_activity_2_8", "minigame_activity_2_8_dati_dadui_" .. var_32_0)
	end

	if arg_32_0.hitCnt_ <= 1 then
		return
	end

	arg_32_0.quizHitCon_:SetSelectedState("true")
	arg_32_0.hitAni_:Play("Fx_correct_cx", -1, 0)

	local var_32_1 = GameSetting.combo_reward.value
	local var_32_2 = var_32_1[arg_32_0.hitCnt_ - 1] or var_32_1[#var_32_1]

	arg_32_0.hitTxt_.text = "x" .. arg_32_0.hitCnt_ - 1
	arg_32_0.addTxt_.text = "+" .. var_32_2
end

function var_0_0.OnQuizFinishGame(arg_33_0)
	gameContext:Go("/activityQuizSceneResult", {
		activityId = arg_33_0.activityID_
	})
end

function var_0_0.OnSendSticker(arg_34_0, arg_34_1)
	arg_34_0:HidePanel()
	arg_34_0:StartStickerTimer()
	QuizGameManager:PlayLocalEmoji(arg_34_1)
end

function var_0_0.StartStickerTimer(arg_35_0)
	arg_35_0:StopStickerTimer()
	SetActive(arg_35_0.stickerCDGo_, true)

	arg_35_0.isStickering_ = true

	local var_35_0 = GameSetting.talk_time.value[1]

	arg_35_0.stickerCD_.text = math.ceil(var_35_0) .. "s"
	arg_35_0.stickerCDIcon_.fillAmount = var_35_0 / GameSetting.talk_time.value[1]
	arg_35_0.stickerTimer_ = Timer.New(function()
		var_35_0 = var_35_0 - 0.05
		arg_35_0.stickerCD_.text = math.ceil(var_35_0) .. "s"
		arg_35_0.stickerCDIcon_.fillAmount = var_35_0 / GameSetting.talk_time.value[1]

		if var_35_0 <= 0 then
			SetActive(arg_35_0.stickerCDGo_, false)

			arg_35_0.isStickering_ = false

			arg_35_0:StopStickerTimer()
		end
	end, 0.05, -1)

	arg_35_0.stickerTimer_:Start()
end

function var_0_0.OnQuizSendAction(arg_37_0, arg_37_1)
	arg_37_0:HidePanel()
	arg_37_0:StartActionTimer()
	QuizGameManager:PlayLocalGesture(arg_37_1)
end

function var_0_0.StartActionTimer(arg_38_0)
	arg_38_0:StopActionTimer()
	SetActive(arg_38_0.actionCDGo_, true)

	arg_38_0.isActioning_ = true

	local var_38_0 = GameSetting.action_time.value[1]

	arg_38_0.actionCD_.text = math.ceil(var_38_0) .. "s"
	arg_38_0.actionCDIcon_.fillAmount = var_38_0 / GameSetting.action_time.value[1]
	arg_38_0.actionTimer_ = Timer.New(function()
		var_38_0 = var_38_0 - 0.05
		arg_38_0.actionCD_.text = math.ceil(var_38_0) .. "s"
		arg_38_0.actionCDIcon_.fillAmount = var_38_0 / GameSetting.talk_time.value[1]

		if var_38_0 <= 0 then
			SetActive(arg_38_0.actionCDGo_, false)

			arg_38_0.isActioning_ = false

			arg_38_0:StopActionTimer()
		end
	end, 0.05, -1)

	arg_38_0.actionTimer_:Start()
end

function var_0_0.OnPlaySticker(arg_40_0, arg_40_1, arg_40_2)
	arg_40_0.stickerBubbleView_:RefreshBubbleView(arg_40_1, arg_40_2)
end

function var_0_0.HidePanel(arg_41_0)
	SetActive(arg_41_0.hideGo_, false)
	arg_41_0.chatStickerView_:Show(false)
	arg_41_0.heroActionView_:Show(false)

	arg_41_0.isStickerOn_ = false
	arg_41_0.isActionOn_ = false
end

function var_0_0.StopWaitTimer(arg_42_0)
	if arg_42_0.waitTimer_ then
		arg_42_0.waitTimer_:Stop()

		arg_42_0.waitTimer_ = nil
	end
end

function var_0_0.StopPrologueTimer(arg_43_0)
	if arg_43_0.prologueTimer_ then
		arg_43_0.prologueTimer_:Stop()

		arg_43_0.prologueTimer_ = nil
	end
end

function var_0_0.StopQuizTimer(arg_44_0)
	if arg_44_0.quizTimer_ then
		arg_44_0.quizTimer_:Stop()

		arg_44_0.quizTimer_ = nil
	end
end

function var_0_0.StopAnsTimer(arg_45_0)
	if arg_45_0.ansTimer_ then
		arg_45_0.ansTimer_:Stop()

		arg_45_0.ansTimer_ = nil
	end
end

function var_0_0.StopAllStateTimer(arg_46_0)
	arg_46_0:StopWaitTimer()
	arg_46_0:StopPrologueTimer()
	arg_46_0:StopQuizTimer()
	arg_46_0:StopAnsTimer()
end

function var_0_0.StopStickerTimer(arg_47_0)
	if arg_47_0.stickerTimer_ then
		arg_47_0.stickerTimer_:Stop()

		arg_47_0.stickerTimer_ = nil
	end
end

function var_0_0.StopActionTimer(arg_48_0)
	if arg_48_0.actionTimer_ then
		arg_48_0.actionTimer_:Stop()

		arg_48_0.actionTimer_ = nil
	end
end

function var_0_0.OnQuizChangeHero(arg_49_0)
	arg_49_0.heroScrollHelper_:Refresh()
end

function var_0_0.OnQuizQuitPlayer(arg_50_0)
	arg_50_0:RefreshRank()
end

function var_0_0.SetShareItem(arg_51_0, arg_51_1)
	if arg_51_1 then
		arg_51_0:SetDefaultBar()
		SetActive(arg_51_0.shareBtn_.gameObject, true)
	else
		manager.windowBar:HideBar()
		SetActive(arg_51_0.shareBtn_.gameObject, false)
	end
end

function var_0_0.SetDefaultBar(arg_52_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey(ActivityQuizTools.GetHelpKey(arg_52_0.activityID_))
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

function var_0_0.OnTop(arg_56_0)
	arg_56_0:SetShareItem(true)
end

function var_0_0.OnExit(arg_57_0)
	manager.notify:RemoveListener(CHAT_SEND_STICKER, arg_57_0.sendStickerHandler_)
	arg_57_0.heroActionView_:OnExit()
	arg_57_0.chatStickerView_:OnExit()
	arg_57_0.stickerBubbleView_:OnExit()
	arg_57_0:StopStickerTimer()
	arg_57_0:StopAllStateTimer()
	arg_57_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_58_0)
	arg_58_0:RemoveAllListeners()
	arg_58_0.heroActionView_:Dispose()

	arg_58_0.heroActionView_ = nil

	arg_58_0.chatStickerView_:Dispose()

	arg_58_0.chatStickerView_ = nil

	arg_58_0.stickerBubbleView_:Dispose()

	arg_58_0.stickerBubbleView_ = nil

	arg_58_0.heroScrollHelper_:Dispose()
	arg_58_0.rankScrollHelper_:Dispose()
	arg_58_0.super.Dispose(arg_58_0)
end

return var_0_0
