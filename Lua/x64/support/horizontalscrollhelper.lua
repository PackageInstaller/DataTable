local var_0_0 = class("HorizontalScrollHelper")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.delegateObj_ = arg_1_1
	arg_1_0.scrollView_ = arg_1_2
	arg_1_0.isVertical_ = arg_1_3
	arg_1_0.startIndex_ = 0
	arg_1_0.endIndex_ = 0
	arg_1_0.maxIndex_ = 0

	arg_1_0:OnCtor()
end

function var_0_0.OnCtor(arg_2_0)
	arg_2_0.itemS_ = {}
	arg_2_0.currentIndex_ = 0
end

function var_0_0.SetSpacing(arg_3_0, arg_3_1)
	arg_3_0.space_ = arg_3_1
end

function var_0_0.SetDataList(arg_4_0, arg_4_1)
	arg_4_0.dataList_ = arg_4_1
	arg_4_0.maxIndex_ = #arg_4_1
end

function var_0_0.RecycleAllItem(arg_5_0)
	for iter_5_0 = #arg_5_0.itemS_, 1, -1 do
		arg_5_0:RecycleItem(iter_5_0)
	end

	arg_5_0.itemS_ = {}
end

function var_0_0.RecycleItem(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.itemS_[arg_6_1]

	if var_6_0 == nil then
		return
	end

	var_6_0:Show(false)

	if var_6_0.pools and var_6_0.recycleIndex then
		var_6_0.pools:FinishIndex(var_6_0.recycleIndex)

		var_6_0.isFree = true
	end

	table.remove(arg_6_0.itemS_, arg_6_1)
end

function var_0_0.Show(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.scrollView_:GetViewBounds()
	local var_7_1 = arg_7_0.scrollView_:GetContentBounds()

	arg_7_0.startIndex_ = arg_7_1 - 1
	arg_7_0.endIndex_ = arg_7_0.startIndex_

	if arg_7_0.isVertical_ == true then
		for iter_7_0 = arg_7_0.endIndex_, arg_7_0.maxIndex_ do
			if var_7_1.max.y <= var_7_0.max.y then
				arg_7_0:NewItemAtEnd()

				var_7_0 = arg_7_0.scrollView_:GetViewBounds()
				var_7_1 = arg_7_0.scrollView_:GetContentBounds()
			else
				break
			end
		end

		while var_7_0.max.y - var_7_0.min.y > var_7_1.max.y - var_7_1.min.y and arg_7_0.startIndex_ > 0 do
			arg_7_0:NewItemAtStart()

			var_7_0 = arg_7_0.scrollView_:GetViewBounds()
			var_7_1 = arg_7_0.scrollView_:GetContentBounds()
		end
	else
		for iter_7_1 = arg_7_0.startIndex_, arg_7_0.maxIndex_ do
			if var_7_1.max.x <= var_7_0.max.x then
				arg_7_0:NewItemAtEnd()

				var_7_0 = arg_7_0.scrollView_:GetViewBounds()
				var_7_1 = arg_7_0.scrollView_:GetContentBounds()
			else
				break
			end
		end

		while var_7_0.max.x - var_7_0.min.x - (var_7_1.max.x - var_7_1.min.x) > 0.001 and arg_7_0.startIndex_ > 0 do
			arg_7_0:NewItemAtStart()

			var_7_0 = arg_7_0.scrollView_:GetViewBounds()
			var_7_1 = arg_7_0.scrollView_:GetContentBounds()
		end
	end

	if not arg_7_0.scrollView_.onUpdateItems then
		function arg_7_0.scrollView_.onUpdateItems(arg_8_0, arg_8_1)
			arg_7_0:UpdateItems(arg_8_0, arg_8_1)
		end
	end
end

function var_0_0.UpdateItems(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_0.isVertical_ then
		arg_9_0:UpdateVertical(arg_9_1, arg_9_2)
	else
		arg_9_0:UpdateHorizontal(arg_9_1, arg_9_2)
	end
end

function var_0_0.UpdateVertical(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1.max.y > arg_10_2.max.y - 0 * arg_10_0:CaculateItemSize(1) then
		arg_10_0:NewItemAtStart()
	end

	if arg_10_1.min.y < arg_10_2.min.y - 0 * arg_10_0:CaculateItemSize(#arg_10_0.itemS_) then
		arg_10_0:NewItemAtEnd()
	end

	arg_10_1 = arg_10_0.scrollView_:GetViewBounds()
	arg_10_2 = arg_10_0.scrollView_:GetContentBounds()

	if arg_10_1.max.y < arg_10_2.max.y - 1 * arg_10_0:CaculateItemSize(1) then
		arg_10_0:RemoveItemAtStart()
	end

	if arg_10_1.min.y > arg_10_2.min.y + 1 * arg_10_0:CaculateItemSize(#arg_10_0.itemS_) then
		arg_10_0:RemoveItemAtEnd()
	end
end

function var_0_0.UpdateHorizontal(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1.min.x < arg_11_2.min.x - 0 * arg_11_0:CaculateItemSize(1) then
		arg_11_0:NewItemAtStart()
	end

	if arg_11_1.max.x > arg_11_2.max.x + 0 * arg_11_0:CaculateItemSize(1) then
		arg_11_0:NewItemAtEnd()
	end

	arg_11_1 = arg_11_0.scrollView_:GetViewBounds()
	arg_11_2 = arg_11_0.scrollView_:GetContentBounds()

	if arg_11_1.min.x > arg_11_2.min.x + 1 * arg_11_0:CaculateItemSize(1) then
		arg_11_0:RemoveItemAtStart()
	end

	if arg_11_1.max.x < arg_11_2.max.x - 1 * arg_11_0:CaculateItemSize(#arg_11_0.itemS_) then
		arg_11_0:RemoveItemAtEnd()
	end
end

function var_0_0.NewItemAtStart(arg_12_0)
	if arg_12_0.startIndex_ < 1 then
		return
	end

	table.insert(arg_12_0.itemS_, 1, arg_12_0.delegateObj_:GetItem(arg_12_0.startIndex_))

	arg_12_0.startIndex_ = arg_12_0.startIndex_ - 1

	arg_12_0.itemS_[1]:Show(true)
	arg_12_0.itemS_[1].gameObject_.transform:SetAsFirstSibling()

	if arg_12_0.isVertical_ then
		arg_12_0.scrollView_:AddContentPosition(Vector2(0, arg_12_0:CaculateItemSize(1) * 1))
	else
		arg_12_0.scrollView_:AddContentPosition(Vector2(arg_12_0:CaculateItemSize(1) * -1, 0))
	end
end

function var_0_0.RemoveItemAtStart(arg_13_0)
	if arg_13_0.endIndex_ >= arg_13_0.maxIndex_ then
		return
	end

	arg_13_0:RecycleItem(1)

	arg_13_0.startIndex_ = arg_13_0.startIndex_ + 1

	if arg_13_0.isVertical_ then
		arg_13_0.scrollView_:AddContentPosition(Vector2(0, arg_13_0:CaculateItemSize(1) * -1))
	else
		arg_13_0.scrollView_:AddContentPosition(Vector2(arg_13_0:CaculateItemSize(1), 0))
	end
end

function var_0_0.NewItemAtEnd(arg_14_0)
	if arg_14_0.endIndex_ >= arg_14_0.maxIndex_ then
		return
	end

	arg_14_0.endIndex_ = arg_14_0.endIndex_ + 1

	table.insert(arg_14_0.itemS_, arg_14_0.delegateObj_:GetItem(arg_14_0.endIndex_))
	arg_14_0.itemS_[#arg_14_0.itemS_]:Show(true)
	arg_14_0.itemS_[#arg_14_0.itemS_].gameObject_.transform:SetAsLastSibling()
end

function var_0_0.RemoveItemAtEnd(arg_15_0)
	arg_15_0:RecycleItem(#arg_15_0.itemS_)

	arg_15_0.endIndex_ = arg_15_0.endIndex_ - 1
end

function var_0_0.CaculateItemSize(arg_16_0, arg_16_1)
	if arg_16_0.isVertical_ then
		return arg_16_0:CaculateVerticalItemSize(arg_16_1)
	else
		return arg_16_0:CaculateHorizontalItemSize(arg_16_1)
	end
end

function var_0_0.CaculateVerticalItemSize(arg_17_0, arg_17_1)
	local var_17_0 = 0
	local var_17_1 = arg_17_0.itemS_[arg_17_1]

	if arg_17_1 <= 0 or not var_17_1 then
		return var_17_0
	end

	local var_17_2 = var_17_1:GetRectTransform()

	if var_17_2 then
		var_17_0 = var_17_0 + var_17_2.sizeDelta.y + arg_17_0.space_
	end

	return var_17_0
end

function var_0_0.CaculateHorizontalItemSize(arg_18_0, arg_18_1)
	local var_18_0 = 0
	local var_18_1 = arg_18_0.itemS_[arg_18_1]

	if arg_18_1 <= 0 or not var_18_1 then
		return var_18_0
	end

	local var_18_2 = var_18_1:GetRectTransform()

	if var_18_2 then
		var_18_0 = var_18_0 + var_18_2.sizeDelta.x + arg_18_0.space_
	end

	return var_18_0
end

function var_0_0.GetStartIndex(arg_19_0)
	return arg_19_0.startIndex_
end

function var_0_0.GetEndIndex(arg_20_0)
	return arg_20_0.endIndex_
end

function var_0_0.OnDispose(arg_21_0)
	arg_21_0.scrollView_.onUpdateItems = nil
	arg_21_0.dataList_ = nil
	arg_21_0.itemS_ = nil
end

return var_0_0
