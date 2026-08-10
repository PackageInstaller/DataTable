local var_0_0 = class("NewGridScrollHelper")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	arg_1_7 = arg_1_7 or 10
	arg_1_0.handler_ = arg_1_1
	arg_1_0.itemPath_ = arg_1_2
	arg_1_0.pool_ = ObjectPoolItem.New()

	arg_1_0.pool_:InitFromObjectPool(arg_1_6, arg_1_2, arg_1_7)

	arg_1_0.itemClass_ = arg_1_3
	arg_1_0.delegateFunc_ = arg_1_4
	arg_1_0.scrollObj_ = arg_1_5
	arg_1_0.scrollRect_ = arg_1_0.scrollObj_:GetComponent("ScrollRectEx")
	arg_1_0.layOut_ = arg_1_6
	arg_1_0.layOutGroup_ = arg_1_6.gameObject:GetComponent("GridLayoutGroup")

	arg_1_0:OnCtor()

	if not arg_1_0.ctored_ then
		ReduxFactory.GetInstance():OnManagedObjCtor(arg_1_0)
	end

	arg_1_0.ctored_ = true
end

function var_0_0.OnCtor(arg_2_0)
	arg_2_0.items_ = {}
	arg_2_0.itemGos_ = {}
	arg_2_0.headIndex_ = 0
	arg_2_0.tailIndex_ = 0
	arg_2_0.perLineNum_ = arg_2_0.layOutGroup_.constraintCount
	arg_2_0.viewSize_ = arg_2_0.scrollObj_:GetComponent("RectTransform").rect.size
	arg_2_0.perPageNum_ = 0

	if arg_2_0.scrollRect_.vertical then
		local var_2_0 = arg_2_0.layOutGroup_.spacing.y
		local var_2_1 = arg_2_0.layOutGroup_.cellSize.y
		local var_2_2 = arg_2_0.layOutGroup_.padding.top
		local var_2_3 = math.ceil((arg_2_0.viewSize_.y - var_2_2 + var_2_0) / (var_2_1 + var_2_0))

		arg_2_0.perPageNum_ = arg_2_0.perLineNum_ * (var_2_3 + 2)
	else
		local var_2_4 = arg_2_0.layOutGroup_.spacing.x
		local var_2_5 = arg_2_0.layOutGroup_.cellSize.x
		local var_2_6 = arg_2_0.layOutGroup_.padding.left
		local var_2_7 = math.ceil((arg_2_0.viewSize_.x - var_2_6 + var_2_4) / (var_2_5 + var_2_4))

		arg_2_0.perPageNum_ = arg_2_0.perLineNum_ * (var_2_7 + 2)
	end

	arg_2_0.scrollRect_.onValueChanged:AddListener(function(arg_3_0)
		arg_2_0:OnScroll(arg_3_0)
	end)
end

function var_0_0.StartScroll(arg_4_0, arg_4_1)
	arg_4_0.maxNum_ = arg_4_1

	arg_4_0:RecycleAllItem()

	arg_4_0.headIndex_ = 0
	arg_4_0.tailIndex_ = 0

	for iter_4_0 = 1, arg_4_0.perPageNum_ do
		if not arg_4_0:GenerateNewItem(true) then
			break
		end
	end

	if arg_4_0.tailIndex_ > 0 then
		arg_4_0.headIndex_ = 1
	end
end

function var_0_0.RecycleAllItem(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.items_) do
		arg_5_0:RecycleItem(iter_5_0, false)
	end
end

function var_0_0.RecycleItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2 = arg_6_2 or false

	local var_6_0 = arg_6_0.items_[arg_6_1]

	if var_6_0 then
		SetActive(var_6_0.gameObject_, arg_6_2)
		arg_6_0.pool_:Return(var_6_0.gameObject_)

		if var_6_0.Dispose then
			var_6_0:Dispose()
		end

		arg_6_0.items_[arg_6_1] = nil
		arg_6_0.itemGos_[arg_6_1] = nil

		manager.classPool:ReturnClass(var_6_0)
	end
end

function var_0_0.GetItemS(arg_7_0)
	local var_7_0 = {}

	for iter_7_0 = arg_7_0.headIndex_, arg_7_0.tailIndex_ do
		table.insert(var_7_0, arg_7_0.items_[iter_7_0])
	end

	return var_7_0
end

function var_0_0.Dispose(arg_8_0)
	if arg_8_0.pool_ then
		arg_8_0.pool_:Dispose()

		arg_8_0.pool_ = nil
	end

	for iter_8_0 = arg_8_0.headIndex_, arg_8_0.tailIndex_ do
		if arg_8_0.items_[iter_8_0] and arg_8_0.items_[iter_8_0].Dispose then
			arg_8_0.items_[iter_8_0]:Dispose()
		end
	end

	arg_8_0.scrollRect_.onValueChanged:RemoveAllListeners()

	arg_8_0.items_ = nil
	arg_8_0.itemGos = nil
	arg_8_0.headIndex_ = nil
	arg_8_0.tailIndex_ = nil
	arg_8_0.callBackFunc_ = nil

	ReduxFactory.GetInstance():OnManagedObjDisposed(arg_8_0)
end

function var_0_0.RegistScrollCallBack(arg_9_0, arg_9_1)
	arg_9_0.callBackFunc_ = arg_9_1
end

function var_0_0.OnScroll(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.scrollRect_.vertical
	local var_10_1 = var_10_0 and arg_10_1.y or arg_10_1.x

	if var_10_1 < 0 then
		if var_10_0 then
			if arg_10_0.tailIndex_ < arg_10_0.maxNum_ then
				arg_10_0:RecycleOnelineItem(true)
				arg_10_0:GenerateOneLineItem(true)
				arg_10_0.scrollRect_:AddContentPosition(arg_10_0:CaculateOffset(true))
			end
		elseif arg_10_0.headIndex_ > 1 then
			arg_10_0:RecycleOnelineItem(false)
			arg_10_0:GenerateOneLineItem(false)
			arg_10_0.scrollRect_:AddContentPosition(arg_10_0:CaculateOffset(false))
		end
	elseif var_10_1 > 1 then
		if var_10_0 then
			if arg_10_0.headIndex_ > 1 then
				arg_10_0:RecycleOnelineItem(false)
				arg_10_0:GenerateOneLineItem(false)
				arg_10_0.scrollRect_:AddContentPosition(arg_10_0:CaculateOffset(false))
			end
		elseif arg_10_0.tailIndex_ < arg_10_0.maxNum_ then
			arg_10_0:RecycleOnelineItem(true)
			arg_10_0:GenerateOneLineItem(true)
			arg_10_0.scrollRect_:AddContentPosition(arg_10_0:CaculateOffset(true))
		end
	end

	if arg_10_0.callBackFunc_ then
		arg_10_0.callBackFunc_()
	end
end

function var_0_0.CaculateOffset(arg_11_0, arg_11_1)
	if arg_11_0.scrollRect_.vertical then
		local var_11_0 = arg_11_0.layOutGroup_.cellSize.y + arg_11_0.layOutGroup_.spacing.y
		local var_11_1 = 0

		return Vector2(var_11_1, arg_11_1 and -var_11_0 or var_11_0)
	else
		local var_11_2 = 0
		local var_11_3 = arg_11_0.layOutGroup_.cellSize.x + arg_11_0.layOutGroup_.spacing.x

		return Vector2(arg_11_1 and var_11_3 or -var_11_3, var_11_2)
	end
end

function var_0_0.RefreshItemSiblingIndex(arg_12_0)
	for iter_12_0 = arg_12_0.headIndex_, arg_12_0.tailIndex_ do
		local var_12_0 = arg_12_0.items_[iter_12_0].gameObject_

		if var_12_0 then
			var_12_0.transform:SetSiblingIndex(iter_12_0 - arg_12_0.headIndex_)
		end
	end
end

function var_0_0.RecycleOnelineItem(arg_13_0, arg_13_1)
	local var_13_0 = 0
	local var_13_1 = 0

	if arg_13_1 then
		var_13_0 = arg_13_0.headIndex_
		var_13_1 = var_13_0 + arg_13_0.perLineNum_ - 1
	else
		var_13_0 = math.floor((arg_13_0.tailIndex_ - arg_13_0.headIndex_) / arg_13_0.perLineNum_) * arg_13_0.perLineNum_ + arg_13_0.headIndex_
		var_13_1 = arg_13_0.tailIndex_
	end

	for iter_13_0 = var_13_0, var_13_1 do
		if arg_13_0.items_[iter_13_0] then
			arg_13_0:RecycleItem(iter_13_0)
		end
	end

	if arg_13_1 then
		arg_13_0.headIndex_ = arg_13_0.headIndex_ + arg_13_0.perLineNum_
	else
		arg_13_0.tailIndex_ = arg_13_0.tailIndex_ - (var_13_1 - var_13_0 + 1)
	end

	arg_13_0:RefreshItemSiblingIndex()
end

function var_0_0.GenerateOneLineItem(arg_14_0, arg_14_1)
	local var_14_0 = 0

	for iter_14_0 = 1, arg_14_0.perLineNum_ do
		if arg_14_0:GenerateNewItem(arg_14_1) then
			var_14_0 = var_14_0 + 1
		end
	end

	return var_14_0 > 0
end

function var_0_0.GenerateNewItem(arg_15_0, arg_15_1)
	local var_15_0 = (arg_15_1 and arg_15_0.tailIndex_ or arg_15_0.headIndex_) + (arg_15_1 and 1 or -1)

	if var_15_0 < 1 then
		return false
	end

	if var_15_0 <= arg_15_0.maxNum_ then
		local var_15_1 = arg_15_0.pool_:Get()

		SetActive(var_15_1, true)

		local var_15_2 = manager.classPool:GetOrCreateClass(arg_15_0.itemClass_, arg_15_0.handler_, var_15_1)

		var_15_1.name = "item" .. var_15_0

		local var_15_3 = arg_15_0.delegateFunc_(var_15_0, var_15_1, var_15_2)

		if var_15_3 then
			local var_15_4 = var_15_1

			if arg_15_1 then
				arg_15_0.tailIndex_ = var_15_0
			else
				arg_15_0.headIndex_ = var_15_0
			end

			arg_15_0.items_[var_15_0] = var_15_3
			arg_15_0.itemGos_[var_15_0] = var_15_1

			var_15_4.transform:SetSiblingIndex(var_15_0 - arg_15_0.headIndex_)

			return var_15_0
		end
	end

	return false
end

function var_0_0.RefreshList(arg_16_0)
	for iter_16_0 = arg_16_0.headIndex_, arg_16_0.tailIndex_ do
		arg_16_0.delegateFunc_(iter_16_0, arg_16_0.items_[iter_16_0].gameObject_, arg_16_0.items_[iter_16_0])
	end
end

return var_0_0
