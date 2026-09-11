local AutoChessMainView = class("AutoChessMainView", ReduxView)

function AutoChessMainView:UIName()
	return "Widget/System/Activity_OsirisHorus/Activity_OsirisHorus_Main/Activity_OsirisHorus_HomeUI"
end

function AutoChessMainView:UIParent()
	return manager.ui.uiMain.transform
end

function AutoChessMainView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function AutoChessMainView:InitUI()
	self:BindCfgUI()

	self.statusController_ = self.controllerEx_:GetController("status")
	self.pvpLockController_ = self.controllerEx_:GetController("pvpLock")
	self.difficultyController_ = self.controllerEx_:GetController("difficulty")
	self.medalItems_ = {}

	for iter_4_0, iter_4_1 in ipairs(AutoChessMedalCfg.all) do
		self.medalItems_[iter_4_1] = AutoChessMedalItem.New(self["medalItem" .. iter_4_0 .. "_"])
	end

	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)
	self.medalTips_ = AutoChessMedalTipsItem.New(self.medalTipsGo_)
	self.skinDlcController_ = self.controller_:GetController("skinDLC")
	self.skinGotController_ = self.controller_:GetController("skinGot")
	self.skinGiftController_ = self.controller_:GetController("skinGift")
	self.timebgController_ = self.controller_:GetController("timebg")
end

function AutoChessMainView:AddUIListeners()
	self:AddBtnListener(self.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("/autoChessLimitTaskView", {
			activityID = ActivityConst.ACTIVITY_AUTO_CHESS_TASK
		})
	end)
	self:AddBtnListener(self.pveBtn_, nil, function()
		JumpTools.OpenPageByJump("/autoChessPVESelectStageView")
	end)
	self:AddBtnListener(self.pvpBtn_, nil, function()
		if not self.isPassPvpStage_ then
			ShowTips("AUTO_CHESS_PVP_LOCKED_TIP")

			return
		end

		JumpTools.OpenPageByJump("/autoChessPVPEnterView")
	end)
	self:AddBtnListener(self.illustratedBtn_, nil, function()
		JumpTools.OpenPageByJump("/autoChessIllustratedWindow")
		OperationRecorder.RecordButtonTouch({
			source = 1,
			button_name = "activity_autochess_illustration_homepage_touch",
			activity_id = self.activityId_
		})
	end)
	self:AddBtnListener(self.taskBtn_, nil, function()
		JumpTools.OpenPageByJump("/autoChessTaskView")
	end)
	self:AddBtnListener(self.skinBtn_, nil, function()
		JumpTools.OpenPageByJump("autoChessSkinDlcView")
	end)
	self.commonPortrait_:RegisteClickCallback(handler(self, self.OnClickHeadBackCall))
end

function AutoChessMainView:OnClickHeadBackCall()
	OperationRecorder.RecordButtonTouch({
		source = 1,
		button_name = "activity_autochess_headshots_touch",
		activity_id = self.activityId_
	})
	JumpTools.OpenPageByJump("autoChessHeadTipsPopView", {
		type = 1
	})
end

function AutoChessMainView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("AUTO_CHESS_ENTRANCE_TIP")
	self:RefreshSkinGet()
end

function AutoChessMainView:OnEnter()
	AutoChessData:SetActivityID(ActivityConst.ACTIVITY_AUTO_CHESS_MAIN)

	self.activityId_ = AutoChessData:GetActivityID()

	self:RefreshUI()
	self:RefreshMedalItmes()
	self:RefreshTime()
	self:RefreshSkinTime()
	self:BindRedPoint()
	self:RefreshPvpTime()

	if not self.move then
		self.move = Asset.Instantiate("Widget/System/Activity_OsirisHorus/Movie/Activity_OsirisHorus_Home_Movie")

		if self.move then
			self.move.transform.parent = self.movieTrans_
			self.move.transform.localScale = Vector3.one
			self.move.transform.localPosition = Vector3.zero
		end
	end
end

function AutoChessMainView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.rewardBtn_.transform, RedPointConst.AUTO_CHESS_LIMIT_TASK .. ActivityConst.ACTIVITY_AUTO_CHESS_TASK)
	manager.redPoint:bindUIandKey(self.pveBtn_.transform, RedPointConst.AUTO_CHESS_PVE_STAGE)
	manager.redPoint:bindUIandKey(self.taskBtn_.transform, RedPointConst.AUTO_CHESS_RESIDENT_TASK .. self.activityId_)
end

function AutoChessMainView:UnBindRedPoint()
	manager.redPoint:unbindUIandKey(self.rewardBtn_.transform, RedPointConst.AUTO_CHESS_LIMIT_TASK .. ActivityConst.ACTIVITY_AUTO_CHESS_TASK)
	manager.redPoint:unbindUIandKey(self.pveBtn_.transform, RedPointConst.AUTO_CHESS_PVE_STAGE)
	manager.redPoint:unbindUIandKey(self.taskBtn_.transform, RedPointConst.AUTO_CHESS_RESIDENT_TASK .. self.activityId_)
end

function AutoChessMainView:RefreshUI()
	self.commonPortrait_:RenderHead(PlayerData:GetPlayerInfo().portrait)

	local var_17_0, var_17_1 = TaskTools.GetTaskNumInfo(self.activityId_)

	self.taskProgressText_.text = GetTipsF("AUTO_CHESS_PROGRESS_NUMBER_HOME", var_17_0, var_17_1)
	self.isPassPvpStage_ = AutoChessTools.GetStageState(GameSetting.auto_chess_PVP_unlock.value[1]) == AutoChessConst.STAGE_STATE.COMPLETED

	self.pvpLockController_:SetSelectedState(self.isPassPvpStage_ and "unlock" or "lock")
	self.statusController_:SetSelectedState(self.isPassPvpStage_ and "pvp" or "pve")

	self.pvpTitleText_.text = GetTips("AUTO_CHESS_PVP_ENTRANCE")
	self.pveTitleText_.text = GetTips("AUTO_CHESS_PVE_ENTRANCE")
	self.taskTitleText_.text = GetTips("AUTO_CHESS_CAREER_ENTRANCE")
	self.illustratTitleText_.text = GetTips("AUTO_CHESS_INDEX_ENTRANCE")

	local var_17_2 = AutoChessAreaCfg[AutoChessTools.GetCurChallengeArea()]

	if self.isPassPvpStage_ then
		self.pveSmallBg_.sprite = getSpriteWithoutAtlas("TextureConfig/Activity_OsirisHorus/Home_img/home_bg_s" .. var_17_2.entrance_picture)
	else
		self.pveBg_.sprite = getSpriteWithoutAtlas("TextureConfig/Activity_OsirisHorus/Home_img/home_bg_m" .. var_17_2.entrance_picture)
	end

	if AutoChessTools.IsCanChallengeStage() and self.isPassPvpStage_ then
		self.difficultyController_:SetSelectedState("on")
	else
		self.difficultyController_:SetSelectedState("off")
	end
end

function AutoChessMainView:RefreshMedalItmes()
	local var_18_0 = {}
	local var_18_1 = {}
	local var_18_2 = {}

	for iter_18_0, iter_18_1 in ipairs(AutoChessMedalCfg.all) do
		local var_18_3, var_18_4 = AutoChessData:FindMedalInfo(iter_18_1)
		local var_18_5 = true

		if AutoChessData.IsMedalUnlockedFromInfo(var_18_4) then
			if (getData("auto_chess_main", "medal_id_" .. iter_18_1 .. "_1") or 0) == 0 then
				table.insert(var_18_0, iter_18_1)

				var_18_5 = false
			end
		end

		if AutoChessData.IsMedalAdvancedFromInfo(var_18_4) then
			if (getData("auto_chess_main", "medal_id_" .. iter_18_1 .. "_2") or 0) == 0 then
				table.insert(var_18_1, iter_18_1)

				var_18_5 = false
			end
		end

		if var_18_5 then
			table.insert(var_18_2, iter_18_1)
		end
	end

	local var_18_6 = 1

	if #var_18_0 > 0 then
		self.normalTimer = Timer.New(function()
			saveData("auto_chess_main", "medal_id_" .. var_18_0[var_18_6] .. "_1", 1)
			self.medalTips_:SetCloseFunc(handler(self, self.OnRefreshMedel))
			self.medalTips_:SetData(var_18_0[var_18_6], false)

			var_18_6 = var_18_6 + 1
		end, 2, #var_18_0)

		self.normalTimer:Start()
	end

	local var_18_7 = 1

	if #var_18_1 > 0 then
		self.advanceTimer = Timer.New(function()
			saveData("auto_chess_main", "medal_id_" .. var_18_1[var_18_7] .. "_2", 1)
			self.medalTips_:SetCloseFunc(handler(self, self.OnRefreshMedel))
			self.medalTips_:SetData(var_18_1[var_18_7], true)

			var_18_7 = var_18_7 + 1
		end, #var_18_0 * 2 + 2, #var_18_1)

		self.advanceTimer:Start()
	end

	if #var_18_2 > 0 then
		for iter_18_2, iter_18_3 in ipairs(var_18_2) do
			self:OnRefreshMedel(iter_18_3, false)
		end
	end
end

function AutoChessMainView:OnRefreshMedel(arg_21_1, arg_21_2)
	self.medalItems_[arg_21_1]:SetData(arg_21_1, arg_21_2)
end

function AutoChessMainView:RefreshTime()
	local var_22_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_AUTO_CHESS_TASK)

	self.timeText_.text = manager.time:GetLostTimeStr2(var_22_0.stopTime)

	SetActive(self.rewardBtn_.gameObject, ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_TASK))

	if self.limittimer_ == nil then
		self.limittimer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_TASK) then
				self.timeText_.text = manager.time:GetLostTimeStr2(var_22_0.stopTime)
			else
				SetActive(self.rewardBtn_.gameObject, false)
				self:LimitStopTimer()
			end
		end, 1, -1)
	end

	self.limittimer_:Start()
end

function AutoChessMainView:RefreshPvpTime()
	if not self.isPassPvpStage_ then
		self.timebgController_:SetSelectedState("un")

		return
	end

	self.timebgController_:SetSelectedState("time")

	local var_24_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_AUTO_CHESS_PVP_4_8)

	if manager.time:GetServerTime() > var_24_0.stopTime then
		self:StopPvpTimeTimer()

		self.txtPvPTime_.text = GetTips("TIME_OVER")

		return
	end

	self.txtPvPTime_.text = GetTipsF("LEFT_TIME", manager.time:GetLostTimeStrWith2Unit(var_24_0.stopTime))

	if self.pvpTimeTimer_ == nil then
		self.pvpTimeTimer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_PVP_4_8) then
				self.txtPvPTime_.text = GetTipsF("LEFT_TIME", manager.time:GetLostTimeStrWith2Unit(var_24_0.stopTime))
			else
				self:StopPvpTimeTimer()

				self.txtPvPTime_.text = GetTips("TIME_OVER")
			end
		end, 1, -1)
	end

	self.pvpTimeTimer_:Start()
end

function AutoChessMainView:LimitStopTimer()
	if self.limittimer_ then
		self.limittimer_:Stop()

		self.limittimer_ = nil
	end
end

function AutoChessMainView:StopPvpTimeTimer()
	if self.pvpTimeTimer_ then
		self.pvpTimeTimer_:Stop()

		self.pvpTimeTimer_ = nil
	end
end

function AutoChessMainView:DisposeSkinTimer()
	if self.skinTimer_ then
		self.skinTimer_:Stop()

		self.skinTimer_ = nil
	end
end

function AutoChessMainView:RefreshSkinTime()
	self:RefreshSkinGet()
	self:UpdateSkinTime()
	self:DisposeSkinTimer()

	self.skinTimer_ = Timer.New(function()
		self:UpdateSkinTime()
	end, 1, -1)

	self.skinTimer_:Start()
end

function AutoChessMainView:UpdateSkinTime()
	local var_31_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_AUTO_CHESS_SKIN)

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_SKIN) then
		self.skinTimeText_.text = manager.time:GetLostTimeStr2(ActivityData:GetActivityData(ActivityConst.ACTIVITY_AUTO_CHESS_SKIN).stopTime)
	elseif manager.time:GetServerTime() < var_31_0.startTime then
		self.skinTimeText_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStr2(var_31_0.startTime))
	elseif manager.time:GetServerTime() > var_31_0.stopTime then
		self.skinTimeText_.text = GetTips("TIME_OVER")
	end
end

function AutoChessMainView:RefreshSkinGet()
	local var_32_0 = AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_AUTO_CHESS_SKIN] or {}

	if not ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_SKIN) then
		self.skinDlcController_:SetSelectedState("off")

		return
	else
		self.skinDlcController_:SetSelectedState("on")
	end

	if TaskTools:GetFinishTaskNum(var_32_0) == #var_32_0 then
		self.skinGotController_:SetSelectedState("on")
	else
		self.skinGotController_:SetSelectedState("off")
	end

	if TaskTools:IsHasReceiveTask(var_32_0) then
		self.skinGiftController_:SetSelectedState("on")
	else
		self.skinGiftController_:SetSelectedState("off")
	end
end

function AutoChessMainView:OnExit()
	manager.windowBar:HideBar()
	self:DisposeSkinTimer()
	self:LimitStopTimer()
	self:StopPvpTimeTimer()

	if self.limittimer_ then
		self.limittimer_:Stop()

		self.limittimer_ = nil
	end

	if self.normalTimer then
		self.normalTimer:Stop()

		self.normalTimer = nil
	end

	if self.advanceTimer then
		self.advanceTimer:Stop()

		self.advanceTimer = nil
	end

	if self.move then
		Object.Destroy(self.move)

		self.move = nil
	end

	self:UnBindRedPoint()
end

function AutoChessMainView:Dispose()
	self.commonPortrait_:Dispose()
	self.medalTips_:Dispose()

	for iter_34_0, iter_34_1 in pairs(self.medalItems_) do
		iter_34_1:Dispose()
	end

	self.medalItems_ = nil

	AutoChessMainView.super.Dispose(self)
end

return AutoChessMainView
