local var_0_0 = class("GridScrollHelper")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.delegateFunc_ = arg_1_1
	arg_1_0.scrollObj_ = arg_1_2
	arg_1_0.scrollRect_ = arg_1_0.scrollObj_:GetComponent("ScrollRectEx")
	arg_1_0.layOut_ = arg_1_3
	arg_1_0.layOutGroup_ = arg_1_3.gameObject:GetComponent("GridLayoutGroup")

	arg_1_0:OnCtor()

	if not arg_1_0.ctored_ then
		ReduxFactory.GetInstance():OnManagedObjCtor(arg_1_0)
	end

	arg_1_0.ctored_ = true
end

function var_0_0.OnCtor(arg_2_0)
	arg_2_0.items_ = {}
	arg_2_0.headIndex_ = 0
	arg_2_0.tailIndex_ = 0
	arg_2_0.perLineNum_ = arg_2_0.layOutGroup_.constraintCount

	arg_2_0:SetPageInfo(arg_2_0.perLineNum_)
	arg_2_0.scrollRect_.onValueChanged:AddListener(function(arg_3_0)
		arg_2_0:OnScroll(arg_3_0)
	end)
end

function var_0_0.SetPageInfo(arg_4_0, arg_4_1)
	arg_4_0.perPageNum_ = 0
	arg_4_0.viewSize_ = arg_4_0.scrollObj_:GetComponent("RectTransform").rect.size

	if arg_4_0.scrollRect_.vertical then
		local var_4_0 = arg_4_0.layOutGroup_.spacing.y
		local var_4_1 = arg_4_0.layOutGroup_.cellSize.y
		local var_4_2 = arg_4_0.layOutGroup_.padding.top
		local var_4_3 = math.ceil((arg_4_0.viewSize_.y - var_4_2 + var_4_0) / (var_4_1 + var_4_0))

		arg_4_0.lineNum_ = var_4_3
		arg_4_0.perPageNum_ = arg_4_1 * (var_4_3 + 2)
	else
		local var_4_4 = arg_4_0.layOutGroup_.spacing.x
		local var_4_5 = arg_4_0.layOutGroup_.cellSize.x
		local var_4_6 = arg_4_0.layOutGroup_.padding.left
		local var_4_7 = math.ceil((arg_4_0.viewSize_.x - var_4_6 + var_4_4) / (var_4_5 + var_4_4))

		arg_4_0.lineNum_ = var_4_7
		arg_4_0.perPageNum_ = arg_4_1 * (var_4_7 + 2)
	end
end

function var_0_0.ResetPageInfo(arg_5_0)
	local var_5_0 = arg_5_0.layOutGroup_.transform.rect.width + arg_5_0.layOutGroup_.spacing.x
	local var_5_1 = arg_5_0.layOutGroup_.cellSize.x + arg_5_0.layOutGroup_.spacing.x

	arg_5_0.perLineNum_ = math.floor(var_5_0 / var_5_1)

	arg_5_0:SetPageInfo(arg_5_0.perLineNum_)
end

function var_0_0.StartScroll(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.maxNum_ = arg_6_1

	arg_6_0:RecycleAllItem(arg_6_1)

	arg_6_2 = not arg_6_2 and 0 or arg_6_2 - 1
	arg_6_3 = arg_6_3 or 0
	arg_6_0.headIndex_ = arg_6_2
	arg_6_0.tailIndex_ = arg_6_2

	for iter_6_0 = 1, arg_6_0.perPageNum_ do
		if not arg_6_0:GenerateNewItem(true) then
			break
		end
	end

	if arg_6_0.scrollRect_.vertical then
		arg_6_0.scrollRect_.verticalNormalizedPosition = 1 - arg_6_3
	else
		arg_6_0.scrollRect_.horizontalNormalizedPosition = arg_6_3
	end

	if arg_6_0.tailIndex_ > 0 then
		arg_6_0.headIndex_ = arg_6_0.headIndex_ + 1
	end
end

function var_0_0.GetHeadIndex(arg_7_0)
	return arg_7_0.headIndex_
end

function var_0_0.GetPosition(arg_8_0)
	if arg_8_0.scrollRect_.vertical then
		return 1 - arg_8_0.scrollRect_.verticalNormalizedPosition
	else
		return arg_8_0.scrollRect_.horizontalNormalizedPosition
	end
end

function var_0_0.RecycleAllItem(arg_9_0, arg_9_1)
	if arg_9_0.headIndex_ and arg_9_0.tailIndex_ then
		for iter_9_0 = arg_9_0.headIndex_, arg_9_0.tailIndex_ do
			arg_9_0:RecycleItem(iter_9_0, false)
		end
	end
end

function var_0_0.RecycleItem(arg_10_0, arg_10_1, arg_10_2)
	arg_10_2 = arg_10_2 or false

	local var_10_0 = arg_10_0.items_[arg_10_1]

	if var_10_0 then
		SetActive(var_10_0.gameObject_, arg_10_2)

		if var_10_0.pools and var_10_0.recycleIndex then
			var_10_0.pools:FinishIndex(var_10_0.recycleIndex)
		end

		if var_10_0.Dispose then
			var_10_0:Dispose()
		else
			manager.classPool:ReturnClass(var_10_0)
		end

		arg_10_0.items_[arg_10_1] = nil
	end
end

function var_0_0.GetItemS(arg_11_0)
	local var_11_0 = {}

	for iter_11_0 = arg_11_0.headIndex_, arg_11_0.tailIndex_ do
		table.insert(var_11_0, arg_11_0.items_[iter_11_0])
	end

	return var_11_0
end

function var_0_0.Dispose(arg_12_0)
	for iter_12_0 = arg_12_0.headIndex_, arg_12_0.tailIndex_ do
		if arg_12_0.items_[iter_12_0] and arg_12_0.items_[iter_12_0].Dispose then
			arg_12_0.items_[iter_12_0]:Dispose()
		end
	end

	arg_12_0.scrollRect_.onValueChanged:RemoveAllListeners()

	arg_12_0.items_ = nil
	arg_12_0.headIndex_ = nil
	arg_12_0.tailIndex_ = nil
	arg_12_0.callBackFunc_ = nil

	ReduxFactory.GetInstance():OnManagedObjDisposed(arg_12_0)
end

function var_0_0.RegistScrollCallBack(arg_13_0, arg_13_1)
	arg_13_0.callBackFunc_ = arg_13_1
end

function var_0_0.OnScroll(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.scrollRect_.vertical
	local var_14_1 = var_14_0 and arg_14_1.y or arg_14_1.x

	if var_14_1 < 0 then
		if var_14_0 then
			if arg_14_0.tailIndex_ < arg_14_0.maxNum_ then
				arg_14_0:RecycleOnelineItem(true)
				arg_14_0:GenerateOneLineItem(true)
				arg_14_0.scrollRect_:AddContentPosition(arg_14_0:CaculateOffset(true))
			end
		elseif arg_14_0.headIndex_ > 1 then
			arg_14_0:RecycleOnelineItem(false)
			arg_14_0:GenerateOneLineItem(false)
			arg_14_0.scrollRect_:AddContentPosition(arg_14_0:CaculateOffset(false))
		end
	elseif var_14_1 > 1 then
		if var_14_0 then
			if arg_14_0.headIndex_ > 1 then
				arg_14_0:RecycleOnelineItem(false)
				arg_14_0:GenerateOneLineItem(false)
				arg_14_0.scrollRect_:AddContentPosition(arg_14_0:CaculateOffset(false))
			end
		elseif arg_14_0.tailIndex_ < arg_14_0.maxNum_ then
			arg_14_0:RecycleOnelineItem(true)
			arg_14_0:GenerateOneLineItem(true)
			arg_14_0.scrollRect_:AddContentPosition(arg_14_0:CaculateOffset(true))
		end
	end

	if arg_14_0.callBackFunc_ then
		arg_14_0.callBackFunc_()
	end
end

function var_0_0.CaculateOffset(arg_15_0, arg_15_1)
	if arg_15_0.scrollRect_.vertical then
		local var_15_0 = arg_15_0.layOutGroup_.cellSize.y + arg_15_0.layOutGroup_.spacing.y
		local var_15_1 = 0

		return Vector2(var_15_1, arg_15_1 and -var_15_0 or var_15_0)
	else
		local var_15_2 = 0
		local var_15_3 = arg_15_0.layOutGroup_.cellSize.x + arg_15_0.layOutGroup_.spacing.x

		return Vector2(arg_15_1 and var_15_3 or -var_15_3, var_15_2)
	end
end

function var_0_0.RefreshItemSiblingIndex(arg_16_0)
	for iter_16_0 = arg_16_0.headIndex_, arg_16_0.tailIndex_ do
		local var_16_0 = arg_16_0.items_[iter_16_0].gameObject_

		if var_16_0 then
			var_16_0.transform:SetSiblingIndex(iter_16_0 - arg_16_0.headIndex_)
		end
	end
end

function var_0_0.RecycleOnelineItem(arg_17_0, arg_17_1)
	local var_17_0 = 0
	local var_17_1 = 0

	if arg_17_1 then
		var_17_0 = arg_17_0.headIndex_
		var_17_1 = var_17_0 + arg_17_0.perLineNum_ - 1
	else
		var_17_0 = math.floor((arg_17_0.tailIndex_ - arg_17_0.headIndex_) / arg_17_0.perLineNum_) * arg_17_0.perLineNum_ + arg_17_0.headIndex_
		var_17_1 = arg_17_0.tailIndex_
	end

	for iter_17_0 = var_17_0, var_17_1 do
		if arg_17_0.items_[iter_17_0] then
			arg_17_0:RecycleItem(iter_17_0)
		end
	end

	if arg_17_1 then
		arg_17_0.headIndex_ = arg_17_0.headIndex_ + arg_17_0.perLineNum_
	else
		arg_17_0.tailIndex_ = arg_17_0.tailIndex_ - (var_17_1 - var_17_0 + 1)
	end

	arg_17_0:RefreshItemSiblingIndex()
end

function var_0_0.GenerateOneLineItem(arg_18_0, arg_18_1)
	local var_18_0 = 0

	for iter_18_0 = 1, arg_18_0.perLineNum_ do
		if arg_18_0:GenerateNewItem(arg_18_1) then
			var_18_0 = var_18_0 + 1
		end
	end

	return var_18_0 > 0
end

function var_0_0.GenerateNewItem(arg_19_0, arg_19_1)
	local var_19_0 = (arg_19_1 and arg_19_0.tailIndex_ or arg_19_0.headIndex_) + (arg_19_1 and 1 or -1)

	if var_19_0 < 1 then
		return false
	end

	local var_19_1 = arg_19_0.delegateFunc_(var_19_0)

	if var_19_1 then
		local var_19_2 = var_19_1.gameObject_

		if arg_19_1 then
			arg_19_0.tailIndex_ = var_19_0
		else
			arg_19_0.headIndex_ = var_19_0
		end

		arg_19_0.items_[var_19_0] = var_19_1

		var_19_2.transform:SetSiblingIndex(var_19_0 - arg_19_0.headIndex_)

		return var_19_0
	end

	return false
end

return var_0_0
