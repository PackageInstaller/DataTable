local var_0_0 = class("CryptolaliaScrollRect")
local var_0_1 = 150

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	pg.DelegateInfo.New(arg_1_0)

	arg_1_0.tpl = arg_1_1.gameObject
	arg_1_0.tpls = {
		arg_1_0.tpl
	}
	arg_1_0.startPosition = arg_1_1.localPosition
	arg_1_0.eventTriggerListener = arg_1_1.parent:GetComponent(typeof(EventTriggerListener))
	arg_1_0.animation = arg_1_2
	arg_1_0.items = {}

	return
end

local function var_0_2(arg_2_0)
	if #arg_2_0.tpls > 0 then
		return table.remove(arg_2_0.tpls, 1)
	else
		return Object.Instantiate(arg_2_0.tpl, arg_2_0.tpl.transform.parent)
	end

	return
end

function NewTpl(arg_3_0, arg_3_1)
	return Object.Instantiate(arg_3_1, arg_3_0.tpl.transform.parent)
end

function var_0_0.Make(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.OnItemInit = arg_4_1
	arg_4_0.OnSelect = arg_4_2

	return
end

function var_0_0.Align(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.totalCnt = math.max(5, arg_5_1)
	arg_5_0.midIndex = math.ceil(arg_5_0.totalCnt / 2)

	for iter_5_0 = 1, arg_5_0.totalCnt do
		table.insert({}, function(arg_6_0)
			local var_6_0 = CryptolaliaScrollRectItem.New(var_0_2(arg_5_0), arg_5_0.midIndex, iter_5_0)

			if arg_5_0.OnItemInit then
				arg_5_0.OnItemInit(var_6_0)
			end

			if var_6_0:IsMidIndex() and arg_5_0.OnSelect then
				arg_5_0.OnSelect(var_6_0)
			end

			table.insert(arg_5_0.items, var_6_0)

			if iter_5_0 % 3 == 0 then
				onNextTick(arg_6_0)
			else
				arg_6_0()
			end

			return
		end)
	end

	seriesAsync({}, arg_5_2)

	return
end

function var_0_0.SetUp(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0.items) do
		onButton(arg_7_0, iter_7_1._go, function()
			if arg_7_0.inAnimation then
				return
			end

			arg_7_0:JumpToMid(iter_7_1:GetIndex())

			return
		end, SFX_PANEL)
	end

	arg_7_0:AddDrag()

	return
end

function var_0_0.AddDrag(arg_9_0)
	arg_9_0.eventTriggerListener:AddBeginDragFunc(function(arg_10_0, arg_10_1)
		arg_9_0.position = arg_10_1.position

		return
	end)
	arg_9_0.eventTriggerListener:AddDragEndFunc(function(arg_11_0, arg_11_1)
		if not arg_9_0.position then
			return
		end

		local var_11_0 = arg_11_1.position - arg_9_0.position

		if math.abs((arg_11_1.position - arg_9_0.position).x) > var_0_1 and math.abs(var_11_0.y) > var_0_1 then
			if var_11_0.x >= 0 then
				arg_9_0:OnListUp()
			end

			if var_11_0.x < 0 then
				arg_9_0:OnListDown()
			end
		end

		arg_9_0.position = nil

		return
	end)

	return
end

function var_0_0.OnListUp(arg_12_0)
	arg_12_0:trigger(arg_12_0.midIndex + 1)

	return
end

function var_0_0.OnListDown(arg_13_0)
	arg_13_0:trigger(arg_13_0.midIndex - 1)

	return
end

function var_0_0.trigger(arg_14_0, arg_14_1)
	local var_14_0

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.items) do
		if iter_14_1:GetIndex() == arg_14_1 then
			var_14_0 = iter_14_1

			break
		end
	end

	if var_14_0 and var_14_0:CanInteractable() then
		arg_14_0:JumpToMid(var_14_0:GetIndex())
	end

	return
end

function var_0_0.JumpToMid(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0.midIndex - arg_15_1 <= 0
	local var_15_1 = {}

	for iter_15_0 = 1, math.abs(arg_15_0.midIndex - arg_15_1) do
		table.insert(var_15_1, function(arg_16_0)
			if var_15_0 then
				local var_16_0 = arg_15_0.midIndex + 1 or arg_15_0.midIndex - 1

				if iter_15_0 == var_0 then
					arg_15_0:Step(arg_15_0.midIndex - var_16_0, arg_16_0)
				else
					arg_15_0:Step(arg_15_0.midIndex - var_16_0, onNextTick(arg_16_0))
				end

				return
			end
		end)
	end

	seriesAsync(var_15_1)

	return
end

function var_0_0.Step1(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_0.inAnimation then
		arg_17_0:ClearAnimation()
	end

	local var_17_0 = {}
	local var_17_1

	for iter_17_0, iter_17_1 in ipairs(arg_17_0.items) do
		local var_17_2 = iter_17_1:GetIndex() + arg_17_1

		if var_17_2 > arg_17_0.totalCnt then
			var_17_2 = var_17_2 - arg_17_0.totalCnt
			arg_17_0.sinker = CryptolaliaScrollRectItem.New(NewTpl(arg_17_0, iter_17_1._go), arg_17_0.midIndex, 0)
		elseif var_17_2 <= 0 then
			var_17_2 = arg_17_0.totalCnt - math.abs(var_17_2)
			arg_17_0.sinker = CryptolaliaScrollRectItem.New(NewTpl(arg_17_0, iter_17_1._go), arg_17_0.midIndex, arg_17_0.totalCnt + 1)
		end

		if var_17_2 == arg_17_0.midIndex then
			var_17_1 = iter_17_1
		end

		table.insert(var_17_0, function(arg_18_0)
			iter_17_1:UpdateIndexWithAnim(var_17_2, var_0, arg_18_0)

			return
		end)
	end

	if arg_17_0.sinker then
		table.insert(var_17_0, function(arg_19_0)
			local var_19_0 = arg_17_0.sinker:GetIndex() + arg_17_1

			arg_17_0.sinker:UpdateIndexWithAnim(var_19_0, var_19_0, arg_19_0)

			return
		end)
	end

	table.insert(var_17_0, function(arg_20_0)
		arg_17_0.animation:Play(arg_17_1):OnComplete(arg_20_0):OnTrigger(function()
			if arg_17_0.OnSelect then
				arg_17_0.OnSelect(var_17_1)
			end

			return
		end)

		return
	end)

	arg_17_0.inAnimation = true

	parallelAsync(var_17_0, function()
		arg_17_0:ClearAnimation()
		arg_17_2()

		return
	end)

	return
end

function var_0_0.Step(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_0.inAnimation then
		arg_23_0:ClearAnimation()
	end

	local var_23_0 = {}
	local var_23_1
	local var_23_2 = {}
	local var_23_3

	for iter_23_0, iter_23_1 in ipairs(arg_23_0.items) do
		local var_23_4 = iter_23_1:GetIndex() + arg_23_1

		if var_23_4 > arg_23_0.totalCnt then
			var_23_4 = var_23_4 - arg_23_0.totalCnt
			arg_23_0.sinker = CryptolaliaScrollRectItem.New(NewTpl(arg_23_0, iter_23_1._go), arg_23_0.midIndex, 0)
			var_23_3 = arg_23_0.sinker:GetPosition()
		elseif var_23_4 <= 0 then
			var_23_4 = arg_23_0.totalCnt - math.abs(var_23_4)
			arg_23_0.sinker = CryptolaliaScrollRectItem.New(NewTpl(arg_23_0, iter_23_1._go), arg_23_0.midIndex, arg_23_0.totalCnt + 1)
			var_23_3 = arg_23_0.sinker:GetPosition()
		end

		if var_23_4 == arg_23_0.midIndex then
			var_23_1 = iter_23_1
		end

		iter_23_1:UpdateIndexSilence(var_23_4)
		table.insert(var_23_2, iter_23_1:GetPosition())
	end

	table.insert(var_23_0, function(arg_24_0)
		arg_23_0.animation:Play(arg_23_1):OnComplete(arg_24_0):OnUpdate(function(arg_25_0)
			for iter_25_0, iter_25_1 in ipairs(arg_23_0.items) do
				iter_25_1:SetPosition(var_23_2[iter_25_0] + arg_25_0)
			end

			if arg_23_0.sinker then
				arg_23_0.sinker:SetPosition(var_23_3 + arg_25_0)
			end

			return
		end):OnLastUpdate(function()
			for iter_26_0, iter_26_1 in ipairs(arg_23_0.items) do
				iter_26_1:Refresh()
			end

			return
		end):OnTrigger(function()
			if arg_23_0.OnSelect then
				arg_23_0.OnSelect(var_23_1)
			end

			return
		end)

		return
	end)

	arg_23_0.inAnimation = true

	parallelAsync(var_23_0, function()
		arg_23_0:ClearAnimation()
		arg_23_2()

		return
	end)

	return
end

function var_0_0.ClearAnimation(arg_29_0)
	if arg_29_0.inAnimation then
		arg_29_0.animation:Stop()

		for iter_29_0, iter_29_1 in ipairs(arg_29_0.items) do
			iter_29_1:ClearAnimation()
		end

		if arg_29_0.sinker then
			Object.Destroy(arg_29_0.sinker._go)

			arg_29_0.sinker = nil
		end

		arg_29_0.inAnimation = false
	end

	return
end

function var_0_0.Dispose(arg_30_0)
	for iter_30_0, iter_30_1 in ipairs(arg_30_0.items) do
		iter_30_1:Dispose()
	end

	arg_30_0:ClearAnimation()

	arg_30_0.items = nil
	arg_30_0.OnItemInit = nil
	arg_30_0.OnSelect = nil

	pg.DelegateInfo.Dispose(arg_30_0)
	arg_30_0.eventTriggerListener:AddBeginDragFunc(nil)
	arg_30_0.eventTriggerListener:AddDragEndFunc(nil)

	arg_30_0.eventTriggerListener = nil

	return
end

return var_0_0
