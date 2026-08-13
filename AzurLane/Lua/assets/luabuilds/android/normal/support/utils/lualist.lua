class = var_0_10000

local var_0_0 = var_0_10000("LuaList")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.parentClass_ = arg_1_1
	arg_1_0.uiListGo_ = arg_1_3.gameObject
	arg_1_0.itemClass_ = arg_1_4
	arg_1_0.itemRenderer_ = arg_1_2
	arg_1_0.itemOfInstanceID_ = {}
	arg_1_0.itemOfIndex_ = {}

	arg_1_0:InitUI()
	arg_1_0:AddListeners()

	return
end

function var_0_0.InitUI(arg_2_0)
	local var_2_0 = arg_2_0.uiListGo_
	local var_2_1 = var_1.GetComponent

	typeof = var_1_10003
	UIList = var_1_10004
	arg_2_0.uiList_ = var_2_1(var_2_0, var_1_10003(var_1_10004))

	return
end

function var_0_0.AddListeners(arg_3_0)
	if arg_3_0.uiList_ ~= nil then
		local var_3_0 = arg_3_0.uiList_
		local var_3_1 = var_1.SetItemRenderer

		handler = var_1_10003

		var_3_1(var_3_0, var_1_10003(arg_3_0, arg_3_0.ItemRenderer))

		local var_3_2 = arg_3_0.uiList_
		local var_3_3 = var_1.SetItemRecycleHandler

		handler = var_3

		var_3_3(var_3_2, var_3(arg_3_0, arg_3_0.ItemRecycleHandler))

		local var_3_4 = arg_3_0.uiList_
		local var_3_5 = var_1.SetPageChangeHandler

		handler = var_3

		var_3_5(var_3_4, var_3(arg_3_0, arg_3_0.PageChangeHandler))

		local var_3_6 = arg_3_0.uiList_
		local var_3_7 = var_1.SetHeadTailChangeHandler

		handler = var_3

		var_3_7(var_3_6, var_3(arg_3_0, arg_3_0.HeadTailChangeHandler))
	end

	return
end

function var_0_0.RemoveListeners(arg_4_0)
	if arg_4_0.uiList_ ~= nil then
		local var_4_0 = arg_4_0.uiList_

		var_1.SetItemRenderer(var_4_0, nil)

		local var_4_1 = arg_4_0.uiList_

		var_1.SetItemRecycleHandler(var_4_1, nil)

		local var_4_2 = arg_4_0.uiList_

		var_1.SetPageChangeHandler(var_4_2, nil)

		local var_4_3 = arg_4_0.uiList_

		var_1.SetHeadTailChangeHandler(var_4_3, nil)
	end

	return
end

function var_0_0.HeadTailChangeHandler(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0.headTailChangeHandler_ ~= nil then
		arg_5_0.headTailChangeHandler_(arg_5_1, arg_5_2)
	end

	return
end

function var_0_0.ItemRenderer(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_1 + 1
	local var_6_1 = arg_6_2:GetInstanceID()
	local var_6_2

	if arg_6_0.itemOfInstanceID_[var_6_1] then
		var_6_2 = arg_6_0.itemOfInstanceID_[var_6_1]
	else
		var_6_2 = arg_6_0.itemClass_.New(arg_6_2.transform, arg_6_0.parentClass_)
		arg_6_0.itemOfInstanceID_[var_6_1] = var_6_2
	end

	arg_6_0.itemOfIndex_[arg_6_1 + 1] = var_6_2

	if var_6_0 > arg_6_0.num_ then
		return
	end

	if arg_6_0.itemRenderer_ then
		arg_6_0.itemRenderer_(var_6_0, var_6_2)
	end

	return
end

function var_0_0.GetItemByIndex(arg_7_0, arg_7_1)
	local var_7_0, var_7_1 = arg_7_0:GetHeadAndTail()

	if var_7_0 == 0 then
		return
	end

	if arg_7_1 < var_7_0 or var_7_1 < arg_7_1 then
		return nil
	end

	return arg_7_0.itemOfIndex_[arg_7_1]
end

function var_0_0.ItemRecycleHandler(arg_8_0, arg_8_1, arg_8_2)
	return
end

function var_0_0.SetPageChangeHandler(arg_9_0, arg_9_1)
	arg_9_0.pageChangeHandler_ = arg_9_1

	return
end

function var_0_0.SetHeadTailChangeHandler(arg_10_0, arg_10_1)
	arg_10_0.headTailChangeHandler_ = arg_10_1

	return
end

function var_0_0.PageChangeHandler(arg_11_0, arg_11_1)
	if arg_11_0.pageChangeHandler_ ~= nil then
		arg_11_0.pageChangeHandler_(arg_11_1 + 1)
	end

	return
end

function var_0_0.ScrollToIndex(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	local var_12_0 = arg_12_1 - 1

	arg_12_2 = arg_12_2 or false
	arg_12_3 = arg_12_3 or false
	arg_12_4 = arg_12_4 or -1

	local var_12_1 = arg_12_0.uiList_

	var_6.ScrollToIndex(var_12_1, var_12_0, arg_12_2, arg_12_3, arg_12_4)

	return
end

function var_0_0.RemoveTween(arg_13_0)
	local var_13_0 = arg_13_0.uiList_

	var_1.RemoveTween(var_13_0)

	return
end

function var_0_0.SwitchToPage(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1 - 1
	local var_14_1 = arg_14_0.uiList_

	var_3.SwitchToPageIndex(var_14_1, var_14_0)

	return
end

function var_0_0.GetItemList(arg_15_0)
	local var_15_0 = {}
	local var_15_1, var_15_2 = arg_15_0:GetHeadAndTail()

	if var_15_1 == 0 then
		return {}
	end

	for iter_15_0 = var_15_1, var_15_2 do
		var_15_0[iter_15_0] = arg_15_0.itemOfIndex_[iter_15_0]
	end

	return var_15_0
end

function var_0_0.GetHeadAndTail(arg_16_0)
	local var_16_0 = arg_16_0.uiList_

	return var_1.GetHeadAndTail(var_16_0).x + 1, var_1.y + 1
end

function var_0_0.SetAlignment(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.uiList_

	var_2.SetAlignment(var_17_0, arg_17_1)

	return
end

function var_0_0.StartScroll(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5)
	arg_18_2 = arg_18_2 or 0
	arg_18_5 = arg_18_5 or -1

	local var_18_0 = arg_18_2 - 1

	arg_18_0.num_ = arg_18_1

	arg_18_0:UpdateUIList(arg_18_1)

	if var_18_0 >= 0 then
		local var_18_1 = arg_18_0.uiList_

		var_7.ScrollToIndex(var_18_1, var_18_0, arg_18_3, arg_18_4, arg_18_5)
	end

	return
end

function var_0_0.StartScrollWithoutAnimator(arg_19_0, arg_19_1, arg_19_2)
	arg_19_0.num_ = arg_19_1

	local var_19_0 = arg_19_0.uiList_

	var_3.SetNumItems(var_19_0, arg_19_1, true)

	if arg_19_2 then
		local var_19_1 = arg_19_0.uiList_

		var_3.SetScrolledPosition(var_19_1, arg_19_2)
	end

	return
end

function var_0_0.Refresh(arg_20_0)
	local var_20_0, var_20_1 = arg_20_0:GetHeadAndTail()

	if var_20_0 == 0 then
		return
	end

	for iter_20_0 = var_20_0, var_20_1 do
		if arg_20_0.itemRenderer_ and arg_20_0.itemOfIndex_[iter_20_0] then
			arg_20_0.itemRenderer_(iter_20_0, var_7)
		end
	end

	return
end

function var_0_0.SetScrolledPosition(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0.uiList_

	var_2.SetScrolledPosition(var_21_0, arg_21_1)

	return
end

function var_0_0.GetScrolledPosition(arg_22_0)
	local var_22_0 = arg_22_0.uiList_

	return var_1.GetScrolledPosition(var_22_0)
end

function var_0_0.StartScrollByPosition(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0.num_ = arg_23_1

	arg_23_0:UpdateUIList(arg_23_1)

	local var_23_0 = arg_23_0
	local var_23_1 = arg_23_0.SetScrolledPosition
	local var_23_2

	if not arg_23_2 then
		::label_23_0::

		Vector2 = var_23_2
		var_23_2 = var_23_2.zero
	end

	var_23_1(var_23_0, var_23_2)

	return
end

function var_0_0.UpdateUIList(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0.uiList_

	var_2.SetNumItems(var_24_0, arg_24_1)

	return
end

function var_0_0.StopRender(arg_25_0)
	if arg_25_0.uiList_ then
		local var_25_0 = arg_25_0.uiList_

		var_1.StopRender(var_25_0)
	end

	return
end

function var_0_0.Dispose(arg_26_0)
	arg_26_0:RemoveListeners()

	if arg_26_0.uiList_ ~= nil then
		arg_26_0:RemoveTween()

		local var_26_0 = arg_26_0.uiList_

		var_1.StopRender(var_26_0)

		local var_26_1 = arg_26_0.uiList_

		var_1.HideBlock(var_26_1)

		arg_26_0.uiList_ = nil
	end

	if arg_26_0.itemOfInstanceID_ then
		pairs = var_1

		for iter_26_0, iter_26_1 in var_1(arg_26_0.itemOfInstanceID_) do
			iter_26_1:willExit()
		end

		arg_26_0.itemOfInstanceID_ = nil
	end

	arg_26_0.pageChangeHandler_ = nil

	return
end

function var_0_0.SetOrientation(arg_27_0, arg_27_1)
	if arg_27_1 == 0 then
		local var_27_0 = arg_27_0.uiList_
		local var_27_1 = var_2.SetOrientation

		Orientation = var_1_10004

		var_27_1(var_27_0, var_1_10004.Horizontal)
	else
		local var_27_2 = arg_27_0.uiList_
		local var_27_3 = var_2.SetOrientation

		Orientation = var_1_10004

		var_27_3(var_27_2, var_1_10004.Vertical)
	end

	return
end

function var_0_0.GetNum(arg_28_0)
	return arg_28_0.num_
end

function var_0_0.SetAppearType(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0.uiList_

	var_2.SetAppearType(var_29_0, arg_29_1)

	return
end

return var_0_0
