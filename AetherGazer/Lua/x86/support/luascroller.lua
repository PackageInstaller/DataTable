local var_0_0 = class("LuaScroller")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.uiScrollerGo_ = arg_1_2
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
	arg_2_0.uiScroller_ = arg_2_0.uiScrollerGo_:GetComponent("UIScroller")
	arg_2_0.emptyController_ = ControllerUtil.GetController(arg_2_0.uiScrollerGo_.transform, "empty")
end

function var_0_0.AddListeners(arg_3_0)
	if arg_3_0.uiScroller_ ~= nil then
		arg_3_0.uiScroller_:SetItemRenderer(handler(arg_3_0, arg_3_0.ItemRenderer))
	end
end

function var_0_0.RemoveListeners(arg_4_0)
	if arg_4_0.uiScroller_ ~= nil then
		arg_4_0.uiScroller_:SetItemRenderer(nil)
	end
end

function var_0_0.ItemRenderer(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_1 + 1
	local var_5_1 = arg_5_2:GetInstanceID()
	local var_5_2

	if arg_5_0.itemOfInstanceID_[var_5_1] then
		var_5_2 = arg_5_0.itemOfInstanceID_[var_5_1]
	else
		var_5_2 = arg_5_0.itemClass_.New(arg_5_2)
		arg_5_0.itemOfInstanceID_[var_5_1] = var_5_2
	end

	arg_5_0.itemOfIndex_[arg_5_1 + 1] = var_5_2

	if arg_5_0.itemRenderer_ then
		arg_5_0.itemRenderer_(var_5_0, var_5_2)
	end
end

function var_0_0.GetItemByIndex(arg_6_0, arg_6_1)
	local var_6_0, var_6_1 = arg_6_0:GetHeadAndTail()

	if var_6_0 == 0 then
		return
	end

	if arg_6_1 < var_6_0 or var_6_1 < arg_6_1 then
		return nil
	end

	return arg_6_0.itemOfIndex_[arg_6_1]
end

function var_0_0.RemoveTween(arg_7_0)
	arg_7_0.uiScroller_:RemoveTween()
end

function var_0_0.GetItemList(arg_8_0)
	local var_8_0 = {}
	local var_8_1, var_8_2 = arg_8_0:GetHeadAndTail()

	if var_8_1 == 0 then
		return {}
	end

	for iter_8_0 = var_8_1, var_8_2 do
		var_8_0[iter_8_0] = arg_8_0.itemOfIndex_[iter_8_0]
	end

	return var_8_0
end

function var_0_0.GetHeadAndTail(arg_9_0)
	local var_9_0 = arg_9_0.uiScroller_:GetHeadAndTail()

	return var_9_0.x + 1, var_9_0.y + 1
end

function var_0_0.StartScroll(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	arg_10_0:UpdateUIList(arg_10_1)

	arg_10_2 = arg_10_2 or 0

	local var_10_0 = arg_10_2 - 1

	arg_10_0.num_ = arg_10_1

	if var_10_0 >= 0 then
		arg_10_0.uiScroller_:ScrollToIndex(var_10_0, arg_10_3, arg_10_4)
	end
end

function var_0_0.ScrollToIndex(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	local var_11_0 = arg_11_1 - 1

	arg_11_2 = arg_11_2 or false
	arg_11_3 = arg_11_3 or false
	arg_11_4 = arg_11_4 or 0.2

	arg_11_0.uiScroller_:ScrollToIndex(var_11_0, arg_11_2, arg_11_3, arg_11_4)
end

function var_0_0.StartScrollWithoutAnimator(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0.num_ = arg_12_1

	arg_12_0.uiScroller_:SetNumItems(arg_12_1, true)

	if arg_12_2 then
		arg_12_0.uiScroller_:SetScrolledPosition(arg_12_2)
	end
end

function var_0_0.Refresh(arg_13_0)
	local var_13_0, var_13_1 = arg_13_0:GetHeadAndTail()

	if var_13_0 == 0 then
		return
	end

	for iter_13_0 = var_13_0, var_13_1 do
		if arg_13_0.itemRenderer_ then
			local var_13_2 = arg_13_0.itemOfIndex_[iter_13_0]

			if var_13_2 then
				arg_13_0.itemRenderer_(iter_13_0, var_13_2)
			end
		end
	end
end

function var_0_0.SetScrolledPosition(arg_14_0, arg_14_1)
	arg_14_0.uiScroller_:SetScrolledPosition(arg_14_1)
end

function var_0_0.GetScrolledPosition(arg_15_0)
	return arg_15_0.uiScroller_:GetScrolledPosition()
end

function var_0_0.StartScrollByPosition(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0.num_ = arg_16_1

	arg_16_0:UpdateUIList(arg_16_1)
	arg_16_0:SetScrolledPosition(arg_16_2)
end

function var_0_0.UpdateUIList(arg_17_0, arg_17_1)
	arg_17_0.uiScroller_:SetNumItems(arg_17_1)

	if arg_17_0.emptyController_ ~= nil then
		arg_17_0.emptyController_:SetSelectedState(arg_17_1 == 0 and "true" or "false")
	end
end

function var_0_0.StopRender(arg_18_0)
	if arg_18_0.uiScroller_ then
		arg_18_0.uiScroller_:StopRender()
	end
end

function var_0_0.Dispose(arg_19_0)
	arg_19_0:RemoveListeners()

	if arg_19_0.uiScroller_ ~= nil then
		arg_19_0.uiScroller_:StopRender()

		arg_19_0.uiScroller_ = nil
	end

	if arg_19_0.itemOfInstanceID_ then
		for iter_19_0, iter_19_1 in pairs(arg_19_0.itemOfInstanceID_) do
			iter_19_1:Dispose()
		end

		arg_19_0.itemOfInstanceID_ = nil
	end

	arg_19_0.pageChangeHandler_ = nil

	ReduxFactory.GetInstance():OnManagedObjDisposed(arg_19_0)
end

function var_0_0.GetNum(arg_20_0)
	return arg_20_0.num_
end

return var_0_0
