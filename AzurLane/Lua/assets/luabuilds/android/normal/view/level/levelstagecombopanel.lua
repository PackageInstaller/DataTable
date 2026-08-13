class = var_0_10000

local var_0_0 = "LevelStageComboPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubPanel"))

function var_0_1.getUIName(arg_1_0)
	return "LevelStageComboPanel"
end

function var_0_1.OnInit(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.tf_combo = var_1.Find(var_2_0, "combo/text")

	local var_2_1 = arg_2_0.tf_combo
	local var_2_2 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.text_combo = var_2_2(var_2_1, var_3(var_1_10004))

	local var_2_3 = arg_2_0._tf

	arg_2_0.tf_perfect = var_1.Find(var_2_3, "perfect/text")

	local var_2_4 = arg_2_0.tf_perfect
	local var_2_5 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.text_perfect = var_2_5(var_2_4, var_3(var_1_10004))

	local var_2_6 = arg_2_0._tf

	arg_2_0.tf_good = var_1.Find(var_2_6, "good/text")

	local var_2_7 = arg_2_0.tf_good
	local var_2_8 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.text_good = var_2_8(var_2_7, var_3(var_1_10004))

	local var_2_9 = arg_2_0._tf

	arg_2_0.tf_miss = var_1.Find(var_2_9, "miss/text")

	local var_2_10 = arg_2_0.tf_miss
	local var_2_11 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.text_miss = var_2_11(var_2_10, var_3(var_1_10004))
	arg_2_0.anims = {}

	return
end

function var_0_1.UpdateView(arg_3_0, arg_3_1)
	if not arg_3_1 then
		return
	end

	setText = var_1_10002

	local var_3_0 = arg_3_0.text_combo
	local var_3_1

	if not arg_3_1.combo then
		var_3_1 = 0
	end

	var_1_10002(var_3_0, var_3_1)

	if arg_3_1.scoreHistory then
		local var_3_2 = arg_3_0.text_perfect
		local var_3_3

		if not var_2[4] then
			var_3_3 = 0
		end

		var_3_2.text = var_3_3

		local var_3_4 = arg_3_0.text_good
		local var_3_5

		if not var_2[2] then
			var_3_5 = 0
		end

		local var_3_6

		if not var_2[3] then
			var_3_6 = 0
		end

		var_3_4.text = var_3_5 + var_3_6

		local var_3_7 = arg_3_0.text_miss
		local var_3_8

		if not var_2[0] then
			var_3_8 = 0
		end

		local var_3_9

		if not var_2[1] then
			var_3_9 = 0
		end

		var_3_7.text = var_3_8 + var_3_9
	end

	return
end

function var_0_1.UpdateViewAnimated(arg_4_0, arg_4_1)
	if not arg_4_1 then
		return
	end

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.SetTextAnim
	local var_4_2 = arg_4_0.tf_combo
	local var_4_3 = arg_4_0.text_combo
	local var_4_4

	if not arg_4_1.combo then
		var_4_4 = 0
	end

	var_4_1(var_4_0, var_4_2, var_4_3, var_4_4, 1)

	if arg_4_1.scoreHistory then
		local var_4_5 = arg_4_0
		local var_4_6 = arg_4_0.SetTextAnim
		local var_4_7 = arg_4_0.tf_perfect
		local var_4_8 = arg_4_0.text_perfect
		local var_4_9

		if not var_2[4] then
			var_4_9 = 0
		end

		var_4_6(var_4_5, var_4_7, var_4_8, var_4_9, 2)

		local var_4_10 = arg_4_0
		local var_4_11 = arg_4_0.SetTextAnim
		local var_4_12 = arg_4_0.tf_good
		local var_4_13 = arg_4_0.text_good
		local var_4_14

		if not var_2[2] then
			var_4_14 = 0
		end

		local var_4_15

		if not var_2[3] then
			var_4_15 = 0
		end

		var_4_11(var_4_10, var_4_12, var_4_13, var_4_14 + var_4_15, 3)

		local var_4_16 = arg_4_0
		local var_4_17 = arg_4_0.SetTextAnim
		local var_4_18 = arg_4_0.tf_miss
		local var_4_19 = arg_4_0.text_miss
		local var_4_20

		if not var_2[0] then
			var_4_20 = 0
		end

		local var_4_21

		if not var_2[1] then
			var_4_21 = 0
		end

		var_4_17(var_4_16, var_4_18, var_4_19, var_4_20 + var_4_21, 4)
	end

	return
end

function var_0_1.SetTextAnim(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	tonumber = var_1_10005

	if var_1_10005(arg_5_2.text) == arg_5_3 then
		return
	end

	local var_5_0 = false
	local var_5_1 = arg_5_1.localPosition

	Vector3 = var_1_10007

	local var_5_2 = var_5_1 + var_1_10007(0, 30, 0)
	local var_5_3 = arg_5_0.anims

	LeanTween = var_9

	local var_5_4 = var_9.value

	go = var_10

	local var_5_5 = var_5_4(var_10(arg_5_1), 0, 1, 0.3)
	local var_5_6 = var_9.setLoopPingPong(var_5_5, 1)
	local var_5_7 = var_9.setOnUpdate

	System = var_11
	var_5_3[arg_5_4] = var_5_7(var_5_6, var_11.Action_float(function(arg_6_0)
		local var_6_0 = arg_5_1

		Vector3 = var_2_10002
		var_6_0.localPosition = var_2_10002.Lerp(var_5_1, var_5_2, arg_6_0)

		if arg_6_0 >= 1 and not var_5_0 then
			arg_5_2.text = arg_5_3
			var_5_0 = true
		end

		return
	end)).id

	return
end

function var_0_1.OnDestroy(arg_7_0)
	pairs = var_1_10001

	for iter_7_0, iter_7_1 in var_1_10001(arg_7_0.anims) do
		LeanTween = var_1_10006

		var_1_10006.cancel(iter_7_1)
	end

	table = var_1

	var_1.clear(arg_7_0.anims)

	return
end

return var_0_1
