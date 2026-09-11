local AutoChessRemakeMainView = class("AutoChessRemakeMainView", ReduxView)

function AutoChessRemakeMainView:UIName()
	return "Widget/System/Activity_Xihe/Activity_Xihe_HomeUI"
end

function AutoChessRemakeMainView:UIParent()
	return manager.ui.uiMain.transform
end

function AutoChessRemakeMainView:Init()
	self:InitUI()
	self:AddUIListeners()

	self.popBackHandler_ = handler(self, self.CheckStartMatch)
end

function AutoChessRemakeMainView:InitUI()
	self:BindCfgUI()

	self.statusController_ = self.controllerEx_:GetController("status")
	self.rankScoreController_ = self.controllerEx_:GetController("rankScore")
	self.currentController_ = self.controllerEx_:GetController("currentRound")
	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)
	self.bubbleController_ = self.collectController_:GetController("bubble")
end

function AutoChessRemakeMainView:AddUIListeners()
	self:AddBtnListener(self.illustratedBtn_, nil, function()
		JumpTools.OpenPageByJump("/autoChessIllustratedWindow")
		OperationRecorder.RecordButtonTouch({
			source = 1,
			button_name = "activity_autochess_illustration_homepage_touch",
			activity_id = self.activityId_
		})
	end)
	self:AddBtnListener(self.limitTaskBtn_, nil, function()
		JumpTools.OpenPageByJump("/autoChessLimitTaskView_4_8", {
			activityID = ActivityConst.ACTIVITY_AUTO_CHESS_4_8_LIMITED_TASK
		})
	end)
	self:AddBtnListener(self.asyncMatchBtn_, nil, function()
		if self.isOnLinePvp_ then
			ShowTips(string.format(GetTips("AUTO_CHESS_2_WILL_OPEN"), manager.time:GetLostTimeStr(ActivityData:GetActivityData(ActivityConst.ACTIVITY_AUTO_CHESS_PVP_4_8).stopTime)))
		elseif AutoChessData:GetGameStatus(AutoChessConst.GAME_TYPE.PVP_5_0) == AutoChessConst.GAME_STATUS.NONE then
			AutoChessTools.StartNewGame(AutoChessConst.GAME_TYPE.PVP_5_0)
		else
			AutoChessTools.GoToGameView(AutoChessConst.GAME_TYPE.PVP_5_0)
			AutoChessAction.SetGamePause(AutoChessConst.GAME_TYPE.PVP_5_0, AutoChessConst.GAME_PAUSE_TYPE.RESUME)
		end
	end)
	self:AddBtnListener(self.syncMatchBtn_, nil, function()
		if self.isOnLinePvp_ then
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
	self:AddBtnListener(self.collectBtn_, nil, function()
		JumpTools.OpenPageByJump("/autoChessCardCollectView")
		OperationRecorder.RecordButtonTouch({
			button_name = "activity_autochess_collect_homepage_touch",
			activity_id = self.activityId_
		})
	end)
	self:AddBtnListener(self.desireBtn_, nil, function()
		OperationRecorder.RecordButtonTouch({
			button_name = "activity_autochess_item_exchange_homepage_touch",
			activity_id = self.activityId_
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
	self:AddBtnListener(self.openCardBtn_, nil, function()
		JumpTools.OpenPageByJump("/autoChessOpenCardMainView")
	end)
	self:AddBtnListener(self.taskBtn_, nil, function()
		JumpTools.OpenPageByJump("/autoChessTaskView_4_8")
	end)
	self:AddBtnListener(self.rankBtn_, nil, function()
		OperationRecorder.RecordButtonTouch({
			button_name = "activity_autochess_rank_homepage_touch",
			activity_id = self.activityId_
		})
		JumpTools.OpenPageByJump("/autoChessRankView_4_8")
	end)
	self:AddBtnListener(self.levelBtn_, nil, function()
		JumpTools.OpenPageByJump("autoChessLevelPopView")
	end)
	self:AddBtnListener(self.teachBtn_, nil, function()
		self:ShowTeachStage(true)
	end)
	self:AddBtnListener(self.gameOverBtn_, nil, function()
		JumpTools.OpenPageByJump("autoChessQuitPopView", {
			gameType = AutoChessConst.GAME_TYPE.PVP_5_0,
			type = AutoChessConst.POP_TYPE.PVP_ASYNC,
			okCb = function()
				AutoChessTools.CancelGame(AutoChessConst.GAME_TYPE.PVP_5_0, true)
			end
		})
	end)
	self:AddBtnListener(self.recordBtn_, nil, function()
		OperationRecorder.RecordButtonTouch({
			button_name = "activity_autochess_record_homepage_touch",
			activity_id = self.activityId_
		})

		if self.isOnLinePvp_ then
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
	self.commonPortrait_:RegisteClickCallback(handler(self, self.OnClickHeadBackCall))
end

function AutoChessRemakeMainView:OnClickHeadBackCall()
	OperationRecorder.RecordButtonTouch({
		button_name = "activity_autochess_headshots_touch",
		activity_id = self.activityId_
	})
	JumpTools.OpenPageByJump("autoChessHeadTipsCollectPopView")
end

function AutoChessRemakeMainView:OnEnter()
	self.isOnLinePvp_ = ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_PVP_4_8)
	self.activityId_ = self.isOnLinePvp_ and ActivityConst.ACTIVITY_AUTO_CHESS_4_8 or ActivityConst.ACTIVITY_AUTO_CHESS_5_0

	AutoChessData:SetActivityID(self.activityId_)
	self:BindRedPoint()
	self:AddMovie()
end

function AutoChessRemakeMainView:OnEnterOver()
	self:RefreshUI()
	self:ShowTeachStage()
	self:CheckShowReconnectPop()
	self:CheckStartMatch()
end

function AutoChessRemakeMainView:OnTop()
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
			activity_id = self.activityId_
		})
		JumpTools.OpenPageByJump("gameHelp", {
			content = GetTips("AUTO_CHESS_2_HOME_TIP")
		})
	end)
	self:RefreshCurrentRound()
end

function AutoChessRemakeMainView:AddMovie()
	if not self.movie_ then
		self.movie_ = Asset.Instantiate("Widget/System/Activity_Xihe/Movie/Activity_Xihe_Home_Movie")

		if self.movie_ then
			self.movie_.transform.parent = self.movieTrans_
			self.movie_.transform.localScale = Vector3.one
			self.movie_.transform.localPosition = Vector3.zero
		end
	end
end

function AutoChessRemakeMainView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.limitTaskBtn_.transform, RedPointConst.AUTO_CHESS_4_8_LIMIT_TASK .. ActivityConst.ACTIVITY_AUTO_CHESS_4_8_LIMITED_TASK)
	manager.redPoint:bindUIandKey(self.openCardBtn_.transform, RedPointConst.AUTO_CHESS_4_8_OPEN_CARD)
	manager.redPoint:bindUIandKey(self.taskBtn_.transform, RedPointConst.AUTO_CHESS_4_8_RESIDENT_TASK .. self.activityId_)
end

function AutoChessRemakeMainView:UnBindRedPoint()
	manager.redPoint:unbindUIandKey(self.limitTaskBtn_.transform, RedPointConst.AUTO_CHESS_4_8_LIMIT_TASK .. ActivityConst.ACTIVITY_AUTO_CHESS_4_8_LIMITED_TASK)
	manager.redPoint:unbindUIandKey(self.openCardBtn_.transform, RedPointConst.AUTO_CHESS_4_8_OPEN_CARD)
	manager.redPoint:unbindUIandKey(self.taskBtn_.transform, RedPointConst.AUTO_CHESS_4_8_RESIDENT_TASK .. self.activityId_)
end

function AutoChessRemakeMainView:ShowTeachStage(arg_37_1)
	local var_37_0 = GameSetting.auto_chess_2_tutorial_stage_id.value[1]
	local var_37_1 = AutoChessData:GetStageStoryId()

	if arg_37_1 or AutoChessTools.GetStageState(GameSetting.auto_chess_2_tutorial_stage_id.value[1]) ~= AutoChessConst.STAGE_STATE.COMPLETED then
		local var_37_2 = AutoChessStageCfg[GameSetting.auto_chess_2_tutorial_stage_id.value[1]]

		if AutoChessStageCfg[GameSetting.auto_chess_2_tutorial_stage_id.value[1]].pre_story and var_37_2.pre_story ~= 0 then
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

function AutoChessRemakeMainView:RefreshUI()
	self.commonPortrait_:ChangeFrameActive(false)
	self.commonPortrait_:RenderHead(PlayerData:GetPlayerInfo().portrait)

	local var_43_0, var_43_1 = TaskTools.GetTaskNumInfo(ActivityConst.ACTIVITY_AUTO_CHESS_4_8)

	self.taskProgressText_.text = string.format("%s<size=44>/%s</size>", var_43_0, var_43_1)
	self.taskTitleText_.text = GetTips("AUTO_CHESS_CAREER_ENTRANCE")
	self.illustratTitleText_.text = GetTips("AUTO_CHESS_INDEX_ENTRANCE")

	self:RefreshActivityButton()
	self:RefreshRankLevel()
	self:RefreshCard()
	self:RefreshTips()
	self:RefreshWish()
	self:RefreshTime()
end

function AutoChessRemakeMainView:RefreshCurrentRound()
	if self.isOnLinePvp_ then
		self.currentController_:SetSelectedState("hide")

		return
	end

	if AutoChessData:GetGameStatus(AutoChessConst.GAME_TYPE.PVP_5_0) == AutoChessConst.GAME_STATUS.NONE then
		self.currentController_:SetSelectedState("hide")

		self.pvpGoText_.text = GetTips("AUTO_CHESS_PVP_ENTRANCE")
	else
		self.currentController_:SetSelectedState("show")

		self.curRoundText_.text = AutoChessData:GetPrepareData(AutoChessConst.GAME_TYPE.PVP_5_0):GetPlayerData().curRoundCount
		self.pvpGoText_.text = GetTips("AUTO_CHESS_BUTTON_RESUME")
	end
end

function AutoChessRemakeMainView:RefreshTips()
	if (getData("autochess_4_8", "isShowSunglasses") or 0) == 0 and AutoChessCardData:GetSunglassesState() ~= 0 then
		saveData("autochess_4_8", "isShowSunglasses", 1)
		JumpTools.OpenPageByJump("autoChessSunglassesPopView", {
			callback = self.popBackHandler_
		})
	else
		if not ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_EXCHANGE_CARD) then
			return
		end

		local var_45_0 = getData("autochess_4_8", "isShowWish") or 0
		local var_45_1 = AutoChessCardData:GetDesireInfo()

		if var_45_1.CardID > 0 and var_45_1.State == AutoChessCardConst.DESIRE_STATE.YES and var_45_0 == 0 then
			JumpTools.OpenPageByJump("autoChessWishPopView", {
				callback = self.popBackHandler_
			})
		end
	end
end

function AutoChessRemakeMainView:RefreshActivityButton()
	if self.isOnLinePvp_ then
		self.statusController_:SetSelectedIndex(0)
	else
		self.statusController_:SetSelectedIndex(1)
	end

	SetActive(self.limitTaskBtn_.gameObject, (ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_4_8_LIMITED_TASK)))
	SetActive(self.desireBtn_.gameObject, (ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_EXCHANGE_CARD)))
end

function AutoChessRemakeMainView:RefreshRankLevel()
	if not self.isOnLinePvp_ then
		SetActive(self.levelBtn_.gameObject, false)

		return
	end

	local var_47_0 = AutoChessCardData:GetRankScore()

	self.nowScoreText_.text = var_47_0

	local var_47_1, var_47_2 = AutoChessTools.GetRankLevelCfg(var_47_0)

	if var_47_1.baseline == 0 then
		SetActive(self.levelBtn_.gameObject, false)

		return
	end

	SetActive(self.levelBtn_.gameObject, true)

	if var_47_1 then
		self.rankTitleText_.text = var_47_1.name
		self.rankIconImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_Xihe/RankIcon/" .. var_47_1.icon)
		self.rankRomaText_.text = NumberTools.IntToRomam(var_47_1.rank_level)
	end

	if var_47_2 then
		self.rankScoreController_:SetSelectedState("show")

		self.maxScoreText_.text = "/" .. var_47_2.baseline

		local var_47_3

		if var_47_1 then
			var_47_3 = var_47_1.baseline or 0
		end

		self.prograssImg_.fillAmount = (var_47_0 - var_47_3) / (var_47_2.baseline - var_47_3)
	else
		self.rankScoreController_:SetSelectedState("hide")

		self.prograssImg_.fillAmount = 1
	end
end

function AutoChessRemakeMainView:RefreshCard()
	local var_48_0 = 0

	for iter_48_0, iter_48_1 in pairs((AutoChessCardData:GetCardList())) do
		if iter_48_1 > 0 then
			var_48_0 = var_48_0 + 1
		end
	end

	self.txtCollect_.text = string.format("%s<size=32>/%s</size>", var_48_0, #AutoChessCardCfg.get_id_list_by_is_card_pool[1])
	self.txtCardNum_.text = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_AUTO_CHESS_CARD_ITEM)
end

function AutoChessRemakeMainView:RefreshWish()
	if not ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_EXCHANGE_CARD) then
		SetActive(self.desireBtn_.gameObject, false)

		if AutoChessCardData:GetDesireInfo().State == AutoChessCardConst.DESIRE_STATE.YES then
			JumpTools.OpenPageByJump("autoChessDesireCurSceceView", {
				mode = AutoChessCardConst.DESIRE_TYPE.MY
			})
		end

		return
	end

	SetActive(self.desireBtn_.gameObject, true)
	self:RefreshWishTime()

	if AutoChessCardData:GetDesireNum() >= GameSetting.auto_chess_2_exchange_self_times.value[1] then
		self.bubbleController_:SetSelectedState("hide")

		return
	end

	local var_49_0 = AutoChessCardData:GetDesireInfo()

	if var_49_0.CardID > 0 then
		self.bubbleController_:SetSelectedState("fulfill")

		self.txtWish_.text = var_49_0.State == AutoChessCardConst.DESIRE_STATE.NO and GetTips("AUTO_CHESS_2_WISHING") or GetTips("AUTO_CHESS_2_WISH_GRANTED")
	else
		self.bubbleController_:SetSelectedState("wish")

		self.txtWishEmpty_.text = GetTips("AUTO_CHESS_2_WISH_AVAILABLE")
	end
end

function AutoChessRemakeMainView:RefreshWishTime()
	local var_50_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_AUTO_CHESS_EXCHANGE_CARD)

	self.txtWishTime_.text = manager.time:GetLostTimeStr2(var_50_0.stopTime)

	if self.wishtimer_ == nil then
		self.wishtimer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_EXCHANGE_CARD) then
				self.txtWishTime_.text = manager.time:GetLostTimeStr2(var_50_0.stopTime)
			else
				self:StopWishTimer()
			end
		end, 1, -1)
	end

	self.wishtimer_:Start()
end

function AutoChessRemakeMainView:StopWishTimer()
	if self.wishtimer_ then
		self.wishtimer_:Stop()

		self.wishtimer_ = nil
	end
end

function AutoChessRemakeMainView:RefreshTime()
	local var_53_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_AUTO_CHESS_4_8_LIMITED_TASK)

	self.timeText_.text = manager.time:GetLostTimeStr2(var_53_0.stopTime)

	SetActive(self.limitTaskBtn_.gameObject, ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_4_8_LIMITED_TASK))

	if self.limittimer_ == nil then
		self.limittimer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_4_8_LIMITED_TASK) then
				self.timeText_.text = manager.time:GetLostTimeStr2(var_53_0.stopTime)
			else
				SetActive(self.limitTaskBtn_.gameObject, false)
				self:LimitStopTimer()
			end
		end, 1, -1)
	end

	self.limittimer_:Start()
end

function AutoChessRemakeMainView:LimitStopTimer()
	if self.limittimer_ then
		self.limittimer_:Stop()

		self.limittimer_ = nil
	end
end

function AutoChessRemakeMainView:CheckStartMatch()
	if not self:IsTop() then
		return
	end

	local var_56_0 = AutoChessCardData:GetRewardItemList()
	local var_56_1 = #var_56_0 > 0

	if self.params_.isStartMatch then
		if var_56_1 then
			sortMergeGetReward(var_56_0, _, function()
				self:MatchJump()
			end)
		else
			self:MatchJump()
		end

		self.params_.isStartMatch = false

		AutoChessCardData:AddRewardItem({})
	else
		if var_56_1 then
			sortMergeGetReward(var_56_0)
		end

		AutoChessCardData:AddRewardItem({})
	end
end

function AutoChessRemakeMainView:MatchJump()
	if self.isOnLinePvp_ then
		AutoChessMatchAction.StartMatch()
	elseif AutoChessData:GetGameStatus(AutoChessConst.GAME_TYPE.PVP_5_0) == AutoChessConst.GAME_STATUS.NONE then
		AutoChessTools.StartNewGame(AutoChessConst.GAME_TYPE.PVP_5_0)
	else
		AutoChessTools.GoToGameView(AutoChessConst.GAME_TYPE.PVP_5_0)
		AutoChessAction.SetGamePause(AutoChessConst.GAME_TYPE.PVP_5_0, AutoChessConst.GAME_PAUSE_TYPE.RESUME)
	end
end

function AutoChessRemakeMainView:CheckShowReconnectPop()
	print("AutoChessRemakeMainView:CheckShowReconnectPop():", tostring(self.params_.isShowQuitPop))

	if self.params_.isShowQuitPop then
		JumpTools.OpenPageByJump("autoChessQuitPopView", {
			gameType = AutoChessConst.GAME_TYPE.ONLINE,
			type = AutoChessConst.POP_TYPE.PVP_SYNC_RECONNECT,
			okCb = function()
				AutoChessMatchAction.ReconnectAutoChess()
			end
		})

		self.params_.isShowQuitPop = false
	end
end

function AutoChessRemakeMainView:OnExit()
	self:StopWishTimer()
	self:LimitStopTimer()
	manager.windowBar:HideBar()
	self:UnBindRedPoint()

	if self.movie_ then
		Object.Destroy(self.movie_)

		self.movie_ = nil
	end
end

function AutoChessRemakeMainView:Dispose()
	self.commonPortrait_:Dispose()
	AutoChessRemakeMainView.super.Dispose(self)
end

return AutoChessRemakeMainView
