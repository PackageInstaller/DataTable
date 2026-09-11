local ActivityCultivateHeroMainView = class("ActivityCultivateHeroMainView", ReduxView)

function ActivityCultivateHeroMainView:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(Asset.Load(self:UIName(arg_1_2)), arg_1_1.transform)
	self.transform_ = self.gameObject_.transform
	self.activityID_ = arg_1_2

	self:Init()
end

function ActivityCultivateHeroMainView:UIName(arg_2_1)
	return CultivateHeroTools.GetMainUIName(arg_2_1)
end

function ActivityCultivateHeroMainView:Init()
	self:BindCfgUI()

	self.roleImage_.immediate = true

	self:AddListeners()

	self.switchItemList_ = LuaList.New(handler(self, self.IndexItem), self.switchListGo_, self:GetSwitchItemClass())
	self.heroTaskList_ = LuaList.New(handler(self, self.IndexHeroTask), self.heroTaskListGo_, self:GetHeroTaskClass())
	self.accumulateRewardList_ = {}
	self.itemDataList_ = {}
	self.clickSwitchItemHandler_ = handler(self, self.OnClickSwitchItem)
	self.receivedHeroTaskHandler_ = handler(self, self.OnReceiveHeroTask)

	self:InitController()
end

function ActivityCultivateHeroMainView:InitController()
	self.accumulateRewardState_ = ControllerUtil.GetController(self.transform_, "accumulateRewardState")
	self.dailyRewardState_ = ControllerUtil.GetController(self.transform_, "dailyRewardState")
	self.allReceiveBtnState_ = ControllerUtil.GetController(self.transform_, "allReceive")
	self.heroLockState_ = ControllerUtil.GetController(self.transform_, "heroLock")
end

function ActivityCultivateHeroMainView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function ActivityCultivateHeroMainView:OnEnter()
	self.stopTime_ = ActivityData:GetActivityData(self.activityID_).stopTime

	self:AddTimer()
	self:BindRedPoint()
	self:MoveSwitchItemInView()
end

function ActivityCultivateHeroMainView:MoveSwitchItemInView()
	if not self.heroList_ or not self.selectHeroID_ then
		return
	end

	local var_7_0 = table.indexof(self.heroList_, self.selectHeroID_)
	local var_7_1, var_7_2 = self.switchItemList_:GetHeadAndTail()

	if var_7_0 <= var_7_1 or var_7_2 <= var_7_0 then
		self.switchItemList_:ScrollToIndex(var_7_0, false, true)
	end
end

function ActivityCultivateHeroMainView:AddListeners()
	self:AddBtnListener(self.unlockHeroBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		local var_9_0 = table.indexof(self.heroList_, self.selectHeroID_)

		var_9_0 = var_9_0 or 1

		JumpTools.JumpToPage2(ActivityCultivateHeroCfg[self.activityID_].source[var_9_0])
	end)
	self:AddBtnListener(self.rewardPreviewBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("cultivateAccumulateReward", {
			rewardActivityID = self.activityID_
		})
	end)
	self:AddBtnListener(self.receiveAccumulateBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		CultivateHeroAction.RequireReceiveAccumulateTask(self.activityID_, self.firstAccumulateTaskID_, function()
			self:RefreshAccumulateTask()
		end)
	end)
	self:AddBtnListener(self.receiveDailyBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		local var_13_0 = ActivityCultivateHeroCfg[self.activityID_].daily_reward

		if self.canReceiveDaily_ == true then
			CultivateHeroAction.RequireReceiveDailyTask(self.activityID_, function()
				self:RefreshDailyTask()
				self:RefreshAccumulateTask()
			end)
		else
			local var_13_1 = {}

			for iter_13_0, iter_13_1 in pairs(var_13_0) do
				var_13_1[iter_13_1[1]] = var_13_1[iter_13_1[1]] or {}
			end

			JumpTools.OpenPageByJump("rewardPreview", {
				rewardList = var_13_0,
				extraItemTemplateDataList = var_13_1
			}, ViewConst.SYSTEM_ID.REWARD_PREVIEW)
		end
	end)
	self:AddBtnListener(self.receiveAllHeroTaskBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		local var_15_0 = CultivateHeroData:GetHeroTaskInfoList(self.activityID_)
		local var_15_1 = {}

		for iter_15_0, iter_15_1 in ipairs(CultivateHeroTaskCfg.get_id_list_by_group_id[self.selectHeroID_]) do
			if var_15_0[iter_15_1].isCompleted == true and not var_15_0[iter_15_1].isReceived then
				var_15_1[#var_15_1 + 1] = iter_15_1
			end
		end

		CultivateHeroAction.RequireReceiveHeroTaskList(self.activityID_, var_15_1, function()
			self:OnReceiveHeroTask()
		end)
	end)
	self:AddBtnListener(self.descBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "CULTIVATE_HERO_DESC",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("CULTIVATE_HERO_DESC")
		})
	end)
end

function ActivityCultivateHeroMainView:RefreshUI(arg_18_1)
	self.heroList_ = ActivityCultivateHeroCfg[self.activityID_].group

	local var_18_0 = CultivateHeroData:GetSelectHeroID(self.activityID_) or self.heroList_[1]

	self.selectHeroID_ = var_18_0

	if var_18_0 == nil then
		return
	end

	CultivateHeroData:SetSelectHeroID(self.activityID_, var_18_0)
	self.heroLockState_:SetSelectedState(tostring(not HeroTools.GetHeroIsUnlock(CultivateHeroTaskCfg[CultivateHeroTaskCfg.get_id_list_by_group_id[var_18_0][1]].hero)))
	self:RefreshSwitchItem()
	self:RefreshRoleImage()
	self:RefreshDesc()
	self:RefreshHeroTask(arg_18_1)
	self:RefreshAccumulateTask()
	self:RefreshDailyTask()
end

function ActivityCultivateHeroMainView:RefreshSwitchItem()
	self.switchItemList_:StartScroll(#self.heroList_, table.indexof(self.heroList_, self.selectHeroID_) or 1)
end

function ActivityCultivateHeroMainView:GetSwitchItemClass()
	return CultivateHeroTools.GetSwitchItemClass(self.activityID_)
end

function ActivityCultivateHeroMainView:IndexItem(arg_21_1, arg_21_2)
	arg_21_2:SetData(self.activityID_, self.heroList_[arg_21_1])
	arg_21_2:SetClickCallBack(self.clickSwitchItemHandler_)
	arg_21_2:RefreshSelect(self.selectHeroID_)
end

function ActivityCultivateHeroMainView:OnClickSwitchItem(arg_22_1)
	if self.selectHeroID_ == arg_22_1 then
		return
	end

	self.rolenodeAni_:Play("UI_ActivityReceivedUI_role_cx", 0, 0)
	self.rolenodeAni_:Update(0)
	CultivateHeroData:SetSelectHeroID(self.activityID_, arg_22_1)

	self.selectHeroID_ = arg_22_1

	self:MoveSwitchItemInView()

	for iter_22_0, iter_22_1 in pairs((self.switchItemList_:GetItemList())) do
		iter_22_1:RefreshSelect(arg_22_1)
	end

	self:RefreshRoleImage()
	self:RefreshHeroTask(false)
	self.heroLockState_:SetSelectedState(tostring(HeroData:GetHeroData(CultivateHeroTaskCfg[CultivateHeroTaskCfg.get_id_list_by_group_id[arg_22_1][1]].hero).unlock == 0))
end

function ActivityCultivateHeroMainView:RefreshHeroTask(arg_23_1)
	local var_23_1

	self.sortedTaskIDList_, var_23_1 = CultivateHeroData:GetSortHeroTaskList(self.selectHeroID_, self.activityID_)

	self.allReceiveBtnState_:SetSelectedState(tostring(var_23_1))

	self.heroNameText_.text = HeroTools.GetHeroFullName(CultivateHeroTaskCfg[self.sortedTaskIDList_[1]].hero)
	self.isEnter = arg_23_1

	if arg_23_1 then
		self.heroTaskList_:SetAppearType(1)
	else
		self.heroTaskList_:SetAppearType(0)
	end

	self.heroTaskList_:StartScroll(#self.sortedTaskIDList_)
end

function ActivityCultivateHeroMainView:GetHeroTaskClass()
	return CultivateHeroTools.GetTaskItemClass(self.activityID_)
end

function ActivityCultivateHeroMainView:IndexHeroTask(arg_25_1, arg_25_2)
	arg_25_2:SetData(self.activityID_, self.sortedTaskIDList_[arg_25_1])
	arg_25_2:SetReveivedHandler(self.receivedHeroTaskHandler_)
	arg_25_2:SetAni(self.isEnter and "UI_Activity_item_cx" or "XH1stReceived_item")
end

function ActivityCultivateHeroMainView:OnReceiveHeroTask()
	self:RefreshHeroTask()
	self:RefreshAccumulateTask()
end

function ActivityCultivateHeroMainView:RefreshAccumulateTask()
	local var_27_0 = ItemTools.getItemNum(ActivityCultivateHeroCfg[self.activityID_].coin_id)
	local var_27_1 = CultivateHeroData:GetAccumulateTaskInfoList(self.activityID_)

	self.accumulateStatus_ = 0

	local var_27_2 = #ActivityPointRewardCfg.get_id_list_by_activity_id[self.activityID_]
	local var_27_3 = 0

	self.firstAccumulateTaskID_ = nil

	for iter_27_0, iter_27_1 in ipairs(ActivityPointRewardCfg.get_id_list_by_activity_id[self.activityID_]) do
		local var_27_4 = var_27_1[iter_27_1] and var_27_1[iter_27_1].isReceived == true

		if var_27_0 < ActivityPointRewardCfg[iter_27_1].need then
			self.accumulateStatus_ = 0

			if self.firstAccumulateTaskID_ == nil then
				self.firstAccumulateTaskID_ = iter_27_1
			end
		elseif not var_27_4 then
			self.accumulateStatus_ = 1
			self.firstAccumulateTaskID_ = iter_27_1

			break
		else
			var_27_3 = var_27_3 + 1
		end

		if iter_27_0 == var_27_2 and var_27_4 then
			self.firstAccumulateTaskID_ = iter_27_1
			self.accumulateStatus_ = 2
		end
	end

	local var_27_5 = ActivityPointRewardCfg[self.firstAccumulateTaskID_]

	self.curAccumulateProgressText_.text = string.format(GetTips("VERIFY_ASSETS_PROCESSING_RATE"), var_27_0, ActivityPointRewardCfg[self.firstAccumulateTaskID_].need)
	self.coinImage_.sprite = ItemTools.getItemSprite(ActivityCultivateHeroCfg[self.activityID_].coin_id)

	self:RefreshTotalAccumulateProgress(var_27_3, var_27_2)
	self:RefreshAccumulateRewardItem(var_27_5)
	self:RefreshAccumulateRewardState()
end

function ActivityCultivateHeroMainView:RefreshTotalAccumulateProgress(arg_28_1, arg_28_2)
	self.totalAccumulateProgressText_.text = string.format(GetTips("VERIFY_ASSETS_PROCESSING_RATE"), arg_28_1, arg_28_2)
end

function ActivityCultivateHeroMainView:RefreshAccumulateRewardItem(arg_29_1)
	for iter_29_0, iter_29_1 in ipairs(arg_29_1.reward_item_list) do
		if not self.accumulateRewardList_[iter_29_0] then
			self.accumulateRewardList_[iter_29_0] = CommonItemPool.New(self.goRewardPanel_, nil, true)
			self.itemDataList_[iter_29_0] = clone(ItemTemplateData)
			self.itemDataList_[iter_29_0].clickFun = function(self)
				ShowPopItem(POP_ITEM, {
					self.id,
					self.number
				})
			end
		end

		self.itemDataList_[iter_29_0].id = iter_29_1[1]
		self.itemDataList_[iter_29_0].number = iter_29_1[2]

		self.accumulateRewardList_[iter_29_0]:Show(true)
		self.accumulateRewardList_[iter_29_0]:SetData(self.itemDataList_[iter_29_0])
	end

	for iter_29_2 = #arg_29_1.reward_item_list + 1, #self.accumulateRewardList_ do
		self.accumulateRewardList_[iter_29_2]:Show(false)
	end
end

function ActivityCultivateHeroMainView:RefreshAccumulateRewardState()
	if self.accumulateStatus_ == 0 then
		self.accumulateRewardState_:SetSelectedState("uncompleted")
	elseif self.accumulateStatus_ == 2 then
		self.accumulateRewardState_:SetSelectedState("received")
	else
		self.accumulateRewardState_:SetSelectedState("unreceived")
	end
end

function ActivityCultivateHeroMainView:RefreshDailyTask()
	self:RefreshDailyProgress()
	self:RefreshDailyRewardState()
end

function ActivityCultivateHeroMainView:RefreshDailyProgress()
	self.dailyPrograssText_.text = string.format(GetTips("VERIFY_ASSETS_PROCESSING_RATE"), ActivityPtData:GetCurrentActivityPt(ActivityPtConst.TASK_DAILY_ACTIVITY_PT), 100)
end

function ActivityCultivateHeroMainView:RefreshDailyRewardState()
	if CultivateHeroData:GetDailyTaskStatus()[self.activityID_] then
		self.dailyRewardState_:SetSelectedState("received")
	elseif 100 <= ActivityPtData:GetCurrentActivityPt(ActivityPtConst.TASK_DAILY_ACTIVITY_PT) then
		self.canReceiveDaily_ = true

		self.dailyRewardState_:SetSelectedState("unreceive")
	else
		self.canReceiveDaily_ = false

		self.dailyRewardState_:SetSelectedState("uncomplete")
	end
end

function ActivityCultivateHeroMainView:OnActivityPtUpdate()
	self:RefreshDailyTask()
end

function ActivityCultivateHeroMainView:RefreshRoleImage()
	self.roleImage_.spriteSync = "TextureConfig/Character/Portrait/" .. CultivateHeroTaskCfg[CultivateHeroTaskCfg.get_id_list_by_group_id[self.selectHeroID_][1]].hero
end

function ActivityCultivateHeroMainView:RefreshDesc()
	self.descText_.text = GetTips("CULTIVATE_HERO_CONTENT")
end

function ActivityCultivateHeroMainView:AddTimer()
	if manager.time:GetServerTime() >= self.stopTime_ then
		self.textTime_.text = GetTips("TIME_OVER")

		return
	end

	self:StopTimer()

	self.textTime_.text = string.format(GetTips("LEFT_TIME"), manager.time:GetLostTimeStrWith2Unit(self.stopTime_))
	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= self.stopTime_ then
			self:StopTimer()

			self.textTime_.text = GetTips("TIME_OVER")

			return
		end

		self.textTime_.text = string.format(GetTips("LEFT_TIME"), manager.time:GetLostTimeStrWith2Unit(self.stopTime_))
	end, 1, -1)

	self.timer_:Start()
end

function ActivityCultivateHeroMainView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ActivityCultivateHeroMainView:OnExit()
	self:UnbindRedPoint()
	self:StopTimer()
end

function ActivityCultivateHeroMainView:Dispose()
	ActivityCultivateHeroMainView.super.Dispose(self)
	self:StopTimer()

	if self.switchItemList_ then
		self.switchItemList_:Dispose()

		self.switchItemList_ = nil
	end

	if self.heroTaskList_ then
		self.heroTaskList_:Dispose()

		self.heroTaskList_ = nil
	end

	if self.accumulateRewardList_ then
		for iter_42_0, iter_42_1 in ipairs(self.accumulateRewardList_) do
			iter_42_1:Dispose()
		end

		self.accumulateRewardList_ = nil
	end

	self.clickSwitchItemHandler_ = nil
	self.receivedHeroTaskHandler_ = nil

	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function ActivityCultivateHeroMainView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.receiveDailyBtn_.transform, (string.format("%s_%s_Daily_Reward", RedPointConst.CULTIVATE_HERO, self.activityID_)))
end

function ActivityCultivateHeroMainView:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.receiveDailyBtn_.transform, (string.format("%s_%s_Daily_Reward", RedPointConst.CULTIVATE_HERO, self.activityID_)))
end

function ActivityCultivateHeroMainView:Show(arg_45_1)
	SetActive(self.gameObject_, arg_45_1)

	if arg_45_1 == true then
		self:RefreshUI(true)
		self:RegistEventListener(NEW_DAY, handler(self, self.OnNewDay))
	else
		self:RemoveAllEventListener()
	end
end

function ActivityCultivateHeroMainView:OnNewDay()
	self:RefreshUI(false)
end

return ActivityCultivateHeroMainView
