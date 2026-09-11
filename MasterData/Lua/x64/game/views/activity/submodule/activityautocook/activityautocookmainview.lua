local ActivityAutoCookMainView = class("ActivityAutoCookMainView", ReduxView)

function ActivityAutoCookMainView:UIName()
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_Com_IdleCanteenUI/SandPlay_Com_IdleCanteenEnterUI"
end

function ActivityAutoCookMainView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityAutoCookMainView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityAutoCookMainView:InitUI()
	self:BindCfgUI()

	self.revenueController_ = self.controllerEx_:GetController("RevenueState")
	self.rewardController_ = self.controllerEx_:GetController("Claima")
	self.detailController_ = self.controllerEx_:GetController("Boost")
	self.stateController1_ = self.heroControllerEx1_:GetController("status")
	self.stateController2_ = self.heroControllerEx2_:GetController("status")
	self.stateController3_ = self.heroControllerEx3_:GetController("status")
	self.stateController4_ = self.heroControllerEx4_:GetController("status")
	self.heroController1_ = self.heroControllerEx1_:GetController("hero")
	self.heroController2_ = self.heroControllerEx2_:GetController("hero")
	self.heroController3_ = self.heroControllerEx3_:GetController("hero")
	self.heroController4_ = self.heroControllerEx4_:GetController("hero")
end

function ActivityAutoCookMainView:AddUIListeners()
	self:AddBtnListener(self.getRewardBtn_, nil, function()
		ActivityAutoCookAction:GetAutoCookReward(self.activityID_)
	end)

	for iter_5_0 = 1, 4 do
		self:AddBtnListener(self["heroBtn" .. iter_5_0 .. "_"], nil, function()
			local var_7_0

			for iter_7_0, iter_7_1 in pairs(ActivityAutoCookStageCfg.get_id_list_by_hero) do
				if 1 == iter_5_0 then
					var_7_0 = iter_7_0

					break
				end
			end

			local var_7_2 = false
			local var_7_3

			for iter_7_2, iter_7_3 in pairs(ActivityAutoCookStageCfg.get_id_list_by_hero[var_7_0]) do
				if ActivityAutoCookStageCfg[iter_7_3].condition > 0 then
					if IsConditionAchieved(ActivityAutoCookStageCfg[iter_7_3].condition) then
						var_7_2 = true

						break
					else
						var_7_2 = false
						var_7_3 = ActivityAutoCookStageCfg[iter_7_3].condition
					end
				else
					var_7_2 = true
				end
			end

			if var_7_2 then
				manager.ui:UIEventEnabled(false)
				self:PlayExitAnimator(function()
					manager.ui:UIEventEnabled(true)
					JumpTools.OpenPageByJump("/activityAutoCookLevelView", {
						battleHeroID = var_7_0
					})
				end)
			else
				ShowTips(string.format(GetTips("ACTIVITY_AUTO_COOK_TIP2"), (QWorldQuestTool.GetQuestProgressText(SandplayTaskCfg.get_id_list_by_main_task_id[ConditionCfg[var_7_3].params[1]][1]))))
			end
		end)
	end

	self:AddBtnListener(self.taskBtn_, nil, function()
		TaskTools:ShowActivityTaskPop(ActivityConst.AUTO_COOK, "Widget/Version/CORGUI_SandPlay_Com/SandPlay_Com/SandPlay_Com_rewardPopUI")
	end)
	self:AddBtnListener(self.showDetailBtn_, nil, function()
		self:HideEffect()
		self.detailController_:SetSelectedState("unfold")
	end)
	self:AddBtnListener(self.hideDetailBtn_, nil, function()
		self.detailController_:SetSelectedState("closed")
	end)
end

function ActivityAutoCookMainView:OnEnter()
	manager.redPoint:setTip(RedPointConst.ACTIVITY_AUTO_COOK_NEW_LEVLE .. ActivityConst.AUTO_COOK, 0)
	manager.redPoint:setTip(RedPointConst.ACTIVITY_AUTO_COOK_GOLDMAX .. ActivityConst.AUTO_COOK, 0)
	self.exitAnimator_:Play("New State", 0, 0)

	self.activityID_ = ActivityConst.AUTO_COOK
	self.titleText_.text = ActivityCfg[self.activityID_].remark

	local var_12_0 = ActivityData:GetActivityData(self.activityID_).stopTime

	if var_12_0 < manager.time:GetServerTime() then
		self.timeText_.text = string.format(GetTips("TIME_OVER"))

		return
	else
		self.timeText_.text = manager.time:GetLostTimeStrWith2Unit(var_12_0, true)
	end

	self.activityTimer_ = Timer.New(function()
		if manager.time:GetServerTime() > var_12_0 then
			self.timeText_.text = string.format(GetTips("TIME_OVER"))

			self:StopTimer()
		else
			self.timeText_.text = manager.time:GetLostTimeStrWith2Unit(var_12_0, true)
		end
	end, 1, -1)

	self.activityTimer_:Start()
	self:RefreshUI()

	self.timer_ = Timer.New(function()
		self:RefreshCurHaveGold()
	end, 61, -1)

	self.timer_:Start()
	manager.redPoint:bindUIandKey(self.taskBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, self.activityID_))
end

function ActivityAutoCookMainView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_AUTO_COOK_TIP1")
end

function ActivityAutoCookMainView:RefreshUI()
	self:RefreshCurHaveGold()
	self:RefreshDetailInfo()
	self:RefreshSpeedPanel()
	self:RefreshHeroStage()
end

function ActivityAutoCookMainView:RefreshCurHaveGold()
	local var_17_0 = ActivityAutoCookData:GetCurHaveGold()

	self.curHaveGoldText_.text = var_17_0
	self.curHaveGoldMaxText_.text = "/" .. ActivityAutoCookData:GetCurHaveGoldMax()
	self.curGetGoldText_.text = ActivityAutoCookData:GetCurGetGold()
	self.curGetGoldMaxText_.text = "/" .. GameSetting.auto_cook_item_week_max.value[1]

	if var_17_0 > 0 then
		self.rewardController_:SetSelectedState("claimable")
	else
		self.rewardController_:SetSelectedState("normal")
	end

	if ActivityAutoCookData:GetCurGetGold() >= GameSetting.auto_cook_item_week_max.value[1] then
		self.revenueController_:SetSelectedState("rest")
	else
		self.revenueController_:SetSelectedState("inOperation")
	end
end

function ActivityAutoCookMainView:RefreshSpeedPanel()
	if self.needShowSpeedPanel_ then
		self.detailController_:SetSelectedState("unfold")
	else
		self.detailController_:SetSelectedState("closed")
	end
end

function ActivityAutoCookMainView:RefreshDetailInfo()
	self.needShowSpeedPanel_ = false

	local var_19_0 = {}
	local var_19_1 = {}

	for iter_19_0, iter_19_1 in pairs((ActivityAutoCookData:GetCurElemontList())) do
		if ActivityAutoCookSpeedCfg[iter_19_1] then
			local var_19_2 = false

			for iter_19_2, iter_19_3 in pairs(var_19_0) do
				if iter_19_3.type == ActivityAutoCookSpeedCfg[iter_19_1].type then
					iter_19_3.speed = iter_19_3.speed + ActivityAutoCookSpeedCfg[iter_19_1].speed
					var_19_2 = true

					break
				end
			end

			if not var_19_2 then
				table.insert(var_19_0, {
					type = ActivityAutoCookSpeedCfg[iter_19_1].type,
					speed = ActivityAutoCookSpeedCfg[iter_19_1].speed
				})
				table.insert(var_19_1, ActivityAutoCookSpeedCfg[iter_19_1].des)
			end
		end
	end

	local var_19_3 = false

	for iter_19_4 = 1, 3 do
		if var_19_0[iter_19_4] == nil then
			SetActive(self["speedItemGo" .. iter_19_4 .. "_"], false)
		else
			SetActive(self["speedItemGo" .. iter_19_4 .. "_"], true)

			self["speedItemText" .. iter_19_4 .. "_"].text = var_19_1[iter_19_4]
			self["speedItemNumText" .. iter_19_4 .. "_"].text = var_19_0[iter_19_4].speed * 10 .. "/" .. GetTips("HOUR")

			if ActivityAutoCookData:GetLocalSpeedRate(iter_19_4) ~= var_19_0[iter_19_4].speed then
				SetActive(self[string.format("speedAnimatorGo%s_", iter_19_4)], false)
				self[string.format("speedAnimator%s_", iter_19_4)]:Play("Num_up", 0, 0)
				self[string.format("speedAnimator%s_", iter_19_4)]:Update(0)
				ActivityAutoCookData:SetLocalSpeedRate(iter_19_4, var_19_0[iter_19_4].speed)

				self.needShowSpeedPanel_ = true
			else
				SetActive(self[string.format("speedAnimatorGo%s_", iter_19_4)], false)
			end

			var_19_3 = true
		end
	end

	if var_19_3 then
		SetActive(self.speedGo_, true)
	else
		SetActive(self.speedGo_, false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.speedContentTrans_)
end

function ActivityAutoCookMainView:RefreshHeroStage()
	for iter_20_0, iter_20_1 in pairs(ActivityAutoCookStageCfg.get_id_list_by_hero) do
		local var_20_0 = false
		local var_20_1 = true

		for iter_20_2, iter_20_3 in pairs(iter_20_1) do
			var_20_0 = ActivityAutoCookStageCfg[iter_20_3].condition <= 0 or not not IsConditionAchieved(ActivityAutoCookStageCfg[iter_20_3].condition) and true

			if not ActivityAutoCookData:GetStageIsFinish(iter_20_3) then
				var_20_1 = false
			end
		end

		self["heroController" .. 1 .. "_"]:SetSelectedState(iter_20_0)

		if var_20_0 then
			if var_20_1 then
				self["stateController" .. 1 .. "_"]:SetSelectedState("finish")
			else
				self["stateController" .. 1 .. "_"]:SetSelectedState("unFinish")
			end
		else
			self["stateController" .. 1 .. "_"]:SetSelectedState("empty")
		end
	end
end

function ActivityAutoCookMainView:OnExit()
	manager.windowBar:HideBar()
	self:StopTimer()
	self:StopExitAnimator()
	self:HideEffect()
	manager.redPoint:unbindUIandKey(self.taskBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, self.activityID_))
end

function ActivityAutoCookMainView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	if self.activityTimer_ then
		self.activityTimer_:Stop()

		self.activityTimer_ = nil
	end
end

function ActivityAutoCookMainView:PlayExitAnimator(arg_23_1)
	self.exitAnimator_:Play("Exit", 0, 0)
	self.exitAnimator_:Update(0)
	self:StopExitAnimator()

	self.exitTimer_ = FrameTimer.New(function()
		if self.exitAnimator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
			self:StopExitAnimator()
			arg_23_1()
		end
	end, 1, -1)

	self.exitTimer_:Start()
end

function ActivityAutoCookMainView:StopExitAnimator()
	if self.exitTimer_ then
		self.exitTimer_:Stop()

		self.exitTimer_ = nil
	end
end

function ActivityAutoCookMainView:HideEffect()
	for iter_26_0 = 1, 3 do
		SetActive(self[string.format("speedAnimatorGo%s_", iter_26_0)], false)
	end
end

function ActivityAutoCookMainView:OnActivityAutoCookGetReward()
	self:RefreshUI()
end

function ActivityAutoCookMainView:Dispose()
	self.super.Dispose(self)
end

return ActivityAutoCookMainView
