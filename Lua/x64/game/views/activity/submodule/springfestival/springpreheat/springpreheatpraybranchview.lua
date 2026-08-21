local var_0_0 = class("SpringPreheatPrayBranchView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaWishingTree/IndiaWishingTreeWishUIRewardsUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.branch_ = SpringPreheatPrayBubbleView.New(arg_3_0.branchGo_)
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.maskBtn_, nil, function()
		arg_4_0:Back()
	end)
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.day_ = arg_6_0.params_.day or SpringPreheatData:GetNextSelectionIndex()

	arg_6_0.branch_:SetData(arg_6_0.day_)
	arg_6_0.branch_:SetClickHandler(function(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
		arg_6_0:OnClickBubble(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	end)
	arg_6_0.branch_:OnEnter()
	arg_6_0:RefreshUI()
end

function var_0_0.OnExit(arg_8_0)
	arg_8_0.branch_:OnExit()
end

function var_0_0.OnTop(arg_9_0)
	SetActive(arg_9_0.gameObject_, true)
end

function var_0_0.OnBehind(arg_10_0)
	SetActive(arg_10_0.gameObject_, false)
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.branch_:Dispose()
	var_0_0.super.Dispose(arg_11_0)
end

function var_0_0.RefreshUI(arg_12_0)
	return
end

function var_0_0.OnClickBubble(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	if arg_13_4 then
		local var_13_0 = arg_13_3:GetItemId()

		ShowPopItem(POP_ITEM, {
			var_13_0
		})
	end
end

return var_0_0
