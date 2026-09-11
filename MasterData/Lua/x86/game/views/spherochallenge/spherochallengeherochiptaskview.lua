local SPHeroChallengeHeroChipTaskView = class("SPHeroChallengeHeroChipTaskView", ReduxView)

function SPHeroChallengeHeroChipTaskView:UIName()
	return "Widget/System/SPHeroChallenge/SPHeroChallengeTaskPop"
end

function SPHeroChallengeHeroChipTaskView:UIParent()
	return manager.ui.uiPop.transform
end

function SPHeroChallengeHeroChipTaskView:OnCtor()
	return
end

function SPHeroChallengeHeroChipTaskView:Init()
	self:InitUI()
	self:AddUIListener()
end

function SPHeroChallengeHeroChipTaskView:InitUI()
	self:BindCfgUI()

	self.taskListModule = CommonTaskListModule.New(self.comTaskList_)
	self.gatherList = LuaList.New(handler(self, self.indexAwardItem), self.awardList_, SPHeroChallengeCommonItem)
	self.chipAwardController = self.chipController:GetController("awardState")
end

function SPHeroChallengeHeroChipTaskView:OnEnter()
	self.taskListModule:OnEnter()

	self.activityID = self.params_.activityID

	if self.activityID then
		self.taskListModule:RenderActivityTaskList(self.activityID)
	end

	self:RefreshView()
	self:RegisterEvents()
	self:StartTimer()
end

function SPHeroChallengeHeroChipTaskView:OnTop()
	return
end

function SPHeroChallengeHeroChipTaskView:OnExit()
	self.taskListModule:OnExit()
	self:RemoveAllEventListener()
	self:CloseTimer()
end

function SPHeroChallengeHeroChipTaskView:AddUIListener()
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.awardBtn, nil, function()
		if self.chipAwardController:GetSelectedState() == "canReceive" then
			TaskAction:SubmitTask(SPHeroChallengeData.activityCfg[SPHeroChallengeData:GetActivityID()].HeroChipTask)
		end
	end)
	self:AddBtnListener(self.drawBtn_, nil, function()
		JumpTools.GoToSystem("/draw", {
			isFirst = true,
			poolId = DrawTools:GetRoleUpPoolID(self.roleID)
		}, ViewConst.SYSTEM_ID.DRAW)
	end)
end

function SPHeroChallengeHeroChipTaskView:RegisterEvents()
	self:RegistEventListener(ON_TASK_SUBMIT_RESPONSE, function()
		self:RefreshGatherProgress()
		SPHeroChallengeRedPointTools:UpdataCanGetEntrustRewardRedPoint((SPHeroChallengeData:GetActivityID()))
	end)
end

function SPHeroChallengeHeroChipTaskView:Dispose()
	if self.taskListModule then
		self.taskListModule:Dispose()
	end

	if self.gatherList then
		self.gatherList:Dispose()
	end

	self:RemoveAllListeners()
	SPHeroChallengeHeroChipTaskView.super.Dispose(self)
	self:CloseTimer()
end

function SPHeroChallengeHeroChipTaskView:RefreshView()
	self:RefreshGatherProgress()
	self:RefreshHeroExtractState()
end

function SPHeroChallengeHeroChipTaskView:RefreshHeroExtractState()
	SetActive(self.drawBtn_.gameObject, false)
end

function SPHeroChallengeHeroChipTaskView:RefreshGatherProgress()
	local var_18_0 = SPHeroChallengeData.activityCfg[SPHeroChallengeData:GetActivityID()].HeroChipTask
	local var_18_1 = TaskData2:GetTask(var_18_0)

	if var_18_1 then
		local var_18_2 = AssignmentCfg[var_18_0].need

		if var_18_1.complete_flag > 0 then
			self.chipAwardController:SetSelectedState("received")
		elseif var_18_2 <= var_18_1.progress then
			self.chipAwardController:SetSelectedState("canReceive")
		else
			self.chipAwardController:SetSelectedState("notMeet")
		end

		local var_18_3 = CurrencyConst.CURRENCY_HERO_CHALLENGE_COIN_2

		self.awardList = {}

		for iter_18_0 = 1, var_18_2 do
			table.insert(self.awardList, iter_18_0 <= var_18_1.progress and {
				state = "full",
				id = var_18_3
			} or {
				id = -1,
				state = "empty"
			})
		end

		self.awardProText.text = string.format("%s/%s", tostring(var_18_1.progress), tostring(var_18_2))

		self.gatherList:StartScroll(#self.awardList)
	end
end

function SPHeroChallengeHeroChipTaskView:indexAwardItem(arg_19_1, arg_19_2)
	arg_19_2:RefreshUI(self.awardList[arg_19_1])
end

function SPHeroChallengeHeroChipTaskView:StartTimer()
	self:CloseTimer()

	self.timer = Timer.New(function()
		self:RefreshHeroExtractState()
	end, 1, -1)

	self.timer:Start()
end

function SPHeroChallengeHeroChipTaskView:CloseTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end
end

return SPHeroChallengeHeroChipTaskView
