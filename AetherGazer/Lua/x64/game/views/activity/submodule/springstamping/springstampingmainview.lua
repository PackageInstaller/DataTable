local var_0_0 = class("SpringStampingMainView", ReduxView)
local var_0_1 = {
	[1] = 1,
	[2] = 6
}

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_Com_Seal/SandPlay_Com_SealPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.btnController_ = arg_4_0.transCon_:GetController("btn")
	arg_4_0.tabController_ = arg_4_0.transCon_:GetController("tab")
	arg_4_0.lockController_ = {}

	for iter_4_0 = 1, 2 do
		arg_4_0.lockController_[iter_4_0] = arg_4_0.transCon_:GetController("lock" .. iter_4_0)
	end

	arg_4_0.rewardItems_ = {}

	for iter_4_1 = 1, 3 do
		arg_4_0.rewardItems_[iter_4_1] = CommonItemView.New(arg_4_0["rewardItem_" .. iter_4_1])
	end

	arg_4_0.storyItems_ = {}

	for iter_4_2 = 1, 8 do
		local var_4_0 = {}

		ComponentBinder.GetInstance():BindCfgUI(var_4_0, arg_4_0["pageGo_" .. iter_4_2])
		var_4_0.clickBtn_.onClick:AddListener(function()
			arg_4_0:OnSelectStory(iter_4_2)
		end)

		var_4_0.lockController = var_4_0.pageCon_:GetController("lock")
		var_4_0.selectController = var_4_0.pageCon_:GetController("select")
		var_4_0.sealController = var_4_0.pageCon_:GetController("seal")
		var_4_0.redController = var_4_0.pageCon_:GetController("isRed")
		var_4_0.titleController = var_4_0.pageCon_:GetController("title")
		arg_4_0.storyItems_[iter_4_2] = var_4_0
	end

	arg_4_0.onReceiveRewardHanle_ = handler(arg_4_0, arg_4_0.ShowStampAnim)
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.firstBtn_, nil, function()
		local var_7_0, var_7_1 = arg_6_0:GetDefaultSelect(1, var_0_1[2] - 1)

		arg_6_0:ChangeTab(var_7_0, var_7_1)
	end)
	arg_6_0:AddBtnListener(arg_6_0.secondBtn_, nil, function()
		local var_8_0, var_8_1 = arg_6_0:GetDefaultSelect(var_0_1[2], #arg_6_0.taskList_)

		arg_6_0:ChangeTab(var_8_0, var_8_1)
	end)
	arg_6_0:AddBtnListener(arg_6_0.sumbitBtn_, nil, function()
		TaskAction:SubmitTask(arg_6_0.taskList_[arg_6_0.selectStoryIndex_].id, arg_6_0.onReceiveRewardHanle_)
		SpringStampingAction.ConfirmStamp(arg_6_0.taskList_[arg_6_0.selectStoryIndex_].id)
	end)
	arg_6_0:AddBtnListener(arg_6_0.backBtn_, nil, function()
		arg_6_0:Back()
	end)
	arg_6_0:AddBtnListener(arg_6_0.goTaskBtn_1, nil, function()
		arg_6_0:Back()
		JumpTools.OpenPageByJump("/qworldQuestMain", {})
	end)
	arg_6_0:AddBtnListener(arg_6_0.goTaskBtn_2, nil, function()
		arg_6_0:Back()
		JumpTools.OpenPageByJump("/qworldQuestMain", {})
	end)
end

function var_0_0.OnEnter(arg_13_0)
	arg_13_0:UpdateView()

	local var_13_0, var_13_1 = arg_13_0:GetDefaultSelect(1, arg_13_0.tabLock_[2] and #arg_13_0.taskList_ or var_0_1[2])

	arg_13_0:ChangeTab(var_13_0, var_13_1)
end

function var_0_0.OnTop(arg_14_0)
	return
end

function var_0_0.UpdateView(arg_15_0)
	arg_15_0.taskList_, arg_15_0.canReceivedRewardList_ = SpringStampingData:CheckTaskList()

	arg_15_0:UpdateTab()
	arg_15_0:UpdateStoryItems()
end

function var_0_0.GetDefaultSelect(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0
	local var_16_1
	local var_16_2
	local var_16_3

	for iter_16_0 = arg_16_1, arg_16_2 do
		local var_16_4 = arg_16_0.taskList_[iter_16_0]

		if var_16_4.isOpen then
			if not var_16_4.isRewarded then
				if var_16_4.isComplete then
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

	local var_16_5 = var_16_0 or var_16_1 or var_16_2 or var_16_3 or arg_16_1
	local var_16_6 = var_16_5 >= var_0_1[2] and 2 or 1

	return var_16_5, var_16_6
end

function var_0_0.ChangeTab(arg_17_0, arg_17_1, arg_17_2)
	if not arg_17_0.tabLock_[arg_17_2] then
		ShowTips(GetTips("DORM_AREA_NOT_OPEN"))

		return
	end

	arg_17_0.selectTabIndex_ = arg_17_2

	arg_17_0.tabController_:SetSelectedState(arg_17_2)
	arg_17_0:OnSelectStory(arg_17_1)
	arg_17_0:CheckUnlockAnim()
end

function var_0_0.UpdateTab(arg_18_0)
	arg_18_0.tabLock_ = {}

	for iter_18_0 = 1, 2 do
		arg_18_0.tabLock_[iter_18_0] = SpringStampingData:GetChapterIsOpen(iter_18_0)

		arg_18_0.lockController_[iter_18_0]:SetSelectedState(tostring(arg_18_0.tabLock_[iter_18_0]))
	end
end

function var_0_0.UpdateStoryItems(arg_19_0)
	for iter_19_0, iter_19_1 in ipairs(arg_19_0.taskList_) do
		local var_19_0 = arg_19_0.storyItems_[iter_19_0]

		var_19_0.titleText_1.text = iter_19_1.name
		var_19_0.titleText_2.text = iter_19_1.name

		var_19_0.lockController:SetSelectedState(tostring(iter_19_1.isComplete))
		var_19_0.sealController:SetSelectedState(tostring(iter_19_1.isRewarded))
		var_19_0.redController:SetSelectedState(tostring(arg_19_0.canReceivedRewardList_[iter_19_1.id] or false))
		var_19_0.titleController:SetSelectedState(iter_19_1.isOpen and "normal" or "close")
	end
end

function var_0_0.OnSelectStory(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0.selectStoryIndex_ and arg_20_0.taskList_[arg_20_0.selectStoryIndex_].isOpen

	if arg_20_0.selectStoryIndex_ and arg_20_0.selectStoryIndex_ ~= arg_20_1 then
		arg_20_0.storyItems_[arg_20_0.selectStoryIndex_].selectController:SetSelectedState("false")
		arg_20_0.storyItems_[arg_20_0.selectStoryIndex_].titleController:SetSelectedState(var_20_0 and "normal" or "close")
	end

	arg_20_0.selectStoryIndex_ = arg_20_1

	local var_20_1 = arg_20_0.taskList_[arg_20_0.selectStoryIndex_].isOpen

	arg_20_0.storyItems_[arg_20_0.selectStoryIndex_].selectController:SetSelectedState("true")
	arg_20_0.storyItems_[arg_20_0.selectStoryIndex_].titleController:SetSelectedState(var_20_1 and "select" or "close")
	arg_20_0:UpdatePageInfo()
end

function var_0_0.UpdatePageInfo(arg_21_0)
	if arg_21_0.selectStoryIndex_ == nil then
		return
	end

	local var_21_0 = arg_21_0.taskList_[arg_21_0.selectStoryIndex_]

	for iter_21_0, iter_21_1 in ipairs(var_21_0.reward) do
		local var_21_1 = clone(ItemTemplateData)

		var_21_1.id = iter_21_1[1]
		var_21_1.number = iter_21_1[2]

		function var_21_1.clickFun(arg_22_0)
			ShowPopItem(POP_ITEM, {
				var_21_1.id,
				var_21_1.number
			})
		end

		arg_21_0.rewardItems_[iter_21_0]:SetData(var_21_1)
	end

	if var_21_0.isOpen then
		arg_21_0.titleText_.text = var_21_0.name
		arg_21_0.contentText_.text = var_21_0.isComplete and GetTips("ACTIVITY_SPRING_STAMP_" .. arg_21_0.selectStoryIndex_) or var_21_0.desc

		local var_21_2 = math.min(var_21_0.process, var_21_0.need)

		arg_21_0.processText_.text = string.format("(%s/%s)", var_21_2, var_21_0.need)

		if var_21_0.isRewarded then
			arg_21_0.btnController_:SetSelectedState("rewarded")
		elseif var_21_0.isComplete then
			arg_21_0.btnController_:SetSelectedState("complete")
		else
			arg_21_0.btnController_:SetSelectedState("not")
		end
	else
		arg_21_0.titleText_.text = GetTips("ACTIVITY_SPRING_STAMP_9")
		arg_21_0.contentText_.text = GetTips("ACTIVITY_SPRING_STAMP_10")
		arg_21_0.taskBtnDesc_.text = GetTips("ACTIVITY_SPRING_STAMP_11")

		arg_21_0.btnController_:SetSelectedState("close")
	end
end

function var_0_0.CheckUnlockAnim(arg_23_0)
	local var_23_0 = arg_23_0.selectTabIndex_ == 1 and var_0_1[1] or var_0_1[2]
	local var_23_1 = arg_23_0.selectTabIndex_ == 1 and var_0_1[2] - 1 or #arg_23_0.storyItems_

	for iter_23_0 = var_23_0, var_23_1 do
		local var_23_2 = arg_23_0.taskList_[iter_23_0]
		local var_23_3 = arg_23_0.storyItems_[iter_23_0]

		if var_23_2.isComplete and not getData("SprinStamping", iter_23_0) then
			var_23_3.illustrationAni_:Play("SealPopUI_Unlock")
			saveData("SprinStamping", iter_23_0, true)
		end
	end
end

function var_0_0.ShowStampAnim(arg_24_0)
	arg_24_0:UpdateView()
	arg_24_0:UpdatePageInfo()
	arg_24_0.storyItems_[arg_24_0.selectStoryIndex_].stampAni_:Play("Seal")
end

function var_0_0.OnExit(arg_25_0)
	arg_25_0.storyItems_[arg_25_0.selectStoryIndex_].selectController:SetSelectedState("false")
	manager.windowBar:HideBar()
end

function var_0_0.OnExitInput(arg_26_0)
	arg_26_0.storyItems_[arg_26_0.selectStoryIndex_].selectController:SetSelectedState("false")
	manager.windowBar:HideBar()
	JumpTools.Back()

	return true
end

function var_0_0.Dispose(arg_27_0)
	for iter_27_0, iter_27_1 in ipairs(arg_27_0.rewardItems_) do
		iter_27_1:Dispose()
	end

	arg_27_0.super.Dispose(arg_27_0)
end

return var_0_0
