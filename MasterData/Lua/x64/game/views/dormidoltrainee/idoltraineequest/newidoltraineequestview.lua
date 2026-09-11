local NewIdolTraineeQuestView = class("NewIdolTraineeQuestView", ReduxView)

function NewIdolTraineeQuestView:UIName()
	return "Widget/BackHouseUI/IdolTrainee/IdolTraineeQuestPopup_new"
end

function NewIdolTraineeQuestView:UIParent()
	return manager.ui.uiPop.transform
end

function NewIdolTraineeQuestView:Init()
	self:InitUI()
	self:AddUIListener()
end

function NewIdolTraineeQuestView:InitUI()
	self:BindCfgUI()

	self.questData_ = {}
	self.questUIList_ = LuaList.New(handler(self, self.RefreshItem), self.questList_, IdolTraineeQuestItem)
	self.rankItemList_ = {}
	self.clearController_ = self.mainControllerEx_:GetController("clear")
	self.infoController_ = self.mainControllerEx_:GetController("info")
	self.rankStateController_ = self.mainControllerEx_:GetController("rankState")
	self.rankSelectController_ = self.mainControllerEx_:GetController("rankSelect")
end

function NewIdolTraineeQuestView:RefreshItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.questData_[arg_5_1])
end

function NewIdolTraineeQuestView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.receiveBtn_, nil, function()
		local var_8_0 = {}

		for iter_8_0, iter_8_1 in pairs(self.questData_) do
			if TaskData2:GetTaskProgress(iter_8_1) >= AssignmentCfg[iter_8_1].need and not TaskData2:GetTaskComplete(iter_8_1) then
				table.insert(var_8_0, iter_8_1)
			end
		end

		local var_8_2 = getData("dorm_weekly_task", "tip_deadline")

		if (var_8_2 and tonumber(var_8_2) > manager.time:GetServerTime() or nil) and false and ((GameSetting.house_task_points or nil) and GameSetting.house_task_points.value[2]) < TaskTools.GetTargetTaskReward(var_8_0, 61) + IdolTraineeData:GetQuestWeeklyData() then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("DORM_TASK_WEEKLY_LIMIT_TIP"),
				toggleText = GetTips("WEEKLY_MUTE_TIP"),
				OkCallback = function()
					TaskAction:SubmitTaskList(var_8_0)
				end,
				ToggleCallback = function(arg_10_0)
					if arg_10_0 then
						saveData("dorm_weekly_task", "tip_deadline", tostring(_G.gameTimer:GetNextWeekFreshTime()))
					end
				end
			})
		else
			TaskAction:SubmitTaskList(var_8_0)
		end
	end)
	self:AddBtnListener(self.infoBtn_, nil, function()
		self.infoController_:SetSelectedState("on")
	end)
	self:AddBtnListener(self.infoBgBtn_, nil, function()
		self.infoController_:SetSelectedState("off")
	end)
end

function NewIdolTraineeQuestView:OnEnter()
	manager.windowBar:HideBar()
	self:UpdateView()
end

function NewIdolTraineeQuestView:OnExit()
	manager.windowBar:HideBar()
end

function NewIdolTraineeQuestView:OnTop()
	self:CheckRankState()
end

function NewIdolTraineeQuestView:UpdateView()
	self.infoText_.text = GetTips("DORM_WEEKLY_TASK_INFO")
	self.rank, self.curNum, self.curMax, self.weekly = IdolTraineeTools:GetCurQuestRankInfo()

	for iter_16_0 = 1, 4 do
		local var_16_0 = self.rankItemList_[iter_16_0]

		if not self.rankItemList_[iter_16_0] then
			var_16_0 = DormTaskRankItem.New(self["rankItemGo_" .. iter_16_0])
			self.rankItemList_[iter_16_0] = var_16_0
		end

		var_16_0:SetData(iter_16_0, self.rank, self.curNum, self.curMax, IdolTraineeRewardRankCfg[iter_16_0])
	end

	self.questData_ = TaskTools:GetIdolTraineeTaskSortList()

	self.questUIList_:StartScroll(#self.questData_)
	self.clearController_:SetSelectedState("false")

	for iter_16_1, iter_16_2 in pairs(self.questData_) do
		if TaskData2:GetTaskProgress(iter_16_2) >= AssignmentCfg[iter_16_2].need and not TaskData2:GetTaskComplete(iter_16_2) then
			self.clearController_:SetSelectedState("true")
		end
	end
end

function NewIdolTraineeQuestView:CheckRankState()
	self.rank, self.curNum, self.curMax, self.weekly = IdolTraineeTools:GetCurQuestRankInfo()
	self.curNumText_.text = self.curNum
	self.progressSlr_.fillAmount = self.weekly / 100
	self.progressText_.text = self.weekly .. "/" .. "100"

	if self.curNum >= self.curMax then
		if IdolTraineeRewardRankCfg[self.rank].type == 1 then
			IdolTraineeAction.GetQuestRankReward(self.rank, {})
		elseif IdolTraineeRewardRankCfg[self.rank].type == 2 then
			local var_17_0 = false

			for iter_17_0 = 1, #IdolTraineeRewardRankCfg[self.rank].reward do
				if HeroTools.GetIsHide(IdolTraineeRewardRankCfg[self.rank].reward[iter_17_0]) or HeroTools.GetIsSkinHide(IdolTraineeRewardRankCfg[self.rank].reward[iter_17_0]) then
					-- block empty
				elseif HeroCfg[IdolTraineeRewardRankCfg[self.rank].reward[iter_17_0] - 10000] and HeroTools.GetHeroIsUnlock(IdolTraineeRewardRankCfg[self.rank].reward[iter_17_0] - 10000) then
					var_17_0 = true

					break
				end
			end

			if var_17_0 then
				JumpTools.OpenPageByJump("/idolTaskItemSelectView", {
					rank = self.rank
				})
			else
				ShowTips("DORM_WEEKLY_TASK_POP_ERROR")
			end
		end
	end
end

function NewIdolTraineeQuestView:OnTaskListChange()
	self:UpdateView()
end

function NewIdolTraineeQuestView:OnExitInput()
	self:Back()

	return true
end

function NewIdolTraineeQuestView:Dispose()
	NewIdolTraineeQuestView.super.Dispose(self)

	if self.questUIList_ then
		self.questUIList_:Dispose()

		self.questUIList_ = nil
	end

	for iter_20_0, iter_20_1 in ipairs(self.rankItemList_) do
		if iter_20_1 then
			iter_20_1:Dispose()
		end
	end
end

return NewIdolTraineeQuestView
