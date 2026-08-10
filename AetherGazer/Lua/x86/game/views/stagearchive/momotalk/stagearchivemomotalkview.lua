local var_0_0 = class("StageArchiveMomoTalkView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Operation/OperationMomoTalkUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:InitPlayer()
	arg_4_0:InitDisplayWindow()
	arg_4_0:InitItemPool()
end

function var_0_0.InitPlayer(arg_5_0)
	arg_5_0.updatePeriod_ = GameSetting.plot_archives_play_speed.value[1] / 1000
	arg_5_0.newMessageHandler_ = handler(arg_5_0, arg_5_0.OnNewMessage)
	arg_5_0.player_ = StageArchiveMomoTalkPlayer.New(arg_5_0.newMessageHandler_, arg_5_0.updatePeriod_)
end

function var_0_0.InitDisplayWindow(arg_6_0)
	local var_6_0 = arg_6_0.diaViewPortTrs_.rect.height
	local var_6_1 = arg_6_0.diaGridTrs_:GetComponent("VerticalLayoutGroup").spacing

	arg_6_0.loopScrollView_ = LoopScrollView.New(arg_6_0, arg_6_0.diaScrollEx_, arg_6_0.diaGridTrs_, arg_6_0.diaViewPortTrs_, var_6_0, var_6_1, true)
end

function var_0_0.InitItemPool(arg_7_0)
	arg_7_0.itemPool_ = StageArchiveMomoTalkPool.New()

	arg_7_0.itemPool_:Init()
end

function var_0_0.AddListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.maskBtn_, nil, function()
		arg_8_0:Back()
	end)
	arg_8_0.skipEventListener:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerClick, LuaHelper.EventTriggerAction1(handler(arg_8_0, arg_8_0.OnSkip)))
	arg_8_0:AddBtnListener(arg_8_0.skipBtn_, nil, function()
		arg_8_0:OnSkip()
	end)
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0.archiveID_ = arg_11_0.params_.archiveID
	arg_11_0.customID = arg_11_0.params_.customID

	arg_11_0:InitMessageData()
	arg_11_0:PlayTalk()
end

function var_0_0.InitMessageData(arg_12_0)
	if not arg_12_0.customID then
		local var_12_0 = StageArchivesCollectCfg[arg_12_0.archiveID_].archive_parameter

		arg_12_0.messageIDList_ = StageArchivesCollectMomoTalkCfg.get_id_list_by_momotalk_plot_id[var_12_0]
	else
		arg_12_0.messageIDList_ = StageArchivesCollectMomoTalkCfg.get_id_list_by_momotalk_plot_id[arg_12_0.customID]
	end
end

function var_0_0.PlayTalk(arg_13_0)
	arg_13_0:InitPlayTalk()

	if StageTools.IsArchiveMomotalkPlayed(arg_13_0.archiveID_) then
		arg_13_0:PlayTalkImmediately()
	else
		arg_13_0:PlayTalkByTime()
	end
end

function var_0_0.InitPlayTalk(arg_14_0)
	arg_14_0.playedMessageIDList_ = {}

	arg_14_0.loopScrollView_:SetContentHeight(arg_14_0.diaViewPortTrs_.rect.height)
end

function var_0_0.PlayTalkImmediately(arg_15_0)
	arg_15_0.playedMessageIDList_ = clone(arg_15_0.messageIDList_)

	table.insert(arg_15_0.playedMessageIDList_, StageConst.STAGE_ARCHIVE_MOMO_TALK_TYPE.NO_NEW)
	arg_15_0.loopScrollView_:RefreshScrollView(true)
	arg_15_0.loopScrollView_:NavigateIndex(1)
end

function var_0_0.PlayTalkByTime(arg_16_0)
	StageTools.SetArchiveMomotalkPlayed(arg_16_0.archiveID_)

	arg_16_0.playedMessageIDList_ = {}

	arg_16_0.loopScrollView_:RefreshScrollView(true)
	arg_16_0.player_:Play(arg_16_0.messageIDList_)
end

function var_0_0.OnNewMessage(arg_17_0, arg_17_1)
	arg_17_0.playedIndex_ = arg_17_1

	table.insert(arg_17_0.playedMessageIDList_, arg_17_0.messageIDList_[arg_17_0.playedIndex_])

	if not arg_17_0.loopScrollView_:IsFillContent() or arg_17_0.diaScrollEx_.verticalNormalizedPosition <= 0.01 then
		FrameTimer.New(function()
			arg_17_0.loopScrollView_:Scroll2End()

			if not isNil(arg_17_0.diaScrollEx_) then
				arg_17_0.diaScrollEx_.verticalNormalizedPosition = 0
			end
		end, 1, 1):Start()
	end

	if arg_17_0.playedIndex_ == #arg_17_0.messageIDList_ then
		arg_17_0.player_:Stop()
		table.insert(arg_17_0.playedMessageIDList_, StageConst.STAGE_ARCHIVE_MOMO_TALK_TYPE.NO_NEW)
	end
end

function var_0_0.OnSkip(arg_19_0)
	arg_19_0.player_:Skip()
end

function var_0_0.LsAddItem(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0

	if arg_20_1 ~= StageConst.STAGE_ARCHIVE_MOMO_TALK_TYPE.NO_NEW then
		var_20_0 = arg_20_0:GetTalkItem(arg_20_1, arg_20_2)
	else
		var_20_0 = arg_20_0:GetNoNewItem(arg_20_1, arg_20_2)
	end

	return var_20_0
end

function var_0_0.GetTalkItem(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = StageArchivesCollectMomoTalkCfg[arg_21_1]
	local var_21_1 = var_21_0.speaker_position
	local var_21_2

	if var_21_1 == StageConst.STAGE_ARCHIVE_MOMO_TALK_POSITION.LEFT then
		var_21_2 = arg_21_0.itemPool_:GetFreeItem(StageConst.STAGE_ARCHIVE_MOMO_TALK_TYPE.LEFT_MESSAGE, function()
			return StageArchiveMomoTalkItem.New(arg_21_0.leftTalkItemGo_, arg_21_0.diaGridTrs_)
		end)
	else
		var_21_2 = arg_21_0.itemPool_:GetFreeItem(StageConst.STAGE_ARCHIVE_MOMO_TALK_TYPE.RIGHT_MESSAGE, function()
			return StageArchiveMomoTalkItem.New(arg_21_0.rightTalkItemGo_, arg_21_0.diaGridTrs_)
		end)
	end

	local var_21_3 = false
	local var_21_4 = arg_21_0.playedMessageIDList_[arg_21_2 - 1]

	if var_21_4 then
		var_21_3 = StageArchivesCollectMomoTalkCfg[var_21_4].speaker_name == var_21_0.speaker_name
	end

	var_21_2.itemView:SetData(arg_21_1, arg_21_2, var_21_3)
	var_21_2.itemView:Show(true)

	return var_21_2
end

function var_0_0.GetNoNewItem(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_0.itemPool_:GetFreeItem(StageConst.STAGE_ARCHIVE_MOMO_TALK_TYPE.NO_NEW, function()
		return StageArchiveMomoTalkNoNewItem.New(arg_24_0.noNewItemGo_, arg_24_0.diaGridTrs_)
	end)

	var_24_0.itemView:SetData(arg_24_2)
	var_24_0.itemView:Show(true)

	return var_24_0
end

function var_0_0.LsRemoveItem(arg_26_0, arg_26_1)
	arg_26_0.itemPool_:ReturnItem(arg_26_1)
	arg_26_1.itemView:Show(false)
end

function var_0_0.LsGetItemData(arg_27_0)
	return arg_27_0.playedMessageIDList_
end

function var_0_0.OnExit(arg_28_0)
	arg_28_0.player_:Stop()
end

function var_0_0.Dispose(arg_29_0)
	arg_29_0.loopScrollView_:Dispose()
	arg_29_0.itemPool_:Dispose()
	arg_29_0.skipEventListener:RemoveAllListeners()
	var_0_0.super.Dispose(arg_29_0)
end

return var_0_0
