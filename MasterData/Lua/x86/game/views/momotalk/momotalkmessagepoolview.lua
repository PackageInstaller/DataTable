local LoopScrollView = import("game.views.chat.loopScrollView.LoopScrollView")
local MomoTalkReplyItem = import("game.views.momoTalk.momotalkItem.TalkShowItem.MomoTalkReplyItem")
local MomoTalkNoneItem = import("game.views.momoTalk.momotalkItem.TalkShowItem.MomoTalkNoneItem")
local MomoTalkMessagePoolView = class("MomoTalkMessagePoolView", ReduxView)
local var_0_4 = 0.8
local var_0_5 = {
	replyM = MomoTalkReplyItem,
	replyO = MomoTalkReplyItem,
	tips = import("game.views.momoTalk.momotalkItem.TalkShowItem.MomoTalkTipsItem"),
	none = MomoTalkNoneItem
}
local var_0_6 = {
	chatBubblePic = import("game.views.momoTalk.momotalkItem.TalkShowItem.MomoTalkBubblePicItem"),
	chatBubbleTalk = import("game.views.momoTalk.momotalkItem.TalkShowItem.MomoTalkBubbleTalkItem"),
	chatBubbleWorld = import("game.views.momoTalk.momotalkItem.TalkShowItem.MomoTalkBubbleWorldItem")
}

function MomoTalkMessagePoolView:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()

	self.scrollContentTrs_ = arg_1_2
	self.scrollRect_ = arg_1_3
	self.sourceDataList_ = {}
	self.dataList_ = {}
	self.visibleSlots_ = {}
	self.outerPoolDic_ = {}
	self.contentPoolDic_ = {}
	self.poolHolder_ = self.poolContent_ or self.transform_
	self.enterAnimationMarkTimer_ = nil

	self:InitLoopScrollView()
end

function MomoTalkMessagePoolView:InitLoopScrollView()
	local var_2_0
	local var_2_1 = 0
	local var_2_2 = 0

	if self.scrollContentTrs_ then
		var_2_0 = self.scrollContentTrs_.parent
		self.viewPortTrs_ = self.scrollContentTrs_.parent

		if var_2_0 then
			var_2_1 = var_2_0.rect.height
		end

		local var_2_3 = self.scrollContentTrs_:GetComponent(typeof(UnityEngine.UI.VerticalLayoutGroup))

		self.layoutGroup_ = var_2_3

		if var_2_3 then
			var_2_2 = var_2_3.spacing
		end
	end

	if self.scrollRect_ and var_2_0 then
		self.loopScrollView_ = LoopScrollView.New(self, self.scrollRect_, self.scrollContentTrs_, var_2_0, var_2_1, var_2_2, true)
	end
end

function MomoTalkMessagePoolView:MarkRenderListEnterAnimation(arg_3_1, arg_3_2)
	local var_3_0 = math.min(arg_3_2 or #arg_3_1, #arg_3_1)

	while var_3_0 and var_3_0 > 0 do
		if arg_3_1 and arg_3_1[var_3_0] then
			local var_3_1 = (arg_3_1 and arg_3_1[var_3_0]).contentList or nil

			if var_3_1 then
				local var_3_2 = var_3_1[#var_3_1] or nil

				if var_3_2 then
					var_3_2.playEnterAnimation = true

					self:StartPlayingEnterAnimationMark(var_3_2.id)

					return var_3_0
				end
			end
		end

		var_3_0 = var_3_0 - 1
	end
end

function MomoTalkMessagePoolView:MarkRenderListEnterAnimationByContentID(arg_4_1, arg_4_2)
	if not arg_4_2 or arg_4_2 <= 0 then
		return
	end

	for iter_4_0 = #(arg_4_1 or {}), 1, -1 do
		local var_4_0

		if arg_4_1[iter_4_0] then
			var_4_0 = arg_4_1[iter_4_0].contentList or nil
		end

		for iter_4_1 = #(var_4_0 or {}), 1, -1 do
			if var_4_0[iter_4_1] and var_4_0[iter_4_1].id == arg_4_2 then
				var_4_0[iter_4_1].playEnterAnimation = true

				self:StartPlayingEnterAnimationMark(var_4_0[iter_4_1].id)

				return
			end
		end
	end
end

function MomoTalkMessagePoolView:ApplyPendingEnterAnimationMark()
	self.pendingEnterAnimationContentID_ = nil

	if not self.pendingEnterAnimationContentID_ then
		return
	end

	self:MarkRenderListEnterAnimationByContentID(self.dataList_, self.pendingEnterAnimationContentID_)
end

function MomoTalkMessagePoolView:ApplyPlayingEnterAnimationMark()
	if not self.playingEnterAnimationContentID_ then
		return
	end

	for iter_6_0, iter_6_1 in ipairs(self.dataList_ or {}) do
		for iter_6_2, iter_6_3 in ipairs((iter_6_1 or nil) and (iter_6_1.contentList or {})) do
			if iter_6_3 and iter_6_3.id == self.playingEnterAnimationContentID_ then
				iter_6_3.playEnterAnimation = true

				return
			end
		end
	end
end

function MomoTalkMessagePoolView:SetPendingEnterAnimationContentID(arg_7_1)
	self.pendingEnterAnimationContentID_ = tonumber(arg_7_1) or arg_7_1
end

function MomoTalkMessagePoolView:ClearRenderListEnterAnimationByContentID(arg_8_1, arg_8_2)
	if not arg_8_2 then
		return
	end

	for iter_8_0, iter_8_1 in ipairs(arg_8_1 or {}) do
		for iter_8_2, iter_8_3 in ipairs((iter_8_1 or nil) and (iter_8_1.contentList or {})) do
			if iter_8_3 and iter_8_3.id == arg_8_2 then
				iter_8_3.playEnterAnimation = nil
			end
		end
	end
end

function MomoTalkMessagePoolView:StopEnterAnimationMarkTimer()
	if self.enterAnimationMarkTimer_ then
		self.enterAnimationMarkTimer_:Stop()

		self.enterAnimationMarkTimer_ = nil
	end
end

function MomoTalkMessagePoolView:StartPlayingEnterAnimationMark(arg_10_1)
	self:StopEnterAnimationMarkTimer()

	self.playingEnterAnimationContentID_ = arg_10_1
	self.enterAnimationMarkTimer_ = Timer.New(function()
		self.enterAnimationMarkTimer_ = nil

		self:FinishPlayingEnterAnimationMark()
	end, var_0_4, 1)

	self.enterAnimationMarkTimer_:Start()
end

function MomoTalkMessagePoolView:FinishPlayingEnterAnimationMark()
	if not self.playingEnterAnimationContentID_ then
		return
	end

	self:ClearRenderListEnterAnimationByContentID(self.dataList_, self.playingEnterAnimationContentID_)

	self.playingEnterAnimationContentID_ = nil
end

function MomoTalkMessagePoolView:ClearPlayingEnterAnimationMark()
	self:StopEnterAnimationMarkTimer()
	self:FinishPlayingEnterAnimationMark()
end

function MomoTalkMessagePoolView:SetData(arg_14_1)
	self.sourceDataList_ = MomoTalkTools.ApplyRecallDisplayRules(arg_14_1 or {})
	self.dataList_ = self:BuildRenderList(self.sourceDataList_)

	self:ApplyPlayingEnterAnimationMark()
	self:ApplyPendingEnterAnimationMark()
end

function MomoTalkMessagePoolView:BuildRenderList(arg_15_1)
	local var_15_0 = {}
	local var_15_1

	for iter_15_0, iter_15_1 in ipairs(arg_15_1 or {}) do
		if iter_15_1 and iter_15_1.outerKey then
			table.insert(var_15_0, iter_15_1)

			var_15_1 = nil
		else
			local var_15_2 = clone(iter_15_1)

			var_15_2.isChatBegin = self:IsChatBegin(var_15_1, iter_15_1)

			if self:CanMergeToLastRenderItem(var_15_0[#var_15_0], var_15_2) then
				table.insert(var_15_0[#var_15_0].contentList, var_15_2)
			else
				local var_15_3 = clone(iter_15_1)

				var_15_3.contentList = {
					var_15_2
				}

				table.insert(var_15_0, var_15_3)
			end

			var_15_1 = iter_15_1
		end
	end

	if self:ShouldAppendDialogueNone(var_15_1) then
		table.insert(var_15_0, {
			outerKey = "none",
			noneState = "end",
			contentList = {}
		})
	end

	return var_15_0
end

function MomoTalkMessagePoolView:ShouldAppendDialogueNone(arg_16_1)
	local var_16_0 = ChatContentCfg[(arg_16_1 or nil) and (arg_16_1.id or 0)]

	if not ChatContentCfg[(arg_16_1 or nil) and (arg_16_1.id or 0)] then
		return false
	end

	if var_16_0.options ~= "" and #var_16_0.options > 0 then
		return false
	end

	return var_16_0.next_content_list == "" or #var_16_0.next_content_list == 0
end

function MomoTalkMessagePoolView:IsChatBegin(arg_17_1, arg_17_2)
	local var_17_0 = ChatContentCfg[(arg_17_2 or nil) and (arg_17_2.id or 0)]
	local var_17_1 = ChatContentCfg[(arg_17_1 or nil) and (arg_17_1.id or 0)]
	local var_17_2 = MomoTalkTools.GetItemDisplayType(arg_17_2, var_17_0)
	local var_17_3 = MomoTalkTools.GetItemDisplayType(arg_17_1, ChatContentCfg[(arg_17_1 or nil) and (arg_17_1.id or 0)])

	if not var_17_0 then
		return true
	end

	if var_17_2 == MomoTalkConst.MSG_TYPE.NARRATE or var_17_2 == MomoTalkConst.MSG_TYPE.RECALL then
		return true
	end

	if not var_17_1 then
		return true
	end

	if var_17_3 == MomoTalkConst.MSG_TYPE.NARRATE or var_17_3 == MomoTalkConst.MSG_TYPE.RECALL then
		return true
	end

	if var_17_0.spokesmen ~= var_17_1.spokesmen then
		return true
	end

	return false
end

function MomoTalkMessagePoolView:CanMergeToLastRenderItem(arg_18_1, arg_18_2)
	if not arg_18_1 or not arg_18_2 then
		return false
	end

	local var_18_0 = arg_18_1.contentList or {
		arg_18_1
	}
	local var_18_1 = var_18_0[#var_18_0]
	local var_18_2 = ChatContentCfg[(var_18_0[#var_18_0] or nil) and (var_18_1.id or 0)]
	local var_18_3 = ChatContentCfg[arg_18_2.id or 0]
	local var_18_4 = MomoTalkTools.GetItemDisplayType(var_18_1, var_18_2)
	local var_18_5 = MomoTalkTools.GetItemDisplayType(arg_18_2, ChatContentCfg[arg_18_2.id or 0])

	if not ChatContentCfg[arg_18_2.id or 0] or not var_18_2 then
		return false
	end

	if var_18_5 == MomoTalkConst.MSG_TYPE.NARRATE or var_18_5 == MomoTalkConst.MSG_TYPE.RECALL then
		return false
	end

	local var_18_6

	if var_18_4 == MomoTalkConst.MSG_TYPE.NARRATE or var_18_4 == MomoTalkConst.MSG_TYPE.RECALL then
		do return false end

		var_18_6 = var_18_3.spokesmen == 0
	end

	local var_18_7 = self:GetOuterKey(var_18_4, var_18_2.spokesmen == 0)
	local var_18_8 = self:GetOuterKey(var_18_5, var_18_6)

	return var_18_2.spokesmen == var_18_3.spokesmen and var_18_7 == var_18_8 and (var_18_8 == "replyM" or var_18_8 == "replyO")
end

function MomoTalkMessagePoolView:ResetDataToEnd(arg_19_1)
	self:SetData(arg_19_1)

	if self.loopScrollView_ then
		self.loopScrollView_:DeleteAllItem()
	else
		self:Clear()
	end

	self:DelayScrollToEnd()
end

function MomoTalkMessagePoolView:ResetDataToIndex(arg_20_1, arg_20_2)
	self:SetData(arg_20_1)

	arg_20_2 = math.max(1, arg_20_2 or 1)

	if self.loopScrollView_ then
		self.loopScrollView_:DeleteAllItem()
	else
		self:Clear()
	end

	self:DelayScrollToIndex(arg_20_2)
end

function MomoTalkMessagePoolView:RefreshLoopMetrics()
	if not self.loopScrollView_ then
		return
	end

	if self.viewPortTrs_ then
		self.loopScrollView_:SetContentHeight(self.viewPortTrs_.rect.height)
	end

	if self.layoutGroup_ then
		self.loopScrollView_.itemSpace_ = self.layoutGroup_.spacing
	end
end

function MomoTalkMessagePoolView:RefreshToEndImmediately()
	if self.loopScrollView_ then
		self.loopScrollView_:DeleteAllItem()
	else
		self:Clear()
	end

	self:ScrollToEnd()
end

function MomoTalkMessagePoolView:AppendLoopTailItemToEnd()
	if not self.loopScrollView_ then
		self:RefreshToEnd()

		return
	end

	self:RefreshLoopMetrics()

	repeat
		local var_23_0 = self:GetLastLoopSlot()
		local var_23_1 = var_23_0 and var_23_0.itemView and var_23_0.itemView:GetIndex() or 0

		if var_23_1 >= #self.dataList_ then
			break
		end

		self.loopScrollView_:AddTailItem()

		local var_23_2 = self:GetLastLoopSlot()
	until var_23_1 >= (var_23_2 and var_23_2.itemView and var_23_2.itemView:GetIndex() or 0)

	self:SetScrollToBottom()
end

function MomoTalkMessagePoolView:CanAppendLoopTailItem(arg_24_1)
	if not self.loopScrollView_ or not arg_24_1 or arg_24_1 <= 0 then
		return false
	end

	local var_24_0 = self:GetLastLoopSlot()

	if not var_24_0 or not var_24_0.itemView then
		return false
	end

	return var_24_0.itemView:GetIndex() == arg_24_1
end

function MomoTalkMessagePoolView:GetLastLoopSlot()
	if not self.loopScrollView_ then
		return nil
	end

	local var_25_0 = self.loopScrollView_:GetItemList()

	return (var_25_0 or nil) and (var_25_0[#var_25_0] or nil)
end

function MomoTalkMessagePoolView:RefreshLastLoopSlotToEnd(arg_26_1)
	local var_26_0 = self:GetLastLoopSlot()

	if not var_26_0 or not var_26_0.itemView or var_26_0.itemView:GetIndex() ~= arg_26_1 then
		return false
	end

	local var_26_1 = var_26_0.cachedHeight_ or var_26_0.itemView:GetItemHeight()

	self:LsUpdateItem(var_26_0, self.dataList_[arg_26_1], arg_26_1)
	self:RebuildSlotLayout(var_26_0, var_26_1)
	self:SetScrollToBottom()

	return true
end

function MomoTalkMessagePoolView:RefreshVisibleLoopSlots()
	if not self.loopScrollView_ then
		return false
	end

	local var_27_0 = self.loopScrollView_:GetItemList()

	if not var_27_0 then
		return false
	end

	for iter_27_0, iter_27_1 in ipairs(var_27_0) do
		local var_27_1 = iter_27_1 and iter_27_1.itemView and iter_27_1.itemView:GetIndex() or nil

		if var_27_1 and self.dataList_[var_27_1] then
			local var_27_2 = iter_27_1.cachedHeight_ or iter_27_1.itemView:GetItemHeight()

			self:LsUpdateItem(iter_27_1, self.dataList_[var_27_1], var_27_1)
			self:RebuildSlotLayout(iter_27_1, var_27_2)
		end
	end

	return true
end

function MomoTalkMessagePoolView:RefreshVisibleShowContinueState()
	if not self.loopScrollView_ then
		return false
	end

	local var_28_0 = self.loopScrollView_:GetItemList()

	if not var_28_0 then
		return false
	end

	for iter_28_0, iter_28_1 in ipairs(var_28_0) do
		local var_28_1 = iter_28_1 and iter_28_1.itemView and iter_28_1.itemView:GetIndex() or nil

		if var_28_1 then
			local var_28_2 = self.dataList_[var_28_1] or nil

			if var_28_2 then
				self:RefreshSlotShowContinueState(iter_28_1, var_28_2)
			end
		end
	end

	return true
end

function MomoTalkMessagePoolView:RefreshSlotShowContinueState(arg_29_1, arg_29_2)
	if not arg_29_1 then
		return
	end

	if arg_29_1.contents and #arg_29_1.contents > 0 then
		for iter_29_0, iter_29_1 in ipairs((self:GetRenderContentList(arg_29_2))) do
			if arg_29_1.contents[iter_29_0] and arg_29_1.contents[iter_29_0].itemView and arg_29_1.contents[iter_29_0].itemView.RefreshShowContinue then
				arg_29_1.contents[iter_29_0].itemView:RefreshShowContinue(iter_29_1)
			end
		end

		return
	end

	if arg_29_1.itemView and arg_29_1.itemView.RefreshShowContinue then
		arg_29_1.itemView:RefreshShowContinue(arg_29_2)
	end
end

function MomoTalkMessagePoolView:ShouldRefreshVisibleSlotsOnAppend(arg_30_1)
	return ChatContentCfg[(arg_30_1 or nil) and (arg_30_1.id or 0)] and ChatContentCfg[(arg_30_1 or nil) and (arg_30_1.id or 0)].type == MomoTalkConst.MSG_TYPE.RECALL
end

function MomoTalkMessagePoolView:RebuildSlotLayout(arg_31_1, arg_31_2)
	if not arg_31_1 or not arg_31_1.itemView then
		return
	end

	arg_31_2 = arg_31_2 or arg_31_1.cachedHeight_ or arg_31_1.itemView:GetItemHeight()

	for iter_31_0, iter_31_1 in ipairs(arg_31_1.contents or {}) do
		if iter_31_1.itemView and iter_31_1.itemView.RebuildLayout then
			iter_31_1.itemView:RebuildLayout()
		end
	end

	if arg_31_1.itemView.RebuildLayout then
		arg_31_1.itemView:RebuildLayout()
	end

	if self.scrollContentTrs_ then
		LayoutRebuilder.ForceRebuildLayoutImmediate(self.scrollContentTrs_)
	end

	local var_31_0 = arg_31_1.itemView:GetItemHeight()

	arg_31_1.cachedHeight_ = var_31_0

	if self.loopScrollView_ and var_31_0 ~= arg_31_2 then
		self.loopScrollView_.contentHeight_ = math.max(0, (self.loopScrollView_.contentHeight_ or 0) + var_31_0 - arg_31_2)
	end
end

function MomoTalkMessagePoolView:AppendDataToEnd(arg_32_1)
	local var_32_0 = #self.dataList_

	self:ClearPlayingEnterAnimationMark()
	self:SetData(arg_32_1)
	self:RefreshVisibleShowContinueState()

	local var_32_1

	if var_32_0 < #self.dataList_ then
		var_32_1 = #self.dataList_
	elseif #self.dataList_ > 0 then
		var_32_1 = var_32_0
	end

	local var_32_2

	if var_32_1 then
		var_32_2 = self:MarkRenderListEnterAnimation(self.dataList_, var_32_1)
	end

	if self:ShouldRefreshVisibleSlotsOnAppend(var_32_2 and self:GetRenderContentList(self.dataList_[var_32_2])[1] or nil) then
		self:RefreshVisibleLoopSlots()
	end

	if var_32_2 and var_32_2 ~= var_32_1 then
		self:RefreshLastLoopSlotToEnd(var_32_2)
	end

	if var_32_1 and var_32_0 < var_32_1 and self:CanAppendLoopTailItem(var_32_0) then
		self:AppendLoopTailItemToEnd()
	elseif var_32_1 and self:RefreshLastLoopSlotToEnd(var_32_1) then
		-- block empty
	else
		self:RefreshToEndImmediately()
	end
end

function MomoTalkMessagePoolView:ReplaceLastDataToEnd(arg_33_1)
	self:SetData(arg_33_1)

	if not self:RefreshLastLoopSlotToEnd((#self.dataList_ > 0 or nil) and (self:MarkRenderListEnterAnimation(self.dataList_, #self.dataList_) or #self.dataList_)) then
		self:RefreshToEndImmediately()
	end
end

function MomoTalkMessagePoolView:SetScrollToBottom()
	if self.loopScrollView_ and self.loopScrollView_.scrollView_ then
		self:RefreshLoopMetrics()

		if self.scrollContentTrs_ then
			LayoutRebuilder.ForceRebuildLayoutImmediate(self.scrollContentTrs_)
		end

		self.loopScrollView_.scrollView_.verticalNormalizedPosition = 0.0001
	end
end

function MomoTalkMessagePoolView:DelayScrollToEnd(arg_35_1)
	self:StopScrollTimer()

	arg_35_1 = arg_35_1 or 2
	self.scrollTimer_ = FrameTimer.New(function()
		self.scrollTimer_ = nil

		self:ScrollToEnd()
	end, arg_35_1, 1)

	self.scrollTimer_:Start()
end

function MomoTalkMessagePoolView:DelayScrollToIndex(arg_37_1, arg_37_2)
	self:StopScrollTimer()

	arg_37_2 = arg_37_2 or 2
	self.scrollTimer_ = FrameTimer.New(function()
		self.scrollTimer_ = nil

		self:ScrollToIndex(arg_37_1)
	end, arg_37_2, 1)

	self.scrollTimer_:Start()
end

function MomoTalkMessagePoolView:StopScrollTimer()
	if self.scrollTimer_ then
		self.scrollTimer_:Stop()

		self.scrollTimer_ = nil
	end
end

function MomoTalkMessagePoolView:RefreshToEnd()
	if self.loopScrollView_ then
		self.loopScrollView_:Scroll2End()
	else
		self:Clear()

		for iter_40_0, iter_40_1 in ipairs(self.dataList_) do
			table.insert(self.visibleSlots_, (self:BuildSlot(iter_40_1, iter_40_0)))
		end
	end
end

function MomoTalkMessagePoolView:RefreshKeepPosition()
	if self.loopScrollView_ then
		self.loopScrollView_:RefreshScrollView(true, true)
	else
		self:RefreshToEnd()
	end
end

function MomoTalkMessagePoolView:DelayLockOuterDescribeLayout(arg_42_1)
	if not arg_42_1 or not arg_42_1.DelayLockDescribeLayout then
		return
	end

	arg_42_1:DelayLockDescribeLayout(0.01)
end

function MomoTalkMessagePoolView:ShouldLockOuterDescribeLayout(arg_43_1)
	if not arg_43_1 or #arg_43_1 ~= 1 then
		return false
	end

	for iter_43_0, iter_43_1 in ipairs(arg_43_1) do
		if iter_43_1 and iter_43_1.playEnterAnimation then
			return true
		end
	end

	return false
end

function MomoTalkMessagePoolView:ShouldPlayOuterEnterAnimation(arg_44_1)
	local var_44_0

	if arg_44_1 then
		var_44_0 = arg_44_1[1] or nil
	end

	return var_44_0 and var_44_0.playEnterAnimation == true
end

function MomoTalkMessagePoolView:PlayOuterEnterAnimation(arg_45_1, arg_45_2)
	if not arg_45_1 or not arg_45_1.itemView or not arg_45_1.itemView.PlayOuterEnterAnimation then
		return
	end

	if self:ShouldPlayOuterEnterAnimation(arg_45_2) then
		arg_45_1.itemView:PlayOuterEnterAnimation()
	end
end

function MomoTalkMessagePoolView:PlaySlotEnterAnimation(arg_46_1, arg_46_2)
	if not arg_46_1 or not arg_46_1.contents then
		return
	end

	for iter_46_0 = #(arg_46_2 or {}), 1, -1 do
		if arg_46_2[iter_46_0] and arg_46_2[iter_46_0].playEnterAnimation and arg_46_1.contents[iter_46_0] and arg_46_1.contents[iter_46_0].itemView then
			arg_46_1.contents[iter_46_0].itemView:PlayEnterAnimation(arg_46_2[iter_46_0])

			return
		end
	end
end

function MomoTalkMessagePoolView:GetOuterKey(arg_47_1, arg_47_2)
	if arg_47_1 == 0 or arg_47_1 == MomoTalkConst.MSG_TYPE.TEXT or arg_47_1 == MomoTalkConst.MSG_TYPE.IMAGE or arg_47_1 == MomoTalkConst.MSG_TYPE.STICKER or arg_47_1 == MomoTalkConst.MSG_TYPE.AUDIO then
		return arg_47_2 and "replyM" or "replyO"
	end

	if arg_47_1 == MomoTalkConst.MSG_TYPE.RECALL or arg_47_1 == MomoTalkConst.MSG_TYPE.NARRATE then
		return "tips"
	end

	return "none"
end

function MomoTalkMessagePoolView:GetOuterTemplate(arg_48_1)
	if arg_48_1 == "replyM" then
		return self.dialogueReplyMGo_
	end

	if arg_48_1 == "replyO" then
		return self.dialogueReplyOGo_
	end

	if arg_48_1 == "tips" then
		return self.dialogueTipsGo_
	end

	return self.dialogueNoneGo_
end

function MomoTalkMessagePoolView:GetFreeOuter(arg_49_1)
	self.outerPoolDic_[arg_49_1] = self.outerPoolDic_[arg_49_1] or {}

	local var_49_0 = self.outerPoolDic_[arg_49_1]

	for iter_49_0, iter_49_1 in ipairs(self.outerPoolDic_[arg_49_1]) do
		if iter_49_1.isFree then
			iter_49_1.isFree = false

			return iter_49_1
		end
	end

	local var_49_1 = (var_0_5[arg_49_1] or MomoTalkNoneItem).New(self:GetOuterTemplate(arg_49_1), self.poolHolder_)

	var_49_1:Show(false)

	local var_49_2 = {
		isFree = false,
		itemView = var_49_1,
		outerKey = arg_49_1
	}

	table.insert(var_49_0, var_49_2)

	return var_49_2
end

function MomoTalkMessagePoolView:GetContentKey(arg_50_1)
	if arg_50_1 == MomoTalkConst.MSG_TYPE.IMAGE or arg_50_1 == MomoTalkConst.MSG_TYPE.STICKER then
		return "chatBubblePic"
	elseif arg_50_1 == MomoTalkConst.MSG_TYPE.AUDIO then
		return "chatBubbleTalk"
	elseif arg_50_1 == 0 or arg_50_1 == MomoTalkConst.MSG_TYPE.TEXT or arg_50_1 == MomoTalkConst.MSG_TYPE.NARRATE then
		return "chatBubbleWorld"
	end

	return nil
end

function MomoTalkMessagePoolView:GetContentTemplate(arg_51_1)
	if arg_51_1 == "chatBubblePic" then
		return self.bubblePicGo_
	end

	if arg_51_1 == "chatBubbleTalk" then
		return self.bubbleTalkGo_
	end

	if arg_51_1 == "chatBubbleWorld" then
		return self.bubbleWorldGo_
	end

	return nil
end

function MomoTalkMessagePoolView:GetFreeContent(arg_52_1)
	self.contentPoolDic_[arg_52_1] = self.contentPoolDic_[arg_52_1] or {}

	local var_52_0 = self.contentPoolDic_[arg_52_1]

	for iter_52_0, iter_52_1 in ipairs(self.contentPoolDic_[arg_52_1]) do
		if iter_52_1.isFree then
			iter_52_1.isFree = false

			return iter_52_1
		end
	end

	local var_52_1 = self:GetContentTemplate(arg_52_1)

	if not var_52_1 or not var_0_6[arg_52_1] then
		return nil
	end

	local var_52_2 = var_0_6[arg_52_1].New(var_52_1, self.poolHolder_)

	var_52_2:Show(false)

	local var_52_3 = {
		isFree = false,
		itemView = var_52_2,
		contentKey = arg_52_1
	}

	table.insert(var_52_0, var_52_3)

	return var_52_3
end

function MomoTalkMessagePoolView:GetItemDisplayCfg(arg_53_1)
	local var_53_0 = ChatContentCfg[(arg_53_1 or nil) and (arg_53_1.id or 0)]
	local var_53_1 = MomoTalkTools.GetItemDisplayContent(arg_53_1, ChatContentCfg[(arg_53_1 or nil) and (arg_53_1.id or 0)])
	local var_53_2 = {}

	if ChatContentCfg[(arg_53_1 or nil) and (arg_53_1.id or 0)] then
		var_53_2.id = var_53_0.id or 0
	end

	if var_53_0 then
		var_53_2.spokesmen = var_53_0.spokesmen or 0
	end

	var_53_2.content = var_53_1
	var_53_2.txt = var_53_1
	var_53_2.type = MomoTalkTools.GetItemDisplayType(arg_53_1, ChatContentCfg[(arg_53_1 or nil) and (arg_53_1.id or 0)])

	if var_53_0 then
		var_53_2.url = var_53_0.url or ""
	end

	if var_53_0 then
		var_53_2.options = var_53_0.options or ""
	end

	if var_53_0 then
		var_53_2.next_content_list = var_53_0.next_content_list or ""
	end

	if var_53_0 then
		var_53_2.belong = var_53_0.belong or 0
	end

	if var_53_0 then
		var_53_2.is_turn = var_53_0.is_turn or 0
	end

	if var_53_0 then
		var_53_2.voice_params = var_53_0.voice_params or ""
	end

	if var_53_0 then
		var_53_2.delay = var_53_0.delay or 0
	end

	return var_53_2
end

function MomoTalkMessagePoolView:GetRenderContentList(arg_54_1)
	return (arg_54_1 or nil) and (arg_54_1.contentList or {})
end

function MomoTalkMessagePoolView:GetRenderOuterKey(arg_55_1, arg_55_2)
	if arg_55_1 and arg_55_1.outerKey then
		return arg_55_1.outerKey
	end

	local var_55_0 = self:GetItemDisplayCfg(arg_55_2)

	return self:GetOuterKey((var_55_0 or nil) and (var_55_0.type or MomoTalkConst.MSG_TYPE.TEXT), var_55_0 and var_55_0.spokesmen == 0 or false)
end

function MomoTalkMessagePoolView:IsSameContentShape(arg_56_1, arg_56_2)
	if arg_56_1 then
		if #(arg_56_1.contents or {}) ~= #arg_56_2 then
			return false
		end
	end

	for iter_56_0, iter_56_1 in ipairs(arg_56_2) do
		local var_56_1 = self:GetItemDisplayCfg(iter_56_1)

		if self:GetSlotContentKey(arg_56_1, iter_56_0) ~= self:GetContentKey((var_56_1 or nil) and (var_56_1.type or MomoTalkConst.MSG_TYPE.TEXT)) then
			return false
		end
	end

	return true
end

function MomoTalkMessagePoolView:GetSlotContentKey(arg_57_1, arg_57_2)
	local var_57_0

	if arg_57_1 then
		::label_57_0::

		var_57_0 = arg_57_1.contents and arg_57_1.contents[arg_57_2 or 1]
	end

	return (var_57_0 or nil) and (var_57_0.contentKey or nil)
end

function MomoTalkMessagePoolView:BuildSlot(arg_58_1, arg_58_2)
	local var_58_0 = self:GetRenderContentList(arg_58_1)
	local var_58_1 = self:GetItemDisplayCfg(var_58_0[1])
	local var_58_2 = self:GetRenderOuterKey(arg_58_1, var_58_0[1])
	local var_58_3 = self:GetFreeOuter(var_58_2)
	local var_58_4 = {}

	var_58_3.itemView:SetParent(self.scrollContentTrs_)
	var_58_3.itemView:Show(true)

	if var_58_2 == "replyM" or var_58_2 == "replyO" then
		for iter_58_0, iter_58_1 in ipairs(var_58_0) do
			local var_58_5 = self:GetItemDisplayCfg(iter_58_1)
			local var_58_6 = self:GetContentKey((var_58_5 or nil) and (var_58_5.type or MomoTalkConst.MSG_TYPE.TEXT))
			local var_58_7 = var_58_6 and self:GetFreeContent(var_58_6) or nil

			if var_58_7 then
				var_58_3.itemView:AttachContent(var_58_7.itemView)
				var_58_7.itemView:Show(true)
				var_58_7.itemView:Reset(var_58_5, iter_58_1)
				table.insert(var_58_4, var_58_7)
			end
		end
	end

	var_58_3.itemView:Reset(var_58_1, arg_58_1, arg_58_2)

	if var_58_2 == "replyM" or var_58_2 == "replyO" then
		if self:ShouldLockOuterDescribeLayout(var_58_0) then
			self:DelayLockOuterDescribeLayout(var_58_3.itemView)
		else
			var_58_3.itemView:RestoreDescribeLayout()
		end

		self:PlayOuterEnterAnimation(var_58_3, var_58_0)
	end

	local var_58_8 = {
		isFree = false,
		itemView = var_58_3.itemView,
		outer = var_58_3,
		contents = var_58_4
	}

	self:BindSlotLayoutChanged(var_58_8)
	self:PlaySlotEnterAnimation(var_58_8, var_58_0)

	return var_58_8
end

function MomoTalkMessagePoolView:RefreshSlot(arg_59_1, arg_59_2, arg_59_3)
	if not arg_59_1 or not arg_59_1.outer then
		return
	end

	local var_59_0 = self:GetRenderContentList(arg_59_2)
	local var_59_1 = self:GetRenderOuterKey(arg_59_2, var_59_0[1])

	if arg_59_1.outer.outerKey ~= var_59_1 or not self:IsSameContentShape(arg_59_1, var_59_0) then
		self:ReturnSlot(arg_59_1)

		local var_59_2 = self:BuildSlot(arg_59_2, arg_59_3)

		arg_59_1.itemView = var_59_2.itemView
		arg_59_1.outer = var_59_2.outer
		arg_59_1.contents = var_59_2.contents
		arg_59_1.isFree = false

		self:BindSlotLayoutChanged(arg_59_1)

		return
	end

	for iter_59_0, iter_59_1 in ipairs(var_59_0) do
		if arg_59_1.contents[iter_59_0] and arg_59_1.contents[iter_59_0].itemView then
			arg_59_1.contents[iter_59_0].itemView:Reset(self:GetItemDisplayCfg(iter_59_1), iter_59_1)
		end
	end

	arg_59_1.outer.itemView:Reset(self:GetItemDisplayCfg(var_59_0[1]), arg_59_2, arg_59_3)

	if var_59_1 == "replyM" or var_59_1 == "replyO" then
		if self:ShouldLockOuterDescribeLayout(var_59_0) then
			self:DelayLockOuterDescribeLayout(arg_59_1.outer.itemView)
		else
			arg_59_1.outer.itemView:RestoreDescribeLayout()
		end
	end

	self:BindSlotLayoutChanged(arg_59_1)
	self:PlaySlotEnterAnimation(arg_59_1, var_59_0)
end

function MomoTalkMessagePoolView:BindSlotLayoutChanged(arg_60_1)
	if not arg_60_1 then
		return
	end

	for iter_60_0, iter_60_1 in ipairs(arg_60_1.contents or {}) do
		if iter_60_1.itemView then
			iter_60_1.itemView.layoutChangedHandler_ = handler(self, self.OnContentLayoutChanged)
			iter_60_1.itemView.layoutChangedSlot_ = arg_60_1
		end
	end

	arg_60_1.cachedHeight_ = arg_60_1.itemView and arg_60_1.itemView:GetItemHeight() or 0
end

function MomoTalkMessagePoolView:OnContentLayoutChanged(arg_61_1)
	if not arg_61_1 or not arg_61_1.itemView then
		return
	end

	local var_61_0 = arg_61_1.cachedHeight_ or arg_61_1.itemView:GetItemHeight()

	if arg_61_1.itemView.RestoreDescribeLayout then
		arg_61_1.itemView:RestoreDescribeLayout()
	end

	for iter_61_0, iter_61_1 in ipairs(arg_61_1.contents or {}) do
		if iter_61_1.itemView and iter_61_1.itemView.RebuildLayout then
			iter_61_1.itemView:RebuildLayout()
		end
	end

	if arg_61_1.itemView.RebuildLayout then
		arg_61_1.itemView:RebuildLayout()
	end

	if self.scrollContentTrs_ then
		LayoutRebuilder.ForceRebuildLayoutImmediate(self.scrollContentTrs_)
	end

	local var_61_1 = arg_61_1.itemView:GetItemHeight()

	arg_61_1.cachedHeight_ = var_61_1

	if self.loopScrollView_ and var_61_1 ~= var_61_0 then
		self.loopScrollView_.contentHeight_ = math.max(0, (self.loopScrollView_.contentHeight_ or 0) + var_61_1 - var_61_0)
	end
end

function MomoTalkMessagePoolView:ReturnSlot(arg_62_1, arg_62_2)
	if not arg_62_1 then
		return
	end

	if arg_62_1.contents then
		for iter_62_0, iter_62_1 in ipairs(arg_62_1.contents) do
			if iter_62_1.itemView then
				iter_62_1.itemView.layoutChangedHandler_ = nil
				iter_62_1.itemView.layoutChangedSlot_ = nil

				arg_62_1.outer.itemView:DetachContent(iter_62_1.itemView, self.poolHolder_)
				iter_62_1.itemView:Show(false)
			end

			iter_62_1.isFree = true
		end

		arg_62_1.contents = {}
	end

	if arg_62_1.outer and arg_62_1.outer.itemView then
		if arg_62_1.outer.itemView.RestoreDescribeLayout then
			arg_62_1.outer.itemView:RestoreDescribeLayout()
		end

		if arg_62_2 and arg_62_1.outer.itemView.MarkLoopRemoving then
			arg_62_1.outer.itemView:MarkLoopRemoving()
		end

		arg_62_1.outer.itemView:Show(false)
		arg_62_1.outer.itemView:SetParent(self.poolHolder_)

		arg_62_1.outer.isFree = true
	end

	arg_62_1.isFree = true
end

function MomoTalkMessagePoolView:AppendItem(arg_63_1, arg_63_2)
	local var_63_0 = self:BuildSlot(arg_63_1, arg_63_2)

	table.insert(self.visibleSlots_, var_63_0)

	return var_63_0.itemView
end

function MomoTalkMessagePoolView:RemoveLastItem()
	if self.loopScrollView_ then
		local var_64_0 = self.loopScrollView_:GetItemList()

		if #var_64_0 > 0 then
			self.loopScrollView_:DeleteIndex(#var_64_0)
		end
	elseif #self.visibleSlots_ > 0 then
		self:ReturnSlot((table.remove(self.visibleSlots_, #self.visibleSlots_)))
	end
end

function MomoTalkMessagePoolView:Clear()
	if self.loopScrollView_ then
		self.loopScrollView_:DeleteAllItem()

		return
	end

	for iter_65_0 = #self.visibleSlots_, 1, -1 do
		self:ReturnSlot(self.visibleSlots_[iter_65_0])
		table.remove(self.visibleSlots_, iter_65_0)
	end
end

function MomoTalkMessagePoolView:ScrollToEnd()
	self:RefreshLoopMetrics()
	self:RefreshToEnd()
	self:SetScrollToBottom()
end

function MomoTalkMessagePoolView:ScrollToIndex(arg_67_1)
	self:RefreshLoopMetrics()

	arg_67_1 = math.max(1, arg_67_1 or 1)

	if self.loopScrollView_ then
		self.loopScrollView_:NavigateIndex(arg_67_1)

		if self.scrollContentTrs_ then
			LayoutRebuilder.ForceRebuildLayoutImmediate(self.scrollContentTrs_)
		end

		if self.loopScrollView_.scrollView_ then
			self.loopScrollView_.scrollView_.verticalNormalizedPosition = 0.9999
		end
	else
		self:Clear()

		for iter_67_0 = arg_67_1, #self.dataList_ do
			table.insert(self.visibleSlots_, (self:BuildSlot(self.dataList_[iter_67_0], iter_67_0)))
		end

		if self.scrollRect_ then
			self.scrollRect_.verticalNormalizedPosition = 0.9999
		end
	end
end

function MomoTalkMessagePoolView:LsGetItemData()
	return self.dataList_ or {}
end

function MomoTalkMessagePoolView:LsAddItem(arg_69_1, arg_69_2)
	return self:BuildSlot(arg_69_1, arg_69_2)
end

function MomoTalkMessagePoolView:LsUpdateItem(arg_70_1, arg_70_2, arg_70_3)
	self:RefreshSlot(arg_70_1, arg_70_2, arg_70_3)
end

function MomoTalkMessagePoolView:LsRemoveItem(arg_71_1)
	self:ReturnSlot(arg_71_1, true)
end

function MomoTalkMessagePoolView:Dispose()
	self:StopScrollTimer()
	self:StopEnterAnimationMarkTimer()

	if self.loopScrollView_ then
		self.loopScrollView_:Dispose()

		self.loopScrollView_ = nil
	end

	for iter_72_0, iter_72_1 in pairs(self.outerPoolDic_) do
		for iter_72_2, iter_72_3 in ipairs(iter_72_1) do
			iter_72_3.itemView:Dispose()
		end
	end

	self.outerPoolDic_ = {}

	for iter_72_4, iter_72_5 in pairs(self.contentPoolDic_) do
		for iter_72_6, iter_72_7 in ipairs(iter_72_5) do
			iter_72_7.itemView:Dispose()
		end
	end

	self.contentPoolDic_ = {}
	self.visibleSlots_ = {}

	MomoTalkMessagePoolView.super.Dispose(self)
end

return MomoTalkMessagePoolView
