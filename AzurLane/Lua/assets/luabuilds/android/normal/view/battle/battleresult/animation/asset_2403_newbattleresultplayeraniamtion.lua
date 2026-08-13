class = var_0_10000

local var_0_0 = var_0_10000("NewBattleResultPlayerAniamtion")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	arg_1_0.playerLv = arg_1_1
	arg_1_0.playerExp = arg_1_2
	arg_1_0.playerExpBar = arg_1_3
	arg_1_0.newPlayer = arg_1_4
	arg_1_0.oldPlayer = arg_1_5

	return
end

function var_0_0.SetUp(arg_2_0, arg_2_1)
	parallelAsync = var_1_10002

	var_1_10002({
		function(arg_3_0)
			local var_3_0 = arg_2_0

			var_1.LevelAnimation(var_3_0, arg_3_0)

			return
		end,
		function(arg_4_0)
			local var_4_0 = arg_2_0

			var_1.ExpAnimation(var_4_0, arg_4_0)

			return
		end,
		function(arg_5_0)
			local var_5_0 = arg_2_0

			var_1.ExpBarAnimation(var_5_0, arg_5_0)

			return
		end
	}, arg_2_1)

	return
end

function var_0_0.LevelAnimation(arg_6_0, arg_6_1)
	if arg_6_0.oldPlayer.level == arg_6_0.newPlayer.level then
		var_1_10004 = arg_6_0.playerLv
		var_1_10004.text = "Lv." .. var_3

		arg_6_1()

		return
	end

	LeanTween = var_1_10004

	local var_6_0 = var_1_10004.value(arg_6_0.playerLv.gameObject, var_2, var_3, 1.5)
	local var_6_1 = var_4.setOnUpdate

	System = var_6

	local var_6_2 = var_6_1(var_6_0, var_6.Action_float(function(arg_7_0)
		local var_7_0 = arg_6_0.playerLv
		local var_7_1 = "Lv."

		math = var_2_10003
		var_7_0.text = var_7_1 .. var_2_10003.ceil(arg_7_0)

		return
	end))
	local var_6_3 = var_4.setOnComplete

	System = var_6

	var_6_3(var_6_2, var_6.Action(arg_6_1))

	return
end

function var_0_0.ExpAnimation(arg_8_0, arg_8_1)
	NewBattleResultUtil = var_1_10002

	local var_8_0 = var_1_10002.GetPlayerExpOffset(arg_8_0.oldPlayer, arg_8_0.newPlayer)

	LeanTween = var_3

	local var_8_1 = var_3.value(arg_8_0.playerExp.gameObject, 0, var_8_0, 1.5)
	local var_8_2 = var_3.setOnUpdate

	System = var_5

	local var_8_3 = var_8_2(var_8_1, var_5.Action_float(function(arg_9_0)
		local var_9_0 = arg_8_0.playerExp
		local var_9_1 = "+"

		math = var_2_10003
		var_9_0.text = var_9_1 .. var_2_10003.ceil(arg_9_0)

		return
	end))
	local var_8_4 = var_3.setOnComplete

	System = var_5

	var_8_4(var_8_3, var_5.Action(arg_8_1))

	return
end

local function var_0_1(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.oldPlayer.exp
	local var_10_1 = arg_10_0.newPlayer.exp

	getConfigFromLevel1 = var_1_10004
	pg = var_1_10005

	local var_10_2 = var_1_10004(var_1_10005.user_level, arg_10_0.newPlayer.level).exp_interval

	LeanTween = var_5

	local var_10_3 = var_5.value(arg_10_0.playerExpBar.gameObject, var_10_0, var_10_1, 1.5)
	local var_10_4 = var_5.setOnUpdate

	System = var_7

	local var_10_5 = var_10_4(var_10_3, var_7.Action_float(function(arg_11_0)
		arg_10_0.playerExpBar.fillAmount = arg_11_0 / var_10_2

		return
	end))
	local var_10_6 = var_5.setOnComplete

	System = var_7

	var_10_6(var_10_5, var_7.Action(arg_10_1))

	return
end

local function var_0_2(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.oldPlayer.exp

	getConfigFromLevel1 = var_1_10003
	pg = var_1_10004

	local var_12_1 = var_1_10003(var_1_10004.user_level, arg_12_0.oldPlayer.level).exp_interval

	LeanTween = var_4

	local var_12_2 = var_4.value(arg_12_0.playerExpBar.gameObject, var_12_0 / var_12_1, 1, 1)
	local var_12_3 = var_4.setOnUpdate

	System = var_6

	local var_12_4 = var_12_3(var_12_2, var_6.Action_float(function(arg_13_0)
		arg_12_0.playerExpBar.fillAmount = arg_13_0

		return
	end))
	local var_12_5 = var_4.setOnComplete

	System = var_6

	var_12_5(var_12_4, var_6.Action(arg_12_1))

	return
end

local function var_0_3(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.newPlayer.exp

	getConfigFromLevel1 = var_1_10003
	pg = var_1_10004

	local var_14_1 = var_1_10003(var_1_10004.user_level, arg_14_0.newPlayer.level).exp_interval

	LeanTween = var_4

	local var_14_2 = var_4.value(arg_14_0.playerExpBar.gameObject, 0, var_14_0 / var_14_1, 1)
	local var_14_3 = var_4.setOnUpdate

	System = var_6

	local var_14_4 = var_14_3(var_14_2, var_6.Action_float(function(arg_15_0)
		arg_14_0.playerExpBar.fillAmount = arg_15_0

		return
	end))
	local var_14_5 = var_4.setOnComplete

	System = var_6

	var_14_5(var_14_4, var_6.Action(arg_14_1))

	return
end

local function var_0_4(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.oldPlayer.level
	local var_16_1 = arg_16_0.newPlayer.level - (var_16_0 + 1)

	LeanTween = var_1_10005

	local var_16_2 = var_1_10005.value(arg_16_0.playerExpBar.gameObject, 0, 1, 1)
	local var_16_3 = var_5.setOnUpdate

	System = var_7

	local var_16_4 = var_16_3(var_16_2, var_7.Action_float(function(arg_17_0)
		arg_16_0.playerExpBar.fillAmount = arg_17_0

		return
	end))
	local var_16_5 = var_5.setRepeat(var_16_4, var_16_1)
	local var_16_6 = var_5.setOnComplete

	System = var_7

	var_16_6(var_16_5, var_7.Action(arg_16_1))

	return
end

local function var_0_5(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0.oldPlayer.level
	local var_18_1 = arg_18_0.newPlayer.level
	local var_18_2 = {}

	table = var_1_10005

	var_1_10005.insert(var_18_2, function(arg_19_0)
		var_0_2(arg_18_0, arg_19_0)

		return
	end)

	if var_18_0 + 1 ~= var_18_1 then
		table = var_5

		var_5.insert(var_18_2, function(arg_20_0)
			var_0_4(arg_18_0, arg_20_0)

			return
		end)
	end

	table = var_5

	var_5.insert(var_18_2, function(arg_21_0)
		var_0_3(arg_18_0, arg_21_0)

		return
	end)

	seriesAsync = var_5

	var_5(var_18_2, arg_18_1)

	return
end

function var_0_0.ExpBarAnimation(arg_22_0, arg_22_1)
	if arg_22_0.oldPlayer.level == arg_22_0.newPlayer.level then
		var_0_1(arg_22_0, arg_22_1)
	else
		var_0_5(arg_22_0, arg_22_1)
	end

	return
end

function var_0_0.Dispose(arg_23_0)
	ipairs = var_1_10001

	for iter_23_0, iter_23_1 in var_1_10001({
		"playerLv",
		"playerExp",
		"playerExpBar"
	}) do
		local var_23_0 = arg_23_0[iter_23_1].gameObject

		LeanTween = var_1_10007

		if var_1_10007.isTweening(var_23_0) then
			LeanTween = var_1_10007

			var_1_10007.cancel(var_23_0)
		end
	end

	return
end

return var_0_0
