local var_0_0 = class("LuaList")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.uiListGo_ = arg_1_2.gameObject
	arg_1_0.itemClass_ = arg_1_3
	arg_1_0.itemRenderer_ = arg_1_1
	arg_1_0.itemOfInstanceID_ = {}
	arg_1_0.itemOfIndex_ = {}

	arg_1_0:InitUI()
	arg_1_0:AddListeners()

	if not arg_1_0.ctored_ then
		ReduxFactory.GetInstance():OnManagedObjCtor(arg_1_0)
	end

	arg_1_0.ctored_ = true
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0.uiList_ = arg_2_0.uiListGo_:GetComponent("UIList")
	arg_2_0.emptyController_ = ControllerUtil.GetController(arg_2_0.uiListGo_.transform, "empty")
end

function var_0_0.AddListeners(arg_3_0)
	if arg_3_0.uiList_ ~= nil then
		arg_3_0.uiList_:SetItemRenderer(handler(arg_3_0, arg_3_0.ItemRenderer))
		arg_3_0.uiList_:SetItemRecycleHandler(handler(arg_3_0, arg_3_0.ItemRecycleHandler))
		arg_3_0.uiList_:SetPageChangeHandler(handler(arg_3_0, arg_3_0.PageChangeHandler))
		arg_3_0.uiList_:SetHeadTailChangeHandler(handler(arg_3_0, arg_3_0.HeadTailChangeHandler))
	end
end

function var_0_0.RemoveListeners(arg_4_0)
	if arg_4_0.uiList_ ~= nil then
		arg_4_0.uiList_:SetItemRenderer(nil)
		arg_4_0.uiList_:SetItemRecycleHandler(nil)
		arg_4_0.uiList_:SetPageChangeHandler(nil)
		arg_4_0.uiList_:SetHeadTailChangeHandler(nil)
	end
end

function var_0_0.HeadTailChangeHandler(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0.headTailChangeHandler_ ~= nil then
		arg_5_0.headTailChangeHandler_(arg_5_1, arg_5_2)
	end
end

function var_0_0.ItemRenderer(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_1 + 1
	local var_6_1 = arg_6_2:GetInstanceID()
	local var_6_2

	if arg_6_0.itemOfInstanceID_[var_6_1] then
		var_6_2 = arg_6_0.itemOfInstanceID_[var_6_1]
	else
		var_6_2 = arg_6_0.itemClass_.New(arg_6_2)
		arg_6_0.itemOfInstanceID_[var_6_1] = var_6_2
	end

	arg_6_0.itemOfIndex_[arg_6_1 + 1] = var_6_2

	if var_6_0 > arg_6_0.num_ then
		return
	end

	if arg_6_0.itemRenderer_ then
		arg_6_0.itemRenderer_(var_6_0, var_6_2)
	end
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
end

function var_0_0.SetHeadTailChangeHandler(arg_10_0, arg_10_1)
	arg_10_0.headTailChangeHandler_ = arg_10_1
end

function var_0_0.PageChangeHandler(arg_11_0, arg_11_1)
	if arg_11_0.pageChangeHandler_ ~= nil then
		arg_11_0.pageChangeHandler_(arg_11_1 + 1)
	end
end

function var_0_0.ScrollToIndex(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	local var_12_0 = arg_12_1 - 1

	arg_12_2 = arg_12_2 or false
	arg_12_3 = arg_12_3 or false
	arg_12_4 = arg_12_4 or -1

	arg_12_0.uiList_:ScrollToIndex(var_12_0, arg_12_2, arg_12_3, arg_12_4)
end

function var_0_0.RemoveTween(arg_13_0)
	arg_13_0.uiList_:RemoveTween()
end

function var_0_0.SwitchToPage(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1 - 1

	arg_14_0.uiList_:SwitchToPageIndex(var_14_0)
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
	local var_16_0 = arg_16_0.uiList_:GetHeadAndTail()

	return var_16_0.x + 1, var_16_0.y + 1
end

function var_0_0.SetAlignment(arg_17_0, arg_17_1)
	arg_17_0.uiList_:SetAlignment(arg_17_1)
end

function var_0_0.StartScroll(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5)
	arg_18_2 = arg_18_2 or 0
	arg_18_5 = arg_18_5 or -1

	local var_18_0 = arg_18_2 - 1

	arg_18_0.num_ = arg_18_1

	arg_18_0:UpdateUIList(arg_18_1)

	if var_18_0 >= 0 then
		arg_18_0.uiList_:ScrollToIndex(var_18_0, arg_18_3, arg_18_4, arg_18_5)
	end
end

function var_0_0.StartScrollWithoutAnimator(arg_19_0, arg_19_1, arg_19_2)
	arg_19_0.num_ = arg_19_1

	arg_19_0.uiList_:SetNumItems(arg_19_1, true)

	if arg_19_0.emptyController_ ~= nil then
		arg_19_0.emptyController_:SetSelectedState(arg_19_1 == 0 and "true" or "false")
	end

	if arg_19_2 then
		arg_19_0.uiList_:SetScrolledPosition(arg_19_2)
	end
end

function var_0_0.Refresh(arg_20_0)
	local var_20_0, var_20_1 = arg_20_0:GetHeadAndTail()

	if var_20_0 == 0 then
		return
	end

	for iter_20_0 = var_20_0, var_20_1 do
		if arg_20_0.itemRenderer_ then
			local var_20_2 = arg_20_0.itemOfIndex_[iter_20_0]

			if var_20_2 then
				arg_20_0.itemRenderer_(iter_20_0, var_20_2)
			end
		end
	end
end

function var_0_0.SetScrolledPosition(arg_21_0, arg_21_1)
	arg_21_0.uiList_:SetScrolledPosition(arg_21_1)
end

function var_0_0.GetScrolledPosition(arg_22_0)
	return arg_22_0.uiList_:GetScrolledPosition()
end

function var_0_0.StartScrollByPosition(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0.num_ = arg_23_1

	arg_23_0:UpdateUIList(arg_23_1)
	arg_23_0:SetScrolledPosition(arg_23_2 or Vector2.zero)
end

function var_0_0.UpdateUIList(arg_24_0, arg_24_1)
	arg_24_0.uiList_:SetNumItems(arg_24_1)

	if arg_24_0.emptyController_ ~= nil then
		arg_24_0.emptyController_:SetSelectedState(arg_24_1 == 0 and "true" or "false")
	end
end

function var_0_0.StopRender(arg_25_0)
	if arg_25_0.uiList_ then
		arg_25_0.uiList_:StopRender()
	end
end

function var_0_0.Dispose(arg_26_0)
	arg_26_0:RemoveListeners()

	if arg_26_0.uiList_ ~= nil then
		arg_26_0:RemoveTween()
		arg_26_0.uiList_:StopRender()
		arg_26_0.uiList_:HideBlock()

		arg_26_0.uiList_ = nil
	end

	if arg_26_0.itemOfInstanceID_ then
		for iter_26_0, iter_26_1 in pairs(arg_26_0.itemOfInstanceID_) do
			iter_26_1:Dispose()
		end

		arg_26_0.itemOfInstanceID_ = nil
	end

	arg_26_0.pageChangeHandler_ = nil

	ReduxFactory.GetInstance():OnManagedObjDisposed(arg_26_0)
end

function var_0_0.SetOrientation(arg_27_0, arg_27_1)
	if arg_27_1 == 0 then
		arg_27_0.uiList_:SetOrientation(Orientation.Horizontal)
	else
		arg_27_0.uiList_:SetOrientation(Orientation.Vertical)
	end
end

function var_0_0.GetNum(arg_28_0)
	return arg_28_0.num_
end

function var_0_0.SetAppearType(arg_29_0, arg_29_1)
	arg_29_0.uiList_:SetAppearType(arg_29_1)
end

function var_0_0.SetLimitMaxDragCount(arg_30_0, arg_30_1)
	arg_30_0.uiList_:SetLimitMaxDragCount(arg_30_1)
end

return var_0_0
