local StageArchiveMomoTalkView = class("StageArchiveMomoTalkView", ReduxView)

function StageArchiveMomoTalkView:UIName()
	return "Widget/System/Operation/OperationMomoTalkUI"
end

function StageArchiveMomoTalkView:UIParent()
	return manager.ui.uiPop.transform
end

function StageArchiveMomoTalkView:Init()
	self:InitUI()
	self:AddListeners()
end

function StageArchiveMomoTalkView:InitUI()
	self:BindCfgUI()
	self:InitPlayer()
	self:InitDisplayWindow()
	self:InitItemPool()
end

function StageArchiveMomoTalkView:InitPlayer()
	self.updatePeriod_ = GameSetting.plot_archives_play_speed.value[1] / 1000
	self.newMessageHandler_ = handler(self, self.OnNewMessage)
	self.player_ = StageArchiveMomoTalkPlayer.New(self.newMessageHandler_, self.updatePeriod_)
end

function StageArchiveMomoTalkView:InitDisplayWindow()
	self.loopScrollView_ = LoopScrollView.New(self, self.diaScrollEx_, self.diaGridTrs_, self.diaViewPortTrs_, self.diaViewPortTrs_.rect.height, self.diaGridTrs_:GetComponent("VerticalLayoutGroup").spacing, true)
end

function StageArchiveMomoTalkView:InitItemPool()
	self.itemPool_ = StageArchiveMomoTalkPool.New()

	self.itemPool_:Init()
end

function StageArchiveMomoTalkView:AddListeners()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
	self.skipEventListener:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerClick, LuaHelper.EventTriggerAction1(handler(self, self.OnSkip)))
	self:AddBtnListener(self.skipBtn_, nil, function()
		self:OnSkip()
	end)
end

function StageArchiveMomoTalkView:OnEnter()
	self.archiveID_ = self.params_.archiveID
	self.customID = self.params_.customID

	self:InitMessageData()
	self:PlayTalk()
end

function StageArchiveMomoTalkView:InitMessageData()
	self.messageIDList_ = not self.customID and StageArchivesCollectMomoTalkCfg.get_id_list_by_momotalk_plot_id[StageArchivesCollectCfg[self.archiveID_].archive_parameter] or StageArchivesCollectMomoTalkCfg.get_id_list_by_momotalk_plot_id[self.customID]
end

function StageArchiveMomoTalkView:PlayTalk()
	self:InitPlayTalk()

	if StageTools.IsArchiveMomotalkPlayed(self.archiveID_) then
		self:PlayTalkImmediately()
	else
		self:PlayTalkByTime()
	end
end

function StageArchiveMomoTalkView:InitPlayTalk()
	self.playedMessageIDList_ = {}

	self.loopScrollView_:SetContentHeight(self.diaViewPortTrs_.rect.height)
end

function StageArchiveMomoTalkView:PlayTalkImmediately()
	self.playedMessageIDList_ = clone(self.messageIDList_)

	table.insert(self.playedMessageIDList_, StageConst.STAGE_ARCHIVE_MOMO_TALK_TYPE.NO_NEW)
	self.loopScrollView_:RefreshScrollView(true)
	self.loopScrollView_:NavigateIndex(1)
end

function StageArchiveMomoTalkView:PlayTalkByTime()
	StageTools.SetArchiveMomotalkPlayed(self.archiveID_)

	self.playedMessageIDList_ = {}

	self.loopScrollView_:RefreshScrollView(true)
	self.player_:Play(self.messageIDList_)
end

function StageArchiveMomoTalkView:OnNewMessage(arg_17_1)
	self.playedIndex_ = arg_17_1

	table.insert(self.playedMessageIDList_, self.messageIDList_[self.playedIndex_])

	if not self.loopScrollView_:IsFillContent() or self.diaScrollEx_.verticalNormalizedPosition <= 0.01 then
		FrameTimer.New(function()
			self.loopScrollView_:Scroll2End()

			if not isNil(self.diaScrollEx_) then
				self.diaScrollEx_.verticalNormalizedPosition = 0
			end
		end, 1, 1):Start()
	end

	if self.playedIndex_ == #self.messageIDList_ then
		self.player_:Stop()
		table.insert(self.playedMessageIDList_, StageConst.STAGE_ARCHIVE_MOMO_TALK_TYPE.NO_NEW)
	end
end

function StageArchiveMomoTalkView:OnSkip()
	self.player_:Skip()
end

function StageArchiveMomoTalkView:LsAddItem(arg_20_1, arg_20_2)
	return arg_20_1 ~= StageConst.STAGE_ARCHIVE_MOMO_TALK_TYPE.NO_NEW and self:GetTalkItem(arg_20_1, arg_20_2) or self:GetNoNewItem(arg_20_1, arg_20_2)
end

function StageArchiveMomoTalkView:GetTalkItem(arg_21_1, arg_21_2)
	local var_21_0 = StageArchivesCollectMomoTalkCfg[arg_21_1]
	local var_21_1 = StageArchivesCollectMomoTalkCfg[arg_21_1].speaker_position == StageConst.STAGE_ARCHIVE_MOMO_TALK_POSITION.LEFT and self.itemPool_:GetFreeItem(StageConst.STAGE_ARCHIVE_MOMO_TALK_TYPE.LEFT_MESSAGE, function()
		return StageArchiveMomoTalkItem.New(self.leftTalkItemGo_, self.diaGridTrs_)
	end) or self.itemPool_:GetFreeItem(StageConst.STAGE_ARCHIVE_MOMO_TALK_TYPE.RIGHT_MESSAGE, function()
		return StageArchiveMomoTalkItem.New(self.rightTalkItemGo_, self.diaGridTrs_)
	end)

	var_21_1.itemView:SetData(arg_21_1, arg_21_2, (self.playedMessageIDList_[arg_21_2 - 1] or nil) and StageArchivesCollectMomoTalkCfg[self.playedMessageIDList_[arg_21_2 - 1]].speaker_name == var_21_0.speaker_name)
	var_21_1.itemView:Show(true)

	return var_21_1
end

function StageArchiveMomoTalkView:GetNoNewItem(arg_24_1, arg_24_2)
	local var_24_0 = self.itemPool_:GetFreeItem(StageConst.STAGE_ARCHIVE_MOMO_TALK_TYPE.NO_NEW, function()
		return StageArchiveMomoTalkNoNewItem.New(self.noNewItemGo_, self.diaGridTrs_)
	end)

	var_24_0.itemView:SetData(arg_24_2)
	var_24_0.itemView:Show(true)

	return var_24_0
end

function StageArchiveMomoTalkView:LsRemoveItem(arg_26_1)
	self.itemPool_:ReturnItem(arg_26_1)
	arg_26_1.itemView:Show(false)
end

function StageArchiveMomoTalkView:LsGetItemData()
	return self.playedMessageIDList_
end

function StageArchiveMomoTalkView:OnExit()
	self.player_:Stop()
end

function StageArchiveMomoTalkView:Dispose()
	self.loopScrollView_:Dispose()
	self.itemPool_:Dispose()
	self.skipEventListener:RemoveAllListeners()
	StageArchiveMomoTalkView.super.Dispose(self)
end

return StageArchiveMomoTalkView
