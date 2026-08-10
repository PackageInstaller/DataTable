local var_0_0 = class("IdolTraineeQuestView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/IdolTrainee/IdolTraineeQuestPopup"
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

	arg_4_0.rankItems = {}
	arg_4_0.questData_ = {}
	arg_4_0.questUIList_ = LuaList.New(handler(arg_4_0, arg_4_0.RefreshItem), arg_4_0.questList_, IdolTraineeQuestItem)
	arg_4_0.rankBtnList_ = {
		arg_4_0.rank1Btn_,
		arg_4_0.rank2Btn_,
		arg_4_0.rank3Btn_,
		arg_4_0.rank4Btn_
	}
	arg_4_0.rankRewardItem_ = CommonItemView.New(arg_4_0.rankItemGo_, true)
	arg_4_0.clearController_ = arg_4_0.mainControllerEx_:GetController("clear")
	arg_4_0.rankStateController_ = arg_4_0.mainControllerEx_:GetController("rankState")
	arg_4_0.rankSelectController_ = arg_4_0.mainControllerEx_:GetController("rankSelect")
end

function var_0_0.RefreshItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.questData_[arg_5_1]

	arg_5_2:SetData(var_5_0)
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.maskBtn_, nil, function()
		arg_6_0:Back()
	end)
	arg_6_0:AddBtnListener(arg_6_0.receiveBtn_, nil, function()
		local var_8_0 = {}

		for iter_8_0, iter_8_1 in pairs(arg_6_0.questData_) do
			local var_8_1 = TaskData2:GetTaskComplete(iter_8_1)

			if TaskData2:GetTaskProgress(iter_8_1) >= AssignmentCfg[iter_8_1].need and not var_8_1 then
				table.insert(var_8_0, iter_8_1)
			end
		end

		TaskAction:SubmitTaskList(var_8_0)
	end)
	arg_6_0:AddBtnListener(arg_6_0.maskBtn_, nil, function()
		arg_6_0:Back()
	end)

	for iter_6_0 = 1, 4 do
		arg_6_0:AddBtnListener(arg_6_0.rankBtnList_[iter_6_0], nil, function()
			arg_6_0:SelectRank(iter_6_0)
		end)
	end
end

function var_0_0.OnEnter(arg_11_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	arg_11_0:UpdateView()
end

function var_0_0.OnExit(arg_12_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnTop(arg_13_0)
	arg_13_0:RefreshRankState()
end

function var_0_0.UpdateView(arg_14_0)
	arg_14_0.questData_ = TaskTools:GetIdolTraineeTaskSortList()

	arg_14_0.questUIList_:StartScroll(#arg_14_0.questData_)
	arg_14_0.clearController_:SetSelectedState("false")

	for iter_14_0, iter_14_1 in pairs(arg_14_0.questData_) do
		local var_14_0 = TaskData2:GetTaskComplete(iter_14_1)

		if TaskData2:GetTaskProgress(iter_14_1) >= AssignmentCfg[iter_14_1].need and not var_14_0 then
			arg_14_0.clearController_:SetSelectedState("true")
		end
	end
end

function var_0_0.RefreshRankState(arg_15_0)
	local var_15_0, var_15_1, var_15_2 = IdolTraineeTools:GetCurQuestRankInfo()
	local var_15_3 = IdolTraineeRewardRankCfg[var_15_0]

	arg_15_0.rankStateController_:SetSelectedState(var_15_0)

	arg_15_0.progressSlr_.value = var_15_2 <= var_15_1 and 1 or var_15_1 / var_15_2
	arg_15_0.progressText_.text = var_15_1 .. "/" .. var_15_2

	arg_15_0:SelectRank(var_15_0)

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

function var_0_0.SelectRank(arg_16_0, arg_16_1)
	local var_16_0 = IdolTraineeTools:GetCurQuestRankInfo()
	local var_16_1 = IdolTraineeRewardRankCfg[arg_16_1]

	arg_16_0.rankSelectController_:SetSelectedState(arg_16_1)

	local var_16_2 = clone(ItemTemplateData)

	var_16_2.id = var_16_1.icon
	var_16_2.number = var_16_1.num
	var_16_2.clickFun = handler(arg_16_0, arg_16_0.OnClickCommonItem)

	arg_16_0.rankRewardItem_:SetData(var_16_2)
	arg_16_0.rankRewardItem_:RefreshCompleted(arg_16_1 < var_16_0)
end

function var_0_0.OnClickCommonItem(arg_17_0, arg_17_1)
	ShowPopItem(POP_ITEM, {
		arg_17_1.id,
		arg_17_1.number
	})
	OperationRecorder.Record("task", "task_item")
end

function var_0_0.OnTaskListChange(arg_18_0)
	arg_18_0:UpdateView()
end

function var_0_0.Dispose(arg_19_0)
	var_0_0.super.Dispose(arg_19_0)

	if arg_19_0.questUIList_ then
		arg_19_0.questUIList_:Dispose()

		arg_19_0.questUIList_ = nil
	end

	if arg_19_0.rankRewardItem_ then
		arg_19_0.rankRewardItem_:Dispose()

		arg_19_0.rankRewardItem_ = nil
	end
end

return var_0_0
