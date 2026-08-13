ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleSubmarineButton", var_0.Battle.BattleWeaponButton)

var_0.Battle.BattleSubmarineButton = var_0_1
var_0_1.__name = "BattleSubmarineButton"

function var_0_1.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	return
end

function var_0_1.OnCountChange(arg_2_0)
	local var_2_0 = arg_2_0._progressInfo
	local var_2_1 = var_1.GetCount(var_2_0)
	local var_2_2 = arg_2_0._progressInfo
	local var_2_3 = var_2.GetTotal(var_2_2)
	local var_2_4 = arg_2_0._countTxt

	string = var_2_2
	var_2_4.text = var_2_2.format("%d", var_2_1)

	return
end

function var_0_1.ConfigSkin(arg_3_0, arg_3_1)
	var_0_1.super.ConfigSkin(arg_3_0, arg_3_1)

	local var_3_0 = arg_3_0._progress.gameObject

	var_2.SetActive(var_3_0, false)

	local var_3_1 = arg_3_0._filledEffect.gameObject

	var_2.SetActive(var_3_1, false)

	return
end

function var_0_1.ConfigCallback(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local function var_4_0()
		arg_4_2()

		return
	end

	var_0_1.super.ConfigCallback(arg_4_0, arg_4_1, var_4_0, arg_4_3, arg_4_4)

	return
end

function var_0_1.OnOverLoadChange(arg_6_0, arg_6_1)
	var_0_1.super.OnOverLoadChange(arg_6_0, arg_6_1)

	local var_6_0 = arg_6_0._progressInfo
	local var_6_1 = var_2.GetTotal(var_6_0)
	local var_6_2 = arg_6_0._progressInfo

	if var_6_1 == var_3.GetCount(var_6_2) then
		quickCheckAndPlayAnimator = var_6_1

		var_6_1(arg_6_0._skin, "weapon_button_into")
	else
		local var_6_3 = arg_6_0._progressInfo

		if var_2.GetCount(var_6_3) == 0 then
			quickCheckAndPlayAnimator = var_2

			var_2(arg_6_0._skin, "weapon_button_use")
		end
	end

	return
end

function var_0_1.Update(arg_7_0)
	return
end

function var_0_1.updateProgressBar(arg_8_0)
	return
end

function var_0_1.OnfilledEffect(arg_9_0)
	return
end

return
