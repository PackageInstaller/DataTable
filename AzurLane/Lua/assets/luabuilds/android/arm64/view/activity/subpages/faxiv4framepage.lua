class = var_0_10000

local var_0_0 = "FaxiV4FramePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.NewFrameTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0._tf

	arg_1_0.bar = var_1.Find(var_1_0, "AD/switcher/phase2/barContent")

	local var_1_1 = arg_1_0._tf

	arg_1_0.cur = var_1.Find(var_1_1, "AD/switcher/phase2/progress/step")

	local var_1_2 = arg_1_0._tf

	arg_1_0.target = var_1.Find(var_1_2, "AD/switcher/phase2/progress/all")

	local var_1_3 = arg_1_0._tf

	arg_1_0.gotTag = var_1.Find(var_1_3, "AD/switcher/phase2/got")

	local var_1_4 = {}
	local var_1_5 = arg_1_0.switchBtn

	var_1_4[1] = var_2.Find(var_1_5, "2")

	local var_1_6 = arg_1_0.switchBtn

	var_1_4[2] = var_2.Find(var_1_6, "1")
	arg_1_0.titles = var_1_4

	return
end

function var_0_1.OnUpdateFlush(arg_2_0)
	local var_2_0 = arg_2_0.activity.data1

	var_2_0 = arg_2_0.avatarConfig.target < var_2_0 and var_2 or var_2_0

	local var_2_1 = var_2_0 / var_2

	setText = var_1_10004

	local var_2_2 = arg_2_0.cur

	if 1 <= var_2_1 then
		setColorStr = var_7

		local var_2_3 = var_2_0

		COLOR_GREEN = var_1_10010

		local var_2_4

		if not var_7(var_2_3, var_1_10010) then
			var_2_4 = var_2_0
		end

		var_1_10004(var_2_2, var_2_4)

		setText = var_1_10004

		var_1_10004(arg_2_0.target, "/" .. var_2)

		setSlider = var_1_10004

		var_1_10004(arg_2_0.bar, 0, var_2, var_2_0)

		local var_2_5 = var_2 <= var_2_0
		local var_2_6 = arg_2_0.activity.data2
		local var_2_7 = 1 <= var_2_6

		setActive = var_6

		local var_2_8 = arg_2_0.battleBtn
		local var_2_9

		if arg_2_0.inPhase2 then
			var_2_9 = not var_2_5
		end

		var_6(var_2_8, var_2_9)

		setActive = var_6

		local var_2_10 = arg_2_0.getBtn
		local var_2_11

		if arg_2_0.inPhase2 then
			var_2_11 = not var_2_7 and var_2_5
		end

		var_6(var_2_10, var_2_11)

		setActive = var_6

		local var_2_12 = arg_2_0.gotBtn
		local var_2_13

		if arg_2_0.inPhase2 then
			var_2_13 = var_2_7
		end

		var_6(var_2_12, var_2_13)

		setActive = var_6

		local var_2_14 = arg_2_0.gotTag
		local var_2_15

		if arg_2_0.inPhase2 then
			var_2_15 = var_2_7
		end

		var_6(var_2_14, var_2_15)

		setActive = var_6

		local var_2_16 = arg_2_0._tf

		var_6(var_8.Find(var_2_16, "AD/switcher/phase2/progress"), not var_2_7)

		return
	end
end

function var_0_1.Switch(arg_3_0, arg_3_1)
	arg_3_0.isSwitching = true
	setToggleEnabled = var_2

	var_2(arg_3_0.switchBtn, false)

	local var_3_0 = {}

	ipairs = var_1_10003

	for iter_3_0, iter_3_1 in var_1_10003({
		arg_3_0.phases,
		arg_3_0.titles
	}) do
		unpack = var_1_10008

		local var_3_1

		var_1_10008, var_3_1 = var_1_10008(iter_3_1)

		local var_3_2

		if arg_3_1 then
			var_3_2 = var_3_1
			var_3_1 = var_1_10008
			var_1_10008 = var_3_2
		end

		LeanTween = var_3_2

		local var_3_3 = var_3_2.cancel

		go = var_1_10012

		var_3_3(var_1_10012(var_1_10008))

		GetOrAddComponent = var_3_3

		local var_3_4 = var_3_3(var_1_10008, "CanvasGroup")

		var_3_4.alpha = 0
		table = var_11

		var_11.insert(var_3_0, function(arg_4_0)
			LeanTween = var_2_10001

			local var_4_0 = var_2_10001.alphaCanvas(var_3_4, 1, 0.4)
			local var_4_1 = var_1.setOnComplete

			System = var_4

			var_4_1(var_4_0, var_4.Action(arg_4_0))

			return
		end)

		LeanTween = var_11

		local var_3_5 = var_11.cancel

		go = var_13

		var_3_5(var_13(var_3_1))

		GetOrAddComponent = var_3_5

		local var_3_6 = var_3_5(var_3_1, "CanvasGroup")

		var_3_6.alpha = 1
		table = var_1_10012

		var_1_10012.insert(var_3_0, function(arg_5_0)
			LeanTween = var_2_10001

			local var_5_0 = var_2_10001.alphaCanvas(var_3_6, 0, 0.4)
			local var_5_1 = var_1.setOnComplete

			System = var_4

			var_5_1(var_5_0, var_4.Action(arg_5_0))

			return
		end)
	end

	parallelAsync = var_3

	var_3(var_3_0, function()
		local var_6_0 = arg_3_0

		var_6_0.isSwitching = nil
		setToggleEnabled = var_6_0

		var_6_0(arg_3_0.switchBtn, true)

		return
	end)

	return
end

return var_0_1
