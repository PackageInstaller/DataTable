class = var_0_10000

local var_0_0 = var_0_10000("BannerScrollRect")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.container = arg_1_1
	arg_1_0.dotContainer = arg_1_2

	local var_1_0 = arg_1_1:Find("item")

	arg_1_0.items = {
		var_1_0
	}

	local var_1_1 = arg_1_2:Find("dot")

	arg_1_0.dots = {
		var_1_1
	}
	arg_1_0.itemWidth = var_1_0.sizeDelta.x
	arg_1_0.dotStartPosX = var_1_1.localPosition.x
	arg_1_0.dotWidth = var_1_1.sizeDelta.x
	arg_1_0.total = 0
	arg_1_0.index = 1

	local var_1_2 = arg_1_0.container

	arg_1_0.dragEvent = var_5.GetComponent(var_1_2, "EventTriggerListener")

	return
end

function var_0_0.GetItem(arg_2_0, arg_2_1)
	local var_2_1

	if not arg_2_0.items[arg_2_1] then
		local var_2_0 = arg_2_0.items[1]

		Object = var_1_10004
		var_2_1 = var_1_10004.Instantiate(var_2_0, var_2_0.transform.parent)
		arg_2_0.items[arg_2_1] = var_2_1
	end

	return var_2_1
end

function var_0_0.GetDot(arg_3_0, arg_3_1)
	local var_3_1

	if not arg_3_0.dots[arg_3_1] then
		local var_3_0 = arg_3_0.dots[1]

		Object = var_1_10004
		var_3_1 = var_1_10004.Instantiate(var_3_0, var_3_0.transform.parent)
		arg_3_0.dots[arg_3_1] = var_3_1
	end

	return var_3_1
end

function var_0_0.AddChild(arg_4_0)
	arg_4_0.total = arg_4_0.total + 1

	local var_4_0 = arg_4_0:GetDot(arg_4_0.total)
	local var_4_1 = arg_4_0
	local var_4_2 = arg_4_0.GetItem(var_4_1, arg_4_0.total)

	setActive = var_4_1

	var_4_1(var_4_2, true)

	setActive = var_4_1

	var_4_1(var_4_0, true)
	arg_4_0:UpdateItemPosition(arg_4_0.total, var_4_2)
	arg_4_0:UpdateDotPosition(arg_4_0.total, var_4_0)

	return var_4_2
end

function var_0_0.UpdateItemPosition(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = (arg_5_1 - 1) * arg_5_0.itemWidth

	Vector3 = var_4
	arg_5_2.localPosition = var_4(var_5_0, arg_5_2.localPosition.y, 0)

	return
end

function var_0_0.UpdateDotPosition(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.dotStartPosX + (arg_6_1 - 1) * (arg_6_0.dotWidth + 15)

	Vector3 = var_4
	arg_6_2.localPosition = var_4(var_6_0, arg_6_2.localPosition.y, 0)

	return
end

function var_0_0.SetUp(arg_7_0)
	if arg_7_0.total == 0 then
		var_1_10002 = arg_7_0

		arg_7_0.Disable(var_1_10002)

		return
	end

	local var_7_0 = arg_7_0.container

	Vector3 = var_1_10002
	var_7_0.localPosition = var_1_10002(0, 0, 0)

	arg_7_0:ScrollTo(1)
	arg_7_0:AutoScroll()
	arg_7_0:AddDrag()

	return
end

function var_0_0.AutoScroll(arg_8_0)
	arg_8_0:RemoveTimer()

	Timer = var_1
	arg_8_0.timer = var_1.New(function()
		local var_9_0

		if (arg_8_0.index + 1) % arg_8_0.total == 0 then
			var_9_0 = arg_8_0.total
		end

		local var_9_1 = arg_8_0

		var_1.ScrollTo(var_9_1, var_9_0)

		return
	end, 5, -1, true)

	local var_8_0 = arg_8_0.timer

	var_1.Start(var_8_0)

	return
end

function var_0_0.ScrollTo(arg_10_0, arg_10_1)
	local var_10_0

	if not arg_10_0.index then
		var_10_0 = 1
	end

	local var_10_1 = (arg_10_1 - 1) * arg_10_0.itemWidth

	arg_10_0.animating = true
	LeanTween = var_4

	local var_10_2 = var_4.moveLocalX

	go = var_1_10005

	local var_10_3 = var_10_2(var_1_10005(arg_10_0.container), -1 * var_10_1, 0.2)
	local var_10_4 = var_4.setEase

	LeanTweenType = var_6

	local var_10_5 = var_10_4(var_10_3, var_6.easeInOutSine)
	local var_10_6 = var_4.setOnComplete

	System = var_6

	var_10_6(var_10_5, var_6.Action(function()
		arg_10_0.animating = false

		return
	end))

	arg_10_0.index = arg_10_1

	local var_10_7 = arg_10_0.dots[var_10_0]

	arg_10_0:TriggerDot(var_10_7, false)

	local var_10_8 = arg_10_0.dots[arg_10_1]

	arg_10_0:TriggerDot(var_10_8, true)

	return
end

function var_0_0.TriggerDot(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_2 then
		Color = var_1_10003

		if not var_1_10003.New(1, 1, 1, 1) then
			Color = var_1_10003
			var_1_10003 = var_1_10003.New(0.4, 0.45, 0.55)
		end

		local var_12_0 = arg_12_1
		local var_12_1 = arg_12_1.GetComponent

		typeof = var_1_10006
		Image = var_1_10007
		var_12_1(var_12_0, var_1_10006(var_1_10007)).color = var_1_10003

		return
	end
end

function var_0_0.AddDrag(arg_13_0)
	local var_13_0 = 0
	local var_13_1
	local var_13_2 = arg_13_0.dragEvent

	var_3.AddBeginDragFunc(var_13_2, function(arg_14_0, arg_14_1)
		if arg_13_0.animating then
			return
		end

		local var_14_0 = arg_13_0

		var_2.Pause(var_14_0)

		var_13_0 = arg_14_1.position.x
		var_13_1 = arg_13_0.container.localPosition

		return
	end)

	local var_13_3 = arg_13_0.dragEvent

	var_3.AddDragFunc(var_13_3, function(arg_15_0, arg_15_1)
		if arg_13_0.animating or not var_13_1 then
			return
		end

		local var_15_0 = (arg_15_1.position.x - var_13_0) * 0.5
		local var_15_1 = arg_13_0.container

		Vector3 = var_2_10004
		var_15_1.localPosition = var_2_10004(var_13_1.x + var_15_0, var_13_1.y, 0)

		return
	end)

	local var_13_4 = arg_13_0.dragEvent

	var_3.AddDragEndFunc(var_13_4, function(arg_16_0, arg_16_1)
		if arg_13_0.animating or not var_13_1 then
			return
		end

		local var_16_0 = arg_16_1.position.x - var_13_0

		math = var_3

		local var_16_1 = var_3.floor

		math = var_2_10004

		local var_16_2 = var_16_1(var_2_10004.abs(var_16_0 / arg_13_0.itemWidth) + 0.5)
		local var_16_3

		if not (var_16_0 < 0) or not (arg_13_0.index + var_16_2) then
			var_16_3 = arg_13_0.index - var_16_2
		end

		math = var_5

		local var_16_4 = var_5.clamp(var_16_3, 1, arg_13_0.total)
		local var_16_5 = arg_13_0

		var_5.ScrollTo(var_16_5, var_16_4)

		local var_16_6 = arg_13_0

		var_5.Resume(var_16_6)

		return
	end)

	return
end

function var_0_0.Reset(arg_17_0)
	arg_17_0:RemoveTimer()

	ClearEventTrigger = var_1

	var_1(arg_17_0.dragEvent)

	LeanTween = var_1

	local var_17_0 = var_1.cancel

	go = var_2

	var_17_0(var_2(arg_17_0.container))

	arg_17_0.total = 0
	arg_17_0.index = 1
	arg_17_0.animating = false

	arg_17_0:Disable()

	return
end

function var_0_0.Disable(arg_18_0)
	ipairs = var_1_10001

	for iter_18_0, iter_18_1 in var_1_10001(arg_18_0.items) do
		setActive = var_1_10006

		var_1_10006(iter_18_1, false)
	end

	ipairs = var_1

	for iter_18_2, iter_18_3 in var_1(arg_18_0.dots) do
		arg_18_0:TriggerDot(iter_18_3, false)

		setActive = var_6

		var_6(iter_18_3, false)
	end

	return
end

function var_0_0.Pause(arg_19_0)
	arg_19_0:RemoveTimer()

	return
end

function var_0_0.Resume(arg_20_0)
	if arg_20_0.total == 0 then
		return
	end

	arg_20_0:AutoScroll()

	return
end

function var_0_0.RemoveTimer(arg_21_0)
	if arg_21_0.timer then
		local var_21_0 = arg_21_0.timer

		var_1.Stop(var_21_0)

		arg_21_0.timer = nil
	end

	return
end

function var_0_0.Dispose(arg_22_0)
	arg_22_0:Reset()

	ipairs = var_1

	for iter_22_0, iter_22_1 in var_1(arg_22_0.items) do
		Object = var_1_10006

		var_1_10006.Destroy(iter_22_1.gameObject)
	end

	ipairs = var_1

	for iter_22_2, iter_22_3 in var_1(arg_22_0.dots) do
		Object = var_1_10006

		var_1_10006.Destroy(iter_22_3.gameObject)
	end

	arg_22_0.items = nil
	arg_22_0.dots = nil

	return
end

return var_0_0
