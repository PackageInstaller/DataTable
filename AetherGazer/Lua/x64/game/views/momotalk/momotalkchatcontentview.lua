local var_0_0 = class("MomoTalkChatContentView", ReduxView)
local var_0_1 = 20

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()

	arg_1_0.choiceStateCon_ = arg_1_0.viewController_:GetController("viewState")
	arg_1_0.msgPoolView_ = MomoTalkMessagePoolView.New(arg_1_0.poolContentGo_, arg_1_0.bubbleContent_, arg_1_0.scrollRect_)
	arg_1_0.choiceView_ = MomoTalkChoiceView.New(arg_1_0.choiceGo_)
	arg_1_0.msgList_ = {}

	arg_1_0:AddListeners()
	arg_1_0:AddEventListener()
end

function var_0_0.AddListeners(arg_2_0)
	if arg_2_0.clickAreaBtn_ then
		arg_2_0:BindAdvanceClickListener(arg_2_0.clickAreaBtn_.gameObject)
	elseif arg_2_0.scrollRect_ then
		arg_2_0:BindAdvanceClickListener(arg_2_0.scrollRect_.gameObject)
	end

	if arg_2_0.historyBtn_ then
		arg_2_0:AddBtnListener(arg_2_0.historyBtn_, nil, function()
			manager.notify:Invoke(MOMOTALK_OPEN_RECORD, arg_2_0.senderID_)
		end)
	end
end

function var_0_0.BindAdvanceClickListener(arg_4_0, arg_4_1)
	if not arg_4_1 then
		return
	end

	arg_4_0.clickAreaEventTrigger_ = arg_4_0:GetOrAddComponent(arg_4_1, typeof(EventTriggerListener))

	arg_4_0.clickAreaEventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerClick, LuaHelper.EventTriggerAction1(function(arg_5_0, arg_5_1)
		if arg_4_0:IsAdvanceClick(arg_5_1) then
			arg_4_0:TryAdvanceChat()
		end
	end))
	arg_4_0:SetListener(arg_4_0.clickAreaEventTrigger_)
end

function var_0_0.IsAdvanceClick(arg_6_0, arg_6_1)
	if not arg_6_1 or not arg_6_1.position or not arg_6_1.pressPosition then
		return true
	end

	local var_6_0 = arg_6_1.position.x - arg_6_1.pressPosition.x
	local var_6_1 = arg_6_1.position.y - arg_6_1.pressPosition.y

	return var_6_0 * var_6_0 + var_6_1 * var_6_1 <= var_0_1 * var_0_1
end

function var_0_0.AddEventListener(arg_7_0)
	arg_7_0:RegistEventListener(MOMOTALK_CHOICE_SELECTED, handler(arg_7_0, arg_7_0.OnChoiceSelected))
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.chatUpdateHandler_ = handler(arg_8_0, arg_8_0.OnChatUpdate)

	manager.notify:RegistListener(MOMOTALK_CHAT_UPDATE, arg_8_0.chatUpdateHandler_)
end

function var_0_0.OnExit(arg_9_0)
	arg_9_0:StopDelayTimer()

	arg_9_0.reportingContentID_ = nil

	if arg_9_0.chatUpdateHandler_ then
		manager.notify:RemoveListener(MOMOTALK_CHAT_UPDATE, arg_9_0.chatUpdateHandler_)

		arg_9_0.chatUpdateHandler_ = nil
	end
end

function var_0_0.SetData(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = ChatMessageCfg[arg_10_2]

	if not var_10_0 then
		return
	end

	arg_10_0.revealedChoiceContentID_ = nil
	arg_10_0.senderID_ = arg_10_1
	arg_10_0.sessionID_ = arg_10_2
	arg_10_0.previousSessionID_ = arg_10_0:GetPreviousSessionID(arg_10_3)
	arg_10_0.openScrollMode_ = arg_10_3

	arg_10_0:LoadSessionData()
	arg_10_0:RefreshHeader()
	arg_10_0:RefreshMessages(arg_10_3)

	local var_10_1 = MomoTalkData:GetData3(var_10_0.type, arg_10_1, arg_10_2)

	if var_10_1 and var_10_1.is_view == 0 then
		MomoTalkAction.SetRead(arg_10_2, arg_10_1)
	end
end

function var_0_0.GetShownCountByCurrentContentID(arg_11_0)
	local var_11_0 = arg_11_0.sessionData_ and arg_11_0.sessionData_.current_content_id or 0

	if not var_11_0 or var_11_0 <= 0 then
		return nil
	end

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.parsedList_) do
		if iter_11_1.id == var_11_0 then
			return iter_11_0
		end
	end

	return nil
end

function var_0_0.HasBreakPointRecorded(arg_12_0, arg_12_1)
	if not arg_12_1 or arg_12_1 <= 0 then
		return true
	end

	local var_12_0 = arg_12_0.sessionData_

	if not var_12_0 then
		return false
	end

	if var_12_0.current_content_id == arg_12_1 then
		return true
	end

	for iter_12_0, iter_12_1 in ipairs(var_12_0.save_list or {}) do
		if iter_12_1.content_id == arg_12_1 then
			return true
		end
	end

	return false
end

function var_0_0.ReportContentProgress(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1 and arg_13_1.id or 0

	if var_13_0 <= 0 or arg_13_0.reportingContentID_ == var_13_0 or arg_13_0:HasBreakPointRecorded(var_13_0) then
		return
	end

	arg_13_0.reportingContentID_ = var_13_0

	MomoTalkAction.AddMomoTalkBreak(arg_13_0.sessionID_, var_13_0, function(arg_14_0)
		if arg_14_0 and arg_13_0.sessionData_ then
			arg_13_0.sessionData_.current_content_id = var_13_0

			local var_14_0 = false

			for iter_14_0, iter_14_1 in ipairs(arg_13_0.sessionData_.save_list or {}) do
				if iter_14_1.content_id == var_13_0 then
					var_14_0 = true

					break
				end
			end

			if not var_14_0 then
				table.insert(arg_13_0.sessionData_.save_list, {
					state = 0,
					content_id = var_13_0
				})
			end
		end

		if arg_13_0.reportingContentID_ == var_13_0 then
			arg_13_0.reportingContentID_ = nil
		end
	end)
end

function var_0_0.ResolveShownCount(arg_15_0)
	if arg_15_0.pendingShownCount_ then
		local var_15_0 = math.min(arg_15_0.pendingShownCount_, #arg_15_0.parsedList_)

		arg_15_0.pendingShownCount_ = nil

		return var_15_0
	end

	local var_15_1 = arg_15_0:GetShownCountByCurrentContentID()

	if var_15_1 then
		return var_15_1
	end

	return arg_15_0:CalcShownCount()
end

function var_0_0.LoadSessionData(arg_16_0)
	local var_16_0 = MomoTalkData:GetData3(MomoTalkConst.DATA_TYPE.CHAT, arg_16_0.senderID_, arg_16_0.sessionID_)

	arg_16_0.sessionData_ = var_16_0

	if var_16_0 and var_16_0.id then
		local var_16_1 = MomoTalkTools.ParseContentData(MomoTalkData:GetData2(MomoTalkConst.DATA_TYPE.CHAT, arg_16_0.senderID_))

		arg_16_0.previousMsgList_ = arg_16_0:BuildPreviousSessionList(var_16_1)
		arg_16_0.parsedList_ = var_16_1[var_16_0.id] or {}
	else
		arg_16_0.previousMsgList_ = {}
		arg_16_0.parsedList_ = {}
	end

	arg_16_0.shownCount_ = arg_16_0:ResolveShownCount()
end

function var_0_0.GetPreviousSessionID(arg_17_0, arg_17_1)
	if arg_17_1 == "top" then
		return nil
	end

	return MomoTalkData:GetPreviousSessionID(MomoTalkConst.DATA_TYPE.CHAT, arg_17_0.senderID_, arg_17_0.sessionID_)
end

function var_0_0.BuildPreviousSessionList(arg_18_0, arg_18_1)
	if not arg_18_0.previousSessionID_ or not arg_18_1 then
		return {}
	end

	local var_18_0 = arg_18_1[arg_18_0.previousSessionID_] or {}
	local var_18_1 = MomoTalkData:GetData3(MomoTalkConst.DATA_TYPE.CHAT, arg_18_0.senderID_, arg_18_0.previousSessionID_)
	local var_18_2 = MomoTalkTools.GetShownCountBySessionProgress(var_18_0, var_18_1)
	local var_18_3 = {}

	for iter_18_0 = 1, var_18_2 do
		if var_18_0[iter_18_0] then
			table.insert(var_18_3, clone(var_18_0[iter_18_0]))
		end
	end

	return var_18_3
end

function var_0_0.CalcShownCount(arg_19_0)
	local var_19_0 = 0

	for iter_19_0, iter_19_1 in ipairs(arg_19_0.parsedList_) do
		if iter_19_1.state == MomoTalkConst.MSG_STATE.READED or iter_19_1.state == "readed" then
			var_19_0 = iter_19_0
		else
			break
		end
	end

	if var_19_0 == 0 and #arg_19_0.parsedList_ > 0 then
		var_19_0 = 1
	end

	return var_19_0
end

function var_0_0.RefreshHeader(arg_20_0)
	if arg_20_0.chatNameText_ then
		local var_20_0 = MomoTalkTools.GetSessionDisplayName(arg_20_0.sessionID_, arg_20_0.senderID_)

		if var_20_0 == "" and arg_20_0.senderID_ and ChatHeroCfg[arg_20_0.senderID_] then
			var_20_0 = GetI18NText(ChatHeroCfg[arg_20_0.senderID_].name or "")
		end

		arg_20_0.chatNameText_.text = var_20_0
	end
end

function var_0_0.RefreshMessages(arg_21_0, arg_21_1)
	arg_21_0.msgList_ = {}

	for iter_21_0, iter_21_1 in ipairs(arg_21_0.previousMsgList_ or {}) do
		table.insert(arg_21_0.msgList_, iter_21_1)
	end

	if #(arg_21_0.previousMsgList_ or {}) > 0 and arg_21_0.shownCount_ > 0 then
		table.insert(arg_21_0.msgList_, {
			outerKey = "none",
			noneState = "normal",
			contentList = {}
		})
	end

	for iter_21_2 = 1, arg_21_0.shownCount_ do
		if arg_21_0.parsedList_[iter_21_2] then
			table.insert(arg_21_0.msgList_, arg_21_0.parsedList_[iter_21_2])
		end
	end

	arg_21_0:RefreshContinueState()

	local var_21_0 = arg_21_0:ConsumePendingRefreshEnterAnimationContentID()

	if var_21_0 then
		arg_21_0.msgPoolView_:SetPendingEnterAnimationContentID(var_21_0)
	end

	if arg_21_1 == "top" then
		arg_21_0.msgPoolView_:ResetDataToIndex(arg_21_0.msgList_, 1)
	else
		arg_21_0.msgPoolView_:ResetDataToEnd(arg_21_0.msgList_)
	end

	arg_21_0:RefreshChoiceArea()
	arg_21_0:EnsureCurrentContentProgress()
end

function var_0_0.EnsureCurrentContentProgress(arg_22_0)
	local var_22_0 = arg_22_0.msgList_[#arg_22_0.msgList_]

	if var_22_0 then
		arg_22_0:ReportContentProgress(var_22_0)
	end
end

function var_0_0.Refresh(arg_23_0)
	if arg_23_0.senderID_ and arg_23_0.sessionID_ then
		local var_23_0 = arg_23_0.openScrollMode_

		arg_23_0.openScrollMode_ = nil

		arg_23_0:LoadSessionData()
		arg_23_0:RefreshMessages(var_23_0)
	end
end

function var_0_0.ConsumePendingRefreshEnterAnimationContentID(arg_24_0)
	local var_24_0 = arg_24_0.pendingRefreshEnterAnimationContentID_

	arg_24_0.pendingRefreshEnterAnimationContentID_ = nil

	if not var_24_0 then
		return nil
	end

	for iter_24_0, iter_24_1 in ipairs(arg_24_0.msgList_ or {}) do
		if iter_24_1 and iter_24_1.id == var_24_0 then
			return var_24_0
		end
	end

	return nil
end

function var_0_0.TryAppendPendingRefreshEnterAnimation(arg_25_0)
	local var_25_0 = arg_25_0.pendingRefreshEnterAnimationContentID_

	if not var_25_0 then
		return false
	end

	local var_25_1 = #arg_25_0.msgList_
	local var_25_2 = arg_25_0.pendingShownCount_

	arg_25_0.pendingRefreshEnterAnimationContentID_ = nil

	arg_25_0:LoadSessionData()

	local var_25_3 = arg_25_0.parsedList_[arg_25_0.shownCount_]

	if not var_25_3 or var_25_3.id ~= var_25_0 or arg_25_0.shownCount_ ~= var_25_1 + 1 then
		arg_25_0.pendingRefreshEnterAnimationContentID_ = var_25_0
		arg_25_0.pendingShownCount_ = var_25_2

		return false
	end

	table.insert(arg_25_0.msgList_, var_25_3)
	arg_25_0:RefreshContinueState()
	arg_25_0.msgPoolView_:SetPendingEnterAnimationContentID(var_25_0)
	arg_25_0.msgPoolView_:AppendDataToEnd(arg_25_0.msgList_)
	arg_25_0:RefreshChoiceArea()
	arg_25_0:ReportContentProgress(var_25_3)

	return true
end

function var_0_0.CanAdvanceChat(arg_26_0)
	if arg_26_0.choiceView_:IsShowing() or arg_26_0.delayTimer_ then
		return false
	end

	if arg_26_0.shownCount_ < #arg_26_0.parsedList_ then
		return true
	end

	if arg_26_0:IsChoiceItem(arg_26_0.msgList_ and arg_26_0.msgList_[#arg_26_0.msgList_]) then
		return true
	end

	return #MomoTalkTools.DONext(clone(arg_26_0.parsedList_)) > #arg_26_0.parsedList_
end

function var_0_0.RefreshContinueState(arg_27_0)
	for iter_27_0, iter_27_1 in ipairs(arg_27_0.msgList_ or {}) do
		iter_27_1.showContinue = false
	end

	local var_27_0 = arg_27_0.msgList_ and arg_27_0.msgList_[#arg_27_0.msgList_]

	if var_27_0 then
		var_27_0.showContinue = arg_27_0:CanAdvanceChat()
	end
end

function var_0_0.TryAdvanceChat(arg_28_0)
	if arg_28_0.choiceView_:IsShowing() then
		return
	end

	if arg_28_0.delayTimer_ then
		return
	end

	if arg_28_0.shownCount_ >= #arg_28_0.parsedList_ then
		if arg_28_0:TryRevealCurrentChoice() then
			return
		end

		local var_28_0 = MomoTalkTools.DONext(clone(arg_28_0.parsedList_))

		if #var_28_0 > #arg_28_0.parsedList_ then
			arg_28_0.parsedList_ = var_28_0
		end
	end

	if arg_28_0.shownCount_ < #arg_28_0.parsedList_ then
		arg_28_0.shownCount_ = arg_28_0.shownCount_ + 1

		local var_28_1 = arg_28_0.parsedList_[arg_28_0.shownCount_]
		local var_28_2 = ChatContentCfg[var_28_1 and var_28_1.id or 0]

		if var_28_2 and var_28_2.delay and var_28_2.delay > 0 then
			arg_28_0:ShowDelayMessage(var_28_1)
		else
			table.insert(arg_28_0.msgList_, var_28_1)
			arg_28_0:RefreshContinueState()
			arg_28_0.msgPoolView_:SetPendingEnterAnimationContentID(var_28_1 and var_28_1.id)
			arg_28_0.msgPoolView_:AppendDataToEnd(arg_28_0.msgList_)
			arg_28_0:ReportContentProgress(var_28_1)
		end

		arg_28_0:CheckBreakPoint()
	end
end

function var_0_0.ShowDelayMessage(arg_29_0, arg_29_1)
	local var_29_0 = {
		state = "delay",
		id = arg_29_1.id,
		messageID = arg_29_1.messageID
	}
	local var_29_1 = ChatContentCfg[arg_29_1 and arg_29_1.id or 0]
	local var_29_2 = arg_29_0:NormalizeMessageDelay(var_29_1 and var_29_1.delay or 0)

	arg_29_0:StopDelayTimer()

	arg_29_0.delayTimer_ = Timer.New(function()
		arg_29_0.delayTimer_ = nil
		arg_29_0.msgList_[#arg_29_0.msgList_] = arg_29_1

		arg_29_0:RefreshContinueState()
		arg_29_0.msgPoolView_:SetPendingEnterAnimationContentID(arg_29_1 and arg_29_1.id)
		arg_29_0.msgPoolView_:ReplaceLastDataToEnd(arg_29_0.msgList_)
		arg_29_0:ReportContentProgress(arg_29_1)
	end, var_29_2, 1)

	table.insert(arg_29_0.msgList_, var_29_0)
	arg_29_0:RefreshContinueState()
	arg_29_0.msgPoolView_:SetPendingEnterAnimationContentID(arg_29_1 and arg_29_1.id)
	arg_29_0.msgPoolView_:AppendDataToEnd(arg_29_0.msgList_)
	arg_29_0.delayTimer_:Start()
end

function var_0_0.NormalizeMessageDelay(arg_31_0, arg_31_1)
	arg_31_1 = tonumber(arg_31_1) or 0

	if arg_31_1 >= 10 then
		arg_31_1 = arg_31_1 / 1000
	end

	return math.max(arg_31_1, 0)
end

function var_0_0.StopDelayTimer(arg_32_0)
	if arg_32_0.delayTimer_ then
		arg_32_0.delayTimer_:Stop()

		arg_32_0.delayTimer_ = nil
	end
end

function var_0_0.IsChoiceItem(arg_33_0, arg_33_1)
	local var_33_0 = ChatContentCfg[arg_33_1 and arg_33_1.id or 0]

	return var_33_0 and var_33_0.options ~= "" and #var_33_0.options > 0
end

function var_0_0.ShowChoiceArea(arg_34_0, arg_34_1)
	if not arg_34_0:IsChoiceItem(arg_34_1) then
		return false
	end

	arg_34_0.revealedChoiceContentID_ = arg_34_1.id

	arg_34_0.choiceView_:Show(arg_34_1)
	arg_34_0:SetChoiceState(arg_34_1)

	return true
end

function var_0_0.TryRevealCurrentChoice(arg_35_0)
	local var_35_0 = arg_35_0.msgList_ and arg_35_0.msgList_[#arg_35_0.msgList_]

	if not arg_35_0:ShowChoiceArea(var_35_0) then
		return false
	end

	arg_35_0:RefreshContinueState()
	arg_35_0.msgPoolView_:RefreshKeepPosition()

	return true
end

function var_0_0.GetChoiceStateName(arg_36_0, arg_36_1)
	local var_36_0 = ChatContentCfg[arg_36_1 and arg_36_1.id or 0]
	local var_36_1 = var_36_0 and var_36_0.options and #var_36_0.options or 0

	if var_36_1 >= 4 then
		return "4"
	elseif var_36_1 == 3 then
		return "3"
	elseif var_36_1 == 2 then
		return "2"
	elseif var_36_1 == 1 then
		return "1"
	end

	return "0"
end

function var_0_0.SetChoiceState(arg_37_0, arg_37_1)
	if arg_37_0.choiceStateCon_ then
		arg_37_0.choiceStateCon_:SetSelectedState(arg_37_0:GetChoiceStateName(arg_37_1))
	end
end

function var_0_0.HideChoiceArea(arg_38_0)
	arg_38_0.revealedChoiceContentID_ = nil

	arg_38_0.choiceView_:Hide()
	arg_38_0:SetChoiceState(nil)
end

function var_0_0.CheckBreakPoint(arg_39_0)
	local var_39_0, var_39_1 = MomoTalkTools.CheckList(arg_39_0.msgList_)

	if var_39_0 == "tab" and arg_39_0.revealedChoiceContentID_ == var_39_1.id then
		arg_39_0:ShowChoiceArea(var_39_1)
	else
		arg_39_0:HideChoiceArea()
	end

	arg_39_0:RefreshContinueState()
	arg_39_0.msgPoolView_:RefreshKeepPosition()
end

function var_0_0.RefreshChoiceArea(arg_40_0)
	local var_40_0, var_40_1 = MomoTalkTools.CheckList(arg_40_0.msgList_)

	if var_40_0 == "tab" and arg_40_0.revealedChoiceContentID_ == var_40_1.id then
		arg_40_0:ShowChoiceArea(var_40_1)
	else
		arg_40_0:HideChoiceArea()
	end

	arg_40_0:RefreshContinueState()
end

function var_0_0.OnChoiceSelected(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_0.choiceView_:GetCurrentItem()
	local var_41_1 = arg_41_0.choiceView_:GetCurrentOptions()

	if not var_41_0 or not var_41_1 then
		return
	end

	local var_41_2 = var_41_1[arg_41_1]

	if not var_41_2 then
		return
	end

	arg_41_0.pendingShownCount_ = arg_41_0.shownCount_ + 1
	arg_41_0.pendingRefreshEnterAnimationContentID_ = var_41_2

	arg_41_0:HideChoiceArea()
	MomoTalkAction.FinishMomoTalkBreak(var_41_0.messageID, var_41_0.id, var_41_2, function()
		return
	end)
end

function var_0_0.OnChatUpdate(arg_43_0)
	if arg_43_0:TryAppendPendingRefreshEnterAnimation() then
		return
	end

	if arg_43_0.reportingContentID_ then
		local var_43_0 = ChatMessageCfg[arg_43_0.sessionID_]
		local var_43_1 = var_43_0 and MomoTalkData:GetData3(var_43_0.type, arg_43_0.senderID_, arg_43_0.sessionID_) or nil

		if var_43_1 and var_43_1.current_content_id == arg_43_0.reportingContentID_ then
			arg_43_0.sessionData_ = var_43_1

			return
		end
	end

	arg_43_0:Refresh()
end

function var_0_0.Dispose(arg_44_0)
	arg_44_0:StopDelayTimer()

	arg_44_0.reportingContentID_ = nil

	arg_44_0.msgPoolView_:Dispose()
	arg_44_0.choiceView_:Dispose()
	var_0_0.super.Dispose(arg_44_0)
end

return var_0_0
