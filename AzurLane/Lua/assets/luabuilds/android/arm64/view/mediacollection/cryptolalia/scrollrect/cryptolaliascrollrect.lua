class = var_0_10000

local var_0_0 = var_0_10000("CryptolaliaScrollRect")
local var_0_1 = 150

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	pg = var_1_10003

	var_1_10003.DelegateInfo.New(arg_1_0)

	arg_1_0.tpl = arg_1_1.gameObject
	arg_1_0.tpls = {
		arg_1_0.tpl
	}
	arg_1_0.startPosition = arg_1_1.localPosition

	local var_1_0 = arg_1_1.parent
	local var_1_1 = var_3.GetComponent

	typeof = var_1_10006
	EventTriggerListener = var_1_10008
	arg_1_0.eventTriggerListener = var_1_1(var_1_0, var_1_10006(var_1_10008))
	arg_1_0.animation = arg_1_2
	arg_1_0.items = {}

	return
end

local function var_0_2(arg_2_0)
	if #arg_2_0.tpls > 0 then
		table = var_1

		return var_1.remove(arg_2_0.tpls, 1)
	else
		Object = var_1

		return var_1.Instantiate(arg_2_0.tpl, arg_2_0.tpl.transform.parent)
	end

	return
end

local function var_0_3(arg_3_0, arg_3_1)
	Object = var_1_10002

	return var_1_10002.Instantiate(arg_3_1, arg_3_0.tpl.transform.parent)
end

local var_0_4 = NewTpl

function var_0_0.Make(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.OnItemInit = arg_4_1
	arg_4_0.OnSelect = arg_4_2

	return
end

function var_0_0.Align(arg_5_0, arg_5_1, arg_5_2)
	math = var_1_10003
	arg_5_0.totalCnt = var_1_10003.max(5, arg_5_1)
	math = var_3
	arg_5_0.midIndex = var_3.ceil(arg_5_0.totalCnt / 2)

	local var_5_0 = {}

	for iter_5_0 = 1, arg_5_0.totalCnt do
		table = var_1_10008

		var_1_10008.insert(var_5_0, function(arg_6_0)
			CryptolaliaScrollRectItem = var_2_10001

			local var_6_0 = var_2_10001.New(var_0_2(arg_5_0), arg_5_0.midIndex, iter_5_0)

			if arg_5_0.OnItemInit then
				arg_5_0.OnItemInit(var_6_0)
			end

			if var_6_0:IsMidIndex() and arg_5_0.OnSelect then
				arg_5_0.OnSelect(var_6_0)
			end

			table = var_2

			var_2.insert(arg_5_0.items, var_6_0)

			if iter_5_0 % 3 == 0 then
				onNextTick = var_2

				var_2(arg_6_0)
			else
				arg_6_0()
			end

			return
		end)
	end

	seriesAsync = var_4

	var_4(var_5_0, arg_5_2)

	return
end

function var_0_0.SetUp(arg_7_0)
	ipairs = var_1_10001

	for iter_7_0, iter_7_1 in var_1_10001(arg_7_0.items) do
		onButton = var_1_10006

		local var_7_0 = arg_7_0
		local var_7_1 = iter_7_1._go

		local function var_7_2()
			if arg_7_0.inAnimation then
				return
			end

			local var_8_0 = arg_7_0
			local var_8_1 = var_0.JumpToMid
			local var_8_2 = iter_7_1

			var_8_1(var_8_0, var_3.GetIndex(var_8_2))

			return
		end

		SFX_PANEL = var_1_10011

		var_1_10006(var_7_0, var_7_1, var_7_2, var_1_10011)
	end

	arg_7_0:AddDrag()

	return
end

function var_0_0.AddDrag(arg_9_0)
	local var_9_0 = arg_9_0.eventTriggerListener

	var_1.AddBeginDragFunc(var_9_0, function(arg_10_0, arg_10_1)
		arg_9_0.position = arg_10_1.position

		return
	end)

	local var_9_1 = arg_9_0.eventTriggerListener

	var_1.AddDragEndFunc(var_9_1, function(arg_11_0, arg_11_1)
		if not arg_9_0.position then
			return
		end

		local var_11_0 = arg_11_1.position - arg_9_0.position

		math = var_2_10004

		if var_2_10004.abs(var_11_0.x) > var_0_1 then
			math = var_4

			if var_4.abs(var_11_0.y) > var_0_1 then
				if var_11_0.x >= 0 then
					local var_11_1 = arg_9_0

					var_4.OnListUp(var_11_1)
				end

				if var_11_0.x < 0 then
					local var_11_2 = arg_9_0

					var_4.OnListDown(var_11_2)
				end
			end
		end

		arg_9_0.position = nil

		return
	end)

	return
end

function var_0_0.OnListUp(arg_12_0)
	local var_12_0 = arg_12_0.midIndex + 1

	arg_12_0:trigger(var_12_0)

	return
end

function var_0_0.OnListDown(arg_13_0)
	local var_13_0 = arg_13_0.midIndex - 1

	arg_13_0:trigger(var_13_0)

	return
end

function var_0_0.trigger(arg_14_0, arg_14_1)
	local var_14_0

	ipairs = var_1_10003

	for iter_14_0, iter_14_1 in var_1_10003(arg_14_0.items) do
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
	math = var_1_10002

	local var_15_0 = var_1_10002.abs(arg_15_0.midIndex - arg_15_1)
	local var_15_1 = arg_15_0.midIndex - arg_15_1 <= 0
	local var_15_2 = {}

	for iter_15_0 = 1, var_15_0 do
		table = var_1_10009

		var_1_10009.insert(var_15_2, function(arg_16_0)
			local var_16_0

			if not var_15_1 or not (arg_15_0.midIndex + 1) then
				var_16_0 = arg_15_0.midIndex - 1
			end

			if iter_15_0 == var_15_0 then
				local var_16_1 = arg_15_0

				var_2.Step(var_16_1, arg_15_0.midIndex - var_16_0, arg_16_0)
			else
				local var_16_2 = arg_15_0
				local var_16_3 = var_2.Step
				local var_16_4 = arg_15_0.midIndex - var_16_0

				onNextTick = var_2_10006

				var_16_3(var_16_2, var_16_4, var_2_10006(arg_16_0))
			end

			return
		end)
	end

	seriesAsync = var_5

	var_5(var_15_2)

	return
end

function var_0_0.Step1(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_0.inAnimation then
		var_1_10005 = arg_17_0

		arg_17_0.ClearAnimation(var_1_10005)
	end

	local var_17_0 = {}
	local var_17_1

	ipairs = var_1_10005

	for iter_17_0, iter_17_1 in var_1_10005(arg_17_0.items) do
		local var_17_2

		if iter_17_1:GetIndex() + arg_17_1 > arg_17_0.totalCnt then
			var_17_2 = var_17_2 - arg_17_0.totalCnt
			CryptolaliaScrollRectItem = var_12

			local var_17_3 = var_12.New

			NewTpl = var_1_10014
			arg_17_0.sinker = var_17_3(var_1_10014(arg_17_0, iter_17_1._go), arg_17_0.midIndex, 0)
		elseif var_17_2 <= 0 then
			local var_17_4 = arg_17_0.totalCnt

			math = var_1_10013
			var_17_2 = var_17_4 - var_1_10013.abs(var_17_2)
			CryptolaliaScrollRectItem = var_17_4

			local var_17_5 = var_17_4.New

			NewTpl = var_1_10014
			arg_17_0.sinker = var_17_5(var_1_10014(arg_17_0, iter_17_1._go), arg_17_0.midIndex, arg_17_0.totalCnt + 1)
		end

		if var_17_2 == arg_17_0.midIndex then
			var_17_1 = iter_17_1
		end

		table = var_12

		var_12.insert(var_17_0, function(arg_18_0)
			local var_18_0 = iter_17_1

			var_1.UpdateIndexWithAnim(var_18_0, var_17_2, var_0, arg_18_0)

			return
		end)
	end

	if arg_17_0.sinker then
		table = var_5

		var_5.insert(var_17_0, function(arg_19_0)
			local var_19_0 = arg_17_0.sinker
			local var_19_1 = var_1.GetIndex(var_19_0) + arg_17_1
			local var_19_2 = arg_17_0.sinker

			var_2.UpdateIndexWithAnim(var_19_2, var_19_1, var_19_1, arg_19_0)

			return
		end)
	end

	table = var_5

	var_5.insert(var_17_0, function(arg_20_0)
		local var_20_0 = arg_17_0.animation
		local var_20_1 = var_1.Play(var_20_0, arg_17_1)
		local var_20_2 = var_1.OnComplete(var_20_1, arg_20_0)

		var_1.OnTrigger(var_20_2, function()
			if arg_17_0.OnSelect then
				arg_17_0.OnSelect(var_17_1)
			end

			return
		end)

		return
	end)

	arg_17_0.inAnimation = true
	parallelAsync = var_5

	var_5(var_17_0, function()
		local var_22_0 = arg_17_0

		var_0.ClearAnimation(var_22_0)
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

	ipairs = var_1_10007

	for iter_23_0, iter_23_1 in var_1_10007(arg_23_0.items) do
		local var_23_4

		if iter_23_1:GetIndex() + arg_23_1 > arg_23_0.totalCnt then
			var_23_4 = var_23_4 - arg_23_0.totalCnt
			CryptolaliaScrollRectItem = var_14

			local var_23_5 = var_14.New

			NewTpl = var_1_10016
			arg_23_0.sinker = var_23_5(var_1_10016(arg_23_0, iter_23_1._go), arg_23_0.midIndex, 0)
			var_1_10016 = arg_23_0.sinker
			var_23_3 = var_14.GetPosition(var_1_10016)
		elseif var_23_4 <= 0 then
			local var_23_6 = arg_23_0.totalCnt

			math = var_1_10015
			var_23_4 = var_23_6 - var_1_10015.abs(var_23_4)
			CryptolaliaScrollRectItem = var_23_6

			local var_23_7 = var_23_6.New

			NewTpl = var_1_10016
			arg_23_0.sinker = var_23_7(var_1_10016(arg_23_0, iter_23_1._go), arg_23_0.midIndex, arg_23_0.totalCnt + 1)
			var_1_10016 = arg_23_0.sinker
			var_23_3 = var_14.GetPosition(var_1_10016)
		end

		if var_23_4 == arg_23_0.midIndex then
			var_23_1 = iter_23_1
		end

		var_1_10016 = iter_23_1

		iter_23_1.UpdateIndexSilence(var_1_10016, var_23_4)

		table = var_14

		var_14.insert(var_23_2, iter_23_1:GetPosition())
	end

	table = var_7

	var_7.insert(var_23_0, function(arg_24_0)
		local var_24_0 = arg_23_0.animation
		local var_24_1 = var_1.Play(var_24_0, arg_23_1)
		local var_24_2 = var_1.OnComplete(var_24_1, arg_24_0)
		local var_24_3 = var_1.OnUpdate(var_24_2, function(arg_25_0)
			ipairs = var_3_10001

			for iter_25_0, iter_25_1 in var_3_10001(arg_23_0.items) do
				iter_25_1:SetPosition(var_23_2[iter_25_0] + arg_25_0)
			end

			if arg_23_0.sinker then
				local var_25_0 = arg_23_0.sinker

				var_1.SetPosition(var_25_0, var_23_3 + arg_25_0)
			end

			return
		end)
		local var_24_4 = var_1.OnLastUpdate(var_24_3, function()
			ipairs = var_3_10000

			for iter_26_0, iter_26_1 in var_3_10000(arg_23_0.items) do
				iter_26_1:Refresh()
			end

			return
		end)

		var_1.OnTrigger(var_24_4, function()
			if arg_23_0.OnSelect then
				arg_23_0.OnSelect(var_23_1)
			end

			return
		end)

		return
	end)

	arg_23_0.inAnimation = true
	parallelAsync = var_7

	var_7(var_23_0, function()
		local var_28_0 = arg_23_0

		var_0.ClearAnimation(var_28_0)
		arg_23_2()

		return
	end)

	return
end

function var_0_0.ClearAnimation(arg_29_0)
	if arg_29_0.inAnimation then
		local var_29_0 = arg_29_0.animation

		var_1.Stop(var_29_0)

		ipairs = var_1

		for iter_29_0, iter_29_1 in var_1(arg_29_0.items) do
			iter_29_1:ClearAnimation()
		end

		if arg_29_0.sinker then
			Object = var_1

			var_1.Destroy(arg_29_0.sinker._go)

			arg_29_0.sinker = nil
		end

		arg_29_0.inAnimation = false
	end

	return
end

function var_0_0.Dispose(arg_30_0)
	ipairs = var_1_10001

	for iter_30_0, iter_30_1 in var_1_10001(arg_30_0.items) do
		iter_30_1:Dispose()
	end

	arg_30_0:ClearAnimation()

	arg_30_0.items = nil
	arg_30_0.OnItemInit = nil
	arg_30_0.OnSelect = nil
	pg = var_1

	var_1.DelegateInfo.Dispose(arg_30_0)

	local var_30_0 = arg_30_0.eventTriggerListener

	var_1.AddBeginDragFunc(var_30_0, nil)

	local var_30_1 = arg_30_0.eventTriggerListener

	var_1.AddDragEndFunc(var_30_1, nil)

	arg_30_0.eventTriggerListener = nil

	return
end

return var_0_0
