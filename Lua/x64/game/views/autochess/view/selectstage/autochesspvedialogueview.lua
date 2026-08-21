local var_0_0 = class("AutoChessPVEDialogueView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_OsirisHorus/Activity_OsirisHorus_Main/Activity_OsirisHorus_DialogueShowUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
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

	arg_4_0.headItem_ = AutoChessHeadItemView.New(arg_4_0.headGo_, AutoChessConst.GAME_TYPE.PVE)
end

function var_0_0.InitPlayer(arg_5_0)
	arg_5_0.updatePeriod_ = GameSetting.plot_archives_play_speed.value[1] / 1000
	arg_5_0.newMessageHandler_ = handler(arg_5_0, arg_5_0.OnNewMessage)
	arg_5_0.player_ = AutoChessTalkPlayer.New(arg_5_0.newMessageHandler_, arg_5_0.updatePeriod_)
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
		if arg_8_0.timer then
			arg_8_0.timer:Stop()

			arg_8_0.timer = nil
		end

		if #arg_8_0.playedMessageIDList_ == #arg_8_0.messageIDList_ then
			arg_8_0:OnDialogEnd()
		else
			arg_8_0:OnSkip()

			local var_9_0 = arg_8_0.loopScrollView_:GetItemList()

			if var_9_0[arg_8_0.playedIndex_] then
				var_9_0[arg_8_0.playedIndex_].itemView:ResetAnimState()
			end
		end
	end)
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.stageID_ = arg_10_0.params_.stageID

	arg_10_0.headItem_:RefreshUI()
	arg_10_0:InitMessageData()
	arg_10_0:PlayTalk()
end

function var_0_0.OnTop(arg_11_0)
	return
end

function var_0_0.InitMessageData(arg_12_0)
	arg_12_0.messageIDList_ = AutoChessTalkCfg.get_id_list_by_stage_id[arg_12_0.stageID_]

	local var_12_0 = AutoChessStageCfg[arg_12_0.stageID_]

	arg_12_0.rightHeroTagText1_.text = var_12_0.enemy_title
	arg_12_0.rightHeroTagText2_.text = var_12_0.enemy_title
	arg_12_0.rightHeroNameText2_.text = var_12_0.enemy_name
	arg_12_0.leftHeroImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Activity_OsirisHorus/Hero/OsirisHorus_Hero_" .. var_12_0.my_character)
	arg_12_0.rightHeroImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Activity_OsirisHorus/Hero/OsirisHorus_Hero_" .. var_12_0.character)
	arg_12_0.bgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Activity_OsirisHorus/PKBg/" .. var_12_0.background)
end

function var_0_0.OnDialogEnd(arg_13_0)
	if AutoChessData:GetGameStatus(AutoChessConst.GAME_TYPE.PVE) ~= AutoChessConst.GAME_STATUS.NONE then
		AutoChessTools.CancelGame(AutoChessConst.GAME_TYPE.PVE, true, function()
			AutoChessTools.StartNewGame(AutoChessConst.GAME_TYPE.PVE, arg_13_0.stageID_)
		end)
	else
		AutoChessTools.StartNewGame(AutoChessConst.GAME_TYPE.PVE, arg_13_0.stageID_)
	end
end

function var_0_0.PlayTalk(arg_15_0)
	arg_15_0:InitPlayTalk()
	arg_15_0:PlayTalkByTime()
end

function var_0_0.InitPlayTalk(arg_16_0)
	arg_16_0.playedMessageIDList_ = {}

	arg_16_0.loopScrollView_:SetContentHeight(arg_16_0.diaViewPortTrs_.rect.height)
end

function var_0_0.PlayTalkByTime(arg_17_0)
	arg_17_0.playedMessageIDList_ = {}

	arg_17_0.loopScrollView_:RefreshScrollView(true)

	arg_17_0.playTimer_ = Timer.New(function()
		arg_17_0.player_:Play(arg_17_0.messageIDList_)
	end, 1, 1)

	arg_17_0.playTimer_:Start()
end

function var_0_0.OnNewMessage(arg_19_0, arg_19_1)
	arg_19_0.playedIndex_ = arg_19_1

	table.insert(arg_19_0.playedMessageIDList_, arg_19_0.messageIDList_[arg_19_0.playedIndex_])

	if not arg_19_0.loopScrollView_:IsFillContent() or arg_19_0.diaScrollEx_.verticalNormalizedPosition <= 0.01 then
		arg_19_0.loopScrollView_:Scroll2End()
		FrameTimer.New(function()
			if not isNil(arg_19_0.diaScrollEx_) then
				arg_19_0.diaScrollEx_.verticalNormalizedPosition = 0
			end
		end, 1, 1):Start()
	end

	if arg_19_0.playedIndex_ == #arg_19_0.messageIDList_ then
		arg_19_0.player_:Stop()

		local var_19_0 = GameSetting.auto_chess_VS_delay.value[1]

		arg_19_0.timer = Timer.New(function()
			arg_19_0:OnDialogEnd()
		end, var_19_0, 1)

		arg_19_0.timer:Start()
	end
end

function var_0_0.OnSkip(arg_22_0)
	arg_22_0.player_:Skip()
end

function var_0_0.LsAddItem(arg_23_0, arg_23_1, arg_23_2)
	return (arg_23_0:GetTalkItem(arg_23_1, arg_23_2))
end

function var_0_0.GetTalkItem(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = AutoChessTalkCfg[arg_24_1].speaker_position
	local var_24_1
	local var_24_2 = var_24_0 == 1

	if var_24_2 then
		var_24_1 = arg_24_0.itemPool_:GetFreeItem(1, function()
			return AutoChessTalkItem.New(arg_24_0.leftTalkItemGo_, arg_24_0.diaGridTrs_)
		end)
	else
		var_24_1 = arg_24_0.itemPool_:GetFreeItem(2, function()
			return AutoChessTalkItem.New(arg_24_0.rightTalkItemGo_, arg_24_0.diaGridTrs_)
		end)
	end

	var_24_1.itemView:SetData(arg_24_1, arg_24_2)
	var_24_1.itemView:Show(true)
	var_24_1.itemView:PlayAnim(var_24_2)

	return var_24_1
end

function var_0_0.LsRemoveItem(arg_27_0, arg_27_1)
	arg_27_0.itemPool_:ReturnItem(arg_27_1)
	arg_27_1.itemView:Show(false)
end

function var_0_0.LsGetItemData(arg_28_0)
	return arg_28_0.playedMessageIDList_
end

function var_0_0.OnExit(arg_29_0)
	manager.windowBar:HideBar()

	for iter_29_0, iter_29_1 in ipairs(arg_29_0.loopScrollView_:GetItemList()) do
		iter_29_1.itemView:ResetAnimState()
	end

	arg_29_0.player_:Stop()

	if arg_29_0.timer then
		arg_29_0.timer:Stop()

		arg_29_0.timer = nil
	end

	if arg_29_0.playTimer_ then
		arg_29_0.playTimer_:Stop()

		arg_29_0.playTimer_ = nil
	end
end

function var_0_0.Dispose(arg_30_0)
	arg_30_0.headItem_:Dispose()
	arg_30_0.loopScrollView_:Dispose()
	arg_30_0.itemPool_:Dispose()
	var_0_0.super.Dispose(arg_30_0)
end

return var_0_0
