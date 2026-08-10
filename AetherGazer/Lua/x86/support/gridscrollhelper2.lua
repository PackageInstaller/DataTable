local var_0_0 = class("GridScrollHelper2")
local var_0_1 = 2
local var_0_2 = class("Pool")

function var_0_2.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0._parent = arg_1_3
	arg_1_0._template = arg_1_2
	arg_1_0._class = arg_1_1
	arg_1_0._pool = {}
	arg_1_0._tmpList = {}

	for iter_1_0 = 1, arg_1_4 do
		arg_1_0:AddPool()
	end
end

function var_0_2.AddPool(arg_2_0)
	local var_2_0 = Object.Instantiate(arg_2_0._template, arg_2_0._parent.transform)

	arg_2_0._pool[#arg_2_0._pool + 1] = arg_2_0._class.New(var_2_0)
end

function var_0_2.Get(arg_3_0)
	if #arg_3_0._tmpList >= 1 then
		local var_3_0 = arg_3_0._tmpList[#arg_3_0._tmpList]

		arg_3_0._tmpList[#arg_3_0._tmpList] = nil

		return var_3_0
	end

	if #arg_3_0._pool >= 1 then
		local var_3_1 = arg_3_0._pool[#arg_3_0._pool]

		arg_3_0._pool[#arg_3_0._pool] = nil

		SetActive(var_3_1.gameObject_, true)

		return var_3_1
	end

	arg_3_0:AddPool()

	local var_3_2 = arg_3_0._pool[#arg_3_0._pool]

	arg_3_0._pool[#arg_3_0._pool] = nil

	return var_3_2
end

function var_0_2.Release(arg_4_0, arg_4_1)
	if arg_4_1.gameObject_.activeSelf then
		arg_4_0._tmpList[#arg_4_0._tmpList + 1] = arg_4_1

		return
	end

	arg_4_0._pool[#arg_4_0._pool + 1] = arg_4_1
end

function var_0_2.ClearTmp(arg_5_0)
	for iter_5_0 = 1, #arg_5_0._tmpList do
		SetActive(arg_5_0._tmpList[iter_5_0].gameObject_, false)

		arg_5_0._pool[#arg_5_0._pool + 1] = arg_5_0._tmpList[iter_5_0]
	end

	arg_5_0._tmpList = {}
end

function var_0_2.Dispose(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0._pool) do
		Object.Destroy(iter_6_1.gameObject_)
		iter_6_1:Dispose()
	end

	arg_6_0._pool = nil
	arg_6_0._tmpList = nil
	arg_6_0._template = nil
end

function var_0_0.Ctor(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
	arg_7_0.delegateFunc_ = arg_7_1
	arg_7_0.scrollObj_ = arg_7_2
	arg_7_0.scrollRect_ = arg_7_0.scrollObj_:GetComponent("ScrollRectEx")
	arg_7_0.layOut_ = arg_7_3
	arg_7_0.layOutGroup_ = arg_7_3.gameObject:GetComponent("GridLayoutGroup")
	arg_7_0.objectPool_ = var_0_2.New(arg_7_5, arg_7_4, arg_7_3, 0)

	arg_7_0:OnCtor()

	if not arg_7_0.ctored_ then
		ReduxFactory.GetInstance():OnManagedObjCtor(arg_7_0)
	end

	arg_7_0.ctored_ = true
end

function var_0_0.SetPageInfo(arg_8_0, arg_8_1)
	arg_8_0.perPageNum_ = 0
	arg_8_0.viewSize_ = arg_8_0.scrollObj_:GetComponent("RectTransform").rect.size

	if arg_8_0.scrollRect_.vertical then
		local var_8_0 = arg_8_0.layOutGroup_.spacing.y
		local var_8_1 = arg_8_0.layOutGroup_.cellSize.y
		local var_8_2 = arg_8_0.layOutGroup_.padding.top
		local var_8_3 = math.ceil((arg_8_0.viewSize_.y - var_8_2 + var_8_0) / (var_8_1 + var_8_0))

		arg_8_0.perPageNum_ = arg_8_1 * (var_8_3 + var_0_1)
		arg_8_0.lineNum_ = var_8_3
	else
		local var_8_4 = arg_8_0.layOutGroup_.spacing.x
		local var_8_5 = arg_8_0.layOutGroup_.cellSize.x
		local var_8_6 = arg_8_0.layOutGroup_.padding.left
		local var_8_7 = math.ceil((arg_8_0.viewSize_.x - var_8_6 + var_8_4) / (var_8_5 + var_8_4))

		arg_8_0.perPageNum_ = arg_8_1 * (var_8_7 + var_0_1)
		arg_8_0.lineNum_ = var_8_7
	end
end

function var_0_0.ResetPageInfo(arg_9_0)
	local var_9_0 = arg_9_0.layOutGroup_.transform.rect.width + arg_9_0.layOutGroup_.spacing.x
	local var_9_1 = arg_9_0.layOutGroup_.cellSize.x + arg_9_0.layOutGroup_.spacing.x

	arg_9_0.perLineNum_ = math.floor(var_9_0 / var_9_1)

	arg_9_0:SetPageInfo(arg_9_0.perLineNum_)
end

function var_0_0.RightStartIndex(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.maxNum_
	local var_10_1 = arg_10_0.perLineNum_
	local var_10_2 = arg_10_0.lineNum_ + var_0_1
	local var_10_3 = math.ceil(var_10_0 / var_10_1)
	local var_10_4 = math.ceil(arg_10_1 / var_10_1)

	if var_10_3 <= var_10_2 then
		return 1
	end

	if var_10_4 > var_10_3 - var_10_2 and var_10_3 - var_10_2 > 0 then
		return (var_10_3 - var_10_2) * var_10_1 + 1
	end

	return (var_10_4 - 1) * var_10_1 + 1
end

function var_0_0.GetHeadIndex(arg_11_0)
	return arg_11_0.headIndex_
end

function var_0_0.RecycleAllItem(arg_12_0, arg_12_1)
	if arg_12_0.headIndex_ and arg_12_0.tailIndex_ then
		for iter_12_0 = arg_12_0.headIndex_, arg_12_0.tailIndex_ do
			arg_12_0:RecycleItem(iter_12_0, true)
		end
	end
end

function var_0_0.GetPosition(arg_13_0)
	if arg_13_0.scrollRect_.vertical then
		return 1 - arg_13_0.scrollRect_.verticalNormalizedPosition
	else
		return arg_13_0.scrollRect_.horizontalNormalizedPosition
	end
end

function var_0_0.OnCtor(arg_14_0)
	arg_14_0.items_ = {}
	arg_14_0.headIndex_ = 1
	arg_14_0.tailIndex_ = 0
	arg_14_0.perLineNum_ = arg_14_0.layOutGroup_.constraintCount

	arg_14_0:SetPageInfo(arg_14_0.perLineNum_)
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
	if arg_16_0.headIndex_ > arg_16_0.tailIndex_ then
		return
	end

	for iter_16_0 = arg_16_0.headIndex_, arg_16_0.tailIndex_ do
		local var_16_0 = arg_16_0.items_[iter_16_0].gameObject_

		if var_16_0 then
			var_16_0.transform:SetSiblingIndex(iter_16_0 - arg_16_0.headIndex_ + 1)
		end
	end
end

function var_0_0.OnScroll(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.scrollRect_.vertical
	local var_17_1 = var_17_0 and arg_17_1.y or arg_17_1.x

	if var_17_1 < 0 then
		if var_17_0 then
			if arg_17_0.tailIndex_ < arg_17_0.maxNum_ then
				arg_17_0:RecycleOnelineItem(true)
				arg_17_0:GenerateOneLineItem(true)
				arg_17_0.scrollRect_:AddContentPosition(arg_17_0:CaculateOffset(true))
				arg_17_0.objectPool_:ClearTmp()
			end
		elseif arg_17_0.headIndex_ > 1 then
			arg_17_0:RecycleOnelineItem(false)
			arg_17_0:GenerateOneLineItem(false)
			arg_17_0.scrollRect_:AddContentPosition(arg_17_0:CaculateOffset(false))
			arg_17_0.objectPool_:ClearTmp()
		end
	elseif var_17_1 > 1 then
		if var_17_0 then
			if arg_17_0.headIndex_ > 1 then
				arg_17_0:RecycleOnelineItem(false)
				arg_17_0:GenerateOneLineItem(false)
				arg_17_0.scrollRect_:AddContentPosition(arg_17_0:CaculateOffset(false))
				arg_17_0.objectPool_:ClearTmp()
			end
		elseif arg_17_0.tailIndex_ < arg_17_0.maxNum_ then
			arg_17_0:RecycleOnelineItem(true)
			arg_17_0:GenerateOneLineItem(true)
			arg_17_0.scrollRect_:AddContentPosition(arg_17_0:CaculateOffset(true))
			arg_17_0.objectPool_:ClearTmp()
		end
	end

	if arg_17_0.callBackFunc_ then
		arg_17_0.callBackFunc_()
	end
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

function var_0_0.RecycleOnelineItem(arg_19_0, arg_19_1)
	local var_19_0 = 0
	local var_19_1 = 0

	if arg_19_1 then
		var_19_0 = arg_19_0.headIndex_
		var_19_1 = var_19_0 + arg_19_0.perLineNum_ - 1
	else
		var_19_0 = (math.ceil((arg_19_0.tailIndex_ - arg_19_0.headIndex_ + 1) / arg_19_0.perLineNum_) - 1) * arg_19_0.perLineNum_ + arg_19_0.headIndex_
		var_19_1 = arg_19_0.tailIndex_
	end

	for iter_19_0 = var_19_0, var_19_1 do
		if arg_19_0.items_[iter_19_0] then
			arg_19_0:RecycleItem(iter_19_0)
		end
	end

	if arg_19_1 then
		arg_19_0.headIndex_ = arg_19_0.headIndex_ + arg_19_0.perLineNum_
	else
		arg_19_0.tailIndex_ = arg_19_0.tailIndex_ - (var_19_1 - var_19_0 + 1)
	end
end

function var_0_0.GetHeadAndTail(arg_20_0)
	if arg_20_0.headIndex_ > arg_20_0.tailIndex_ then
		return 0, 0
	end

	return arg_20_0.headIndex_, arg_20_0.tailIndex_
end

function var_0_0.GetItemS(arg_21_0)
	local var_21_0 = {}

	if arg_21_0.headIndex_ > arg_21_0.tailIndex_ then
		return var_21_0
	end

	for iter_21_0 = arg_21_0.headIndex_, arg_21_0.tailIndex_ do
		table.insert(var_21_0, arg_21_0.items_[iter_21_0])
	end

	return var_21_0
end

function var_0_0.RecycleItem(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0.items_[arg_22_1]

	if var_22_0 then
		if arg_22_2 then
			SetActive(var_22_0.gameObject_, false)
		end

		arg_22_0.objectPool_:Release(var_22_0)

		arg_22_0.items_[arg_22_1] = nil
	end
end

function var_0_0.RegistScrollCallBack(arg_23_0, arg_23_1)
	arg_23_0.callBackFunc_ = arg_23_1
end

function var_0_0.Dispose(arg_24_0)
	for iter_24_0 = arg_24_0.headIndex_, arg_24_0.tailIndex_ do
		if arg_24_0.items_[iter_24_0] and arg_24_0.items_[iter_24_0].Dispose then
			Object.Destroy(arg_24_0.items_[iter_24_0].gameObject_)
			arg_24_0.items_[iter_24_0]:Dispose()
		end
	end

	arg_24_0.scrollRect_.onValueChanged:RemoveAllListeners()

	arg_24_0.items_ = nil
	arg_24_0.headIndex_ = nil
	arg_24_0.tailIndex_ = nil
	arg_24_0.callBackFunc_ = nil

	arg_24_0.objectPool_:Dispose()
	ReduxFactory.GetInstance():OnManagedObjDisposed(arg_24_0)
end

function var_0_0.GenerateNewItem(arg_25_0, arg_25_1)
	local var_25_0 = (arg_25_1 and arg_25_0.tailIndex_ or arg_25_0.headIndex_) + (arg_25_1 and 1 or -1)

	if var_25_0 < 1 or var_25_0 > arg_25_0.maxNum_ then
		return false
	end

	local var_25_1 = arg_25_0.objectPool_:Get()

	arg_25_0.delegateFunc_(var_25_0, var_25_1)

	if arg_25_1 then
		arg_25_0.tailIndex_ = var_25_0
	else
		arg_25_0.headIndex_ = var_25_0
	end

	arg_25_0.items_[var_25_0] = var_25_1

	arg_25_0:RefreshItemSiblingIndex()

	return var_25_0
end

function var_0_0.StartScroll(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	arg_26_0.maxNum_ = arg_26_1

	arg_26_0.scrollRect_.onValueChanged:RemoveAllListeners()
	arg_26_0.scrollRect_.onValueChanged:AddListener(function(arg_27_0)
		arg_26_0:OnScroll(arg_27_0)
	end)

	if arg_26_0.headIndex_ and arg_26_0.tailIndex_ then
		for iter_26_0 = arg_26_0.headIndex_, arg_26_0.tailIndex_ do
			local var_26_0 = arg_26_0.items_[iter_26_0]

			if var_26_0 then
				arg_26_0.objectPool_:Release(var_26_0)

				arg_26_0.items_[iter_26_0] = nil
			end
		end
	end

	local var_26_1
	local var_26_2 = not arg_26_2 and 1 or arg_26_0:RightStartIndex(arg_26_2)

	arg_26_0.headIndex_ = var_26_2
	arg_26_0.tailIndex_ = var_26_2 - 1

	local var_26_3

	for iter_26_1 = 1, arg_26_0.perPageNum_ do
		local var_26_4 = arg_26_0.tailIndex_ + 1

		if var_26_4 < 1 or var_26_4 > arg_26_0.maxNum_ then
			break
		end

		local var_26_5 = arg_26_0.objectPool_:Get()

		SetActive(var_26_5.gameObject_, true)
		arg_26_0.delegateFunc_(var_26_4, var_26_5)

		local var_26_6 = var_26_5.gameObject_

		arg_26_0.tailIndex_ = var_26_4
		arg_26_0.items_[var_26_4] = var_26_5

		var_26_6.transform:SetSiblingIndex(var_26_4 - arg_26_0.headIndex_ + 1)
	end

	arg_26_0.objectPool_:ClearTmp()

	if not arg_26_3 then
		if arg_26_2 then
			local var_26_7 = math.ceil(arg_26_2 / arg_26_0.perLineNum_)
			local var_26_8 = math.ceil(var_26_2 / arg_26_0.perLineNum_)

			if var_26_7 == var_26_8 then
				arg_26_3 = 0
			elseif var_26_7 - var_26_8 > var_0_1 then
				arg_26_3 = 1
			else
				arg_26_3 = (var_26_7 - var_26_8) / (var_0_1 + 1)
			end
		else
			arg_26_3 = 0 or arg_26_3
		end
	end

	if arg_26_0.scrollRect_.vertical then
		arg_26_0.scrollRect_.verticalNormalizedPosition = 1 - arg_26_3
	else
		arg_26_0.scrollRect_.horizontalNormalizedPosition = arg_26_3
	end
end

return var_0_0
