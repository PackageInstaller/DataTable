class = var_0_10000

local var_0_0 = var_0_10000("NewBattleResultShipCardAnimation")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	arg_1_0.isExpMode = arg_1_2
	arg_1_0.maxOutput = arg_1_6
	arg_1_0.ship = arg_1_3
	arg_1_0.newShip = arg_1_4
	arg_1_0.statistic = arg_1_5 or {}

	local var_1_0 = arg_1_1:Find("atk")
	local var_1_1 = var_7.GetComponent

	typeof = var_9
	Text = var_1_10010
	arg_1_0.label1 = var_1_1(var_1_0, var_9(var_1_10010))

	local var_1_2 = arg_1_1:Find("killCount")
	local var_1_3 = var_7.GetComponent

	typeof = var_9
	Text = var_1_10010
	arg_1_0.label2 = var_1_3(var_1_2, var_9(var_1_10010))

	local var_1_4 = arg_1_1:Find("dmg/bar")
	local var_1_5 = var_7.GetComponent

	typeof = var_9
	Image = var_1_10010
	arg_1_0.damagebar = var_1_5(var_1_4, var_9(var_1_10010))

	return
end

function var_0_0.SetUp(arg_2_0, arg_2_1)
	arg_2_0:Clear()

	if arg_2_0.isExpMode then
		arg_2_0:DoExpAnimation(arg_2_1)
	else
		arg_2_0:DoOutputAnimation(arg_2_1)
	end

	return
end

function var_0_0.DoExpAnimation(arg_3_0, arg_3_1)
	parallelAsync = var_1_10002

	var_1_10002({
		function(arg_4_0)
			local var_4_0 = arg_3_0

			var_1.ExpAnimation(var_4_0, arg_4_0)

			return
		end,
		function(arg_5_0)
			local var_5_0 = arg_3_0

			var_1.LevelAnimation(var_5_0, arg_5_0)

			return
		end,
		function(arg_6_0)
			local var_6_0 = arg_3_0

			var_1.ExpBarAnimation(var_6_0, arg_6_0)

			return
		end
	}, arg_3_1)

	return
end

function var_0_0.ExpAnimation(arg_7_0, arg_7_1)
	NewBattleResultUtil = var_1_10002

	local var_7_0 = var_1_10002.GetShipExpOffset(arg_7_0.ship, arg_7_0.newShip)

	LeanTween = var_3

	local var_7_1 = var_3.value(arg_7_0.label1.gameObject, 0, var_7_0, 1)
	local var_7_2 = var_3.setOnUpdate

	System = var_5

	local var_7_3 = var_7_2(var_7_1, var_5.Action_float(function(arg_8_0)
		local var_8_0 = arg_7_0.label1
		local var_8_1 = "EXP"
		local var_8_2 = "<color=#FFDE38>+"

		math = var_2_10004
		var_8_0.text = var_8_1 .. var_8_2 .. var_2_10004.ceil(arg_8_0) .. "</color>"

		return
	end))
	local var_7_4 = var_3.setOnComplete

	System = var_5

	var_7_4(var_7_3, var_5.Action(arg_7_1))

	return
end

function var_0_0.LevelAnimation(arg_9_0, arg_9_1)
	if arg_9_0.ship.level == arg_9_0.newShip.level then
		var_1_10004 = arg_9_0.label2
		var_1_10004.text = "Lv." .. var_3

		arg_9_1()

		return
	end

	LeanTween = var_1_10004

	local var_9_0 = var_1_10004.value(arg_9_0.label2.gameObject, var_2, var_3, 1)
	local var_9_1 = var_4.setOnUpdate

	System = var_6

	local var_9_2 = var_9_1(var_9_0, var_6.Action_float(function(arg_10_0)
		local var_10_0 = arg_9_0.label2
		local var_10_1 = "Lv."

		math = var_2_10003
		var_10_0.text = var_10_1 .. var_2_10003.ceil(arg_10_0)

		return
	end))
	local var_9_3 = var_4.setOnComplete

	System = var_6

	var_9_3(var_9_2, var_6.Action(arg_9_1))

	return
end

local function var_0_1(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.ship
	local var_11_1 = var_2.getExp(var_11_0)
	local var_11_2 = arg_11_0.newShip
	local var_11_3 = var_3.getExp(var_11_2)

	getExpByRarityFromLv1 = var_11_2

	local var_11_4 = arg_11_0.newShip
	local var_11_5 = var_11_2(var_5.getConfig(var_11_4, "rarity"), arg_11_0.newShip.level)

	LeanTween = var_5

	local var_11_6 = var_5.value(arg_11_0.damagebar.gameObject, var_11_1, var_11_3, 1)
	local var_11_7 = var_5.setOnUpdate

	System = var_7

	local var_11_8 = var_11_7(var_11_6, var_7.Action_float(function(arg_12_0)
		arg_11_0.damagebar.fillAmount = arg_12_0 / var_11_5

		return
	end))
	local var_11_9 = var_5.setOnComplete

	System = var_7

	var_11_9(var_11_8, var_7.Action(arg_11_1))

	return
end

local function var_0_2(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.ship
	local var_13_1 = var_2.getExp(var_13_0)

	getExpByRarityFromLv1 = var_13_0

	local var_13_2 = arg_13_0.ship
	local var_13_3 = var_13_0(var_4.getConfig(var_13_2, "rarity"), arg_13_0.ship.level)

	LeanTween = var_4

	local var_13_4 = var_4.value(arg_13_0.damagebar.gameObject, var_13_1 / var_13_3, 1, 0.5)
	local var_13_5 = var_4.setOnUpdate

	System = var_6

	local var_13_6 = var_13_5(var_13_4, var_6.Action_float(function(arg_14_0)
		arg_13_0.damagebar.fillAmount = arg_14_0

		return
	end))
	local var_13_7 = var_4.setOnComplete

	System = var_6

	var_13_7(var_13_6, var_6.Action(arg_13_1))

	return
end

local function var_0_3(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0.newShip
	local var_15_1 = var_2.getExp(var_15_0)

	getExpByRarityFromLv1 = var_15_0

	local var_15_2 = arg_15_0.newShip
	local var_15_3 = var_15_0(var_4.getConfig(var_15_2, "rarity"), arg_15_0.newShip.level)

	LeanTween = var_4

	local var_15_4 = var_4.value(arg_15_0.damagebar.gameObject, 0, var_15_1 / var_15_3, 0.5)
	local var_15_5 = var_4.setOnUpdate

	System = var_6

	local var_15_6 = var_15_5(var_15_4, var_6.Action_float(function(arg_16_0)
		arg_15_0.damagebar.fillAmount = arg_16_0

		return
	end))
	local var_15_7 = var_4.setOnComplete

	System = var_6

	var_15_7(var_15_6, var_6.Action(arg_15_1))

	return
end

local function var_0_4(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.ship.level
	local var_17_1 = arg_17_0.newShip.level - (var_17_0 + 1)

	LeanTween = var_1_10005

	local var_17_2 = var_1_10005.value(arg_17_0.damagebar.gameObject, 0, 1, 0.3)
	local var_17_3 = var_5.setOnUpdate

	System = var_7

	local var_17_4 = var_17_3(var_17_2, var_7.Action_float(function(arg_18_0)
		arg_17_0.damagebar.fillAmount = arg_18_0

		return
	end))
	local var_17_5 = var_5.setRepeat(var_17_4, var_17_1)
	local var_17_6 = var_5.setOnComplete

	System = var_7

	var_17_6(var_17_5, var_7.Action(arg_17_1))

	return
end

local function var_0_5(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0.ship.level
	local var_19_1 = arg_19_0.newShip.level
	local var_19_2 = {}

	table = var_1_10005

	var_1_10005.insert(var_19_2, function(arg_20_0)
		var_0_2(arg_19_0, arg_20_0)

		return
	end)

	if var_19_0 + 1 ~= var_19_1 then
		table = var_5

		var_5.insert(var_19_2, function(arg_21_0)
			var_0_4(arg_19_0, arg_21_0)

			return
		end)
	end

	table = var_5

	var_5.insert(var_19_2, function(arg_22_0)
		var_0_3(arg_19_0, arg_22_0)

		return
	end)

	seriesAsync = var_5

	var_5(var_19_2, arg_19_1)

	return
end

function var_0_0.ExpBarAnimation(arg_23_0, arg_23_1)
	if arg_23_0.ship.level == arg_23_0.newShip.level then
		var_0_1(arg_23_0, arg_23_1)
	else
		var_0_5(arg_23_0, arg_23_1)
	end

	return
end

function var_0_0.DoOutputAnimation(arg_24_0, arg_24_1)
	parallelAsync = var_1_10002

	var_1_10002({
		function(arg_25_0)
			local var_25_0 = arg_24_0

			var_1.KillCntAnimation(var_25_0, arg_25_0)

			return
		end,
		function(arg_26_0)
			local var_26_0 = arg_24_0

			var_1.OutputAnimation(var_26_0, arg_26_0)

			return
		end,
		function(arg_27_0)
			local var_27_0 = arg_24_0

			var_1.OutputBarAnimation(var_27_0, arg_27_0)

			return
		end
	}, arg_24_1)

	return
end

function var_0_0.KillCntAnimation(arg_28_0, arg_28_1)
	local var_28_0 = 0
	local var_28_1

	if not arg_28_0.statistic.kill_count then
		var_28_1 = 0
	end

	LeanTween = var_1_10004

	local var_28_2 = var_1_10004.value(arg_28_0.label2.gameObject, var_28_0, var_28_1, 1)
	local var_28_3 = var_4.setOnUpdate

	System = var_6

	local var_28_4 = var_28_3(var_28_2, var_6.Action_float(function(arg_29_0)
		local var_29_0 = arg_28_0.label2

		math = var_2_10002
		var_29_0.text = var_2_10002.ceil(arg_29_0)

		return
	end))
	local var_28_5 = var_4.setOnComplete

	System = var_6

	var_28_5(var_28_4, var_6.Action(arg_28_1))

	return
end

function var_0_0.OutputAnimation(arg_30_0, arg_30_1)
	local var_30_0 = 0
	local var_30_1

	if not arg_30_0.statistic.output then
		var_30_1 = 0
	end

	LeanTween = var_1_10004

	local var_30_2 = var_1_10004.value(arg_30_0.label1.gameObject, var_30_0, var_30_1, 1)
	local var_30_3 = var_4.setOnUpdate

	System = var_6

	local var_30_4 = var_30_3(var_30_2, var_6.Action_float(function(arg_31_0)
		local var_31_0 = arg_30_0.label1

		math = var_2_10002
		var_31_0.text = var_2_10002.ceil(arg_31_0)

		return
	end))
	local var_30_5 = var_4.setOnComplete

	System = var_6

	var_30_5(var_30_4, var_6.Action(arg_30_1))

	return
end

function var_0_0.OutputBarAnimation(arg_32_0, arg_32_1)
	local var_32_0 = 0
	local var_32_1

	if not arg_32_0.statistic.output then
		var_32_1 = 0
	end

	local var_32_2 = var_32_1 / arg_32_0.maxOutput

	LeanTween = var_4

	local var_32_3 = var_4.value(arg_32_0.damagebar.gameObject, var_32_0, var_32_2, 1)
	local var_32_4 = var_4.setOnUpdate

	System = var_6

	local var_32_5 = var_32_4(var_32_3, var_6.Action_float(function(arg_33_0)
		arg_32_0.damagebar.fillAmount = arg_33_0

		return
	end))
	local var_32_6 = var_4.setOnComplete

	System = var_6

	var_32_6(var_32_5, var_6.Action(arg_32_1))

	return
end

function var_0_0.Clear(arg_34_0)
	ipairs = var_1_10001

	for iter_34_0, iter_34_1 in var_1_10001({
		"label1",
		"label2",
		"damagebar"
	}) do
		local var_34_0 = arg_34_0[iter_34_1].gameObject

		LeanTween = var_1_10007

		if var_1_10007.isTweening(var_34_0) then
			LeanTween = var_1_10007

			var_1_10007.cancel(var_34_0)
		end
	end

	return
end

function var_0_0.Dispose(arg_35_0)
	arg_35_0:Clear()

	return
end

return var_0_0
