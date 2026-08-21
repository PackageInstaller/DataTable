module("frameworkext.lmvc.view.component.LoopListHelper", package.seeall)

local var_0_0 = class("LoopListHelper")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._endlessLoop = false
	arg_1_0._loopListView = goutil.addComponentOnce(arg_1_1, UIComponentType.LoopListView2)
end

function var_0_0.InitListView(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0._handler = arg_2_3
	arg_2_0._callbackFunc = arg_2_2
	arg_2_0._itemTotalCount = arg_2_1

	if arg_2_0._loopListView ~= nil then
		arg_2_1 = tonumber(arg_2_1)

		arg_2_0._loopListView:InitListView(arg_2_0, arg_2_1, arg_2_0.OnGetItemByIndex)
	elseif enableErrorLog then
		printError("LoopListHelper: could not found LoopListView Component!")
	end
end

function var_0_0.NewListViewItem(arg_3_0, arg_3_1)
	if arg_3_0._loopListView ~= nil then
		return arg_3_0._loopListView:NewListViewItem(arg_3_1)
	end
end

function var_0_0.SetListItemCount(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0._loopListView ~= nil then
		arg_4_0._itemTotalCount = arg_4_1

		arg_4_0._loopListView:SetListItemCount(arg_4_1, arg_4_2)
	end
end

function var_0_0.GetListItemCount(arg_5_0)
	return arg_5_0._itemTotalCount
end

function var_0_0.MoveToItemIndex(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0._loopListView ~= nil then
		arg_6_0._loopListView:MovePanelToItemIndex(arg_6_1, arg_6_2 and arg_6_2 or 0)
	end
end

function var_0_0.RefreshItemByItemIndex(arg_7_0, arg_7_1)
	if arg_7_0._loopListView ~= nil then
		arg_7_0._loopListView:RefreshItemByItemIndex(arg_7_1)
	end
end

function var_0_0.GetLoopListView(arg_8_0)
	return arg_8_0._loopListView
end

function var_0_0.OnGetItemByIndex(arg_9_0, arg_9_1)
	if not arg_9_0._endlessLoop and arg_9_1 < 0 then
		return nil
	end

	if arg_9_0._handler and arg_9_0._callbackFunc ~= nil then
		return arg_9_0._callbackFunc(arg_9_0._handler, arg_9_1)
	end

	return nil
end

function var_0_0.RefreshAllShownItem(arg_10_0)
	if arg_10_0._loopListView then
		arg_10_0._loopListView:RefreshAllShownItem()
	end
end

function var_0_0.ClearCells(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1 and true or false

	arg_11_0:SetListItemCount(0, var_11_0)

	if arg_11_0._loopListView then
		arg_11_0._loopListView:RefreshAllShownItem()
	end
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0._handler = nil
	arg_12_0._callbackFunc = nil
	arg_12_0._itemTotalCount = 0

	if arg_12_0._loopListView ~= nil then
		arg_12_0._loopListView:DestroyListView(arg_12_0, arg_12_0.OnGetItemByIndex)
	end

	arg_12_0._loopListView = nil
	arg_12_0._endlessLoop = false
end

function var_0_0.SetSnapVecThreshold(arg_13_0, arg_13_1)
	arg_13_0._loopListView:SetSnapVecThreshold(arg_13_1)
end

function var_0_0.GetShownItemByItemIndex(arg_14_0, arg_14_1)
	arg_14_0._loopListView:GetShownItemByItemIndex(arg_14_1)
end

function var_0_0.getCurSnapNearestItemIndex(arg_15_0)
	return arg_15_0._loopListView.CurSnapNearestItemIndex
end

function var_0_0.GetItemCornerPosInViewPort(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0._loopListView:GetItemCornerPos(arg_16_1, arg_16_2)
end

function var_0_0.getScrollRect(arg_17_0)
	return arg_17_0._loopListView.ScrollRect
end

function var_0_0.SetSnapTargetItemIndex(arg_18_0, arg_18_1)
	arg_18_0._loopListView:SetSnapTargetItemIndex(arg_18_1)
end

function var_0_0.ClearSnapData(arg_19_0)
	arg_19_0._loopListView:ClearSnapData()
end

function var_0_0.AddSnapNearestChangedListener(arg_20_0, arg_20_1, arg_20_2)
	arg_20_0._loopListView:AddSnapNearestChangedListener(arg_20_1, arg_20_2)
end

function var_0_0.RemoveSnapNearestChangedListener(arg_21_0)
	arg_21_0._loopListView:RemoveSnapNearestChangedListener()
end

function var_0_0.AddSnapItemFinishedListener(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0._loopListView:AddSnapItemFinishedListener(arg_22_1, arg_22_2)
end

function var_0_0.RemoveSnapItemFinishedListener(arg_23_0)
	arg_23_0._loopListView:RemoveSnapItemFinishedListener()
end

function var_0_0.AddBeginDragListener(arg_24_0, arg_24_1, arg_24_2)
	arg_24_0._loopListView:AddBeginDragListener(arg_24_1, arg_24_2)
end

function var_0_0.RemoveBeginDragListener(arg_25_0)
	arg_25_0._loopListView:RemoveBeginDragListener()
end

function var_0_0.AddDragListener(arg_26_0, arg_26_1, arg_26_2)
	arg_26_0._loopListView:AddDragListener(arg_26_1, arg_26_2)
end

function var_0_0.RemoveDragListener(arg_27_0)
	arg_27_0._loopListView:RemoveDragListener()
end

function var_0_0.AddEndDragListener(arg_28_0, arg_28_1, arg_28_2)
	arg_28_0._loopListView:AddEndDragListener(arg_28_1, arg_28_2)
end

function var_0_0.RemoveEndDragListener(arg_29_0)
	arg_29_0._loopListView:RemoveEndDragListener()
end

function var_0_0.AddOnRecycleItemListener(arg_30_0, arg_30_1, arg_30_2)
	arg_30_0._loopListView:AddOnRecycleItemListener(arg_30_1, arg_30_2)
end

function var_0_0.RemoveOnRecycleItemListener(arg_31_0)
	arg_31_0._loopListView:RemoveOnRecycleItemListener()
end

function var_0_0.GetCurShowItemIndexRange(arg_32_0)
	return arg_32_0._loopListView:GetCurShowItemIndexRange(0, 0)
end

function var_0_0.setEndlessLoop(arg_33_0)
	arg_33_0._endlessLoop = true
end

return var_0_0
