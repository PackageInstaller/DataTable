module("frameworkext.lmvc.view.component.LoopStaggeredGridViewHelper", package.seeall)

local var_0_0 = class("LoopStaggeredGridViewHelper")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._loopGridView = goutil.addComponentOnce(arg_1_1, UIComponentType.LoopStaggeredGridView)
end

function var_0_0.InitStaggeredGridView(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6, arg_2_7)
	arg_2_0._handler = arg_2_7
	arg_2_0._callbackFunc = arg_2_6
	arg_2_0._itemTotalCount = arg_2_1

	if arg_2_0._loopGridView ~= nil then
		arg_2_1 = tonumber(arg_2_1)

		arg_2_0._loopGridView:InitStaggeredGridView(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_0.OnGetItemByItemIndex)
	elseif enableErrorLog then
		printError("LoopStaggeredGridViewHelper: could not found LoopStaggeredGridView Component!")
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

function var_0_0.ResetGridViewLayoutParam(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	if arg_5_0._loopGridView ~= nil then
		return arg_5_0._loopGridView:ResetGridViewLayoutParam(arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	end
end

function var_0_0.ResetListView(arg_6_0, arg_6_1)
	if arg_6_0._loopGridView ~= nil then
		return arg_6_0._loopGridView:ResetListView(arg_6_1)
	end
end

function var_0_0.UpdateAllGroupShownItemsPos(arg_7_0)
	if arg_7_0._loopGridView ~= nil then
		return arg_7_0._loopGridView:UpdateAllGroupShownItemsPos()
	end
end

function var_0_0.MoveToItemIndex(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_0._loopGridView ~= nil then
		arg_8_0._loopGridView:MovePanelToItemIndex(arg_8_1, arg_8_2 and arg_8_2 or 0, arg_8_3 and arg_8_3 or 0)
	end
end

function var_0_0.RefreshItemByItemIndex(arg_9_0, arg_9_1)
	if arg_9_0._loopGridView ~= nil then
		arg_9_0._loopGridView:RefreshItemByItemIndex(arg_9_1)
	end
end

function var_0_0.GetLoopStaggeredGridView(arg_10_0)
	return arg_10_0._loopGridView
end

function var_0_0.OnGetItemByItemIndex(arg_11_0, arg_11_1)
	if arg_11_1 < 0 or arg_11_1 >= arg_11_0._itemTotalCount then
		return nil
	end

	if arg_11_0._handler and arg_11_0._callbackFunc ~= nil then
		return arg_11_0._callbackFunc(arg_11_0._handler, arg_11_1)
	end

	return nil
end

function var_0_0.RefreshAllShownItem(arg_12_0)
	if arg_12_0._loopGridView then
		arg_12_0._loopGridView:RefreshAllShownItem()
	end
end

function var_0_0.IsInited(arg_13_0)
	if arg_13_0._loopGridView then
		return arg_13_0._loopGridView.IsInited
	end
end

function var_0_0.RecycleAllItem(arg_14_0)
	if arg_14_0._loopGridView then
		return arg_14_0._loopGridView:RecycleAllItem()
	end
end

function var_0_0.ClearCells(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1 and true or false

	arg_15_0:SetListItemCount(0, var_15_0)

	if arg_15_0._loopGridView then
		arg_15_0._loopGridView:RefreshAllShownItem()
	end
end

function var_0_0.Dispose(arg_16_0)
	arg_16_0._handler = nil
	arg_16_0._callbackFunc = nil
	arg_16_0._itemTotalCount = 0

	if arg_16_0._loopGridView ~= nil then
		arg_16_0._loopGridView:DestroyListView(arg_16_0, arg_16_0.OnGetItemByRowColumn)
	end

	arg_16_0._loopGridView = nil
end

function var_0_0.GetShownItemByItemIndex(arg_17_0, arg_17_1)
	arg_17_0._loopGridView:GetShownItemByItemIndex(arg_17_1)
end

function var_0_0.onItemSizeChanged(arg_18_0, arg_18_1)
	return arg_18_0._loopGridView:OnItemSizeChanged(arg_18_1)
end

function var_0_0.getScrollRect(arg_19_0)
	return arg_19_0._loopGridView.ScrollRect
end

function var_0_0.AddBeginDragListener(arg_20_0, arg_20_1, arg_20_2)
	arg_20_0._loopGridView:AddBeginDragListener(arg_20_1, arg_20_2)
end

function var_0_0.RemoveBeginDragListener(arg_21_0)
	arg_21_0._loopGridView:RemoveBeginDragListener()
end

function var_0_0.AddDragListener(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0._loopGridView:AddDragListener(arg_22_1, arg_22_2)
end

function var_0_0.RemoveDragListener(arg_23_0)
	arg_23_0._loopGridView:RemoveDragListener()
end

function var_0_0.AddEndDragListener(arg_24_0, arg_24_1, arg_24_2)
	arg_24_0._loopGridView:AddEndDragListener(arg_24_1, arg_24_2)
end

function var_0_0.RemoveEndDragListener(arg_25_0)
	arg_25_0._loopGridView:RemoveEndDragListener()
end

return var_0_0
