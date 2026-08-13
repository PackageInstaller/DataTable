class = var_0_10000

local var_0_0 = "DexiV6FramePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.NewFrameTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.battleBtn = var_1.Find(var_1_1, "battle_btn")

	local var_1_2 = arg_1_0.bg

	arg_1_0.getBtn = var_1.Find(var_1_2, "get_btn")

	local var_1_3 = arg_1_0.bg

	arg_1_0.gotBtn = var_1.Find(var_1_3, "got_btn")

	local var_1_4 = arg_1_0._tf

	arg_1_0.switchBtn = var_1.Find(var_1_4, "AD/switch_btn")

	local var_1_5 = {}
	local var_1_6 = arg_1_0._tf

	var_1_5[1] = var_2.Find(var_1_6, "AD/switcher/phase1")

	local var_1_7 = arg_1_0._tf

	var_1_5[2] = var_2.Find(var_1_7, "AD/switcher/phase2")
	arg_1_0.phases = var_1_5

	local var_1_8 = arg_1_0._tf

	arg_1_0.bar = var_1.Find(var_1_8, "AD/switcher/phase2/Image/barContent/bar")

	local var_1_9 = arg_1_0._tf

	arg_1_0.cur = var_1.Find(var_1_9, "AD/switcher/phase2/Image/step")

	local var_1_10 = arg_1_0._tf

	arg_1_0.gotTag = var_1.Find(var_1_10, "AD/switcher/phase2/Image/got")

	local var_1_11 = arg_1_0._tf

	arg_1_0.getTag = var_1.Find(var_1_11, "AD/switcher/phase2/Image/get")

	return
end

function var_0_1.OnUpdateFlush(arg_2_0)
	local var_2_0 = arg_2_0.activity.data1

	var_2_0 = arg_2_0.avatarConfig.target < var_2_0 and var_2 or var_2_0

	local var_2_1 = var_2_0 / var_2

	setText = var_1_10004

	local var_2_2 = arg_2_0.cur

	if 1 <= var_2_1 then
		setColorStr = var_2_3
		var_1_10007 = var_2_0
		COLOR_GREEN = var_1_10008

		local var_2_3

		if not var_2_3(var_1_10007, var_1_10008) then
			setColorStr = var_2_3
			var_2_3 = var_2_3(var_2_0, "#81CBD0")
		end

		setColorStr = var_1_10007

		var_1_10004(var_2_2, var_2_3 .. var_1_10007("/" .. var_2, "#1AB3B1"))

		setFillAmount = var_1_10004

		var_1_10004(arg_2_0.bar, var_2_1)

		local var_2_4 = var_2 <= var_2_0
		local var_2_5 = arg_2_0.activity.data2
		local var_2_6 = 1 <= var_2_5

		setActive = var_6

		local var_2_7 = arg_2_0.battleBtn
		local var_2_8

		if arg_2_0.inPhase2 then
			var_2_8 = not var_2_4
		end

		var_6(var_2_7, var_2_8)

		setActive = var_6

		local var_2_9 = arg_2_0.getBtn
		local var_2_10

		if arg_2_0.inPhase2 then
			var_2_10 = not var_2_6 and var_2_4
		end

		var_6(var_2_9, var_2_10)

		setActive = var_6

		local var_2_11 = arg_2_0.gotBtn
		local var_2_12

		if arg_2_0.inPhase2 then
			var_2_12 = var_2_6
		end

		var_6(var_2_11, var_2_12)

		setActive = var_6

		local var_2_13 = arg_2_0.gotTag
		local var_2_14

		if arg_2_0.inPhase2 then
			var_2_14 = var_2_6
		end

		var_6(var_2_13, var_2_14)

		setActive = var_6

		local var_2_15 = arg_2_0.getTag
		local var_2_16

		if arg_2_0.inPhase2 then
			var_2_16 = not var_2_6 and var_2_4
		end

		var_6(var_2_15, var_2_16)

		setActive = var_6

		var_6(arg_2_0.cur, not var_2_6)

		return
	end
end

return var_0_1
