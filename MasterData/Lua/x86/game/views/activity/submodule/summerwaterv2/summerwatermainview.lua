local SummerWaterMainView = class("SummerWaterMainView", ReduxView)

function SummerWaterMainView:UIName()
	return "Widget/Version/SummerUI_3_4/SummerUI_3_4_SwimsuitUI/SummerUI_3_4_SwimsuitWaterGunUI"
end

function SummerWaterMainView:UIParent()
	return manager.ui.uiMain.transform
end

function SummerWaterMainView:Init()
	self:InitUI()
end

function SummerWaterMainView:InitUI()
	self:BindCfgUI()
	self:AddUIListeners()

	self.modelShowController_ = self.controller_:GetController("show")
	self.singleSelectShowController_ = self.singleSelectController_:GetController("select")
	self.tabSelectController_ = {
		ControllerUtil.GetController(self.singleTab_.transform, "select"),
		(ControllerUtil.GetController(self.multiTab_.transform, "select"))
	}
	self.btnShowController_ = self.btnController_:GetController("btn")
	self.multiLockController_ = self.multiLockCon_:GetController("lock")
	self.singleLockController_ = self.singleBtnCon_:GetController("grey")
end

function SummerWaterMainView:CheckIsOpenCooperation()
	local var_5_0 = manager.time:GetServerHour()

	if var_5_0 < GameSetting.activity_water_online_open.value[1] or var_5_0 >= GameSetting.activity_water_online_open.value[2] then
		ShowTips("ACTIVITY_WATER_ONLINE_OPEN")

		return false
	end

	return true
end

function SummerWaterMainView:AddUIListeners()
	self:AddBtnListener(self.multiPlayBtn_, nil, function()
		local var_7_0

		if not self:CheckIsOpenCooperation() then
			do return end

			var_7_0 = ActivitySummerWaterData:GetCurrentScheduleData()
		end

		if CooperationData:GetIsMatching() then
			CooperationAction.CancelMatching()
		else
			CooperationAction.StartMatching(var_7_0.open_online_stage_id, BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER_COOPERATION, {
				(CooperationData:GetCooperationHero(BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER_COOPERATION, var_7_0.open_online_stage_id, self.activityID_))
			}, self.activityID_)
		end

		self:ShowMatching()
	end)
	self:AddBtnListener(self.singlePlayBtn_, nil, function()
		if not self.selectHero_ or self.selectHero_ == 0 then
			ShowTips("ACTIVITY_WATER_NEED_SELECT_HERO")

			return
		end

		JumpTools.OpenPageByJump("/summerWaterSectionSelectHero", {
			section = ActivitySummerWaterData.GetCurrentScheduleData().open_stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_SUMMER_WATER,
			activityID = self.activityID_,
			mainActivityID = self.activityID_
		})
	end)
	self:AddBtnListener(self.singleTab_, nil, function()
		self:SelectTab(1)
	end)
	self:AddBtnListener(self.multiTab_, nil, function()
		self:SelectTab(2)
	end)
	self:AddBtnListener(self.cancelBtn_, nil, function()
		self:HideMatching()
	end)
	self:AddBtnListener(self.rewardBtn_, nil, function()
		local var_12_0 = {}

		for iter_12_0, iter_12_1 in ipairs(AssignmentCfg.get_id_list_by_activity_id[self.activityID_]) do
			if not table.indexof(var_12_0, iter_12_1) then
				table.insert(var_12_0, iter_12_1)
			end
		end

		JumpTools.OpenPageByJump("summerQuestRewardPop", {
			activityIDList = var_12_0
		})
	end)
	self:AddBtnListener(self.createRoomBtn_, nil, function()
		if not self:CheckIsOpenCooperation() then
			return
		end

		if CooperationData:GetRoomData() then
			CooperationTools.GotoCooperation()
		else
			local var_13_0 = ActivitySummerWaterData.GetCurrentScheduleData()

			CooperationAction.CreateRoom(var_13_0.open_online_stage_id, BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER_COOPERATION, {
				(CooperationData:GetCooperationHero(BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER_COOPERATION, var_13_0.open_online_stage_id, self.activityID_))
			}, self.activityID_)
		end
	end)
	self:AddBtnListener(self.roleBtn1_, nil, function()
		self:SelectHero(self.singleHeroList_[1])
	end)
	self:AddBtnListener(self.roleBtn2_, nil, function()
		self:SelectHero(self.singleHeroList_[2])
	end)
	self:AddBtnListener(nil, self.searchBtn_, function()
		if not self:CheckIsOpenCooperation() then
			return
		end

		JumpTools.OpenPageByJump("cooperationApply", {
			room_type = BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER_COOPERATION
		})
	end)
end

function SummerWaterMainView:OnEnter()
	self.activityID_ = ActivitySummerWaterData:GetActivityID()

	if not self.activityID_ then
		ShowTips("TIME_OVER")
		ActivityTools.JumpBackToActivityMainViewByTheme(ActivityCfg[ActivitySummerWaterData:GetMainActivityID()].activity_theme)

		return
	end

	self:SetActiveData()
	self:RefreshBar()
	self:SelectTab(self.selectModel_)
	self:AddTimer()
	self:RefreshUI()
	self:BindRedPoint()
end

function SummerWaterMainView:SetActiveData()
	local var_18_0 = ActivityData:GetActivityData(self.activityID_)

	self.startTime_ = var_18_0.startTime
	self.stopTime_ = var_18_0.stopTime
	self.scheduleCfg_ = ActivitySummerWaterData:GetCurrentScheduleCfg()
	self.singleHeroList_ = self.scheduleCfg_.hero_id_list
	self.multiHeroList_ = self.scheduleCfg_.online_hero_id_list
	self.selectHero_ = SummerWaterTools.GetSingleSelectHero()
	self.selectModel_ = getData("SummerWater", "selectModel") or 1
end

function SummerWaterMainView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.rewardBtn_.transform, RedPointConst.ACTIVITY_WATER_ASSIGNMENT)
	manager.redPoint:bindUIandKey(self.multiTab_.transform, RedPointConst.ACTIVITY_WATER_MULTIPLE_OPEN)
end

function SummerWaterMainView:UnBindRedPoint()
	manager.redPoint:unbindUIandKey(self.rewardBtn_.transform, RedPointConst.ACTIVITY_WATER_ASSIGNMENT)
	manager.redPoint:unbindUIandKey(self.multiTab_.transform, RedPointConst.ACTIVITY_WATER_MULTIPLE_OPEN)
end

function SummerWaterMainView:OnWaterResult()
	self:OnTop()
end

function SummerWaterMainView:OnTop()
	self.activityID_ = ActivitySummerWaterData:GetActivityID()

	if not self.activityID_ then
		ShowTips("TIME_OVER")
		ActivityTools.JumpBackToActivityMainViewByTheme(ActivityCfg[ActivitySummerWaterData:GetMainActivityID()].activity_theme)

		return
	end

	self:RefreshBar()

	local var_22_0 = ActivityData:GetActivityData(self.activityID_)

	self.startTime_ = var_22_0.startTime
	self.stopTime_ = var_22_0.stopTime
	self.scheduleCfg_ = ActivitySummerWaterData:GetCurrentScheduleCfg()
	self.singleHeroList_ = self.scheduleCfg_.hero_id_list
	self.multiHeroList_ = self.scheduleCfg_.online_hero_id_list
	self.selectHero_ = SummerWaterTools.GetSingleSelectHero()

	self:SelectTab(self.selectModel_)
	self:AddTimer()
	self:RefreshUI()
end

function SummerWaterMainView:RefreshBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		INVITE_BAR,
		self.scheduleCfg_.assistance_coin_id
	})
	manager.windowBar:SetBarCanAdd(self.scheduleCfg_.assistance_coin_id, true)
	manager.windowBar:SetGameHelpKey("ACTIVITY_SWIMSUIT_EXPLAIN_WATER")
	manager.windowBar:RegistBackCallBack(function()
		ActivityTools.JumpBackToActivityMainViewByTheme(ActivityCfg[ActivitySummerWaterData:GetMainActivityID()].activity_theme)
	end)
end

function SummerWaterMainView:SelectTab(arg_25_1)
	self.selectModel_ = arg_25_1

	if arg_25_1 == 2 then
		saveData("Activity_Water", "time", manager.time:GetServerTime())
		ActivityWaterAction.UpdateCooperationRedPoint()
	end

	for iter_25_0, iter_25_1 in ipairs(self.tabSelectController_) do
		iter_25_1:SetSelectedState(tostring(iter_25_0 == arg_25_1))
	end

	self.modelShowController_:SetSelectedIndex(arg_25_1 - 1)

	if self.selectModel_ == 1 then
		self:RefreshRoleController()
	elseif self.selectModel_ == 2 then
		self:RefreshMultiController()
	end

	self.btnShowController_:SetSelectedIndex(arg_25_1 - 1)
end

function SummerWaterMainView:RefreshMultiController()
	local var_26_1 = manager.time:GetServerHour()

	self.multiLockController_:SetSelectedState(tostring(not ((var_26_1 < GameSetting.activity_water_online_open.value[1] or var_26_1 >= GameSetting.activity_water_online_open.value[2] or nil) and false)))
end

function SummerWaterMainView:SelectHero(arg_27_1)
	if self.selectHero_ == arg_27_1 then
		return
	end

	self.selectHero_ = arg_27_1

	SummerWaterTools.SetSingleSelectHero(arg_27_1)
	self:RefreshRoleController()
end

function SummerWaterMainView:RefreshRoleController()
	self.singleSelectShowController_:SetSelectedIndex(0)
	self.singleLockController_:SetSelectedState("true")

	for iter_28_0, iter_28_1 in ipairs(self.singleHeroList_) do
		if self.selectHero_ == iter_28_1 then
			self.singleSelectShowController_:SetSelectedIndex(iter_28_0)
			self.singleLockController_:SetSelectedState("false")
		end
	end
end

function SummerWaterMainView:RefreshUI()
	if manager.time:GetServerTime() >= self.stopTime_ then
		ShowTips("TIME_OVER")
		ActivityTools.JumpBackToActivityMainViewByTheme(ActivityCfg[ActivitySummerWaterData:GetMainActivityID()].activity_theme)
	end

	self.roleImg1_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. HeroStandardSystemCfg[self.singleHeroList_[1]].hero_id)
	self.roleImg2_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. HeroStandardSystemCfg[self.singleHeroList_[2]].hero_id)

	local var_29_0 = ActivitySummerWaterData:GetTotalGainCurrenyNum() .. "/" .. self.scheduleCfg_.voting_ticket_limit

	self.singleGetNumText_.text = var_29_0
	self.multiGetNumText_.text = var_29_0
end

function SummerWaterMainView:AddTimer()
	self:StopTimer()
	self:RefreshTimeText()

	local var_30_0 = ActivityData:GetActivityData(ActivitySummerWaterData:GetMainActivityID()).stopTime

	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() > var_30_0 then
			return
		end

		self:RefreshMultiController()
		self:RefreshTimeText()
	end, 1, -1)

	self.timer_:Start()
end

function SummerWaterMainView:RefreshTimeText()
	if self.timeText_ then
		self.timeText_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStrWith2Unit(ActivityData:GetActivityData(ActivitySummerWaterData:GetMainActivityID()).stopTime, true)
	end
end

function SummerWaterMainView:OnExit()
	self:StopTimer()
	manager.windowBar:HideBar()
	self:HideMatching()
	self:UnBindRedPoint()
	saveData("SummerWater", "selectModel", self.selectModel_)
end

function SummerWaterMainView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function SummerWaterMainView:IsActivityTime()
	if manager.time:GetServerTime() < self.startTime_ then
		ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStrWith2Unit(self.startTime_, true)))

		return false
	end

	if manager.time:GetServerTime() >= self.stopTime_ then
		ShowTips("TIME_OVER")

		return false
	end

	return true
end

function SummerWaterMainView:ShowMatching()
	SetActive(self.popGo_, true)

	self.curMatchingSeconds_ = 0
	self.secondLabel_.text = string.format(GetTips("ACTIVITY_WATER_MATCHING"), self.curMatchingSeconds_ .. "s")

	if self.matchingTimer_ == nil then
		self.matchingTimer_ = Timer.New(function()
			self:OnMatchingTimer()
		end, 1, -1)
	end

	self.matchingTimer_:Start()
end

function SummerWaterMainView:HideMatching()
	if self.matchingTimer_ then
		self.matchingTimer_:Stop()

		self.matchingTimer_ = nil
	end

	self.curMatchingSeconds_ = 0

	CooperationAction.CancelMatching()
	SetActive(self.popGo_, false)
end

function SummerWaterMainView:OnMatchingTimer()
	self.curMatchingSeconds_ = self.curMatchingSeconds_ + 1
	self.secondLabel_.text = string.format(GetTips("ACTIVITY_WATER_MATCHING"), self.curMatchingSeconds_ .. "s")
end

return SummerWaterMainView
