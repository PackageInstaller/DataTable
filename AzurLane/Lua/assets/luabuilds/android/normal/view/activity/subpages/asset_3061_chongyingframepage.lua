class = var_0_10000

local var_0_0 = "ChongYingFramePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.NewFrameTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0._tf

	arg_1_0.bar = var_1.Find(var_1_0, "AD/switcher/phase2/barContent")

	local var_1_1 = arg_1_0._tf

	arg_1_0.cur = var_1.Find(var_1_1, "AD/switcher/phase2/progress/step")

	local var_1_2 = arg_1_0._tf

	arg_1_0.target = var_1.Find(var_1_2, "AD/switcher/phase2/progress/all")

	local var_1_3 = arg_1_0._tf

	arg_1_0.getTag = var_1.Find(var_1_3, "AD/switcher/phase2/get")

	local var_1_4 = arg_1_0._tf

	arg_1_0.gotTag = var_1.Find(var_1_4, "AD/switcher/phase2/got")

	local var_1_5 = {}
	local var_1_6 = arg_1_0.switchBtn

	var_1_5[1] = var_2.Find(var_1_6, "2")

	local var_1_7 = arg_1_0.switchBtn

	var_1_5[2] = var_2.Find(var_1_7, "1")
	arg_1_0.titles = var_1_5

	return
end

function var_0_1.OnUpdateFlush(arg_2_0)
	local var_2_0 = arg_2_0.activity.data1

	var_2_0 = arg_2_0.avatarConfig.target < var_2_0 and var_2 or var_2_0

	local var_2_1 = var_2_0 / var_2

	setText = var_1_10004

	local var_2_2 = arg_2_0.cur

	if 1 <= var_2_1 then
		setColorStr = var_6

		local var_2_3 = var_2_0

		COLOR_GREEN = var_1_10008

		local var_2_4

		if not var_6(var_2_3, var_1_10008) then
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

		local var_2_14 = arg_2_0.getTag
		local var_2_15

		if arg_2_0.inPhase2 then
			var_2_15 = not var_2_7 and var_2_5
		end

		var_6(var_2_14, var_2_15)

		setActive = var_6

		local var_2_16 = arg_2_0.gotTag
		local var_2_17

		if arg_2_0.inPhase2 then
			var_2_17 = var_2_7
		end

		var_6(var_2_16, var_2_17)

		setActive = var_6

		local var_2_18 = arg_2_0._tf

		var_6(var_7.Find(var_2_18, "AD/switcher/phase2/progress"), not var_2_7)

		return
	end
end

function var_0_1.Switch(arg_3_0, arg_3_1)
	arg_3_0.isSwitching = true
	setToggleEnabled = var_2

	var_2(arg_3_0.switchBtn, false)

	local var_3_0 = {}

	ipairs = var_3

	for iter_3_0, iter_3_1 in var_3({
		arg_3_0.phases,
		arg_3_0.titles
	}) do
		unpack = var_1_10008

		local var_3_1

		var_1_10008, var_3_1 = var_1_10008(iter_3_1)

		if arg_3_1 then
			var_1_10010 = var_3_1
			var_3_1 = var_1_10008
			var_1_10008 = var_1_10010
		end

		LeanTween = var_1_10010
		var_1_10010 = var_1_10010.cancel
		go = var_1_10011

		var_1_10010(var_1_10011(var_1_10008))

		GetOrAddComponent = var_1_10010
		var_1_10010 = var_1_10010(var_1_10008, "CanvasGroup")
		var_1_10010.alpha = 0
		table = var_1_10011

		var_1_10011.insert(var_3_0, function(arg_4_0)
			LeanTween = var_2_10001

			local var_4_0 = var_2_10001.alphaCanvas(var_1_10010, 1, 0.4)
			local var_4_1 = var_1.setOnComplete

			System = var_3

			var_4_1(var_4_0, var_3.Action(arg_4_0))

			return
		end)

		LeanTween = var_1_10011
		var_1_10011 = var_1_10011.cancel
		go = var_12

		var_1_10011(var_12(var_3_1))

		GetOrAddComponent = var_1_10011
		var_1_10011 = var_1_10011(var_3_1, "CanvasGroup")
		var_1_10011.alpha = 1
		table = var_12

		var_12.insert(var_3_0, function(arg_5_0)
			LeanTween = var_2_10001

			local var_5_0 = var_2_10001.alphaCanvas(var_1_10011, 0, 0.4)
			local var_5_1 = var_1.setOnComplete

			System = var_3

			var_5_1(var_5_0, var_3.Action(arg_5_0))

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
