local var_0_0 = import("game.views.chat.loopScrollView.LoopScrollView")
local var_0_1 = import("game.views.momoTalk.momotalkItem.TalkShowItem.MomoTalkReplyItem")
local var_0_2 = import("game.views.momoTalk.momotalkItem.TalkShowItem.MomoTalkNoneItem")
local var_0_3 = import("game.views.momoTalk.momotalkItem.TalkShowItem.MomoTalkTipsItem")
local var_0_4 = import("game.views.momoTalk.momotalkItem.TalkShowItem.MomoTalkBubblePicItem")
local var_0_5 = import("game.views.momoTalk.momotalkItem.TalkShowItem.MomoTalkBubbleTalkItem")
local var_0_6 = import("game.views.momoTalk.momotalkItem.TalkShowItem.MomoTalkBubbleWorldItem")
local var_0_7 = class("MomoTalkMessagePoolView", ReduxView)
local var_0_8 = 0.8
local var_0_9 = {
	replyM = var_0_1,
	replyO = var_0_1,
	tips = var_0_3,
	none = var_0_2
}
local var_0_10 = {
	chatBubblePic = var_0_4,
	chatBubbleTalk = var_0_5,
	chatBubbleWorld = var_0_6
}

function var_0_7.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()

	arg_1_0.scrollContentTrs_ = arg_1_2
	arg_1_0.scrollRect_ = arg_1_3
	arg_1_0.sourceDataList_ = {}
	arg_1_0.dataList_ = {}
	arg_1_0.visibleSlots_ = {}
	arg_1_0.outerPoolDic_ = {}
	arg_1_0.contentPoolDic_ = {}
	arg_1_0.poolHolder_ = arg_1_0.poolContent_ or arg_1_0.transform_
	arg_1_0.enterAnimationMarkTimer_ = nil

	arg_1_0:InitLoopScrollView()
end

function var_0_7.InitLoopScrollView(arg_2_0)
	local var_2_0
	local var_2_1 = 0
	local var_2_2 = 0

	if arg_2_0.scrollContentTrs_ then
		var_2_0 = arg_2_0.scrollContentTrs_.parent
		arg_2_0.viewPortTrs_ = var_2_0

		if var_2_0 then
			var_2_1 = var_2_0.rect.height
		end

		local var_2_3 = arg_2_0.scrollContentTrs_:GetComponent(typeof(UnityEngine.UI.VerticalLayoutGroup))

		arg_2_0.layoutGroup_ = var_2_3

		if var_2_3 then
			var_2_2 = var_2_3.spacing
		end
	end

	if arg_2_0.scrollRect_ and var_2_0 then
		arg_2_0.loopScrollView_ = var_0_0.New(arg_2_0, arg_2_0.scrollRect_, arg_2_0.scrollContentTrs_, var_2_0, var_2_1, var_2_2, true)
	end
end

function var_0_7.MarkRenderListEnterAnimation(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = math.min(arg_3_2 or #arg_3_1, #arg_3_1)

	while var_3_0 and var_3_0 > 0 do
		local var_3_1 = arg_3_1 and arg_3_1[var_3_0]
		local var_3_2 = var_3_1 and var_3_1.contentList or nil
		local var_3_3 = var_3_2 and var_3_2[#var_3_2] or nil

		if var_3_3 then
			var_3_3.playEnterAnimation = true

			arg_3_0:StartPlayingEnterAnimationMark(var_3_3.id)

			return var_3_0
		end

		var_3_0 = var_3_0 - 1
	end
end

function var_0_7.MarkRenderListEnterAnimationByContentID(arg_4_0, arg_4_1, arg_4_2)
	if not arg_4_2 or arg_4_2 <= 0 then
		return
	end

	for iter_4_0 = #(arg_4_1 or {}), 1, -1 do
		local var_4_0 = arg_4_1[iter_4_0]
		local var_4_1 = var_4_0 and var_4_0.contentList or nil

		for iter_4_1 = #(var_4_1 or {}), 1, -1 do
			local var_4_2 = var_4_1[iter_4_1]

			if var_4_2 and var_4_2.id == arg_4_2 then
				var_4_2.playEnterAnimation = true

				arg_4_0:StartPlayingEnterAnimationMark(var_4_2.id)

				return
			end
		end
	end
end

function var_0_7.ApplyPendingEnterAnimationMark(arg_5_0)
	local var_5_0 = arg_5_0.pendingEnterAnimationContentID_

	arg_5_0.pendingEnterAnimationContentID_ = nil

	if not var_5_0 then
		return
	end

	arg_5_0:MarkRenderListEnterAnimationByContentID(arg_5_0.dataList_, var_5_0)
end

function var_0_7.ApplyPlayingEnterAnimationMark(arg_6_0)
	if not arg_6_0.playingEnterAnimationContentID_ then
		return
	end

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.dataList_ or {}) do
		for iter_6_2, iter_6_3 in ipairs(iter_6_1 and iter_6_1.contentList or {}) do
			if iter_6_3 and iter_6_3.id == arg_6_0.playingEnterAnimationContentID_ then
				iter_6_3.playEnterAnimation = true

				return
			end
		end
	end
end

function var_0_7.SetPendingEnterAnimationContentID(arg_7_0, arg_7_1)
	arg_7_0.pendingEnterAnimationContentID_ = tonumber(arg_7_1) or arg_7_1
end

function var_0_7.ClearRenderListEnterAnimationByContentID(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_2 then
		return
	end

	for iter_8_0, iter_8_1 in ipairs(arg_8_1 or {}) do
		for iter_8_2, iter_8_3 in ipairs(iter_8_1 and iter_8_1.contentList or {}) do
			if iter_8_3 and iter_8_3.id == arg_8_2 then
				iter_8_3.playEnterAnimation = nil
			end
		end
	end
end

function var_0_7.StopEnterAnimationMarkTimer(arg_9_0)
	if arg_9_0.enterAnimationMarkTimer_ then
		arg_9_0.enterAnimationMarkTimer_:Stop()

		arg_9_0.enterAnimationMarkTimer_ = nil
	end
end

function var_0_7.StartPlayingEnterAnimationMark(arg_10_0, arg_10_1)
	arg_10_0:StopEnterAnimationMarkTimer()

	arg_10_0.playingEnterAnimationContentID_ = arg_10_1
	arg_10_0.enterAnimationMarkTimer_ = Timer.New(function()
		arg_10_0.enterAnimationMarkTimer_ = nil

		arg_10_0:FinishPlayingEnterAnimationMark()
	end, var_0_8, 1)

	arg_10_0.enterAnimationMarkTimer_:Start()
end

function var_0_7.FinishPlayingEnterAnimationMark(arg_12_0)
	if not arg_12_0.playingEnterAnimationContentID_ then
		return
	end

	arg_12_0:ClearRenderListEnterAnimationByContentID(arg_12_0.dataList_, arg_12_0.playingEnterAnimationContentID_)

	arg_12_0.playingEnterAnimationContentID_ = nil
end

function var_0_7.ClearPlayingEnterAnimationMark(arg_13_0)
	arg_13_0:StopEnterAnimationMarkTimer()
	arg_13_0:FinishPlayingEnterAnimationMark()
end

function var_0_7.SetData(arg_14_0, arg_14_1)
	arg_14_0.sourceDataList_ = MomoTalkTools.ApplyRecallDisplayRules(arg_14_1 or {})
	arg_14_0.dataList_ = arg_14_0:BuildRenderList(arg_14_0.sourceDataList_)

	arg_14_0:ApplyPlayingEnterAnimationMark()
	arg_14_0:ApplyPendingEnterAnimationMark()
end

function var_0_7.BuildRenderList(arg_15_0, arg_15_1)
	local var_15_0 = {}
	local var_15_1

	for iter_15_0, iter_15_1 in ipairs(arg_15_1 or {}) do
		if iter_15_1 and iter_15_1.outerKey then
			table.insert(var_15_0, iter_15_1)

			var_15_1 = nil
		else
			local var_15_2 = clone(iter_15_1)

			var_15_2.isChatBegin = arg_15_0:IsChatBegin(var_15_1, iter_15_1)

			local var_15_3 = var_15_0[#var_15_0]

			if arg_15_0:CanMergeToLastRenderItem(var_15_3, var_15_2) then
				table.insert(var_15_3.contentList, var_15_2)
			else
				local var_15_4 = clone(iter_15_1)

				var_15_4.contentList = {
					var_15_2
				}

				table.insert(var_15_0, var_15_4)
			end

			var_15_1 = iter_15_1
		end
	end

	if arg_15_0:ShouldAppendDialogueNone(var_15_1) then
		table.insert(var_15_0, {
			outerKey = "none",
			noneState = "end",
			contentList = {}
		})
	end

	return var_15_0
end

function var_0_7.ShouldAppendDialogueNone(arg_16_0, arg_16_1)
	local var_16_0 = ChatContentCfg[arg_16_1 and arg_16_1.id or 0]

	if not var_16_0 then
		return false
	end

	if var_16_0.options ~= "" and #var_16_0.options > 0 then
		return false
	end

	return var_16_0.next_content_list == "" or #var_16_0.next_content_list == 0
end

function var_0_7.IsChatBegin(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = ChatContentCfg[arg_17_2 and arg_17_2.id or 0]
	local var_17_1 = ChatContentCfg[arg_17_1 and arg_17_1.id or 0]
	local var_17_2 = MomoTalkTools.GetItemDisplayType(arg_17_2, var_17_0)
	local var_17_3 = MomoTalkTools.GetItemDisplayType(arg_17_1, var_17_1)

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

function var_0_7.CanMergeToLastRenderItem(arg_18_0, arg_18_1, arg_18_2)
	if not arg_18_1 or not arg_18_2 then
		return false
	end

	local var_18_0 = arg_18_1.contentList or {
		arg_18_1
	}
	local var_18_1 = var_18_0[#var_18_0]
	local var_18_2 = ChatContentCfg[var_18_1 and var_18_1.id or 0]
	local var_18_3 = ChatContentCfg[arg_18_2.id or 0]
	local var_18_4 = MomoTalkTools.GetItemDisplayType(var_18_1, var_18_2)
	local var_18_5 = MomoTalkTools.GetItemDisplayType(arg_18_2, var_18_3)

	if not var_18_3 or not var_18_2 then
		return false
	end

	if var_18_5 == MomoTalkConst.MSG_TYPE.NARRATE or var_18_5 == MomoTalkConst.MSG_TYPE.RECALL then
		return false
	end

	if var_18_4 == MomoTalkConst.MSG_TYPE.NARRATE or var_18_4 == MomoTalkConst.MSG_TYPE.RECALL then
		return false
	end

	local var_18_6 = var_18_2.spokesmen == 0
	local var_18_7 = var_18_3.spokesmen == 0
	local var_18_8 = arg_18_0:GetOuterKey(var_18_4, var_18_6)
	local var_18_9 = arg_18_0:GetOuterKey(var_18_5, var_18_7)

	return var_18_2.spokesmen == var_18_3.spokesmen and var_18_8 == var_18_9 and (var_18_9 == "replyM" or var_18_9 == "replyO")
end

function var_0_7.ResetDataToEnd(arg_19_0, arg_19_1)
	arg_19_0:SetData(arg_19_1)

	if arg_19_0.loopScrollView_ then
		arg_19_0.loopScrollView_:DeleteAllItem()
	else
		arg_19_0:Clear()
	end

	arg_19_0:DelayScrollToEnd()
end

function var_0_7.ResetDataToIndex(arg_20_0, arg_20_1, arg_20_2)
	arg_20_0:SetData(arg_20_1)

	arg_20_2 = math.max(1, arg_20_2 or 1)

	if arg_20_0.loopScrollView_ then
		arg_20_0.loopScrollView_:DeleteAllItem()
	else
		arg_20_0:Clear()
	end

	arg_20_0:DelayScrollToIndex(arg_20_2)
end

function var_0_7.RefreshLoopMetrics(arg_21_0)
	if not arg_21_0.loopScrollView_ then
		return
	end

	if arg_21_0.viewPortTrs_ then
		arg_21_0.loopScrollView_:SetContentHeight(arg_21_0.viewPortTrs_.rect.height)
	end

	if arg_21_0.layoutGroup_ then
		arg_21_0.loopScrollView_.itemSpace_ = arg_21_0.layoutGroup_.spacing
	end
end

function var_0_7.RefreshToEndImmediately(arg_22_0)
	if arg_22_0.loopScrollView_ then
		arg_22_0.loopScrollView_:DeleteAllItem()
	else
		arg_22_0:Clear()
	end

	arg_22_0:ScrollToEnd()
end

function var_0_7.AppendLoopTailItemToEnd(arg_23_0)
	if not arg_23_0.loopScrollView_ then
		arg_23_0:RefreshToEnd()

		return
	end

	arg_23_0:RefreshLoopMetrics()

	repeat
		local var_23_0 = arg_23_0:GetLastLoopSlot()
		local var_23_1 = var_23_0 and var_23_0.itemView and var_23_0.itemView:GetIndex() or 0

		if var_23_1 >= #arg_23_0.dataList_ then
			break
		end

		arg_23_0.loopScrollView_:AddTailItem()

		local var_23_2 = arg_23_0:GetLastLoopSlot()
	until var_23_1 >= (var_23_2 and var_23_2.itemView and var_23_2.itemView:GetIndex() or 0)

	arg_23_0:SetScrollToBottom()
end

function var_0_7.CanAppendLoopTailItem(arg_24_0, arg_24_1)
	if not arg_24_0.loopScrollView_ or not arg_24_1 or arg_24_1 <= 0 then
		return false
	end

	local var_24_0 = arg_24_0:GetLastLoopSlot()

	if not var_24_0 or not var_24_0.itemView then
		return false
	end

	return var_24_0.itemView:GetIndex() == arg_24_1
end

function var_0_7.GetLastLoopSlot(arg_25_0)
	if not arg_25_0.loopScrollView_ then
		return nil
	end

	local var_25_0 = arg_25_0.loopScrollView_:GetItemList()

	return var_25_0 and var_25_0[#var_25_0] or nil
end

function var_0_7.RefreshLastLoopSlotToEnd(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0:GetLastLoopSlot()

	if not var_26_0 or not var_26_0.itemView or var_26_0.itemView:GetIndex() ~= arg_26_1 then
		return false
	end

	local var_26_1 = var_26_0.cachedHeight_ or var_26_0.itemView:GetItemHeight()

	arg_26_0:LsUpdateItem(var_26_0, arg_26_0.dataList_[arg_26_1], arg_26_1)
	arg_26_0:RebuildSlotLayout(var_26_0, var_26_1)
	arg_26_0:SetScrollToBottom()

	return true
end

function var_0_7.RefreshVisibleLoopSlots(arg_27_0)
	if not arg_27_0.loopScrollView_ then
		return false
	end

	local var_27_0 = arg_27_0.loopScrollView_:GetItemList()

	if not var_27_0 then
		return false
	end

	for iter_27_0, iter_27_1 in ipairs(var_27_0) do
		local var_27_1 = iter_27_1 and iter_27_1.itemView and iter_27_1.itemView:GetIndex() or nil

		if var_27_1 and arg_27_0.dataList_[var_27_1] then
			local var_27_2 = iter_27_1.cachedHeight_ or iter_27_1.itemView:GetItemHeight()

			arg_27_0:LsUpdateItem(iter_27_1, arg_27_0.dataList_[var_27_1], var_27_1)
			arg_27_0:RebuildSlotLayout(iter_27_1, var_27_2)
		end
	end

	return true
end

function var_0_7.RefreshVisibleShowContinueState(arg_28_0)
	if not arg_28_0.loopScrollView_ then
		return false
	end

	local var_28_0 = arg_28_0.loopScrollView_:GetItemList()

	if not var_28_0 then
		return false
	end

	for iter_28_0, iter_28_1 in ipairs(var_28_0) do
		local var_28_1 = iter_28_1 and iter_28_1.itemView and iter_28_1.itemView:GetIndex() or nil
		local var_28_2 = var_28_1 and arg_28_0.dataList_[var_28_1] or nil

		if var_28_2 then
			arg_28_0:RefreshSlotShowContinueState(iter_28_1, var_28_2)
		end
	end

	return true
end

function var_0_7.RefreshSlotShowContinueState(arg_29_0, arg_29_1, arg_29_2)
	if not arg_29_1 then
		return
	end

	local var_29_0 = arg_29_0:GetRenderContentList(arg_29_2)

	if arg_29_1.contents and #arg_29_1.contents > 0 then
		for iter_29_0, iter_29_1 in ipairs(var_29_0) do
			local var_29_1 = arg_29_1.contents[iter_29_0]

			if var_29_1 and var_29_1.itemView and var_29_1.itemView.RefreshShowContinue then
				var_29_1.itemView:RefreshShowContinue(iter_29_1)
			end
		end

		return
	end

	if arg_29_1.itemView and arg_29_1.itemView.RefreshShowContinue then
		arg_29_1.itemView:RefreshShowContinue(arg_29_2)
	end
end

function var_0_7.ShouldRefreshVisibleSlotsOnAppend(arg_30_0, arg_30_1)
	local var_30_0 = ChatContentCfg[arg_30_1 and arg_30_1.id or 0]

	return var_30_0 and var_30_0.type == MomoTalkConst.MSG_TYPE.RECALL
end

function var_0_7.RebuildSlotLayout(arg_31_0, arg_31_1, arg_31_2)
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

	if arg_31_0.scrollContentTrs_ then
		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_0.scrollContentTrs_)
	end

	local var_31_0 = arg_31_1.itemView:GetItemHeight()

	arg_31_1.cachedHeight_ = var_31_0

	if arg_31_0.loopScrollView_ and var_31_0 ~= arg_31_2 then
		arg_31_0.loopScrollView_.contentHeight_ = math.max(0, (arg_31_0.loopScrollView_.contentHeight_ or 0) + var_31_0 - arg_31_2)
	end
end

function var_0_7.AppendDataToEnd(arg_32_0, arg_32_1)
	local var_32_0 = #arg_32_0.dataList_

	arg_32_0:ClearPlayingEnterAnimationMark()
	arg_32_0:SetData(arg_32_1)
	arg_32_0:RefreshVisibleShowContinueState()

	local var_32_1

	if var_32_0 < #arg_32_0.dataList_ then
		var_32_1 = #arg_32_0.dataList_
	elseif #arg_32_0.dataList_ > 0 then
		var_32_1 = var_32_0
	end

	local var_32_2

	if var_32_1 then
		var_32_2 = arg_32_0:MarkRenderListEnterAnimation(arg_32_0.dataList_, var_32_1)
	end

	local var_32_3 = var_32_2 and arg_32_0:GetRenderContentList(arg_32_0.dataList_[var_32_2])[1] or nil

	if arg_32_0:ShouldRefreshVisibleSlotsOnAppend(var_32_3) then
		arg_32_0:RefreshVisibleLoopSlots()
	end

	if var_32_2 and var_32_2 ~= var_32_1 then
		arg_32_0:RefreshLastLoopSlotToEnd(var_32_2)
	end

	if var_32_1 and var_32_0 < var_32_1 and arg_32_0:CanAppendLoopTailItem(var_32_0) then
		arg_32_0:AppendLoopTailItemToEnd()
	elseif var_32_1 and arg_32_0:RefreshLastLoopSlotToEnd(var_32_1) then
		-- block empty
	else
		arg_32_0:RefreshToEndImmediately()
	end
end

function var_0_7.ReplaceLastDataToEnd(arg_33_0, arg_33_1)
	arg_33_0:SetData(arg_33_1)

	local var_33_0 = #arg_33_0.dataList_
	local var_33_1 = var_33_0

	if var_33_0 > 0 then
		var_33_1 = arg_33_0:MarkRenderListEnterAnimation(arg_33_0.dataList_, var_33_0) or var_33_0
	end

	if not arg_33_0:RefreshLastLoopSlotToEnd(var_33_1) then
		arg_33_0:RefreshToEndImmediately()
	end
end

function var_0_7.SetScrollToBottom(arg_34_0)
	if arg_34_0.loopScrollView_ and arg_34_0.loopScrollView_.scrollView_ then
		arg_34_0:RefreshLoopMetrics()

		if arg_34_0.scrollContentTrs_ then
			LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_0.scrollContentTrs_)
		end

		arg_34_0.loopScrollView_.scrollView_.verticalNormalizedPosition = 0.0001
	end
end

function var_0_7.DelayScrollToEnd(arg_35_0, arg_35_1)
	arg_35_0:StopScrollTimer()

	arg_35_1 = arg_35_1 or 2
	arg_35_0.scrollTimer_ = FrameTimer.New(function()
		arg_35_0.scrollTimer_ = nil

		arg_35_0:ScrollToEnd()
	end, arg_35_1, 1)

	arg_35_0.scrollTimer_:Start()
end

function var_0_7.DelayScrollToIndex(arg_37_0, arg_37_1, arg_37_2)
	arg_37_0:StopScrollTimer()

	arg_37_2 = arg_37_2 or 2
	arg_37_0.scrollTimer_ = FrameTimer.New(function()
		arg_37_0.scrollTimer_ = nil

		arg_37_0:ScrollToIndex(arg_37_1)
	end, arg_37_2, 1)

	arg_37_0.scrollTimer_:Start()
end

function var_0_7.StopScrollTimer(arg_39_0)
	if arg_39_0.scrollTimer_ then
		arg_39_0.scrollTimer_:Stop()

		arg_39_0.scrollTimer_ = nil
	end
end

function var_0_7.RefreshToEnd(arg_40_0)
	if arg_40_0.loopScrollView_ then
		arg_40_0.loopScrollView_:Scroll2End()
	else
		arg_40_0:Clear()

		for iter_40_0, iter_40_1 in ipairs(arg_40_0.dataList_) do
			local var_40_0 = arg_40_0:BuildSlot(iter_40_1, iter_40_0)

			table.insert(arg_40_0.visibleSlots_, var_40_0)
		end
	end
end

function var_0_7.RefreshKeepPosition(arg_41_0)
	if arg_41_0.loopScrollView_ then
		arg_41_0.loopScrollView_:RefreshScrollView(true, true)
	else
		arg_41_0:RefreshToEnd()
	end
end

function var_0_7.DelayLockOuterDescribeLayout(arg_42_0, arg_42_1)
	if not arg_42_1 or not arg_42_1.DelayLockDescribeLayout then
		return
	end

	arg_42_1:DelayLockDescribeLayout(0.01)
end

function var_0_7.ShouldLockOuterDescribeLayout(arg_43_0, arg_43_1)
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

function var_0_7.ShouldPlayOuterEnterAnimation(arg_44_0, arg_44_1)
	local var_44_0 = arg_44_1 and arg_44_1[1] or nil

	return var_44_0 and var_44_0.playEnterAnimation == true
end

function var_0_7.PlayOuterEnterAnimation(arg_45_0, arg_45_1, arg_45_2)
	if not arg_45_1 or not arg_45_1.itemView or not arg_45_1.itemView.PlayOuterEnterAnimation then
		return
	end

	if arg_45_0:ShouldPlayOuterEnterAnimation(arg_45_2) then
		arg_45_1.itemView:PlayOuterEnterAnimation()
	end
end

function var_0_7.PlaySlotEnterAnimation(arg_46_0, arg_46_1, arg_46_2)
	if not arg_46_1 or not arg_46_1.contents then
		return
	end

	for iter_46_0 = #(arg_46_2 or {}), 1, -1 do
		local var_46_0 = arg_46_2[iter_46_0]
		local var_46_1 = arg_46_1.contents[iter_46_0]

		if var_46_0 and var_46_0.playEnterAnimation and var_46_1 and var_46_1.itemView then
			var_46_1.itemView:PlayEnterAnimation(var_46_0)

			return
		end
	end
end

function var_0_7.GetOuterKey(arg_47_0, arg_47_1, arg_47_2)
	if arg_47_1 == 0 or arg_47_1 == MomoTalkConst.MSG_TYPE.TEXT or arg_47_1 == MomoTalkConst.MSG_TYPE.IMAGE or arg_47_1 == MomoTalkConst.MSG_TYPE.STICKER or arg_47_1 == MomoTalkConst.MSG_TYPE.AUDIO then
		return arg_47_2 and "replyM" or "replyO"
	end

	if arg_47_1 == MomoTalkConst.MSG_TYPE.RECALL or arg_47_1 == MomoTalkConst.MSG_TYPE.NARRATE then
		return "tips"
	end

	return "none"
end

function var_0_7.GetOuterTemplate(arg_48_0, arg_48_1)
	if arg_48_1 == "replyM" then
		return arg_48_0.dialogueReplyMGo_
	end

	if arg_48_1 == "replyO" then
		return arg_48_0.dialogueReplyOGo_
	end

	if arg_48_1 == "tips" then
		return arg_48_0.dialogueTipsGo_
	end

	return arg_48_0.dialogueNoneGo_
end

function var_0_7.GetFreeOuter(arg_49_0, arg_49_1)
	if not arg_49_0.outerPoolDic_[arg_49_1] then
		arg_49_0.outerPoolDic_[arg_49_1] = {}
	end

	local var_49_0 = arg_49_0.outerPoolDic_[arg_49_1]

	for iter_49_0, iter_49_1 in ipairs(var_49_0) do
		if iter_49_1.isFree then
			iter_49_1.isFree = false

			return iter_49_1
		end
	end

	local var_49_1 = var_0_9[arg_49_1] or var_0_2
	local var_49_2 = arg_49_0:GetOuterTemplate(arg_49_1)
	local var_49_3 = var_49_1.New(var_49_2, arg_49_0.poolHolder_)

	var_49_3:Show(false)

	local var_49_4 = {
		isFree = false,
		itemView = var_49_3,
		outerKey = arg_49_1
	}

	table.insert(var_49_0, var_49_4)

	return var_49_4
end

function var_0_7.GetContentKey(arg_50_0, arg_50_1)
	if arg_50_1 == MomoTalkConst.MSG_TYPE.IMAGE or arg_50_1 == MomoTalkConst.MSG_TYPE.STICKER then
		return "chatBubblePic"
	elseif arg_50_1 == MomoTalkConst.MSG_TYPE.AUDIO then
		return "chatBubbleTalk"
	elseif arg_50_1 == 0 or arg_50_1 == MomoTalkConst.MSG_TYPE.TEXT or arg_50_1 == MomoTalkConst.MSG_TYPE.NARRATE then
		return "chatBubbleWorld"
	end

	return nil
end

function var_0_7.GetContentTemplate(arg_51_0, arg_51_1)
	if arg_51_1 == "chatBubblePic" then
		return arg_51_0.bubblePicGo_
	end

	if arg_51_1 == "chatBubbleTalk" then
		return arg_51_0.bubbleTalkGo_
	end

	if arg_51_1 == "chatBubbleWorld" then
		return arg_51_0.bubbleWorldGo_
	end

	return nil
end

function var_0_7.GetFreeContent(arg_52_0, arg_52_1)
	if not arg_52_0.contentPoolDic_[arg_52_1] then
		arg_52_0.contentPoolDic_[arg_52_1] = {}
	end

	local var_52_0 = arg_52_0.contentPoolDic_[arg_52_1]

	for iter_52_0, iter_52_1 in ipairs(var_52_0) do
		if iter_52_1.isFree then
			iter_52_1.isFree = false

			return iter_52_1
		end
	end

	local var_52_1 = arg_52_0:GetContentTemplate(arg_52_1)
	local var_52_2 = var_0_10[arg_52_1]

	if not var_52_1 or not var_52_2 then
		return nil
	end

	local var_52_3 = var_52_2.New(var_52_1, arg_52_0.poolHolder_)

	var_52_3:Show(false)

	local var_52_4 = {
		isFree = false,
		itemView = var_52_3,
		contentKey = arg_52_1
	}

	table.insert(var_52_0, var_52_4)

	return var_52_4
end

function var_0_7.GetItemDisplayCfg(arg_53_0, arg_53_1)
	local var_53_0 = ChatContentCfg[arg_53_1 and arg_53_1.id or 0]
	local var_53_1 = MomoTalkTools.GetItemDisplayContent(arg_53_1, var_53_0)
	local var_53_2 = MomoTalkTools.GetItemDisplayType(arg_53_1, var_53_0)

	return {
		id = var_53_0 and var_53_0.id or 0,
		spokesmen = var_53_0 and var_53_0.spokesmen or 0,
		content = var_53_1,
		txt = var_53_1,
		type = var_53_2,
		url = var_53_0 and var_53_0.url or "",
		options = var_53_0 and var_53_0.options or "",
		next_content_list = var_53_0 and var_53_0.next_content_list or "",
		belong = var_53_0 and var_53_0.belong or 0,
		is_turn = var_53_0 and var_53_0.is_turn or 0,
		voice_params = var_53_0 and var_53_0.voice_params or "",
		delay = var_53_0 and var_53_0.delay or 0
	}
end

function var_0_7.GetRenderContentList(arg_54_0, arg_54_1)
	return arg_54_1 and arg_54_1.contentList or {}
end

function var_0_7.GetRenderOuterKey(arg_55_0, arg_55_1, arg_55_2)
	if arg_55_1 and arg_55_1.outerKey then
		return arg_55_1.outerKey
	end

	local var_55_0 = arg_55_0:GetItemDisplayCfg(arg_55_2)
	local var_55_1 = var_55_0 and var_55_0.type or MomoTalkConst.MSG_TYPE.TEXT
	local var_55_2 = var_55_0 and var_55_0.spokesmen == 0 or false

	return arg_55_0:GetOuterKey(var_55_1, var_55_2)
end

function var_0_7.IsSameContentShape(arg_56_0, arg_56_1, arg_56_2)
	if #(arg_56_1 and arg_56_1.contents or {}) ~= #arg_56_2 then
		return false
	end

	for iter_56_0, iter_56_1 in ipairs(arg_56_2) do
		local var_56_0 = arg_56_0:GetItemDisplayCfg(iter_56_1)
		local var_56_1 = arg_56_0:GetContentKey(var_56_0 and var_56_0.type or MomoTalkConst.MSG_TYPE.TEXT)

		if arg_56_0:GetSlotContentKey(arg_56_1, iter_56_0) ~= var_56_1 then
			return false
		end
	end

	return true
end

function var_0_7.GetSlotContentKey(arg_57_0, arg_57_1, arg_57_2)
	local var_57_0 = arg_57_1 and arg_57_1.contents and arg_57_1.contents[arg_57_2 or 1]

	return var_57_0 and var_57_0.contentKey or nil
end

function var_0_7.BuildSlot(arg_58_0, arg_58_1, arg_58_2)
	local var_58_0 = arg_58_0:GetRenderContentList(arg_58_1)
	local var_58_1 = var_58_0[1]
	local var_58_2 = arg_58_0:GetItemDisplayCfg(var_58_1)
	local var_58_3 = arg_58_0:GetRenderOuterKey(arg_58_1, var_58_1)
	local var_58_4 = arg_58_0:GetFreeOuter(var_58_3)
	local var_58_5 = {}

	var_58_4.itemView:SetParent(arg_58_0.scrollContentTrs_)
	var_58_4.itemView:Show(true)

	if var_58_3 == "replyM" or var_58_3 == "replyO" then
		for iter_58_0, iter_58_1 in ipairs(var_58_0) do
			local var_58_6 = arg_58_0:GetItemDisplayCfg(iter_58_1)
			local var_58_7 = arg_58_0:GetContentKey(var_58_6 and var_58_6.type or MomoTalkConst.MSG_TYPE.TEXT)
			local var_58_8 = var_58_7 and arg_58_0:GetFreeContent(var_58_7) or nil

			if var_58_8 then
				var_58_4.itemView:AttachContent(var_58_8.itemView)
				var_58_8.itemView:Show(true)
				var_58_8.itemView:Reset(var_58_6, iter_58_1)
				table.insert(var_58_5, var_58_8)
			end
		end
	end

	var_58_4.itemView:Reset(var_58_2, arg_58_1, arg_58_2)

	if var_58_3 == "replyM" or var_58_3 == "replyO" then
		if arg_58_0:ShouldLockOuterDescribeLayout(var_58_0) then
			arg_58_0:DelayLockOuterDescribeLayout(var_58_4.itemView)
		else
			var_58_4.itemView:RestoreDescribeLayout()
		end

		arg_58_0:PlayOuterEnterAnimation(var_58_4, var_58_0)
	end

	local var_58_9 = {
		isFree = false,
		itemView = var_58_4.itemView,
		outer = var_58_4,
		contents = var_58_5
	}

	arg_58_0:BindSlotLayoutChanged(var_58_9)
	arg_58_0:PlaySlotEnterAnimation(var_58_9, var_58_0)

	return var_58_9
end

function var_0_7.RefreshSlot(arg_59_0, arg_59_1, arg_59_2, arg_59_3)
	if not arg_59_1 or not arg_59_1.outer then
		return
	end

	local var_59_0 = arg_59_0:GetRenderContentList(arg_59_2)
	local var_59_1 = var_59_0[1]
	local var_59_2 = arg_59_0:GetItemDisplayCfg(var_59_1)
	local var_59_3 = arg_59_0:GetRenderOuterKey(arg_59_2, var_59_1)

	if arg_59_1.outer.outerKey ~= var_59_3 or not arg_59_0:IsSameContentShape(arg_59_1, var_59_0) then
		arg_59_0:ReturnSlot(arg_59_1)

		local var_59_4 = arg_59_0:BuildSlot(arg_59_2, arg_59_3)

		arg_59_1.itemView = var_59_4.itemView
		arg_59_1.outer = var_59_4.outer
		arg_59_1.contents = var_59_4.contents
		arg_59_1.isFree = false

		arg_59_0:BindSlotLayoutChanged(arg_59_1)

		return
	end

	for iter_59_0, iter_59_1 in ipairs(var_59_0) do
		local var_59_5 = arg_59_0:GetItemDisplayCfg(iter_59_1)
		local var_59_6 = arg_59_1.contents[iter_59_0]

		if var_59_6 and var_59_6.itemView then
			var_59_6.itemView:Reset(var_59_5, iter_59_1)
		end
	end

	arg_59_1.outer.itemView:Reset(var_59_2, arg_59_2, arg_59_3)

	if var_59_3 == "replyM" or var_59_3 == "replyO" then
		if arg_59_0:ShouldLockOuterDescribeLayout(var_59_0) then
			arg_59_0:DelayLockOuterDescribeLayout(arg_59_1.outer.itemView)
		else
			arg_59_1.outer.itemView:RestoreDescribeLayout()
		end
	end

	arg_59_0:BindSlotLayoutChanged(arg_59_1)
	arg_59_0:PlaySlotEnterAnimation(arg_59_1, var_59_0)
end

function var_0_7.BindSlotLayoutChanged(arg_60_0, arg_60_1)
	if not arg_60_1 then
		return
	end

	for iter_60_0, iter_60_1 in ipairs(arg_60_1.contents or {}) do
		if iter_60_1.itemView then
			iter_60_1.itemView.layoutChangedHandler_ = handler(arg_60_0, arg_60_0.OnContentLayoutChanged)
			iter_60_1.itemView.layoutChangedSlot_ = arg_60_1
		end
	end

	arg_60_1.cachedHeight_ = arg_60_1.itemView and arg_60_1.itemView:GetItemHeight() or 0
end

function var_0_7.OnContentLayoutChanged(arg_61_0, arg_61_1)
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

	if arg_61_0.scrollContentTrs_ then
		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_0.scrollContentTrs_)
	end

	local var_61_1 = arg_61_1.itemView:GetItemHeight()

	arg_61_1.cachedHeight_ = var_61_1

	if arg_61_0.loopScrollView_ and var_61_1 ~= var_61_0 then
		arg_61_0.loopScrollView_.contentHeight_ = math.max(0, (arg_61_0.loopScrollView_.contentHeight_ or 0) + var_61_1 - var_61_0)
	end
end

function var_0_7.ReturnSlot(arg_62_0, arg_62_1, arg_62_2)
	if not arg_62_1 then
		return
	end

	if arg_62_1.contents then
		for iter_62_0, iter_62_1 in ipairs(arg_62_1.contents) do
			if iter_62_1.itemView then
				iter_62_1.itemView.layoutChangedHandler_ = nil
				iter_62_1.itemView.layoutChangedSlot_ = nil

				arg_62_1.outer.itemView:DetachContent(iter_62_1.itemView, arg_62_0.poolHolder_)
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
		arg_62_1.outer.itemView:SetParent(arg_62_0.poolHolder_)

		arg_62_1.outer.isFree = true
	end

	arg_62_1.isFree = true
end

function var_0_7.AppendItem(arg_63_0, arg_63_1, arg_63_2)
	local var_63_0 = arg_63_0:BuildSlot(arg_63_1, arg_63_2)

	table.insert(arg_63_0.visibleSlots_, var_63_0)

	return var_63_0.itemView
end

function var_0_7.RemoveLastItem(arg_64_0)
	if arg_64_0.loopScrollView_ then
		local var_64_0 = arg_64_0.loopScrollView_:GetItemList()

		if #var_64_0 > 0 then
			arg_64_0.loopScrollView_:DeleteIndex(#var_64_0)
		end
	elseif #arg_64_0.visibleSlots_ > 0 then
		local var_64_1 = table.remove(arg_64_0.visibleSlots_, #arg_64_0.visibleSlots_)

		arg_64_0:ReturnSlot(var_64_1)
	end
end

function var_0_7.Clear(arg_65_0)
	if arg_65_0.loopScrollView_ then
		arg_65_0.loopScrollView_:DeleteAllItem()

		return
	end

	for iter_65_0 = #arg_65_0.visibleSlots_, 1, -1 do
		local var_65_0 = arg_65_0.visibleSlots_[iter_65_0]

		arg_65_0:ReturnSlot(var_65_0)
		table.remove(arg_65_0.visibleSlots_, iter_65_0)
	end
end

function var_0_7.ScrollToEnd(arg_66_0)
	arg_66_0:RefreshLoopMetrics()
	arg_66_0:RefreshToEnd()
	arg_66_0:SetScrollToBottom()
end

function var_0_7.ScrollToIndex(arg_67_0, arg_67_1)
	arg_67_0:RefreshLoopMetrics()

	arg_67_1 = math.max(1, arg_67_1 or 1)

	if arg_67_0.loopScrollView_ then
		arg_67_0.loopScrollView_:NavigateIndex(arg_67_1)

		if arg_67_0.scrollContentTrs_ then
			LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_0.scrollContentTrs_)
		end

		if arg_67_0.loopScrollView_.scrollView_ then
			arg_67_0.loopScrollView_.scrollView_.verticalNormalizedPosition = 0.9999
		end
	else
		arg_67_0:Clear()

		for iter_67_0 = arg_67_1, #arg_67_0.dataList_ do
			local var_67_0 = arg_67_0:BuildSlot(arg_67_0.dataList_[iter_67_0], iter_67_0)

			table.insert(arg_67_0.visibleSlots_, var_67_0)
		end

		if arg_67_0.scrollRect_ then
			arg_67_0.scrollRect_.verticalNormalizedPosition = 0.9999
		end
	end
end

function var_0_7.LsGetItemData(arg_68_0)
	return arg_68_0.dataList_ or {}
end

function var_0_7.LsAddItem(arg_69_0, arg_69_1, arg_69_2)
	return arg_69_0:BuildSlot(arg_69_1, arg_69_2)
end

function var_0_7.LsUpdateItem(arg_70_0, arg_70_1, arg_70_2, arg_70_3)
	arg_70_0:RefreshSlot(arg_70_1, arg_70_2, arg_70_3)
end

function var_0_7.LsRemoveItem(arg_71_0, arg_71_1)
	arg_71_0:ReturnSlot(arg_71_1, true)
end

function var_0_7.Dispose(arg_72_0)
	arg_72_0:StopScrollTimer()
	arg_72_0:StopEnterAnimationMarkTimer()

	if arg_72_0.loopScrollView_ then
		arg_72_0.loopScrollView_:Dispose()

		arg_72_0.loopScrollView_ = nil
	end

	for iter_72_0, iter_72_1 in pairs(arg_72_0.outerPoolDic_) do
		for iter_72_2, iter_72_3 in ipairs(iter_72_1) do
			iter_72_3.itemView:Dispose()
		end
	end

	arg_72_0.outerPoolDic_ = {}

	for iter_72_4, iter_72_5 in pairs(arg_72_0.contentPoolDic_) do
		for iter_72_6, iter_72_7 in ipairs(iter_72_5) do
			iter_72_7.itemView:Dispose()
		end
	end

	arg_72_0.contentPoolDic_ = {}
	arg_72_0.visibleSlots_ = {}

	var_0_7.super.Dispose(arg_72_0)
end

return var_0_7
