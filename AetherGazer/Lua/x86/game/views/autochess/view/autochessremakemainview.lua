local var_0_0 = class("AutoChessRemakeMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Xihe/Activity_Xihe_HomeUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()

	arg_3_0.popBackHandler_ = handler(arg_3_0, arg_3_0.CheckStartMatch)
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.statusController_ = arg_4_0.controllerEx_:GetController("status")
	arg_4_0.rankScoreController_ = arg_4_0.controllerEx_:GetController("rankScore")
	arg_4_0.currentController_ = arg_4_0.controllerEx_:GetController("currentRound")
	arg_4_0.commonPortrait_ = CommonHeadPortrait.New(arg_4_0.headItem_)
	arg_4_0.bubbleController_ = arg_4_0.collectController_:GetController("bubble")
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.illustratedBtn_, nil, function()
		JumpTools.OpenPageByJump("/autoChessIllustratedWindow")
		OperationRecorder.RecordButtonTouch({
			source = 1,
			button_name = "activity_autochess_illustration_homepage_touch",
			activity_id = arg_5_0.activityId_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.limitTaskBtn_, nil, function()
		JumpTools.OpenPageByJump("/autoChessLimitTaskView_4_8", {
			activityID = ActivityConst.ACTIVITY_AUTO_CHESS_4_8_LIMITED_TASK
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.asyncMatchBtn_, nil, function()
		if arg_5_0.isOnLinePvp_ then
			local var_8_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_AUTO_CHESS_PVP_4_8).stopTime

			ShowTips(string.format(GetTips("AUTO_CHESS_2_WILL_OPEN"), manager.time:GetLostTimeStr(var_8_0)))
		elseif AutoChessData:GetGameStatus(AutoChessConst.GAME_TYPE.PVP_5_0) == AutoChessConst.GAME_STATUS.NONE then
			AutoChessTools.StartNewGame(AutoChessConst.GAME_TYPE.PVP_5_0)
		else
			AutoChessTools.GoToGameView(AutoChessConst.GAME_TYPE.PVP_5_0)
			AutoChessAction.SetGamePause(AutoChessConst.GAME_TYPE.PVP_5_0, AutoChessConst.GAME_PAUSE_TYPE.RESUME)
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.syncMatchBtn_, nil, function()
		if arg_5_0.isOnLinePvp_ then
			if AutoChessData:GetIsInMatch() then
				return
			end

			if getData("AutoChessMatch", "SyncMatch") == nil then
				JumpTools.OpenPageByJump("/gameHelpPro", {
					hideHomeBtn = 1,
					isPrefab = true,
					pages = GameSetting.auto_chess_2_sync_desc.value,
					exitCallback = function()
						AutoChessTools.StartNewGame(AutoChessConst.GAME_TYPE.ONLINE)
						saveData("AutoChessMatch", "SyncMatch", true)
					end
				})
			else
				AutoChessTools.StartNewGame(AutoChessConst.GAME_TYPE.ONLINE)
			end
		else
			ShowTips("AUTO_CHESS_2_CLOSED")
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.collectBtn_, nil, function()
		JumpTools.OpenPageByJump("/autoChessCardCollectView")
		OperationRecorder.RecordButtonTouch({
			button_name = "activity_autochess_collect_homepage_touch",
			activity_id = arg_5_0.activityId_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.desireBtn_, nil, function()
		OperationRecorder.RecordButtonTouch({
			button_name = "activity_autochess_item_exchange_homepage_touch",
			activity_id = arg_5_0.activityId_
		})

		if AutoChessCardData:GetFriendCardList() == nil then
			AutoChessCardAction.GetCardDesireList(AutoChessCardConst.DESIRE_TYPE.FRIEND, function()
				if AutoChessCardData:GetOtherCardList() == nil then
					AutoChessCardAction.GetCardDesireList(AutoChessCardConst.DESIRE_TYPE.OTHER, function()
						JumpTools.OpenPageByJump("/autoChessDesireMainView")
					end)
				else
					JumpTools.OpenPageByJump("/autoChessDesireMainView")
				end
			end)
		elseif AutoChessCardData:GetOtherCardList() == nil then
			AutoChessCardAction.GetCardDesireList(AutoChessCardConst.DESIRE_TYPE.OTHER, function()
				JumpTools.OpenPageByJump("/autoChessDesireMainView")
			end)
		else
			JumpTools.OpenPageByJump("/autoChessDesireMainView")
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.openCardBtn_, nil, function()
		JumpTools.OpenPageByJump("/autoChessOpenCardMainView")
	end)
	arg_5_0:AddBtnListener(arg_5_0.taskBtn_, nil, function()
		JumpTools.OpenPageByJump("/autoChessTaskView_4_8")
	end)
	arg_5_0:AddBtnListener(arg_5_0.rankBtn_, nil, function()
		OperationRecorder.RecordButtonTouch({
			button_name = "activity_autochess_rank_homepage_touch",
			activity_id = arg_5_0.activityId_
		})
		JumpTools.OpenPageByJump("/autoChessRankView_4_8")
	end)
	arg_5_0:AddBtnListener(arg_5_0.levelBtn_, nil, function()
		JumpTools.OpenPageByJump("autoChessLevelPopView")
	end)
	arg_5_0:AddBtnListener(arg_5_0.teachBtn_, nil, function()
		arg_5_0:ShowTeachStage(true)
	end)
	arg_5_0:AddBtnListener(arg_5_0.gameOverBtn_, nil, function()
		JumpTools.OpenPageByJump("autoChessQuitPopView", {
			gameType = AutoChessConst.GAME_TYPE.PVP_5_0,
			type = AutoChessConst.POP_TYPE.PVP_ASYNC,
			okCb = function()
				AutoChessTools.CancelGame(AutoChessConst.GAME_TYPE.PVP_5_0, true)
			end
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.recordBtn_, nil, function()
		OperationRecorder.RecordButtonTouch({
			button_name = "activity_autochess_record_homepage_touch",
			activity_id = arg_5_0.activityId_
		})

		if arg_5_0.isOnLinePvp_ then
			AutoChessMatchAction.RequestRecord(AutoChessConst.RECORD_TYPE.PVP_4_8_ONLINE, function()
				JumpTools.OpenPageByJump("/autoChessRecordView", {
					recordType = AutoChessConst.RECORD_TYPE.PVP_4_8_ONLINE
				})
			end)
		else
			AutoChessMatchAction.RequestRecord(AutoChessConst.RECORD_TYPE.PVP_4_8_ONLINE, function()
				AutoChessMatchAction.RequestRecord(AutoChessConst.RECORD_TYPE.PVP_4_8, function()
					JumpTools.OpenPageByJump("/autoChessRecordView", {
						recordType = AutoChessConst.RECORD_TYPE.PVP_4_8
					})
				end)
			end)
		end
	end)
	arg_5_0.commonPortrait_:RegisteClickCallback(handler(arg_5_0, arg_5_0.OnClickHeadBackCall))
end

function var_0_0.OnClickHeadBackCall(arg_27_0)
	OperationRecorder.RecordButtonTouch({
		button_name = "activity_autochess_headshots_touch",
		activity_id = arg_27_0.activityId_
	})
	JumpTools.OpenPageByJump("autoChessHeadTipsCollectPopView")
end

function var_0_0.OnEnter(arg_28_0)
	arg_28_0.isOnLinePvp_ = ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_PVP_4_8)

	if arg_28_0.isOnLinePvp_ then
		arg_28_0.activityId_ = ActivityConst.ACTIVITY_AUTO_CHESS_4_8
	else
		arg_28_0.activityId_ = ActivityConst.ACTIVITY_AUTO_CHESS_5_0
	end

	AutoChessData:SetActivityID(arg_28_0.activityId_)
	arg_28_0:BindRedPoint()
	arg_28_0:AddMovie()
end

function var_0_0.OnEnterOver(arg_29_0)
	arg_29_0:RefreshUI()
	arg_29_0:ShowTeachStage()
	arg_29_0:CheckShowReconnectPop()
	arg_29_0:CheckStartMatch()
end

function var_0_0.OnTop(arg_30_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if AutoChessData:GetIsInMatch() then
			return
		end

		JumpTools.Back()
	end)
	manager.windowBar:RegistHomeCallBack(function()
		if AutoChessData:GetIsInMatch() then
			return
		end

		gameContext:Go("/home", nil, nil, true)
	end)
	manager.windowBar:RegistInfoCallBack(function()
		if AutoChessData:GetIsInMatch() then
			return
		end

		OperationRecorder.RecordButtonTouch({
			button_name = "activity_autochess_homepage_rules",
			activity_id = arg_30_0.activityId_
		})
		JumpTools.OpenPageByJump("gameHelp", {
			content = GetTips("AUTO_CHESS_2_HOME_TIP")
		})
	end)
	arg_30_0:RefreshCurrentRound()
end

function var_0_0.AddMovie(arg_34_0)
	if not arg_34_0.movie_ then
		arg_34_0.movie_ = Asset.Instantiate("Widget/System/Activity_Xihe/Movie/Activity_Xihe_Home_Movie")

		if arg_34_0.movie_ then
			arg_34_0.movie_.transform.parent = arg_34_0.movieTrans_
			arg_34_0.movie_.transform.localScale = Vector3.one
			arg_34_0.movie_.transform.localPosition = Vector3.zero
		end
	end
end

function var_0_0.BindRedPoint(arg_35_0)
	manager.redPoint:bindUIandKey(arg_35_0.limitTaskBtn_.transform, RedPointConst.AUTO_CHESS_4_8_LIMIT_TASK .. ActivityConst.ACTIVITY_AUTO_CHESS_4_8_LIMITED_TASK)
	manager.redPoint:bindUIandKey(arg_35_0.openCardBtn_.transform, RedPointConst.AUTO_CHESS_4_8_OPEN_CARD)
	manager.redPoint:bindUIandKey(arg_35_0.taskBtn_.transform, RedPointConst.AUTO_CHESS_4_8_RESIDENT_TASK .. arg_35_0.activityId_)
end

function var_0_0.UnBindRedPoint(arg_36_0)
	manager.redPoint:unbindUIandKey(arg_36_0.limitTaskBtn_.transform, RedPointConst.AUTO_CHESS_4_8_LIMIT_TASK .. ActivityConst.ACTIVITY_AUTO_CHESS_4_8_LIMITED_TASK)
	manager.redPoint:unbindUIandKey(arg_36_0.openCardBtn_.transform, RedPointConst.AUTO_CHESS_4_8_OPEN_CARD)
	manager.redPoint:unbindUIandKey(arg_36_0.taskBtn_.transform, RedPointConst.AUTO_CHESS_4_8_RESIDENT_TASK .. arg_36_0.activityId_)
end

function var_0_0.ShowTeachStage(arg_37_0, arg_37_1)
	local var_37_0 = GameSetting.auto_chess_2_tutorial_stage_id.value[1]
	local var_37_1 = AutoChessData:GetStageStoryId()

	if arg_37_1 or AutoChessTools.GetStageState(var_37_0) ~= AutoChessConst.STAGE_STATE.COMPLETED then
		local var_37_2 = AutoChessStageCfg[var_37_0]

		if var_37_2.pre_story and var_37_2.pre_story ~= 0 then
			gameContext:Go("/blank")
			manager.story:StartStoryById(var_37_2.pre_story, function(arg_38_0)
				JumpTools.OpenPageByJump("autoChessQuitPopView", {
					gameType = AutoChessConst.GAME_TYPE.ONLINE,
					type = AutoChessConst.POP_TYPE.SKIP_TEACHING,
					okCb = function()
						AutoChessAction.SkipStage(var_37_0)

						if var_37_2.post_story and var_37_2.post_story ~= 0 then
							gameContext:Go("/blank")
							manager.story:StartStoryById(var_37_2.post_story, function(arg_40_0)
								AutoChessData:SetStageStoryId(nil)
								JumpTools.Back()
							end)
						end
					end,
					cancelCb = function()
						JumpTools.OpenPageByJump("/autoChessPVEDialogueView", {
							stageID = var_37_0
						})
					end
				})
			end)
		end
	elseif var_37_1 then
		gameContext:Go("/blank")
		manager.story:StartStoryById(var_37_1, function(arg_42_0)
			AutoChessData:SetStageStoryId(nil)
			JumpTools.Back()
		end)
	end
end

function var_0_0.RefreshUI(arg_43_0)
	arg_43_0.commonPortrait_:ChangeFrameActive(false)
	arg_43_0.commonPortrait_:RenderHead(PlayerData:GetPlayerInfo().portrait)

	local var_43_0, var_43_1 = TaskTools.GetTaskNumInfo(ActivityConst.ACTIVITY_AUTO_CHESS_4_8)

	arg_43_0.taskProgressText_.text = string.format("%s<size=44>/%s</size>", var_43_0, var_43_1)
	arg_43_0.taskTitleText_.text = GetTips("AUTO_CHESS_CAREER_ENTRANCE")
	arg_43_0.illustratTitleText_.text = GetTips("AUTO_CHESS_INDEX_ENTRANCE")

	arg_43_0:RefreshActivityButton()
	arg_43_0:RefreshRankLevel()
	arg_43_0:RefreshCard()
	arg_43_0:RefreshTips()
	arg_43_0:RefreshWish()
	arg_43_0:RefreshTime()
end

function var_0_0.RefreshCurrentRound(arg_44_0)
	if arg_44_0.isOnLinePvp_ then
		arg_44_0.currentController_:SetSelectedState("hide")

		return
	end

	if AutoChessData:GetGameStatus(AutoChessConst.GAME_TYPE.PVP_5_0) == AutoChessConst.GAME_STATUS.NONE then
		arg_44_0.currentController_:SetSelectedState("hide")

		arg_44_0.pvpGoText_.text = GetTips("AUTO_CHESS_PVP_ENTRANCE")
	else
		arg_44_0.currentController_:SetSelectedState("show")

		local var_44_0 = AutoChessData:GetPrepareData(AutoChessConst.GAME_TYPE.PVP_5_0)

		arg_44_0.curRoundText_.text = var_44_0:GetPlayerData().curRoundCount
		arg_44_0.pvpGoText_.text = GetTips("AUTO_CHESS_BUTTON_RESUME")
	end
end

function var_0_0.RefreshTips(arg_45_0)
	local var_45_0 = AutoChessCardData:GetSunglassesState()

	if (getData("autochess_4_8", "isShowSunglasses") or 0) == 0 and var_45_0 ~= 0 then
		saveData("autochess_4_8", "isShowSunglasses", 1)
		JumpTools.OpenPageByJump("autoChessSunglassesPopView", {
			callback = arg_45_0.popBackHandler_
		})
	else
		if not ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_EXCHANGE_CARD) then
			return
		end

		local var_45_1 = getData("autochess_4_8", "isShowWish") or 0
		local var_45_2 = AutoChessCardData:GetDesireInfo()

		if var_45_2.CardID > 0 and var_45_2.State == AutoChessCardConst.DESIRE_STATE.YES and var_45_1 == 0 then
			JumpTools.OpenPageByJump("autoChessWishPopView", {
				callback = arg_45_0.popBackHandler_
			})
		end
	end
end

function var_0_0.RefreshActivityButton(arg_46_0)
	if arg_46_0.isOnLinePvp_ then
		arg_46_0.statusController_:SetSelectedIndex(0)
	else
		arg_46_0.statusController_:SetSelectedIndex(1)
	end

	local var_46_0 = ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_4_8_LIMITED_TASK)
	local var_46_1 = ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_EXCHANGE_CARD)

	SetActive(arg_46_0.limitTaskBtn_.gameObject, var_46_0)
	SetActive(arg_46_0.desireBtn_.gameObject, var_46_1)
end

function var_0_0.RefreshRankLevel(arg_47_0)
	if not arg_47_0.isOnLinePvp_ then
		SetActive(arg_47_0.levelBtn_.gameObject, false)

		return
	end

	local var_47_0 = AutoChessCardData:GetRankScore()

	arg_47_0.nowScoreText_.text = var_47_0

	local var_47_1, var_47_2 = AutoChessTools.GetRankLevelCfg(var_47_0)

	if var_47_1.baseline == 0 then
		SetActive(arg_47_0.levelBtn_.gameObject, false)

		return
	end

	SetActive(arg_47_0.levelBtn_.gameObject, true)

	if var_47_1 then
		arg_47_0.rankTitleText_.text = var_47_1.name
		arg_47_0.rankIconImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_Xihe/RankIcon/" .. var_47_1.icon)
		arg_47_0.rankRomaText_.text = NumberTools.IntToRomam(var_47_1.rank_level)
	end

	if var_47_2 then
		arg_47_0.rankScoreController_:SetSelectedState("show")

		arg_47_0.maxScoreText_.text = "/" .. var_47_2.baseline

		local var_47_3 = var_47_1 and var_47_1.baseline or 0

		arg_47_0.prograssImg_.fillAmount = (var_47_0 - var_47_3) / (var_47_2.baseline - var_47_3)
	else
		arg_47_0.rankScoreController_:SetSelectedState("hide")

		arg_47_0.prograssImg_.fillAmount = 1
	end
end

function var_0_0.RefreshCard(arg_48_0)
	local var_48_0 = #AutoChessCardCfg.get_id_list_by_is_card_pool[1]
	local var_48_1 = AutoChessCardData:GetCardList()
	local var_48_2 = 0

	for iter_48_0, iter_48_1 in pairs(var_48_1) do
		if iter_48_1 > 0 then
			var_48_2 = var_48_2 + 1
		end
	end

	arg_48_0.txtCollect_.text = string.format("%s<size=32>/%s</size>", var_48_2, var_48_0)
	arg_48_0.txtCardNum_.text = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_AUTO_CHESS_CARD_ITEM)
end

function var_0_0.RefreshWish(arg_49_0)
	if not ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_EXCHANGE_CARD) then
		SetActive(arg_49_0.desireBtn_.gameObject, false)

		if AutoChessCardData:GetDesireInfo().State == AutoChessCardConst.DESIRE_STATE.YES then
			JumpTools.OpenPageByJump("autoChessDesireCurSceceView", {
				mode = AutoChessCardConst.DESIRE_TYPE.MY
			})
		end

		return
	end

	SetActive(arg_49_0.desireBtn_.gameObject, true)
	arg_49_0:RefreshWishTime()

	if AutoChessCardData:GetDesireNum() >= GameSetting.auto_chess_2_exchange_self_times.value[1] then
		arg_49_0.bubbleController_:SetSelectedState("hide")

		return
	end

	local var_49_0 = AutoChessCardData:GetDesireInfo()

	if var_49_0.CardID > 0 then
		arg_49_0.bubbleController_:SetSelectedState("fulfill")

		if var_49_0.State == AutoChessCardConst.DESIRE_STATE.NO then
			arg_49_0.txtWish_.text = GetTips("AUTO_CHESS_2_WISHING")
		else
			arg_49_0.txtWish_.text = GetTips("AUTO_CHESS_2_WISH_GRANTED")
		end
	else
		arg_49_0.bubbleController_:SetSelectedState("wish")

		arg_49_0.txtWishEmpty_.text = GetTips("AUTO_CHESS_2_WISH_AVAILABLE")
	end
end

function var_0_0.RefreshWishTime(arg_50_0)
	local var_50_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_AUTO_CHESS_EXCHANGE_CARD)

	arg_50_0.txtWishTime_.text = manager.time:GetLostTimeStr2(var_50_0.stopTime)

	if arg_50_0.wishtimer_ == nil then
		arg_50_0.wishtimer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_EXCHANGE_CARD) then
				arg_50_0.txtWishTime_.text = manager.time:GetLostTimeStr2(var_50_0.stopTime)
			else
				arg_50_0:StopWishTimer()
			end
		end, 1, -1)
	end

	arg_50_0.wishtimer_:Start()
end

function var_0_0.StopWishTimer(arg_52_0)
	if arg_52_0.wishtimer_ then
		arg_52_0.wishtimer_:Stop()

		arg_52_0.wishtimer_ = nil
	end
end

function var_0_0.RefreshTime(arg_53_0)
	local var_53_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_AUTO_CHESS_4_8_LIMITED_TASK)

	arg_53_0.timeText_.text = manager.time:GetLostTimeStr2(var_53_0.stopTime)

	SetActive(arg_53_0.limitTaskBtn_.gameObject, ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_4_8_LIMITED_TASK))

	if arg_53_0.limittimer_ == nil then
		arg_53_0.limittimer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_4_8_LIMITED_TASK) then
				arg_53_0.timeText_.text = manager.time:GetLostTimeStr2(var_53_0.stopTime)
			else
				SetActive(arg_53_0.limitTaskBtn_.gameObject, false)
				arg_53_0:LimitStopTimer()
			end
		end, 1, -1)
	end

	arg_53_0.limittimer_:Start()
end

function var_0_0.LimitStopTimer(arg_55_0)
	if arg_55_0.limittimer_ then
		arg_55_0.limittimer_:Stop()

		arg_55_0.limittimer_ = nil
	end
end

function var_0_0.CheckStartMatch(arg_56_0)
	if not arg_56_0:IsTop() then
		return
	end

	local var_56_0 = AutoChessCardData:GetRewardItemList()
	local var_56_1 = #var_56_0 > 0

	if arg_56_0.params_.isStartMatch then
		if var_56_1 then
			sortMergeGetReward(var_56_0, _, function()
				arg_56_0:MatchJump()
			end)
		else
			arg_56_0:MatchJump()
		end

		arg_56_0.params_.isStartMatch = false

		AutoChessCardData:AddRewardItem({})
	else
		if var_56_1 then
			sortMergeGetReward(var_56_0)
		end

		AutoChessCardData:AddRewardItem({})
	end
end

function var_0_0.MatchJump(arg_58_0)
	if arg_58_0.isOnLinePvp_ then
		AutoChessMatchAction.StartMatch()
	elseif AutoChessData:GetGameStatus(AutoChessConst.GAME_TYPE.PVP_5_0) == AutoChessConst.GAME_STATUS.NONE then
		AutoChessTools.StartNewGame(AutoChessConst.GAME_TYPE.PVP_5_0)
	else
		AutoChessTools.GoToGameView(AutoChessConst.GAME_TYPE.PVP_5_0)
		AutoChessAction.SetGamePause(AutoChessConst.GAME_TYPE.PVP_5_0, AutoChessConst.GAME_PAUSE_TYPE.RESUME)
	end
end

function var_0_0.CheckShowReconnectPop(arg_59_0)
	print("AutoChessRemakeMainView:CheckShowReconnectPop():", tostring(arg_59_0.params_.isShowQuitPop))

	if arg_59_0.params_.isShowQuitPop then
		JumpTools.OpenPageByJump("autoChessQuitPopView", {
			gameType = AutoChessConst.GAME_TYPE.ONLINE,
			type = AutoChessConst.POP_TYPE.PVP_SYNC_RECONNECT,
			okCb = function()
				AutoChessMatchAction.ReconnectAutoChess()
			end
		})

		arg_59_0.params_.isShowQuitPop = false
	end
end

function var_0_0.OnExit(arg_61_0)
	arg_61_0:StopWishTimer()
	arg_61_0:LimitStopTimer()
	manager.windowBar:HideBar()
	arg_61_0:UnBindRedPoint()

	if arg_61_0.movie_ then
		Object.Destroy(arg_61_0.movie_)

		arg_61_0.movie_ = nil
	end
end

function var_0_0.Dispose(arg_62_0)
	arg_62_0.commonPortrait_:Dispose()
	var_0_0.super.Dispose(arg_62_0)
end

return var_0_0
