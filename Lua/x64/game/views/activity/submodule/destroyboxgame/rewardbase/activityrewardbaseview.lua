local var_0_0 = class("ActivityRewardBaseView", ReduxView)

var_0_0.OBJECT_TYPE = {
	ITEM = 2,
	TITLE = 1
}

function var_0_0.UIName(arg_1_0)
	return ""
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.refreshHandler_ = handler(arg_3_0, arg_3_0.OnUpdateUI)

	local var_3_0 = arg_3_0.contentTf_.rect.height
	local var_3_1 = arg_3_0.gridTrs_:GetComponent("VerticalLayoutGroup").spacing

	arg_3_0.loopScrollView_ = LoopScrollView.New(arg_3_0, arg_3_0.scrollRectEx_, arg_3_0.gridTrs_, arg_3_0.contentTf_, var_3_0, var_3_1, true)
	arg_3_0.titleItemPool_ = {}
	arg_3_0.taskItemPool_ = {}
	arg_3_0.receiveAllController_ = arg_3_0.controllerEx_:GetController("receiveAll")
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0:InitData()
	arg_4_0:RefreshUI()
	manager.notify:RegistListener(ACTIVITY_REWARD_REFRESH, arg_4_0.refreshHandler_)
end

function var_0_0.OnExit(arg_5_0)
	manager.notify:RemoveListener(ACTIVITY_REWARD_REFRESH, arg_5_0.refreshHandler_)
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.refreshHandler_ = nil

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.titleItemPool_) do
		iter_6_1.itemView:Dispose()
	end

	arg_6_0.titleItemPool_ = nil

	for iter_6_2, iter_6_3 in ipairs(arg_6_0.taskItemPool_) do
		iter_6_3.itemView:Dispose()
	end

	arg_6_0.taskItemPool_ = nil

	arg_6_0.loopScrollView_:Dispose()

	arg_6_0.loopScrollView_ = nil

	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.bgBtn_, nil, function()
		arg_7_0:Back()
	end)
	arg_7_0:AddBtnListener(arg_7_0.receiveBtn_, nil, function()
		arg_7_0:OnClickReceiveBtn()
	end)
end

function var_0_0.RefreshUI(arg_10_0)
	arg_10_0:RefreshText()
	arg_10_0:RefreshScroll()
end

function var_0_0.RefreshScroll(arg_11_0)
	arg_11_0.loopScrollView_:NavigateIndex(1)
end

function var_0_0.RefreshText(arg_12_0)
	arg_12_0.getLabel1_.text = arg_12_0:GetFinishRewardCnt()

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_0.getLabel1_.transform)

	arg_12_0.getLabel2_.text = string.format("/%s", arg_12_0:GetMaxTaskCnt())

	if #arg_12_0.canReceiveRewardList_ > 0 then
		arg_12_0.receiveAllController_:SetSelectedState("true")
	else
		arg_12_0.receiveAllController_:SetSelectedState("false")
	end
end

function var_0_0.GetUnReceiveData(arg_13_0)
	return
end

function var_0_0.OnUpdateUI(arg_14_0)
	arg_14_0:GetUnReceiveData()
	arg_14_0:RefreshText()

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.loopScrollView_:GetItemList()) do
		iter_14_1.itemView:Update()
	end
end

function var_0_0.InitData(arg_15_0)
	arg_15_0.uiDataList_ = {}
end

function var_0_0.GetMaxTaskCnt(arg_16_0)
	return 0
end

function var_0_0.GetFinishRewardCnt(arg_17_0)
	return 0
end

function var_0_0.GetTaskItemClass(arg_18_0)
	return ActivityRewardItemBase
end

function var_0_0.OnClickReceiveBtn(arg_19_0)
	return
end

function var_0_0.LsAddItem(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_1.objectType
	local var_20_1

	if var_20_0 == var_0_0.OBJECT_TYPE.TITLE then
		var_20_1 = arg_20_0:GetFreeItem(arg_20_0.titleItemPool_, function()
			return ActivityRewardTitleItem.New(arg_20_0.titleItem_, arg_20_0.parent_)
		end)
	else
		var_20_1 = arg_20_0:GetFreeItem(arg_20_0.taskItemPool_, function()
			return arg_20_0:GetTaskItemClass().New(arg_20_0.taskItem_, arg_20_0.parent_)
		end)
	end

	var_20_1.itemView:SetData(arg_20_1.data, arg_20_2)

	return var_20_1
end

function var_0_0.LsRemoveItem(arg_23_0, arg_23_1, arg_23_2)
	arg_23_1.itemView:Show(false)

	arg_23_1.isFree = true
end

function var_0_0.LsGetItemData(arg_24_0)
	return arg_24_0.uiDataList_
end

function var_0_0.GetFreeItem(arg_25_0, arg_25_1, arg_25_2)
	for iter_25_0, iter_25_1 in pairs(arg_25_1) do
		if iter_25_1.isFree == true then
			iter_25_1.isFree = false

			return iter_25_1
		end
	end

	local var_25_0 = {
		isFree = false,
		itemView = arg_25_2()
	}

	table.insert(arg_25_1, var_25_0)

	return var_25_0
end

return var_0_0
