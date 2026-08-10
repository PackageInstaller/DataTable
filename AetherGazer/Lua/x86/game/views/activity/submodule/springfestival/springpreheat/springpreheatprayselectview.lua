local var_0_0 = class("SpringPreheatPraySelectView", ReduxView)

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
	arg_3_0.selectController_ = ControllerUtil.GetController(arg_3_0.transform_, "Notoptional")
	arg_3_0.stateController_ = ControllerUtil.GetController(arg_3_0.transform_, "state")

	arg_3_0.stateController_:SetSelectedState("select")

	arg_3_0.branch_ = SpringPreheatPrayBubbleView.New(arg_3_0.branchGo_)
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.maskBtn_, nil, function()
		arg_4_0:OnClickCancelBtn()
	end)
	arg_4_0:AddBtnListener(arg_4_0.cancelBtn_, nil, function()
		arg_4_0:OnClickCancelBtn()
	end)
	arg_4_0:AddBtnListener(arg_4_0.confirmBtn_, nil, function()
		arg_4_0:OnClickConfirmBtn()
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.day_ = SpringPreheatData:GetNextSelectionIndex()

	arg_8_0.branch_:SetData(arg_8_0.day_)
	arg_8_0.branch_:SetClickHandler(function(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
		arg_8_0:OnClickBubble(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	end)
	arg_8_0.branch_:OnEnter()

	arg_8_0.itemIdList_ = arg_8_0:GetSortedList()

	arg_8_0.itemUiList_:StartScroll(#arg_8_0.itemIdList_)
	arg_8_0:ResetSelectItems()
	arg_8_0.selectController_:SetSelectedState("no")
	arg_8_0:RefreshUI()
end

function var_0_0.OnExit(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.itemUiList_:GetItemList()) do
		iter_10_1:OnExit()
	end

	arg_10_0.branch_:OnExit()
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.itemUiList_:Dispose()
	arg_11_0.branch_:Dispose()
	var_0_0.super.Dispose(arg_11_0)
end

function var_0_0.IndexItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.itemIdList_[arg_12_1]

	arg_12_2:SetClickHandler(function(arg_13_0)
		arg_12_0:OnClickRewardItem(arg_12_1, arg_13_0)
	end)
	arg_12_2:SwitchToSelecting()
	arg_12_2:SetSelectable(not SpringPreheatData:IsSelected(var_12_0))
	arg_12_2:SetSelected(false)
	arg_12_2:SetData(var_12_0)
end

function var_0_0.RefreshUI(arg_14_0)
	local var_14_0 = arg_14_0:GetSelectRewardList()

	arg_14_0.branch_:UpdateItemIdList(var_14_0)
	arg_14_0.branch_:RefreshItemUiList()

	arg_14_0.tipsText_.text = GetTips(string.format("SPRING_PREHEAT_EDIT_REWARD_DAY_%d", arg_14_0.day_))
	arg_14_0.selectNumText_.text = string.format("%d/%d", arg_14_0.selectedCount, arg_14_0.params_.maxSelectCount)
end

function var_0_0.OnClickRewardItem(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_0.itemSelected[arg_15_1] then
		arg_15_2:SetSelected(false)
		arg_15_0:RemoveSelectItem(arg_15_1)
	elseif arg_15_0.selectedCount >= arg_15_0.params_.maxSelectCount then
		ShowTips("SPRING_PREHEAT_SELECT_CONDITION")
	elseif not SpringPreheatData:IsSelected(arg_15_0.itemIdList_[arg_15_1]) then
		arg_15_2:SetSelected(true)
		arg_15_0:AddSelectItem(arg_15_1)
	end

	arg_15_0.selectController_:SetSelectedState(arg_15_0.selectedCount >= arg_15_0.params_.maxSelectCount and "yes" or "no")
	arg_15_2:RefreshUI()
	arg_15_0:RefreshUI()
end

function var_0_0.OnClickCancelBtn(arg_16_0)
	if arg_16_0.isAniPlaying_ then
		return
	end

	arg_16_0:Back()
end

function var_0_0.OnClickConfirmBtn(arg_17_0)
	if arg_17_0.selectedCount ~= 2 then
		ShowTips("SPRING_PREHEAT_SELECT_CONDITION")

		return
	end

	arg_17_0:TryUploadSelection()
end

function var_0_0.TryUploadSelection(arg_18_0)
	local var_18_0 = arg_18_0:GetSelectRewardList()

	if #var_18_0 ~= 2 then
		ShowTips("SPRING_PREHEAT_SELECT_CONDITION")

		return
	end

	if arg_18_0.isAniPlaying_ then
		return
	end

	local var_18_1 = SpringPreheatData:GetNextSelectionIndex()

	SpringPreheatAction:UploadPraySelection(var_18_1, var_18_0, function()
		arg_18_0:PlayEffect(function()
			if arg_18_0.params_.onSelectionConfirmed then
				arg_18_0.params_.onSelectionConfirmed(var_18_0)
			end

			arg_18_0:Back()
		end)
	end)
end

function var_0_0.GetSortedList(arg_21_0)
	local var_21_0 = SpringPreheatData:GetPoolItemList()
	local var_21_1 = SpringPreheatData:GetPraySelectionFullList()

	table.sort(var_21_0, function(arg_22_0, arg_22_1)
		local var_22_0 = SpringPreheatData:IsSelected(arg_22_0)
		local var_22_1 = SpringPreheatData:IsSelected(arg_22_1)

		if var_22_0 and var_22_1 then
			return table.indexof(var_21_1, arg_22_0) < table.indexof(var_21_1, arg_22_1)
		elseif var_22_0 or var_22_1 then
			return not var_22_0
		end

		return arg_22_0 < arg_22_1
	end)

	return var_21_0
end

function var_0_0.AddSelectItem(arg_23_0, arg_23_1)
	arg_23_0.itemSelected[arg_23_1] = true
	arg_23_0.selectedCount = arg_23_0.selectedCount + 1

	table.insert(arg_23_0.selectIndexList_, arg_23_1)
end

function var_0_0.RemoveSelectItem(arg_24_0, arg_24_1)
	arg_24_0.itemSelected[arg_24_1] = false
	arg_24_0.selectedCount = arg_24_0.selectedCount - 1

	table.removebyvalue(arg_24_0.selectIndexList_, arg_24_1)
end

function var_0_0.ResetSelectItems(arg_25_0)
	arg_25_0.itemSelected = {}
	arg_25_0.selectedCount = 0

	for iter_25_0, iter_25_1 in ipairs(arg_25_0.itemIdList_) do
		arg_25_0.itemSelected[iter_25_0] = false
	end

	arg_25_0.selectIndexList_ = {}
end

function var_0_0.GetSelectRewardList(arg_26_0)
	local var_26_0 = SpringPreheatData:GetPoolItemList()
	local var_26_1 = {}

	for iter_26_0, iter_26_1 in ipairs(arg_26_0.selectIndexList_) do
		table.insert(var_26_1, var_26_0[iter_26_1])
	end

	for iter_26_2 = #var_26_1 + 1, arg_26_0.params_.maxSelectCount do
		table.insert(var_26_1, 0)
	end

	return var_26_1
end

function var_0_0.OnClickBubble(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	if arg_27_4 then
		local var_27_0 = arg_27_3:GetItemId()

		ShowPopItem(POP_ITEM, {
			var_27_0
		})
	end
end

function var_0_0.PlayEffect(arg_28_0, arg_28_1)
	if arg_28_0.selectAni_ then
		arg_28_0.isAniPlaying_ = true

		arg_28_0.selectAni_:Play("IndiaWishingTreeWishSelUI02", -1, 0)
		arg_28_0.selectAni_:Update(0)
		AnimatorTools.PlayAnimationWithCallback(arg_28_0.selectAni_, "IndiaWishingTreeWishSelUI02", function()
			arg_28_0.isAniPlaying_ = false

			arg_28_1()
		end)
	else
		arg_28_1()
	end
end

return var_0_0
