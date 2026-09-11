local IdolTraineeQuestView = class("IdolTraineeQuestView", ReduxView)

function IdolTraineeQuestView:UIName()
	return "Widget/BackHouseUI/IdolTrainee/IdolTraineeQuestPopup"
end

function IdolTraineeQuestView:UIParent()
	return manager.ui.uiPop.transform
end

function IdolTraineeQuestView:Init()
	self:InitUI()
	self:AddUIListener()
end

function IdolTraineeQuestView:InitUI()
	self:BindCfgUI()

	self.rankItems = {}
	self.questData_ = {}
	self.questUIList_ = LuaList.New(handler(self, self.RefreshItem), self.questList_, IdolTraineeQuestItem)
	self.rankBtnList_ = {
		self.rank1Btn_,
		self.rank2Btn_,
		self.rank3Btn_,
		self.rank4Btn_
	}
	self.rankRewardItem_ = CommonItemView.New(self.rankItemGo_, true)
	self.clearController_ = self.mainControllerEx_:GetController("clear")
	self.rankStateController_ = self.mainControllerEx_:GetController("rankState")
	self.rankSelectController_ = self.mainControllerEx_:GetController("rankSelect")
end

function IdolTraineeQuestView:RefreshItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.questData_[arg_5_1])
end

function IdolTraineeQuestView:AddUIListener()
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

		TaskAction:SubmitTaskList(var_8_0)
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)

	for iter_6_0 = 1, 4 do
		self:AddBtnListener(self.rankBtnList_[iter_6_0], nil, function()
			self:SelectRank(iter_6_0)
		end)
	end
end

function IdolTraineeQuestView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	self:UpdateView()
end

function IdolTraineeQuestView:OnExit()
	manager.windowBar:HideBar()
end

function IdolTraineeQuestView:OnTop()
	self:RefreshRankState()
end

function IdolTraineeQuestView:UpdateView()
	self.questData_ = TaskTools:GetIdolTraineeTaskSortList()

	self.questUIList_:StartScroll(#self.questData_)
	self.clearController_:SetSelectedState("false")

	for iter_14_0, iter_14_1 in pairs(self.questData_) do
		if TaskData2:GetTaskProgress(iter_14_1) >= AssignmentCfg[iter_14_1].need and not TaskData2:GetTaskComplete(iter_14_1) then
			self.clearController_:SetSelectedState("true")
		end
	end
end

function IdolTraineeQuestView:RefreshRankState()
	local var_15_0, var_15_1, var_15_2 = IdolTraineeTools:GetCurQuestRankInfo()
	local var_15_3 = IdolTraineeRewardRankCfg[var_15_0]

	self.rankStateController_:SetSelectedState(var_15_0)

	self.progressSlr_.value = var_15_2 <= var_15_1 and 1 or var_15_1 / var_15_2
	self.progressText_.text = var_15_1 .. "/" .. var_15_2

	self:SelectRank(var_15_0)

	if var_15_2 <= var_15_1 then
		if var_15_3.type == 1 then
			IdolTraineeAction.GetQuestRankReward(var_15_0, {})
		elseif var_15_3.type == 2 then
			JumpTools.OpenPageByJump("/idolTraineeQuestRankSelect", {
				rank = var_15_0
			})
		end
	end
end

function IdolTraineeQuestView:SelectRank(arg_16_1)
	local var_16_0 = IdolTraineeTools:GetCurQuestRankInfo()

	self.rankSelectController_:SetSelectedState(arg_16_1)

	local var_16_1 = clone(ItemTemplateData)

	var_16_1.id = IdolTraineeRewardRankCfg[arg_16_1].icon
	var_16_1.number = IdolTraineeRewardRankCfg[arg_16_1].num
	var_16_1.clickFun = handler(self, self.OnClickCommonItem)

	self.rankRewardItem_:SetData(var_16_1)
	self.rankRewardItem_:RefreshCompleted(arg_16_1 < var_16_0)
end

function IdolTraineeQuestView:OnClickCommonItem(arg_17_1)
	ShowPopItem(POP_ITEM, {
		arg_17_1.id,
		arg_17_1.number
	})
	OperationRecorder.Record("task", "task_item")
end

function IdolTraineeQuestView:OnTaskListChange()
	self:UpdateView()
end

function IdolTraineeQuestView:Dispose()
	IdolTraineeQuestView.super.Dispose(self)

	if self.questUIList_ then
		self.questUIList_:Dispose()

		self.questUIList_ = nil
	end

	if self.rankRewardItem_ then
		self.rankRewardItem_:Dispose()

		self.rankRewardItem_ = nil
	end
end

return IdolTraineeQuestView
