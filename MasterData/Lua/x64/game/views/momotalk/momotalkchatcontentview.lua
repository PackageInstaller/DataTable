local MomoTalkChatContentView = class("MomoTalkChatContentView", ReduxView)
local var_0_1 = 20

function MomoTalkChatContentView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()

	self.choiceStateCon_ = self.viewController_:GetController("viewState")
	self.msgPoolView_ = MomoTalkMessagePoolView.New(self.poolContentGo_, self.bubbleContent_, self.scrollRect_)
	self.choiceView_ = MomoTalkChoiceView.New(self.choiceGo_)
	self.msgList_ = {}

	self:AddListeners()
	self:AddEventListener()
end

function MomoTalkChatContentView:AddListeners()
	if self.clickAreaBtn_ then
		self:BindAdvanceClickListener(self.clickAreaBtn_.gameObject)
	elseif self.scrollRect_ then
		self:BindAdvanceClickListener(self.scrollRect_.gameObject)
	end

	if self.historyBtn_ then
		self:AddBtnListener(self.historyBtn_, nil, function()
			manager.notify:Invoke(MOMOTALK_OPEN_RECORD, self.senderID_)
		end)
	end
end

function MomoTalkChatContentView:BindAdvanceClickListener(arg_4_1)
	if not arg_4_1 then
		return
	end

	self.clickAreaEventTrigger_ = self:GetOrAddComponent(arg_4_1, typeof(EventTriggerListener))

	self.clickAreaEventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerClick, LuaHelper.EventTriggerAction1(function(arg_5_0, arg_5_1)
		if self:IsAdvanceClick(arg_5_1) then
			self:TryAdvanceChat()
		end
	end))
	self:SetListener(self.clickAreaEventTrigger_)
end

function MomoTalkChatContentView:IsAdvanceClick(arg_6_1)
	if not arg_6_1 or not arg_6_1.position or not arg_6_1.pressPosition then
		return true
	end

	local var_6_0 = arg_6_1.position.x - arg_6_1.pressPosition.x
	local var_6_1 = arg_6_1.position.y - arg_6_1.pressPosition.y

	return var_6_0 * var_6_0 + var_6_1 * var_6_1 <= var_0_1 * var_0_1
end

function MomoTalkChatContentView:AddEventListener()
	self:RegistEventListener(MOMOTALK_CHOICE_SELECTED, handler(self, self.OnChoiceSelected))
end

function MomoTalkChatContentView:OnEnter()
	self.chatUpdateHandler_ = handler(self, self.OnChatUpdate)

	manager.notify:RegistListener(MOMOTALK_CHAT_UPDATE, self.chatUpdateHandler_)
end

function MomoTalkChatContentView:OnExit()
	self:StopDelayTimer()

	self.reportingContentID_ = nil

	if self.chatUpdateHandler_ then
		manager.notify:RemoveListener(MOMOTALK_CHAT_UPDATE, self.chatUpdateHandler_)

		self.chatUpdateHandler_ = nil
	end
end

function MomoTalkChatContentView:SetData(arg_10_1, arg_10_2, arg_10_3)
	if not ChatMessageCfg[arg_10_2] then
		return
	end

	self.revealedChoiceContentID_ = nil
	self.senderID_ = arg_10_1
	self.sessionID_ = arg_10_2
	self.previousSessionID_ = self:GetPreviousSessionID(arg_10_3)
	self.openScrollMode_ = arg_10_3

	self:LoadSessionData()
	self:RefreshHeader()
	self:RefreshMessages(arg_10_3)

	local var_10_0 = MomoTalkData:GetData3(ChatMessageCfg[arg_10_2].type, arg_10_1, arg_10_2)

	if var_10_0 and var_10_0.is_view == 0 then
		MomoTalkAction.SetRead(arg_10_2, arg_10_1)
	end
end

function MomoTalkChatContentView:GetShownCountByCurrentContentID()
	local var_11_0

	if self.sessionData_ then
		var_11_0 = self.sessionData_.current_content_id or 0

		if not var_11_0 or var_11_0 <= 0 then
			return nil
		end
	end

	for iter_11_0, iter_11_1 in ipairs(self.parsedList_) do
		if iter_11_1.id == var_11_0 then
			return iter_11_0
		end
	end

	return nil
end

function MomoTalkChatContentView:HasBreakPointRecorded(arg_12_1)
	if not arg_12_1 or arg_12_1 <= 0 then
		return true
	end

	local var_12_0 = self.sessionData_

	if not self.sessionData_ then
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

function MomoTalkChatContentView:ReportContentProgress(arg_13_1)
	local var_13_0

	if arg_13_1 then
		var_13_0 = arg_13_1.id or 0

		if var_13_0 <= 0 or self.reportingContentID_ == var_13_0 or self:HasBreakPointRecorded(var_13_0) then
			return
		end
	end

	self.reportingContentID_ = var_13_0

	MomoTalkAction.AddMomoTalkBreak(self.sessionID_, var_13_0, function(arg_14_0)
		if arg_14_0 and self.sessionData_ then
			self.sessionData_.current_content_id = var_13_0

			local var_14_0 = false

			for iter_14_0, iter_14_1 in ipairs(self.sessionData_.save_list or {}) do
				if iter_14_1.content_id == var_13_0 then
					var_14_0 = true

					break
				end
			end

			if not var_14_0 then
				table.insert(self.sessionData_.save_list, {
					state = 0,
					content_id = var_13_0
				})
			end
		end

		if self.reportingContentID_ == var_13_0 then
			self.reportingContentID_ = nil
		end
	end)
end

function MomoTalkChatContentView:ResolveShownCount()
	if self.pendingShownCount_ then
		self.pendingShownCount_ = nil

		return (math.min(self.pendingShownCount_, #self.parsedList_))
	end

	local var_15_0 = self:GetShownCountByCurrentContentID()

	if var_15_0 then
		return var_15_0
	end

	return self:CalcShownCount()
end

function MomoTalkChatContentView:LoadSessionData()
	local var_16_0 = MomoTalkData:GetData3(MomoTalkConst.DATA_TYPE.CHAT, self.senderID_, self.sessionID_)

	self.sessionData_ = var_16_0

	if var_16_0 and var_16_0.id then
		local var_16_1 = MomoTalkTools.ParseContentData(MomoTalkData:GetData2(MomoTalkConst.DATA_TYPE.CHAT, self.senderID_))

		self.previousMsgList_ = self:BuildPreviousSessionList(var_16_1)
		self.parsedList_ = var_16_1[var_16_0.id] or {}
	else
		self.previousMsgList_ = {}
		self.parsedList_ = {}
	end

	self.shownCount_ = self:ResolveShownCount()
end

function MomoTalkChatContentView:GetPreviousSessionID(arg_17_1)
	if arg_17_1 == "top" then
		return nil
	end

	return MomoTalkData:GetPreviousSessionID(MomoTalkConst.DATA_TYPE.CHAT, self.senderID_, self.sessionID_)
end

function MomoTalkChatContentView:BuildPreviousSessionList(arg_18_1)
	if not self.previousSessionID_ or not arg_18_1 then
		return {}
	end

	local var_18_0 = arg_18_1[self.previousSessionID_]
	local var_18_1

	if not arg_18_1[self.previousSessionID_] then
		var_18_0 = {}
		var_18_1 = {}
	end

	for iter_18_0 = 1, MomoTalkTools.GetShownCountBySessionProgress(var_18_0, (MomoTalkData:GetData3(MomoTalkConst.DATA_TYPE.CHAT, self.senderID_, self.previousSessionID_))) do
		if var_18_0[iter_18_0] then
			table.insert(var_18_1, clone(var_18_0[iter_18_0]))
		end
	end

	return var_18_1
end

function MomoTalkChatContentView:CalcShownCount()
	local var_19_0 = 0

	for iter_19_0, iter_19_1 in ipairs(self.parsedList_) do
		if iter_19_1.state == MomoTalkConst.MSG_STATE.READED or iter_19_1.state == "readed" then
			var_19_0 = iter_19_0
		else
			break
		end
	end

	if var_19_0 == 0 and #self.parsedList_ > 0 then
		var_19_0 = 1
	end

	return var_19_0
end

function MomoTalkChatContentView:RefreshHeader()
	if self.chatNameText_ then
		local var_20_0 = MomoTalkTools.GetSessionDisplayName(self.sessionID_, self.senderID_)

		if var_20_0 == "" and self.senderID_ and ChatHeroCfg[self.senderID_] then
			var_20_0 = GetI18NText(ChatHeroCfg[self.senderID_].name or "")
		end

		self.chatNameText_.text = var_20_0
	end
end

function MomoTalkChatContentView:RefreshMessages(arg_21_1)
	self.msgList_ = {}

	for iter_21_0, iter_21_1 in ipairs(self.previousMsgList_ or {}) do
		table.insert(self.msgList_, iter_21_1)
	end

	if #(self.previousMsgList_ or {}) > 0 and self.shownCount_ > 0 then
		table.insert(self.msgList_, {
			outerKey = "none",
			noneState = "normal",
			contentList = {}
		})
	end

	for iter_21_2 = 1, self.shownCount_ do
		if self.parsedList_[iter_21_2] then
			table.insert(self.msgList_, self.parsedList_[iter_21_2])
		end
	end

	self:RefreshContinueState()

	local var_21_0 = self:ConsumePendingRefreshEnterAnimationContentID()

	if var_21_0 then
		self.msgPoolView_:SetPendingEnterAnimationContentID(var_21_0)
	end

	if arg_21_1 == "top" then
		self.msgPoolView_:ResetDataToIndex(self.msgList_, 1)
	else
		self.msgPoolView_:ResetDataToEnd(self.msgList_)
	end

	self:RefreshChoiceArea()
	self:EnsureCurrentContentProgress()
end

function MomoTalkChatContentView:EnsureCurrentContentProgress()
	if self.msgList_[#self.msgList_] then
		self:ReportContentProgress(self.msgList_[#self.msgList_])
	end
end

function MomoTalkChatContentView:Refresh()
	if self.senderID_ and self.sessionID_ then
		self.openScrollMode_ = nil

		self:LoadSessionData()
		self:RefreshMessages(self.openScrollMode_)
	end
end

function MomoTalkChatContentView:ConsumePendingRefreshEnterAnimationContentID()
	self.pendingRefreshEnterAnimationContentID_ = nil

	if not self.pendingRefreshEnterAnimationContentID_ then
		return nil
	end

	for iter_24_0, iter_24_1 in ipairs(self.msgList_ or {}) do
		if iter_24_1 and iter_24_1.id == self.pendingRefreshEnterAnimationContentID_ then
			return self.pendingRefreshEnterAnimationContentID_
		end
	end

	return nil
end

function MomoTalkChatContentView:TryAppendPendingRefreshEnterAnimation()
	if not self.pendingRefreshEnterAnimationContentID_ then
		return false
	end

	local var_25_0 = #self.msgList_

	self.pendingRefreshEnterAnimationContentID_ = nil

	self:LoadSessionData()

	if not self.parsedList_[self.shownCount_] or self.parsedList_[self.shownCount_].id ~= self.pendingRefreshEnterAnimationContentID_ or self.shownCount_ ~= var_25_0 + 1 then
		self.pendingRefreshEnterAnimationContentID_ = self.pendingRefreshEnterAnimationContentID_
		self.pendingShownCount_ = self.pendingShownCount_

		return false
	end

	table.insert(self.msgList_, self.parsedList_[self.shownCount_])
	self:RefreshContinueState()
	self.msgPoolView_:SetPendingEnterAnimationContentID(self.pendingRefreshEnterAnimationContentID_)
	self.msgPoolView_:AppendDataToEnd(self.msgList_)
	self:RefreshChoiceArea()
	self:ReportContentProgress(self.parsedList_[self.shownCount_])

	return true
end

function MomoTalkChatContentView:CanAdvanceChat()
	if self.choiceView_:IsShowing() or self.delayTimer_ then
		return false
	end

	if self.shownCount_ < #self.parsedList_ then
		return true
	end

	if self:IsChoiceItem(self.msgList_ and self.msgList_[#self.msgList_]) then
		return true
	end

	return #MomoTalkTools.DONext(clone(self.parsedList_)) > #self.parsedList_
end

function MomoTalkChatContentView:RefreshContinueState()
	for iter_27_0, iter_27_1 in ipairs(self.msgList_ or {}) do
		iter_27_1.showContinue = false
	end

	local var_27_1 = self.msgList_ and self.msgList_[#self.msgList_]

	if var_27_1 then
		var_27_1.showContinue = self:CanAdvanceChat()
	end
end

function MomoTalkChatContentView:TryAdvanceChat()
	if self.choiceView_:IsShowing() then
		return
	end

	if self.delayTimer_ then
		return
	end

	if self.shownCount_ >= #self.parsedList_ then
		if self:TryRevealCurrentChoice() then
			return
		end

		local var_28_0 = MomoTalkTools.DONext(clone(self.parsedList_))

		if #var_28_0 > #self.parsedList_ then
			self.parsedList_ = var_28_0
		end
	end

	if self.shownCount_ < #self.parsedList_ then
		self.shownCount_ = self.shownCount_ + 1

		local var_28_1 = self.parsedList_[self.shownCount_]
		local var_28_2 = ChatContentCfg[(self.parsedList_[self.shownCount_] or nil) and (var_28_1.id or 0)]

		if ChatContentCfg[(self.parsedList_[self.shownCount_] or nil) and (var_28_1.id or 0)] and var_28_2.delay and var_28_2.delay > 0 then
			self:ShowDelayMessage(var_28_1)
		else
			table.insert(self.msgList_, var_28_1)
			self:RefreshContinueState()
			self.msgPoolView_:SetPendingEnterAnimationContentID(var_28_1 and var_28_1.id)
			self.msgPoolView_:AppendDataToEnd(self.msgList_)
			self:ReportContentProgress(var_28_1)
		end

		self:CheckBreakPoint()
	end
end

function MomoTalkChatContentView:ShowDelayMessage(arg_29_1)
	local var_29_1 = self:NormalizeMessageDelay((ChatContentCfg[(arg_29_1 or nil) and (arg_29_1.id or 0)] or nil) and (ChatContentCfg[(arg_29_1 or nil) and (arg_29_1.id or 0)].delay or 0))

	self:StopDelayTimer()

	self.delayTimer_ = Timer.New(function()
		self.delayTimer_ = nil
		self.msgList_[#self.msgList_] = arg_29_1

		self:RefreshContinueState()
		self.msgPoolView_:SetPendingEnterAnimationContentID(arg_29_1 and arg_29_1.id)
		self.msgPoolView_:ReplaceLastDataToEnd(self.msgList_)
		self:ReportContentProgress(arg_29_1)
	end, var_29_1, 1)

	table.insert(self.msgList_, {
		state = "delay",
		id = arg_29_1.id,
		messageID = arg_29_1.messageID
	})
	self:RefreshContinueState()
	self.msgPoolView_:SetPendingEnterAnimationContentID(arg_29_1 and arg_29_1.id)
	self.msgPoolView_:AppendDataToEnd(self.msgList_)
	self.delayTimer_:Start()
end

function MomoTalkChatContentView:NormalizeMessageDelay(arg_31_1)
	arg_31_1 = tonumber(arg_31_1) or 0

	if arg_31_1 >= 10 then
		arg_31_1 = arg_31_1 / 1000
	end

	return math.max(arg_31_1, 0)
end

function MomoTalkChatContentView:StopDelayTimer()
	if self.delayTimer_ then
		self.delayTimer_:Stop()

		self.delayTimer_ = nil
	end
end

function MomoTalkChatContentView:IsChoiceItem(arg_33_1)
	local var_33_0 = ChatContentCfg[(arg_33_1 or nil) and (arg_33_1.id or 0)]

	return ChatContentCfg[(arg_33_1 or nil) and (arg_33_1.id or 0)] and var_33_0.options ~= "" and #var_33_0.options > 0
end

function MomoTalkChatContentView:ShowChoiceArea(arg_34_1)
	if not self:IsChoiceItem(arg_34_1) then
		return false
	end

	self.revealedChoiceContentID_ = arg_34_1.id

	self.choiceView_:Show(arg_34_1)
	self:SetChoiceState(arg_34_1)

	return true
end

function MomoTalkChatContentView:TryRevealCurrentChoice()
	if not self:ShowChoiceArea(self.msgList_ and self.msgList_[#self.msgList_]) then
		return false
	end

	self:RefreshContinueState()
	self.msgPoolView_:RefreshKeepPosition()

	return true
end

function MomoTalkChatContentView:GetChoiceStateName(arg_36_1)
	local var_36_0 = ChatContentCfg[(arg_36_1 or nil) and (arg_36_1.id or 0)]

	if ChatContentCfg[(arg_36_1 or nil) and (arg_36_1.id or 0)] and var_36_0.options then
		local var_36_1 = #var_36_0.options or 0

		if var_36_1 >= 4 then
			return "4"
		elseif var_36_1 == 3 then
			return "3"
		elseif var_36_1 == 2 then
			return "2"
		elseif var_36_1 == 1 then
			return "1"
		end
	end

	return "0"
end

function MomoTalkChatContentView:SetChoiceState(arg_37_1)
	if self.choiceStateCon_ then
		self.choiceStateCon_:SetSelectedState(self:GetChoiceStateName(arg_37_1))
	end
end

function MomoTalkChatContentView:HideChoiceArea()
	self.revealedChoiceContentID_ = nil

	self.choiceView_:Hide()
	self:SetChoiceState(nil)
end

function MomoTalkChatContentView:CheckBreakPoint()
	local var_39_0, var_39_1 = MomoTalkTools.CheckList(self.msgList_)

	if var_39_0 == "tab" and self.revealedChoiceContentID_ == var_39_1.id then
		self:ShowChoiceArea(var_39_1)
	else
		self:HideChoiceArea()
	end

	self:RefreshContinueState()
	self.msgPoolView_:RefreshKeepPosition()
end

function MomoTalkChatContentView:RefreshChoiceArea()
	local var_40_0, var_40_1 = MomoTalkTools.CheckList(self.msgList_)

	if var_40_0 == "tab" and self.revealedChoiceContentID_ == var_40_1.id then
		self:ShowChoiceArea(var_40_1)
	else
		self:HideChoiceArea()
	end

	self:RefreshContinueState()
end

function MomoTalkChatContentView:OnChoiceSelected(arg_41_1)
	local var_41_0 = self.choiceView_:GetCurrentItem()
	local var_41_1 = self.choiceView_:GetCurrentOptions()

	if not var_41_0 or not var_41_1 then
		return
	end

	local var_41_2 = var_41_1[arg_41_1]

	if not var_41_1[arg_41_1] then
		return
	end

	self.pendingShownCount_ = self.shownCount_ + 1
	self.pendingRefreshEnterAnimationContentID_ = var_41_2

	self:HideChoiceArea()
	MomoTalkAction.FinishMomoTalkBreak(var_41_0.messageID, var_41_0.id, var_41_2, function()
		return
	end)
end

function MomoTalkChatContentView:OnChatUpdate()
	if self:TryAppendPendingRefreshEnterAnimation() then
		return
	end

	if self.reportingContentID_ then
		local var_43_0 = ChatMessageCfg[self.sessionID_] and MomoTalkData:GetData3(ChatMessageCfg[self.sessionID_].type, self.senderID_, self.sessionID_) or nil

		if var_43_0 and var_43_0.current_content_id == self.reportingContentID_ then
			self.sessionData_ = var_43_0

			return
		end
	end

	self:Refresh()
end

function MomoTalkChatContentView:Dispose()
	self:StopDelayTimer()

	self.reportingContentID_ = nil

	self.msgPoolView_:Dispose()
	self.choiceView_:Dispose()
	MomoTalkChatContentView.super.Dispose(self)
end

return MomoTalkChatContentView
