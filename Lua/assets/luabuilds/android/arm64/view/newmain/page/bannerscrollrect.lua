local var_0_0 = class("BannerScrollRect")

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
	arg_1_0.dragEvent = arg_1_0.container:GetComponent("EventTriggerListener")

	return
end

function var_0_0.GetItem(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0.items[arg_2_1]

	if not arg_2_0.items[arg_2_1] then
		var_2_0 = Object.Instantiate(arg_2_0.items[1], arg_2_0.items[1].transform.parent)
		arg_2_0.items[arg_2_1] = var_2_0
	end

	return var_2_0
end

function var_0_0.GetDot(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.dots[arg_3_1]

	if not arg_3_0.dots[arg_3_1] then
		var_3_0 = Object.Instantiate(arg_3_0.dots[1], arg_3_0.dots[1].transform.parent)
		arg_3_0.dots[arg_3_1] = var_3_0
	end

	return var_3_0
end

function var_0_0.AddChild(arg_4_0)
	arg_4_0.total = arg_4_0.total + 1

	local var_4_0 = arg_4_0:GetDot(arg_4_0.total)
	local var_4_1 = arg_4_0:GetItem(arg_4_0.total)

	setActive(var_4_1, true)
	setActive(var_4_0, true)
	arg_4_0:UpdateItemPosition(arg_4_0.total, var_4_1)
	arg_4_0:UpdateDotPosition(arg_4_0.total, var_4_0)

	return var_4_1
end

function var_0_0.UpdateItemPosition(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2.localPosition = Vector3((arg_5_1 - 1) * arg_5_0.itemWidth, arg_5_2.localPosition.y, 0)

	return
end

function var_0_0.UpdateDotPosition(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2.localPosition = Vector3(arg_6_0.dotStartPosX + (arg_6_1 - 1) * (arg_6_0.dotWidth + 15), arg_6_2.localPosition.y, 0)

	return
end

function var_0_0.SetUp(arg_7_0)
	if arg_7_0.total == 0 then
		arg_7_0:Disable()

		return
	end

	arg_7_0.container.localPosition = Vector3(0, 0, 0)

	arg_7_0:ScrollTo(1)
	arg_7_0:AutoScroll()
	arg_7_0:AddDrag()

	return
end

function var_0_0.AutoScroll(arg_8_0)
	arg_8_0:RemoveTimer()

	arg_8_0.timer = Timer.New(function()
		local var_9_0 = (arg_8_0.index + 1) % arg_8_0.total

		if (arg_8_0.index + 1) % arg_8_0.total == 0 then
			var_9_0 = arg_8_0.total
		end

		arg_8_0:ScrollTo(var_9_0)

		return
	end, 5, -1, true)

	arg_8_0.timer:Start()

	return
end

function var_0_0.ScrollTo(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.index or 1

	arg_10_0.animating = true

	LeanTween.moveLocalX(go(arg_10_0.container), -1 * var_10_1, 0.2):setEase(LeanTweenType.easeInOutSine):setOnComplete(System.Action(function()
		arg_10_0.animating = false

		return
	end))

	arg_10_0.index = arg_10_1

	arg_10_0:TriggerDot(arg_10_0.dots[var_10_0], false)
	arg_10_0:TriggerDot(arg_10_0.dots[arg_10_1], true)

	return
end

function var_0_0.TriggerDot(arg_12_0, arg_12_1, arg_12_2)
	arg_12_1:GetComponent(typeof(Image)).color = arg_12_2 and Color.New(1, 1, 1, 1) or Color.New(0.4, 0.45, 0.55)

	return
end

function var_0_0.AddDrag(arg_13_0)
	local var_13_0 = 0
	local var_13_1

	arg_13_0.dragEvent:AddBeginDragFunc(function(arg_14_0, arg_14_1)
		if arg_13_0.animating then
			return
		end

		arg_13_0:Pause()

		var_13_0 = arg_14_1.position.x
		var_13_1 = arg_13_0.container.localPosition

		return
	end)
	arg_13_0.dragEvent:AddDragFunc(function(arg_15_0, arg_15_1)
		if arg_13_0.animating or not var_13_1 then
			return
		end

		arg_13_0.container.localPosition = Vector3(var_13_1.x + (arg_15_1.position.x - var_13_0) * 0.5, var_13_1.y, 0)

		return
	end)
	arg_13_0.dragEvent:AddDragEndFunc(function(arg_16_0, arg_16_1)
		local var_16_0

		if arg_13_0.animating or not var_13_1 then
			do return end

			var_16_0 = math.floor(math.abs((arg_16_1.position.x - var_13_0) / arg_13_0.itemWidth) + 0.5)
		end

		if arg_16_1.position.x - var_13_0 < 0 then
			local var_16_1 = arg_13_0.index + var_16_0 or arg_13_0.index - var_16_0

			arg_13_0:ScrollTo((math.clamp(var_16_1, 1, arg_13_0.total)))
			arg_13_0:Resume()

			return
		end
	end)

	return
end

function var_0_0.Reset(arg_17_0)
	arg_17_0:RemoveTimer()
	ClearEventTrigger(arg_17_0.dragEvent)
	LeanTween.cancel(go(arg_17_0.container))

	arg_17_0.total = 0
	arg_17_0.index = 1
	arg_17_0.animating = false

	arg_17_0:Disable()

	return
end

function var_0_0.Disable(arg_18_0)
	for iter_18_0, iter_18_1 in ipairs(arg_18_0.items) do
		setActive(iter_18_1, false)
	end

	for iter_18_2, iter_18_3 in ipairs(arg_18_0.dots) do
		arg_18_0:TriggerDot(iter_18_3, false)
		setActive(iter_18_3, false)
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
		arg_21_0.timer:Stop()

		arg_21_0.timer = nil
	end

	return
end

function var_0_0.Dispose(arg_22_0)
	arg_22_0:Reset()

	for iter_22_0, iter_22_1 in ipairs(arg_22_0.items) do
		Object.Destroy(iter_22_1.gameObject)
	end

	for iter_22_2, iter_22_3 in ipairs(arg_22_0.dots) do
		Object.Destroy(iter_22_3.gameObject)
	end

	arg_22_0.items = nil
	arg_22_0.dots = nil

	return
end

return var_0_0
