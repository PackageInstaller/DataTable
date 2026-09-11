local AutoChessPVEDialogueView = class("AutoChessPVEDialogueView", ReduxView)

function AutoChessPVEDialogueView:UIName()
	return "Widget/System/Activity_OsirisHorus/Activity_OsirisHorus_Main/Activity_OsirisHorus_DialogueShowUI"
end

function AutoChessPVEDialogueView:UIParent()
	return manager.ui.uiMain.transform
end

function AutoChessPVEDialogueView:Init()
	self:InitUI()
	self:AddListeners()
end

function AutoChessPVEDialogueView:InitUI()
	self:BindCfgUI()
	self:InitPlayer()
	self:InitDisplayWindow()
	self:InitItemPool()

	self.headItem_ = AutoChessHeadItemView.New(self.headGo_, AutoChessConst.GAME_TYPE.PVE)
end

function AutoChessPVEDialogueView:InitPlayer()
	self.updatePeriod_ = GameSetting.plot_archives_play_speed.value[1] / 1000
	self.newMessageHandler_ = handler(self, self.OnNewMessage)
	self.player_ = AutoChessTalkPlayer.New(self.newMessageHandler_, self.updatePeriod_)
end

function AutoChessPVEDialogueView:InitDisplayWindow()
	self.loopScrollView_ = LoopScrollView.New(self, self.diaScrollEx_, self.diaGridTrs_, self.diaViewPortTrs_, self.diaViewPortTrs_.rect.height, self.diaGridTrs_:GetComponent("VerticalLayoutGroup").spacing, true)
end

function AutoChessPVEDialogueView:InitItemPool()
	self.itemPool_ = StageArchiveMomoTalkPool.New()

	self.itemPool_:Init()
end

function AutoChessPVEDialogueView:AddListeners()
	self:AddBtnListener(self.maskBtn_, nil, function()
		if self.timer then
			self.timer:Stop()

			self.timer = nil
		end

		if #self.playedMessageIDList_ == #self.messageIDList_ then
			self:OnDialogEnd()
		else
			self:OnSkip()

			local var_9_0 = self.loopScrollView_:GetItemList()

			if var_9_0[self.playedIndex_] then
				var_9_0[self.playedIndex_].itemView:ResetAnimState()
			end
		end
	end)
end

function AutoChessPVEDialogueView:OnEnter()
	self.stageID_ = self.params_.stageID

	self.headItem_:RefreshUI()
	self:InitMessageData()
	self:PlayTalk()
end

function AutoChessPVEDialogueView:OnTop()
	return
end

function AutoChessPVEDialogueView:InitMessageData()
	self.messageIDList_ = AutoChessTalkCfg.get_id_list_by_stage_id[self.stageID_]
	self.rightHeroTagText1_.text = AutoChessStageCfg[self.stageID_].enemy_title
	self.rightHeroTagText2_.text = AutoChessStageCfg[self.stageID_].enemy_title
	self.rightHeroNameText2_.text = AutoChessStageCfg[self.stageID_].enemy_name
	self.leftHeroImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Activity_OsirisHorus/Hero/OsirisHorus_Hero_" .. AutoChessStageCfg[self.stageID_].my_character)
	self.rightHeroImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Activity_OsirisHorus/Hero/OsirisHorus_Hero_" .. AutoChessStageCfg[self.stageID_].character)
	self.bgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Activity_OsirisHorus/PKBg/" .. AutoChessStageCfg[self.stageID_].background)
end

function AutoChessPVEDialogueView:OnDialogEnd()
	if AutoChessData:GetGameStatus(AutoChessConst.GAME_TYPE.PVE) ~= AutoChessConst.GAME_STATUS.NONE then
		AutoChessTools.CancelGame(AutoChessConst.GAME_TYPE.PVE, true, function()
			AutoChessTools.StartNewGame(AutoChessConst.GAME_TYPE.PVE, self.stageID_)
		end)
	else
		AutoChessTools.StartNewGame(AutoChessConst.GAME_TYPE.PVE, self.stageID_)
	end
end

function AutoChessPVEDialogueView:PlayTalk()
	self:InitPlayTalk()
	self:PlayTalkByTime()
end

function AutoChessPVEDialogueView:InitPlayTalk()
	self.playedMessageIDList_ = {}

	self.loopScrollView_:SetContentHeight(self.diaViewPortTrs_.rect.height)
end

function AutoChessPVEDialogueView:PlayTalkByTime()
	self.playedMessageIDList_ = {}

	self.loopScrollView_:RefreshScrollView(true)

	self.playTimer_ = Timer.New(function()
		self.player_:Play(self.messageIDList_)
	end, 1, 1)

	self.playTimer_:Start()
end

function AutoChessPVEDialogueView:OnNewMessage(arg_19_1)
	self.playedIndex_ = arg_19_1

	table.insert(self.playedMessageIDList_, self.messageIDList_[self.playedIndex_])

	if not self.loopScrollView_:IsFillContent() or self.diaScrollEx_.verticalNormalizedPosition <= 0.01 then
		self.loopScrollView_:Scroll2End()
		FrameTimer.New(function()
			if not isNil(self.diaScrollEx_) then
				self.diaScrollEx_.verticalNormalizedPosition = 0
			end
		end, 1, 1):Start()
	end

	if self.playedIndex_ == #self.messageIDList_ then
		self.player_:Stop()

		self.timer = Timer.New(function()
			self:OnDialogEnd()
		end, GameSetting.auto_chess_VS_delay.value[1], 1)

		self.timer:Start()
	end
end

function AutoChessPVEDialogueView:OnSkip()
	self.player_:Skip()
end

function AutoChessPVEDialogueView:LsAddItem(arg_23_1, arg_23_2)
	return (self:GetTalkItem(arg_23_1, arg_23_2))
end

function AutoChessPVEDialogueView:GetTalkItem(arg_24_1, arg_24_2)
	local var_24_0
	local var_24_1 = AutoChessTalkCfg[arg_24_1].speaker_position == 1

	var_24_0 = AutoChessTalkCfg[arg_24_1].speaker_position == 1 and self.itemPool_:GetFreeItem(1, function()
		return AutoChessTalkItem.New(self.leftTalkItemGo_, self.diaGridTrs_)
	end) or self.itemPool_:GetFreeItem(2, function()
		return AutoChessTalkItem.New(self.rightTalkItemGo_, self.diaGridTrs_)
	end)

	var_24_0.itemView:SetData(arg_24_1, arg_24_2)
	var_24_0.itemView:Show(true)
	var_24_0.itemView:PlayAnim(var_24_1)

	return var_24_0
end

function AutoChessPVEDialogueView:LsRemoveItem(arg_27_1)
	self.itemPool_:ReturnItem(arg_27_1)
	arg_27_1.itemView:Show(false)
end

function AutoChessPVEDialogueView:LsGetItemData()
	return self.playedMessageIDList_
end

function AutoChessPVEDialogueView:OnExit()
	manager.windowBar:HideBar()

	for iter_29_0, iter_29_1 in ipairs(self.loopScrollView_:GetItemList()) do
		iter_29_1.itemView:ResetAnimState()
	end

	self.player_:Stop()

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	if self.playTimer_ then
		self.playTimer_:Stop()

		self.playTimer_ = nil
	end
end

function AutoChessPVEDialogueView:Dispose()
	self.headItem_:Dispose()
	self.loopScrollView_:Dispose()
	self.itemPool_:Dispose()
	AutoChessPVEDialogueView.super.Dispose(self)
end

return AutoChessPVEDialogueView
