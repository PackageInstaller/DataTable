class = var_0_10000

local var_0_0 = var_0_10000("RollingCircleRect")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	pg = var_1_10003

	var_1_10003.DelegateInfo.New(arg_1_0)

	arg_1_0.childs = {}
	arg_1_0.tpl = arg_1_1
	arg_1_0.parent = arg_1_2

	arg_1_0:AddDragListener()

	return
end

function var_0_0.SetCallback(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.binder = arg_2_1
	arg_2_0.OnSelected = arg_2_2
	arg_2_0.OnRelease = arg_2_3

	return
end

function var_0_0.AddItem(arg_3_0, arg_3_1)
	local var_3_0
	local var_3_2

	if #arg_3_0.childs <= 0 then
		RollingCircleItem = var_3_2

		local var_3_1 = var_3_2.New(arg_3_0.tpl, var_3 + 1, arg_3_1)

		var_3_0.Init(var_3_1)
	else
		Object = var_3_2
		var_3_2 = var_3_2.Instantiate(arg_3_0.tpl, arg_3_0.tpl.parent)
		RollingCircleItem = var_5
		var_3_0 = var_5.New(var_3_2, var_3 + 1, arg_3_1)

		local var_3_3 = arg_3_0.childs[#arg_3_0.childs]
		local var_3_4 = arg_3_0.childs[1]

		var_1_10008 = var_3_0

		var_3_0.SetPrev(var_1_10008, var_3_3)

		var_1_10008 = var_3_0

		var_3_0.SetNext(var_1_10008, var_3_4)

		var_1_10008 = var_3_4

		var_3_4.SetPrev(var_1_10008, var_3_0)

		var_1_10008 = var_3_3

		var_3_3.SetNext(var_1_10008, var_3_0)

		var_1_10008 = var_3_0

		var_3_0.Init(var_1_10008)
	end

	table = var_3_2

	var_3_2.insert(arg_3_0.childs, var_3_0)

	onButton = var_4

	local var_3_5 = arg_3_0
	local var_3_6 = var_3_0._tr

	local function var_3_7()
		local var_4_0 = arg_3_0

		var_0.ScrollToCenter(var_4_0, var_3_0)

		if arg_3_0.OnRelease then
			arg_3_0.OnRelease(arg_3_0.binder, var_3_0)
		end

		return
	end

	SFX_PANEL = var_1_10008

	var_4(var_3_5, var_3_6, var_3_7, var_1_10008)

	return var_3_0
end

function var_0_0.ScrollTo(arg_5_0, arg_5_1)
	Canvas = var_1_10002

	var_1_10002.ForceUpdateCanvases()

	_ = var_2

	if var_2.detect(arg_5_0.childs, function(arg_6_0)
		return arg_6_0:GetID() == arg_5_1
	end) then
		triggerButton = var_3

		var_3(var_2._tr)
	end

	return
end

function var_0_0.AddDragListener(arg_7_0)
	local function var_7_0(arg_8_0)
		local var_8_0 = arg_8_0 > 0 and -1 or 1
		local var_8_1 = arg_7_0

		var_2.Step(var_8_1, var_8_0)

		return
	end

	local function var_7_1()
		_ = var_2_10000

		local var_9_0 = var_2_10000.detect(arg_7_0.childs, function(arg_10_0)
			local var_10_0 = arg_10_0
			local var_10_1 = arg_10_0.IsCenter
			local var_10_2 = arg_7_0

			return var_10_1(var_10_0, var_3.GetCenterIndex(var_10_2))
		end)

		if arg_7_0.OnRelease then
			arg_7_0.OnRelease(arg_7_0.binder, var_9_0)
		end

		return
	end

	var_0_0.AddVerticalDrag(arg_7_0.parent, var_7_0, var_7_1)

	return
end

function var_0_0.GetCenterIndex(arg_11_0)
	local var_11_0 = #arg_11_0.childs

	math = var_1_10002

	local var_11_1 = var_1_10002.ceil(var_11_0 / 2)

	math = var_3

	return var_3.min(4, var_11_1)
end

function var_0_0.ScrollToCenter(arg_12_0, arg_12_1)
	if arg_12_0:GetCenterIndex() - arg_12_1:GetIndex() == 0 then
		return
	end

	arg_12_0:Step(var_4)

	return
end

function var_0_0.Step(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1 > 0 and "GoForward" or "GoBack"

	math = var_1_10003

	local var_13_1 = var_1_10003.abs(arg_13_1)
	local var_13_2 = arg_13_0:GetCenterIndex()

	for iter_13_0 = 1, var_13_1 do
		ipairs = var_1_10009

		for iter_13_1, iter_13_2 in var_1_10009(arg_13_0.childs) do
			iter_13_2:Record()
		end

		var_1_10009 = nil
		ipairs = var_10

		for iter_13_3, iter_13_4 in var_10(arg_13_0.childs) do
			iter_13_4[var_13_0](iter_13_4)

			if iter_13_4:IsCenter(var_13_2) then
				var_1_10009 = iter_13_4
			end
		end

		if arg_13_0.OnSelected then
			arg_13_0.OnSelected(arg_13_0.binder, var_1_10009)
		end
	end

	return
end

function var_0_0.AddVerticalDrag(arg_14_0, arg_14_1, arg_14_2)
	GetOrAddComponent = var_1_10003

	local var_14_0 = var_1_10003(arg_14_0, "EventTriggerListener")
	local var_14_1 = 90
	local var_14_2
	local var_14_3 = 0
	local var_14_4 = 0
	local var_14_5 = 0

	var_14_0:AddBeginDragFunc(function(arg_15_0, arg_15_1)
		var_14_3 = 0
		var_14_4 = 0
		var_14_2 = arg_15_1.position
		var_14_5 = var_14_2.y

		return
	end)
	var_14_0:AddDragFunc(function(arg_16_0, arg_16_1)
		if var_14_5 > arg_16_1.position.y and var_14_4 ~= 0 then
			var_14_2 = arg_16_1.position
			var_14_4 = 0
		elseif var_14_5 < arg_16_1.position.y and var_14_3 ~= 0 then
			var_14_2 = arg_16_1.position
			var_14_3 = 0
		end

		local var_16_0 = arg_16_1.position.y - var_14_2.y

		math = var_3

		local var_16_1 = var_3.abs

		math = var_2_10004

		local var_16_2 = var_16_1(var_2_10004.floor(var_16_0 / var_14_1))

		if arg_14_1 and var_16_2 > var_14_3 then
			var_14_3 = var_16_2

			arg_14_1(var_16_0)
		end

		if arg_14_1 and var_16_2 < var_14_4 then
			var_14_4 = var_16_2

			arg_14_1(var_16_0)
		end

		var_14_5 = var_14_2.y

		return
	end)
	var_14_0:AddDragEndFunc(function(arg_17_0, arg_17_1)
		if arg_14_2 then
			arg_14_2()
		end

		return
	end)

	return
end

function var_0_0.Dispose(arg_18_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_18_0)

	ipairs = var_1

	for iter_18_0, iter_18_1 in var_1(arg_18_0.childs) do
		iter_18_1:Dispose()
	end

	ClearEventTrigger = var_1
	GetOrAddComponent = var_2

	var_1(var_2(arg_18_0.parent, "EventTriggerListener"))

	arg_18_0.binder = nil
	arg_18_0.OnSelected = nil
	arg_18_0.OnRelease = nil
	arg_18_0.childs = nil

	return
end

return var_0_0
