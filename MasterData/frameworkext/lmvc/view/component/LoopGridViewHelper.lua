module("frameworkext.lmvc.view.component.LoopGridViewHelper", package.seeall)

local var_0_0 = class("LoopGridViewHelper")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._loopGridView = goutil.addComponentOnce(arg_1_1, UIComponentType.LoopGridView)
end

function var_0_0.InitGridView(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0._handler = arg_2_3
	arg_2_0._callbackFunc = arg_2_2
	arg_2_0._itemTotalCount = arg_2_1

	if arg_2_0._loopGridView ~= nil then
		arg_2_1 = tonumber(arg_2_1)

		arg_2_0._loopGridView:InitGridView(arg_2_0, arg_2_1, arg_2_0.OnGetItemByRowColumn)
	elseif enableErrorLog then
		printError("LoopGridViewHelper: could not found LoopGridView Component!")
	end
end

function var_0_0.NewListViewItem(arg_3_0, arg_3_1)
	if arg_3_0._loopGridView ~= nil then
		return arg_3_0._loopGridView:NewListViewItem(arg_3_1)
	end
end

function var_0_0.SetListItemCount(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0._loopGridView ~= nil then
		arg_4_0._itemTotalCount = arg_4_1

		arg_4_0._loopGridView:SetListItemCount(arg_4_1, arg_4_2)
	end
end

function var_0_0.MoveToItemIndex(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_0._loopGridView ~= nil then
		arg_5_0._loopGridView:MovePanelToItemByIndex(arg_5_1, arg_5_2 and arg_5_2 or 0, arg_5_3 and arg_5_3 or 0)
	end
end

function var_0_0.RefreshItemByItemIndex(arg_6_0, arg_6_1)
	if arg_6_0._loopGridView ~= nil then
		arg_6_0._loopGridView:RefreshItemByItemIndex(arg_6_1)
	end
end

function var_0_0.GetLoopGridView(arg_7_0)
	return arg_7_0._loopGridView
end

function var_0_0.OnGetItemByRowColumn(arg_8_0, arg_8_1)
	if arg_8_1 < 0 or arg_8_1 >= arg_8_0._itemTotalCount then
		return nil
	end

	if arg_8_0._handler and arg_8_0._callbackFunc ~= nil then
		return arg_8_0._callbackFunc(arg_8_0._handler, arg_8_1)
	end

	return nil
end

function var_0_0.RefreshAllShownItem(arg_9_0)
	if arg_9_0._loopGridView then
		arg_9_0._loopGridView:RefreshAllShownItem()
	end
end

function var_0_0.ClearCells(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1 and true or false

	arg_10_0:SetListItemCount(0, var_10_0)

	if arg_10_0._loopGridView then
		arg_10_0._loopGridView:RefreshAllShownItem()
	end
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0._handler = nil
	arg_11_0._callbackFunc = nil
	arg_11_0._itemTotalCount = 0

	if arg_11_0._loopGridView ~= nil then
		arg_11_0._loopGridView:DestroyListView(arg_11_0, arg_11_0.OnGetItemByRowColumn)
	end

	arg_11_0._loopGridView = nil
end

function var_0_0.SetSnapVecThreshold(arg_12_0, arg_12_1)
	arg_12_0._loopGridView:SetSnapVecThreshold(arg_12_1)
end

function var_0_0.GetShownItemByItemIndex(arg_13_0, arg_13_1)
	arg_13_0._loopGridView:GetShownItemByItemIndex(arg_13_1)
end

function var_0_0.getCurSnapNearestItemRowColumn(arg_14_0)
	return arg_14_0._loopGridView:GetCurSnapNearestItemRowColumn()
end

function var_0_0.getScrollRect(arg_15_0)
	return arg_15_0._loopGridView.ScrollRect
end

function var_0_0.SetSnapTargetItemRowColumn(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0._loopGridView:SetSnapTargetItemRowColumn(arg_16_1, arg_16_2)
end

function var_0_0.ClearSnapData(arg_17_0)
	arg_17_0._loopGridView:ClearSnapData()
end

function var_0_0.AddSnapNearestChangedListener(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0._loopGridView:AddSnapNearestChangedListener(arg_18_1, arg_18_2)
end

function var_0_0.RemoveSnapNearestChangedListener(arg_19_0)
	arg_19_0._loopGridView:RemoveSnapNearestChangedListener()
end

function var_0_0.AddSnapItemFinishedListener(arg_20_0, arg_20_1, arg_20_2)
	arg_20_0._loopGridView:AddSnapItemFinishedListener(arg_20_1, arg_20_2)
end

function var_0_0.RemoveSnapItemFinishedListener(arg_21_0)
	arg_21_0._loopGridView:RemoveSnapItemFinishedListener()
end

function var_0_0.AddBeginDragListener(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0._loopGridView:AddBeginDragListener(arg_22_1, arg_22_2)
end

function var_0_0.RemoveBeginDragListener(arg_23_0)
	arg_23_0._loopGridView:RemoveBeginDragListener()
end

function var_0_0.AddDragListener(arg_24_0, arg_24_1, arg_24_2)
	arg_24_0._loopGridView:AddDragListener(arg_24_1, arg_24_2)
end

function var_0_0.RemoveDragListener(arg_25_0)
	arg_25_0._loopGridView:RemoveDragListener()
end

function var_0_0.AddEndDragListener(arg_26_0, arg_26_1, arg_26_2)
	arg_26_0._loopGridView:AddEndDragListener(arg_26_1, arg_26_2)
end

function var_0_0.RemoveEndDragListener(arg_27_0)
	arg_27_0._loopGridView:RemoveEndDragListener()
end

function var_0_0.SetGridFixedGroupCount(arg_28_0, arg_28_1, arg_28_2)
	if arg_28_0._loopGridView then
		arg_28_0._loopGridView:SetGridFixedGroupCount(arg_28_1, arg_28_2)
	end
end

function var_0_0.SetItemSize(arg_29_0, arg_29_1)
	if arg_29_0._loopGridView then
		arg_29_0._loopGridView:SetItemSize(arg_29_1)
	end
end

function var_0_0.SetItemPadding(arg_30_0, arg_30_1)
	if arg_30_0._loopGridView then
		arg_30_0._loopGridView:SetItemPadding(arg_30_1)
	end
end

function var_0_0.SetPadding(arg_31_0, arg_31_1)
	if arg_31_0._loopGridView then
		arg_31_0._loopGridView:SetPadding(arg_31_1)
	end
end

return var_0_0
