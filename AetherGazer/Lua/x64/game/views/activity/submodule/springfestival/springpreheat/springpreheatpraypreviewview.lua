local var_0_0 = class("SpringPreheatPrayPreviewView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaWishingTree/IndiaWishingTreeWishSelUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.itemUiList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.listGo_, SpringPreheatPrayRewardItem)
	arg_3_0.stateController_ = ControllerUtil.GetController(arg_3_0.transform_, "state")

	arg_3_0.stateController_:SetSelectedState("preview")
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.maskBtn_, nil, function()
		arg_4_0:Back()
	end)
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.itemIdList_ = arg_6_0:GetSortedList()

	arg_6_0.itemUiList_:StartScroll(#arg_6_0.itemIdList_)
	arg_6_0:RefreshUI()
end

function var_0_0.OnExit(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0.itemUiList_:GetItemList()) do
		iter_7_1:OnExit()
	end
end

function var_0_0.OnTop(arg_8_0)
	SetActive(arg_8_0.gameObject_, true)
end

function var_0_0.OnBehind(arg_9_0)
	SetActive(arg_9_0.gameObject_, false)
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.itemUiList_:Dispose()
	var_0_0.super.Dispose(arg_10_0)
end

function var_0_0.IndexItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.itemIdList_[arg_11_1]

	arg_11_2:SetClickHandler(function(arg_12_0)
		arg_11_0:OnClickRewardItem(arg_11_1, arg_12_0)
	end)
	arg_11_2:SwitchToSelecting()
	arg_11_2:SetSelectable(not SpringPreheatData:IsSelected(var_11_0))
	arg_11_2:SetSelected(false)
	arg_11_2:SetData(var_11_0)
end

function var_0_0.RefreshUI(arg_13_0)
	return
end

function var_0_0.OnClickRewardItem(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_2:GetItemId()

	ShowPopItem(POP_ITEM, {
		var_14_0
	})
end

function var_0_0.GetSortedList(arg_15_0)
	local var_15_0 = SpringPreheatData:GetPoolItemList()
	local var_15_1 = SpringPreheatData:GetPraySelectionFullList()

	table.sort(var_15_0, function(arg_16_0, arg_16_1)
		local var_16_0 = SpringPreheatData:IsSelected(arg_16_0)
		local var_16_1 = SpringPreheatData:IsSelected(arg_16_1)

		if var_16_0 and var_16_1 then
			return table.indexof(var_15_1, arg_16_0) < table.indexof(var_15_1, arg_16_1)
		elseif var_16_0 or var_16_1 then
			return not var_16_0
		end

		return arg_16_0 < arg_16_1
	end)

	return var_15_0
end

return var_0_0
