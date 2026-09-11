local SpringStampingMainView = class("SpringStampingMainView", ReduxView)
local var_0_1 = {
	[1] = 1,
	[2] = 6
}

function SpringStampingMainView:UIName()
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_Com_Seal/SandPlay_Com_SealPopUI"
end

function SpringStampingMainView:UIParent()
	return manager.ui.uiPop.transform
end

function SpringStampingMainView:Init()
	self:InitUI()
	self:AddUIListener()
end

function SpringStampingMainView:InitUI()
	self:BindCfgUI()

	self.btnController_ = self.transCon_:GetController("btn")
	self.tabController_ = self.transCon_:GetController("tab")
	self.lockController_ = {}

	for iter_4_0 = 1, 2 do
		self.lockController_[iter_4_0] = self.transCon_:GetController("lock" .. iter_4_0)
	end

	self.rewardItems_ = {}

	for iter_4_1 = 1, 3 do
		self.rewardItems_[iter_4_1] = CommonItemView.New(self["rewardItem_" .. iter_4_1])
	end

	self.storyItems_ = {}

	for iter_4_2 = 1, 8 do
		local var_4_0 = {}

		ComponentBinder.GetInstance():BindCfgUI(var_4_0, self["pageGo_" .. iter_4_2])
		var_4_0.clickBtn_.onClick:AddListener(function()
			self:OnSelectStory(iter_4_2)
		end)

		var_4_0.lockController = var_4_0.pageCon_:GetController("lock")
		var_4_0.selectController = var_4_0.pageCon_:GetController("select")
		var_4_0.sealController = var_4_0.pageCon_:GetController("seal")
		var_4_0.redController = var_4_0.pageCon_:GetController("isRed")
		var_4_0.titleController = var_4_0.pageCon_:GetController("title")
		self.storyItems_[iter_4_2] = var_4_0
	end

	self.onReceiveRewardHanle_ = handler(self, self.ShowStampAnim)
end

function SpringStampingMainView:AddUIListener()
	self:AddBtnListener(self.firstBtn_, nil, function()
		local var_7_0, var_7_1 = self:GetDefaultSelect(1, var_0_1[2] - 1)

		self:ChangeTab(var_7_0, var_7_1)
	end)
	self:AddBtnListener(self.secondBtn_, nil, function()
		local var_8_0, var_8_1 = self:GetDefaultSelect(var_0_1[2], #self.taskList_)

		self:ChangeTab(var_8_0, var_8_1)
	end)
	self:AddBtnListener(self.sumbitBtn_, nil, function()
		TaskAction:SubmitTask(self.taskList_[self.selectStoryIndex_].id, self.onReceiveRewardHanle_)
		SpringStampingAction.ConfirmStamp(self.taskList_[self.selectStoryIndex_].id)
	end)
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.goTaskBtn_1, nil, function()
		self:Back()
		JumpTools.OpenPageByJump("/qworldQuestMain", {})
	end)
	self:AddBtnListener(self.goTaskBtn_2, nil, function()
		self:Back()
		JumpTools.OpenPageByJump("/qworldQuestMain", {})
	end)
end

function SpringStampingMainView:OnEnter()
	self:UpdateView()

	local var_13_0, var_13_1 = self:GetDefaultSelect(1, (self.tabLock_[2] or nil) and (#self.taskList_ or var_0_1[2]))

	self:ChangeTab(var_13_0, var_13_1)
end

function SpringStampingMainView:OnTop()
	return
end

function SpringStampingMainView:UpdateView()
	self.taskList_, self.canReceivedRewardList_ = SpringStampingData:CheckTaskList()

	self:UpdateTab()
	self:UpdateStoryItems()
end

function SpringStampingMainView:GetDefaultSelect(arg_16_1, arg_16_2)
	local var_16_0
	local var_16_1
	local var_16_2
	local var_16_3

	for iter_16_0 = arg_16_1, arg_16_2 do
		if self.taskList_[iter_16_0].isOpen then
			if not self.taskList_[iter_16_0].isRewarded then
				if self.taskList_[iter_16_0].isComplete then
					var_16_0 = var_16_0 and math.min(iter_16_0, var_16_0) or iter_16_0
				else
					var_16_1 = var_16_1 and math.min(iter_16_0, var_16_1) or iter_16_0
				end
			else
				var_16_2 = var_16_2 and math.min(iter_16_0, var_16_2) or iter_16_0
			end
		else
			var_16_3 = var_16_3 and math.min(iter_16_0, var_16_3) or iter_16_0
		end
	end

	return var_16_0 or var_16_1 or var_16_2 or var_16_3 or arg_16_1, (var_16_0 or var_16_1 or var_16_2 or var_16_3 or arg_16_1) >= var_0_1[2] and 2 or 1
end

function SpringStampingMainView:ChangeTab(arg_17_1, arg_17_2)
	if not self.tabLock_[arg_17_2] then
		ShowTips(GetTips("DORM_AREA_NOT_OPEN"))

		return
	end

	self.selectTabIndex_ = arg_17_2

	self.tabController_:SetSelectedState(arg_17_2)
	self:OnSelectStory(arg_17_1)
	self:CheckUnlockAnim()
end

function SpringStampingMainView:UpdateTab()
	self.tabLock_ = {}

	for iter_18_0 = 1, 2 do
		self.tabLock_[iter_18_0] = SpringStampingData:GetChapterIsOpen(iter_18_0)

		self.lockController_[iter_18_0]:SetSelectedState(tostring(self.tabLock_[iter_18_0]))
	end
end

function SpringStampingMainView:UpdateStoryItems()
	for iter_19_0, iter_19_1 in ipairs(self.taskList_) do
		local var_19_0 = self.storyItems_[iter_19_0]

		self.storyItems_[iter_19_0].titleText_1.text = iter_19_1.name
		var_19_0.titleText_2.text = iter_19_1.name

		var_19_0.lockController:SetSelectedState(tostring(iter_19_1.isComplete))
		var_19_0.sealController:SetSelectedState(tostring(iter_19_1.isRewarded))
		var_19_0.redController:SetSelectedState(tostring(self.canReceivedRewardList_[iter_19_1.id] or false))
		var_19_0.titleController:SetSelectedState(iter_19_1.isOpen and "normal" or "close")
	end
end

function SpringStampingMainView:OnSelectStory(arg_20_1)
	if self.selectStoryIndex_ and self.selectStoryIndex_ ~= arg_20_1 then
		self.storyItems_[self.selectStoryIndex_].selectController:SetSelectedState("false")
		self.storyItems_[self.selectStoryIndex_].titleController:SetSelectedState(self.selectStoryIndex_ and self.taskList_[self.selectStoryIndex_].isOpen and "normal" or "close")
	end

	self.selectStoryIndex_ = arg_20_1

	local var_20_1 = self.taskList_[self.selectStoryIndex_].isOpen

	self.storyItems_[self.selectStoryIndex_].selectController:SetSelectedState("true")
	self.storyItems_[self.selectStoryIndex_].titleController:SetSelectedState(var_20_1 and "select" or "close")
	self:UpdatePageInfo()
end

function SpringStampingMainView:UpdatePageInfo()
	if self.selectStoryIndex_ == nil then
		return
	end

	local var_21_0 = self.taskList_[self.selectStoryIndex_]

	for iter_21_0, iter_21_1 in ipairs(self.taskList_[self.selectStoryIndex_].reward) do
		local var_21_1 = clone(ItemTemplateData)

		var_21_1.id = iter_21_1[1]
		var_21_1.number = iter_21_1[2]

		function var_21_1.clickFun(arg_22_0)
			ShowPopItem(POP_ITEM, {
				var_21_1.id,
				var_21_1.number
			})
		end

		self.rewardItems_[iter_21_0]:SetData(var_21_1)
	end

	if var_21_0.isOpen then
		self.titleText_.text = var_21_0.name
		self.contentText_.text = var_21_0.isComplete and GetTips("ACTIVITY_SPRING_STAMP_" .. self.selectStoryIndex_) or var_21_0.desc
		self.processText_.text = string.format("(%s/%s)", math.min(var_21_0.process, var_21_0.need), var_21_0.need)

		if var_21_0.isRewarded then
			self.btnController_:SetSelectedState("rewarded")
		elseif var_21_0.isComplete then
			self.btnController_:SetSelectedState("complete")
		else
			self.btnController_:SetSelectedState("not")
		end
	else
		self.titleText_.text = GetTips("ACTIVITY_SPRING_STAMP_9")
		self.contentText_.text = GetTips("ACTIVITY_SPRING_STAMP_10")
		self.taskBtnDesc_.text = GetTips("ACTIVITY_SPRING_STAMP_11")

		self.btnController_:SetSelectedState("close")
	end
end

function SpringStampingMainView:CheckUnlockAnim()
	local var_23_0

	if self.selectTabIndex_ == 1 then
		var_23_0 = var_0_1[1] or var_0_1[2]

		local var_23_1

		if self.selectTabIndex_ == 1 then
			var_23_1 = var_0_1[2] - 1 or #self.storyItems_
		end
	end

	for iter_23_0 = var_23_0, var_23_1 do
		if self.taskList_[iter_23_0].isComplete and not getData("SprinStamping", iter_23_0) then
			self.storyItems_[iter_23_0].illustrationAni_:Play("SealPopUI_Unlock")
			saveData("SprinStamping", iter_23_0, true)
		end
	end
end

function SpringStampingMainView:ShowStampAnim()
	self:UpdateView()
	self:UpdatePageInfo()
	self.storyItems_[self.selectStoryIndex_].stampAni_:Play("Seal")
end

function SpringStampingMainView:OnExit()
	self.storyItems_[self.selectStoryIndex_].selectController:SetSelectedState("false")
	manager.windowBar:HideBar()
end

function SpringStampingMainView:OnExitInput()
	self.storyItems_[self.selectStoryIndex_].selectController:SetSelectedState("false")
	manager.windowBar:HideBar()
	JumpTools.Back()

	return true
end

function SpringStampingMainView:Dispose()
	for iter_27_0, iter_27_1 in ipairs(self.rewardItems_) do
		iter_27_1:Dispose()
	end

	self.super.Dispose(self)
end

return SpringStampingMainView
