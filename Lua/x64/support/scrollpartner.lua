local var_0_0 = class("ScrollPartner")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.partner_ = arg_1_2
	arg_1_0.scrollRect_ = arg_1_1:GetComponent("ScrollRectEx")
	arg_1_0.grid_ = arg_1_1.transform:Find("Grid").gameObject
	arg_1_0.rect_ = arg_1_0.grid_.gameObject:GetComponent("RectTransform")
	arg_1_0.partnerRect_ = arg_1_3:GetComponent("RectTransform")
	arg_1_0.gameObject_.transform.localPosition = arg_1_2.transform.localPosition
	arg_1_0.gameObject_:GetComponent("RectTransform").sizeDelta = arg_1_2:GetComponent("RectTransform").sizeDelta
	arg_1_0.helper_ = arg_1_4
	arg_1_0.childCnt_ = arg_1_0.grid_.transform.childCount
	arg_1_0.ceilPos_ = arg_1_5

	arg_1_0:OnCtor()
end

function var_0_0.OnCtor(arg_2_0)
	arg_2_0.children_ = {}

	for iter_2_0 = 1, arg_2_0.childCnt_ do
		local var_2_0 = arg_2_0.grid_.transform:Find("item" .. iter_2_0)

		arg_2_0.children_[iter_2_0] = {
			trs = var_2_0,
			x = var_2_0.localPosition.x
		}

		if iter_2_0 == 1 then
			arg_2_0.startPos_ = -var_2_0.localPosition.y
		end
	end

	local var_2_1 = arg_2_0.partner_:GetComponent("ScrollRectEx")

	arg_2_0.timer_ = FrameTimer.New(function()
		local var_3_0 = var_2_1.normalizedPosition

		arg_2_0:OnScroll(var_3_0)
	end, 1, -1)

	arg_2_0.timer_:Start()
end

function var_0_0.OnScroll(arg_4_0, arg_4_1)
	arg_4_0:SetPage()

	arg_4_0.scrollRect_.normalizedPosition = arg_4_1
end

function var_0_0.SetPage(arg_5_0)
	local var_5_0 = arg_5_0.helper_.headIndex_
	local var_5_1 = arg_5_0.helper_.maxNum_
	local var_5_2 = arg_5_0.helper_.tailIndex_
	local var_5_3 = arg_5_0.helper_.perLineNum_
	local var_5_4 = arg_5_0.helper_.perPageNum_
	local var_5_5 = math.floor(var_5_0 / var_5_3)
	local var_5_6 = arg_5_0.helper_.layOutGroup_.spacing.y
	local var_5_7 = arg_5_0.helper_.layOutGroup_.cellSize.y
	local var_5_8 = (var_5_6 + var_5_7) * var_5_5
	local var_5_9 = math.ceil((var_5_8 - arg_5_0.startPos_) / arg_5_0.ceilPos_) + 1

	if var_5_9 < 1 then
		var_5_9 = 1
	end

	local var_5_10 = arg_5_0.startPos_ + (var_5_9 - 1) * arg_5_0.ceilPos_ - var_5_8

	if var_5_10 < 0 then
		var_5_10 = 0
	end

	local var_5_11 = (var_5_9 - 1) % arg_5_0.childCnt_ + 1
	local var_5_12 = arg_5_0.pageSize_
	local var_5_13 = var_5_4 / var_5_3

	if var_5_1 <= var_5_4 then
		var_5_13 = math.ceil(var_5_1 / var_5_3)
	end

	arg_5_0.pageSize_ = var_5_13 * var_5_7 + (var_5_13 - 1) * var_5_6

	if arg_5_0.pageSize_ ~= var_5_12 then
		arg_5_0.rect_.sizeDelta = Vector2(arg_5_0.rect_.sizeDelta.x, arg_5_0.pageSize_)
	end

	if arg_5_0.head_ == var_5_0 then
		return
	end

	arg_5_0.head_ = var_5_0

	local var_5_14 = var_5_10
	local var_5_15 = 0

	for iter_5_0 = var_5_11, arg_5_0.childCnt_ do
		local var_5_16 = arg_5_0.children_[iter_5_0]
		local var_5_17 = -var_5_15 * arg_5_0.ceilPos_ - var_5_14

		var_5_16.trs.localPosition = Vector3(var_5_16.x, var_5_17, 0)
		var_5_15 = var_5_15 + 1
	end

	for iter_5_1 = 1, var_5_11 - 1 do
		local var_5_18 = arg_5_0.children_[iter_5_1]
		local var_5_19 = -var_5_15 * arg_5_0.ceilPos_ - var_5_14

		var_5_18.trs.localPosition = Vector3(var_5_18.x, var_5_19, 0)
		var_5_15 = var_5_15 + 1
	end
end

function var_0_0.Dispose(arg_6_0)
	if arg_6_0.timer_ then
		arg_6_0.timer_:Stop()

		arg_6_0.timer_ = nil
	end
end

return var_0_0
