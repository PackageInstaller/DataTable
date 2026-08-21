local var_0_0 = class("NewBattleResultShipCardAnimation")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	arg_1_0.isExpMode = arg_1_2
	arg_1_0.maxOutput = arg_1_6
	arg_1_0.ship = arg_1_3
	arg_1_0.newShip = arg_1_4
	arg_1_0.statistic = arg_1_5 or {}
	arg_1_0.label1 = arg_1_1:Find("atk"):GetComponent(typeof(Text))
	arg_1_0.label2 = arg_1_1:Find("killCount"):GetComponent(typeof(Text))
	arg_1_0.damagebar = arg_1_1:Find("dmg/bar"):GetComponent(typeof(Image))

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
	parallelAsync({
		function(arg_4_0)
			arg_3_0:ExpAnimation(arg_4_0)

			return
		end,
		function(arg_5_0)
			arg_3_0:LevelAnimation(arg_5_0)

			return
		end,
		function(arg_6_0)
			arg_3_0:ExpBarAnimation(arg_6_0)

			return
		end
	}, arg_3_1)

	return
end

function var_0_0.ExpAnimation(arg_7_0, arg_7_1)
	LeanTween.value(arg_7_0.label1.gameObject, 0, NewBattleResultUtil.GetShipExpOffset(arg_7_0.ship, arg_7_0.newShip), 1):setOnUpdate(System.Action_float(function(arg_8_0)
		arg_7_0.label1.text = "EXP" .. "<color=#FFDE38>+" .. math.ceil(arg_8_0) .. "</color>"

		return
	end)):setOnComplete(System.Action(arg_7_1))

	return
end

function var_0_0.LevelAnimation(arg_9_0, arg_9_1)
	if arg_9_0.ship.level == arg_9_0.newShip.level then
		arg_9_0.label2.text = "Lv." .. arg_9_0.newShip.level

		arg_9_1()

		return
	end

	LeanTween.value(arg_9_0.label2.gameObject, arg_9_0.ship.level, arg_9_0.newShip.level, 1):setOnUpdate(System.Action_float(function(arg_10_0)
		arg_9_0.label2.text = "Lv." .. math.ceil(arg_10_0)

		return
	end)):setOnComplete(System.Action(arg_9_1))

	return
end

local function var_0_1(arg_11_0, arg_11_1)
	local var_11_0 = getExpByRarityFromLv1(arg_11_0.newShip:getConfig("rarity"), arg_11_0.newShip.level)

	LeanTween.value(arg_11_0.damagebar.gameObject, arg_11_0.ship:getExp(), arg_11_0.newShip:getExp(), 1):setOnUpdate(System.Action_float(function(arg_12_0)
		arg_11_0.damagebar.fillAmount = arg_12_0 / var_11_0

		return
	end)):setOnComplete(System.Action(arg_11_1))

	return
end

local function var_0_2(arg_13_0, arg_13_1)
	LeanTween.value(arg_13_0.damagebar.gameObject, arg_13_0.ship:getExp() / getExpByRarityFromLv1(arg_13_0.ship:getConfig("rarity"), arg_13_0.ship.level), 1, 0.5):setOnUpdate(System.Action_float(function(arg_14_0)
		arg_13_0.damagebar.fillAmount = arg_14_0

		return
	end)):setOnComplete(System.Action(arg_13_1))

	return
end

local function var_0_3(arg_15_0, arg_15_1)
	LeanTween.value(arg_15_0.damagebar.gameObject, 0, arg_15_0.newShip:getExp() / getExpByRarityFromLv1(arg_15_0.newShip:getConfig("rarity"), arg_15_0.newShip.level), 0.5):setOnUpdate(System.Action_float(function(arg_16_0)
		arg_15_0.damagebar.fillAmount = arg_16_0

		return
	end)):setOnComplete(System.Action(arg_15_1))

	return
end

local function var_0_4(arg_17_0, arg_17_1)
	LeanTween.value(arg_17_0.damagebar.gameObject, 0, 1, 0.3):setOnUpdate(System.Action_float(function(arg_18_0)
		arg_17_0.damagebar.fillAmount = arg_18_0

		return
	end)):setRepeat(arg_17_0.newShip.level - (arg_17_0.ship.level + 1)):setOnComplete(System.Action(arg_17_1))

	return
end

local function var_0_5(arg_19_0, arg_19_1)
	table.insert({}, function(arg_20_0)
		var_0_2(arg_19_0, arg_20_0)

		return
	end)

	if arg_19_0.ship.level + 1 ~= arg_19_0.newShip.level then
		table.insert({}, function(arg_21_0)
			var_0_4(arg_19_0, arg_21_0)

			return
		end)
	end

	table.insert({}, function(arg_22_0)
		var_0_3(arg_19_0, arg_22_0)

		return
	end)
	seriesAsync({}, arg_19_1)

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
	parallelAsync({
		function(arg_25_0)
			arg_24_0:KillCntAnimation(arg_25_0)

			return
		end,
		function(arg_26_0)
			arg_24_0:OutputAnimation(arg_26_0)

			return
		end,
		function(arg_27_0)
			arg_24_0:OutputBarAnimation(arg_27_0)

			return
		end
	}, arg_24_1)

	return
end

function var_0_0.KillCntAnimation(arg_28_0, arg_28_1)
	LeanTween.value(arg_28_0.label2.gameObject, 0, var_28_0, 1):setOnUpdate(System.Action_float(function(arg_29_0)
		arg_28_0.label2.text = math.ceil(arg_29_0)

		return
	end)):setOnComplete(System.Action(arg_28_1))

	return
end

function var_0_0.OutputAnimation(arg_30_0, arg_30_1)
	LeanTween.value(arg_30_0.label1.gameObject, 0, var_30_0, 1):setOnUpdate(System.Action_float(function(arg_31_0)
		arg_30_0.label1.text = math.ceil(arg_31_0)

		return
	end)):setOnComplete(System.Action(arg_30_1))

	return
end

function var_0_0.OutputBarAnimation(arg_32_0, arg_32_1)
	LeanTween.value(arg_32_0.damagebar.gameObject, 0, var_32_0 / arg_32_0.maxOutput, 1):setOnUpdate(System.Action_float(function(arg_33_0)
		arg_32_0.damagebar.fillAmount = arg_33_0

		return
	end)):setOnComplete(System.Action(arg_32_1))

	return
end

function var_0_0.Clear(arg_34_0)
	for iter_34_0, iter_34_1 in ipairs({
		"label1",
		"label2",
		"damagebar"
	}) do
		if LeanTween.isTweening(arg_34_0[iter_34_1].gameObject) then
			LeanTween.cancel(arg_34_0[iter_34_1].gameObject)
		end
	end

	return
end

function var_0_0.Dispose(arg_35_0)
	arg_35_0:Clear()

	return
end

return var_0_0
