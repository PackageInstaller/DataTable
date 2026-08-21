local var_0_0 = class("LoopScrollView", BaseView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7, arg_1_8)
	arg_1_0.parentView_ = arg_1_1
	arg_1_0.scrollView_ = arg_1_2
	arg_1_0.viewPort_ = arg_1_4
	arg_1_0.rectGrid_ = arg_1_3
	arg_1_0.itemList_ = {}
	arg_1_0.contentHeight_ = 0
	arg_1_0.itemSpace_ = arg_1_6
	arg_1_0.padding_ = arg_1_3:GetComponent("HorizontalOrVerticalLayoutGroup").padding
	arg_1_0.currentHeight_ = arg_1_5
	arg_1_0.isBottom_ = arg_1_7
	arg_1_0.isHorizontal = arg_1_8

	arg_1_0:AddListeners()
end

function var_0_0.Dispose(arg_2_0)
	arg_2_0:RemoveAllListeners()

	arg_2_0.itemList_ = nil
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddToggleListener(arg_3_0.scrollView_, function(arg_4_0)
		if arg_3_0.isHorizontal then
			if arg_4_0.x < 0 or arg_4_0.x == 0 and arg_3_0.rectGrid_.anchoredPosition.x > 0 then
				arg_3_0:DeleteItem(false)
				arg_3_0:AddHeadItem()
			elseif arg_4_0.x > 1 or arg_4_0.x == 1 and arg_3_0.rectGrid_.anchoredPosition.x < 0 then
				arg_3_0:DeleteItem(true)
				arg_3_0:AddTailItem()
			end
		elseif arg_4_0.y < 0 or arg_4_0.y == 0 and arg_3_0.rectGrid_.anchoredPosition.y > 0 then
			arg_3_0:DeleteItem(true)
			arg_3_0:AddTailItem()
		elseif arg_4_0.y > 1 or arg_4_0.y == 1 and arg_3_0.rectGrid_.anchoredPosition.y < 0 then
			arg_3_0:DeleteItem(false)
			arg_3_0:AddHeadItem()
		end
	end)
end

function var_0_0.GetContentHeight(arg_5_0)
	if arg_5_0.isHorizontal then
		return arg_5_0.currentHeight_ - arg_5_0.padding_.left
	else
		return arg_5_0.currentHeight_ - arg_5_0.padding_.top
	end
end

function var_0_0.SetContentHeight(arg_6_0, arg_6_1)
	arg_6_0.currentHeight_ = arg_6_1
end

function var_0_0.RestoredScroll(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0:NavigateIndex(arg_7_1)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_0.rectGrid_)

	if arg_7_0.isHorizontal then
		arg_7_0.scrollView_.horizontalNormalizedPosition = arg_7_2
	else
		arg_7_0.scrollView_.verticalNormalizedPosition = arg_7_2
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_0.rectGrid_)
end

function var_0_0.NavigateIndex(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_2 = arg_8_2 or 0

	if not arg_8_3 then
		if arg_8_0.isHorizontal then
			arg_8_0.scrollView_.horizontalNormalizedPosition = 0.9999
		else
			arg_8_0.scrollView_.verticalNormalizedPosition = 0.9999
		end
	end

	for iter_8_0 = #arg_8_0.itemList_, 1, -1 do
		local var_8_0 = arg_8_0.itemList_[iter_8_0]

		arg_8_0.parentView_:LsRemoveItem(var_8_0)
		table.remove(arg_8_0.itemList_, #arg_8_0.itemList_)
	end

	arg_8_0.contentHeight_ = 0

	local var_8_1 = arg_8_0.parentView_:LsGetItemData()

	for iter_8_1 = arg_8_1, #var_8_1 do
		local var_8_2 = arg_8_0.parentView_:LsAddItem(var_8_1[iter_8_1], iter_8_1)

		table.insert(arg_8_0.itemList_, var_8_2)
		var_8_2.itemView:SetAsLastSibling()

		if var_8_2.itemView:IsActive() then
			arg_8_0.contentHeight_ = arg_8_0.contentHeight_ + arg_8_0.itemSpace_ + var_8_2.itemView:GetItemHeight()
		end

		if arg_8_0.contentHeight_ >= arg_8_0:GetContentHeight() + math.abs(arg_8_2) then
			break
		end
	end

	if arg_8_0.isBottom_ and arg_8_0.contentHeight_ < arg_8_0:GetContentHeight() then
		arg_8_0:Scroll2End()
	end
end

function var_0_0.Scroll2End(arg_9_0)
	for iter_9_0 = #arg_9_0.itemList_, 1, -1 do
		local var_9_0 = arg_9_0.itemList_[iter_9_0]

		arg_9_0.parentView_:LsRemoveItem(var_9_0)
		table.remove(arg_9_0.itemList_, iter_9_0)
	end

	arg_9_0.contentHeight_ = 0

	local var_9_1 = arg_9_0.parentView_:LsGetItemData()

	for iter_9_1 = #var_9_1, 1, -1 do
		local var_9_2 = arg_9_0.parentView_:LsAddItem(var_9_1[iter_9_1], iter_9_1)

		table.insert(arg_9_0.itemList_, 1, var_9_2)
		var_9_2.itemView:SetAsFirstSibling()

		if var_9_2.itemView:IsActive() then
			arg_9_0.contentHeight_ = arg_9_0.contentHeight_ + arg_9_0.itemSpace_ + var_9_2.itemView:GetItemHeight()
		end

		if arg_9_0.contentHeight_ >= arg_9_0:GetContentHeight() then
			break
		end
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_0.rectGrid_)

	if arg_9_0.isHorizontal then
		arg_9_0.scrollView_.horizontalNormalizedPosition = 0.0001
	else
		arg_9_0.scrollView_.verticalNormalizedPosition = 0.0001
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_0.rectGrid_)
end

function var_0_0.RefreshScrollView(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = 0.99999
	local var_10_1
	local var_10_2 = arg_10_0.rectGrid_.localPosition

	if arg_10_2 then
		if arg_10_0.isHorizontal then
			var_10_0 = arg_10_0.scrollView_.horizontalNormalizedPosition
		else
			var_10_0 = arg_10_0.scrollView_.verticalNormalizedPosition
		end

		var_10_1 = arg_10_0.rectGrid_.localPosition
	else
		var_10_1 = Vector2.zero
	end

	if #arg_10_0.itemList_ <= 0 then
		arg_10_0:NavigateIndex(1)

		if arg_10_0.isHorizontal then
			arg_10_0.scrollView_.horizontalNormalizedPosition = var_10_0
		else
			arg_10_0.scrollView_.verticalNormalizedPosition = var_10_0
		end

		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_0.rectGrid_)

		return
	end

	local var_10_3 = arg_10_0.itemList_[1].itemView:GetIndex()

	if arg_10_0.itemList_[1].itemView:IsActive() == false then
		arg_10_0:NavigateIndex(var_10_3)

		if arg_10_0.isHorizontal then
			arg_10_0.scrollView_.horizontalNormalizedPosition = var_10_0
		else
			arg_10_0.scrollView_.verticalNormalizedPosition = var_10_0
		end

		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_0.rectGrid_)

		return
	end

	local var_10_4 = arg_10_0.parentView_:LsGetItemData()

	if #var_10_4 <= 0 then
		arg_10_0:DeleteAllItem()

		if arg_10_0.isHorizontal then
			arg_10_0.scrollView_.horizontalNormalizedPosition = var_10_0
		else
			arg_10_0.scrollView_.verticalNormalizedPosition = var_10_0
		end

		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_0.rectGrid_)

		return
	end

	local var_10_5 = var_10_4[var_10_3]

	if arg_10_1 then
		arg_10_0:DeleteAllItem()

		if arg_10_0.isHorizontal then
			arg_10_0:NavigateIndex(var_10_3, var_10_1.x)
		else
			arg_10_0:NavigateIndex(var_10_3, var_10_1.y)
		end

		arg_10_0.rectGrid_.localPosition = var_10_1

		if arg_10_0.isHorizontal then
			arg_10_0.scrollView_.horizontalNormalizedPosition = var_10_0
		else
			arg_10_0.scrollView_.verticalNormalizedPosition = var_10_0
		end

		if arg_10_0.contentHeight_ < arg_10_0:GetContentHeight() then
			arg_10_0:Scroll2End()
		end

		return
	else
		arg_10_0.parentView_:LsUpdateItem(arg_10_0.itemList_[1], var_10_5, var_10_3)

		for iter_10_0 = #arg_10_0.itemList_, 2, -1 do
			local var_10_6 = arg_10_0.itemList_[iter_10_0]

			arg_10_0.parentView_:LsRemoveItem(var_10_6)
			table.remove(arg_10_0.itemList_, iter_10_0)
		end

		arg_10_0.contentHeight_ = arg_10_0.itemSpace_ + arg_10_0.itemList_[1].itemView:GetItemHeight()
	end

	arg_10_0:AddTail2End()
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_0.rectGrid_)

	if arg_10_0.isHorizontal then
		arg_10_0.scrollView_.horizontalNormalizedPosition = var_10_0
	else
		arg_10_0.scrollView_.verticalNormalizedPosition = var_10_0
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_0.rectGrid_)
end

function var_0_0.AddTail2End(arg_11_0)
	local var_11_0 = arg_11_0.parentView_:LsGetItemData()

	if #var_11_0 <= 0 then
		return
	end

	while arg_11_0.contentHeight_ < arg_11_0:GetContentHeight() do
		local var_11_1 = 1

		if #arg_11_0.itemList_ > 0 and arg_11_0.itemList_[#arg_11_0.itemList_].itemView:GetIndex() + 1 > #var_11_0 then
			break
		end

		arg_11_0:AddTailItem()
	end

	arg_11_0:AddTailItem()

	while arg_11_0.contentHeight_ < arg_11_0:GetContentHeight() do
		local var_11_2 = 1

		if #arg_11_0.itemList_ > 0 and arg_11_0.itemList_[1].itemView:GetIndex() - 1 <= 0 then
			break
		end

		arg_11_0:AddHeadItem()
	end
end

function var_0_0.DeleteIndex(arg_12_0, arg_12_1)
	for iter_12_0 = #arg_12_0.itemList_, arg_12_1, -1 do
		local var_12_0 = arg_12_0.itemList_[iter_12_0]

		arg_12_0.parentView_:LsRemoveItem(var_12_0)

		if var_12_0.itemView:IsActive() then
			arg_12_0.contentHeight_ = arg_12_0.contentHeight_ - arg_12_0.itemSpace_ - var_12_0.itemView:GetItemHeight()
		end

		table.remove(arg_12_0.itemList_, #arg_12_0.itemList_)
	end

	arg_12_0:AddTail2End()
end

function var_0_0.DeleteItem(arg_13_0, arg_13_1)
	while arg_13_0.contentHeight_ > arg_13_0:GetContentHeight() do
		local var_13_0 = 1

		if arg_13_1 then
			arg_13_0:DeleteHeadItem()
		else
			arg_13_0:DeleteTailItem()

			var_13_0 = #arg_13_0.itemList_
		end

		if var_13_0 <= 0 then
			break
		end

		local var_13_1 = arg_13_0.itemList_[var_13_0]

		if var_13_1 == nil then
			break
		end

		if arg_13_0.contentHeight_ - arg_13_0.itemSpace_ - var_13_1.itemView:GetItemHeight() < arg_13_0:GetContentHeight() then
			break
		end
	end
end

function var_0_0.DeleteHeadItem(arg_14_0)
	local var_14_0 = arg_14_0.itemList_[1]

	if arg_14_0.contentHeight_ - arg_14_0.itemSpace_ - var_14_0.itemView:GetItemHeight() > arg_14_0:GetContentHeight() then
		arg_14_0.parentView_:LsRemoveItem(var_14_0)
		table.remove(arg_14_0.itemList_, 1)

		if var_14_0.itemView:IsActive() then
			if arg_14_0.isHorizontal then
				arg_14_0.scrollView_:AddContentPosition(Vector2(arg_14_0.itemSpace_ + var_14_0.itemView:GetItemHeight(), 0))
			else
				arg_14_0.scrollView_:AddContentPosition(Vector2(0, -arg_14_0.itemSpace_ - var_14_0.itemView:GetItemHeight()))
			end

			arg_14_0.contentHeight_ = arg_14_0.contentHeight_ - arg_14_0.itemSpace_ - var_14_0.itemView:GetItemHeight()
		else
			arg_14_0:DeleteHeadItem()
		end
	end
end

function var_0_0.DeleteTailItem(arg_15_0)
	local var_15_0 = arg_15_0.itemList_[#arg_15_0.itemList_]

	if arg_15_0.contentHeight_ - arg_15_0.itemSpace_ - var_15_0.itemView:GetItemHeight() > arg_15_0:GetContentHeight() then
		arg_15_0.parentView_:LsRemoveItem(var_15_0)
		table.remove(arg_15_0.itemList_, #arg_15_0.itemList_)

		if var_15_0.itemView:IsActive() then
			arg_15_0.contentHeight_ = arg_15_0.contentHeight_ - arg_15_0.itemSpace_ - var_15_0.itemView:GetItemHeight()
		else
			arg_15_0:DeleteTailItem()
		end
	end
end

function var_0_0.AddTailItem(arg_16_0)
	local var_16_0 = arg_16_0.parentView_:LsGetItemData()

	if #var_16_0 <= 0 then
		return
	end

	local var_16_1 = 1

	if #arg_16_0.itemList_ > 0 then
		var_16_1 = arg_16_0.itemList_[#arg_16_0.itemList_].itemView:GetIndex() + 1

		if var_16_1 > #var_16_0 then
			return
		end
	end

	local var_16_2 = var_16_0[var_16_1]
	local var_16_3 = arg_16_0.parentView_:LsAddItem(var_16_2, var_16_1)

	table.insert(arg_16_0.itemList_, var_16_3)
	var_16_3.itemView:SetAsLastSibling()

	if var_16_3.itemView:IsActive() then
		arg_16_0.contentHeight_ = arg_16_0.contentHeight_ + arg_16_0.itemSpace_ + var_16_3.itemView:GetItemHeight()
	else
		arg_16_0:AddTailItem()
	end
end

function var_0_0.AddHeadItem(arg_17_0)
	local var_17_0 = arg_17_0.parentView_:LsGetItemData()

	if #var_17_0 <= 0 then
		return
	end

	local var_17_1 = 1

	if #arg_17_0.itemList_ > 0 then
		var_17_1 = arg_17_0.itemList_[1].itemView:GetIndex()
		var_17_1 = var_17_1 - 1

		if var_17_1 <= 0 then
			return
		end
	end

	local var_17_2 = var_17_0[var_17_1]
	local var_17_3 = arg_17_0.parentView_:LsAddItem(var_17_2, var_17_1)

	table.insert(arg_17_0.itemList_, 1, var_17_3)
	var_17_3.itemView:SetAsFirstSibling()

	if var_17_3.itemView:IsActive() then
		arg_17_0.contentHeight_ = arg_17_0.contentHeight_ + arg_17_0.itemSpace_ + var_17_3.itemView:GetItemHeight()

		if arg_17_0.isHorizontal then
			arg_17_0.scrollView_:AddContentPosition(Vector2(-arg_17_0.itemSpace_ - var_17_3.itemView:GetItemHeight(), 0))
		else
			arg_17_0.scrollView_:AddContentPosition(Vector2(0, arg_17_0.itemSpace_ + var_17_3.itemView:GetItemHeight()))
		end
	else
		arg_17_0:AddHeadItem()
	end
end

function var_0_0.DeleteAllItem(arg_18_0)
	for iter_18_0 = #arg_18_0.itemList_, 1, -1 do
		local var_18_0 = arg_18_0.itemList_[iter_18_0]

		arg_18_0.parentView_:LsRemoveItem(var_18_0)
		table.remove(arg_18_0.itemList_, iter_18_0)
	end

	arg_18_0.contentHeight_ = 0
end

function var_0_0.GetFirstItemHeight(arg_19_0)
	local var_19_0 = arg_19_0.itemList_[1]

	if not var_19_0 then
		return 0
	end

	return var_19_0.itemView:GetItemHeight() + arg_19_0.itemSpace_
end

function var_0_0.GetLastItemHeight(arg_20_0)
	local var_20_0 = arg_20_0.itemList_[#arg_20_0.itemList_]

	if not var_20_0 then
		return 0
	end

	return var_20_0.itemView:GetItemHeight() + arg_20_0.itemSpace_
end

function var_0_0.GetItemList(arg_21_0)
	return arg_21_0.itemList_
end

function var_0_0.IsFillContent(arg_22_0)
	return arg_22_0.contentHeight_ >= arg_22_0:GetContentHeight()
end

return var_0_0
