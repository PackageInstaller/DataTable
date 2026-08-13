ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleSubmarineButtonSkinElite_20260520", var_0.Battle.BattleSubmarineButton)

var_0.Battle.BattleSubmarineButtonSkinElite_20260520 = var_0_1
var_0_1.__name = "BattleSubmarineButtonSkinElite_20260520"

function var_0_1.ConfigSkin(arg_1_0, arg_1_1)
	var_0_1.super.ConfigSkin(arg_1_0, arg_1_1)

	local var_1_0 = arg_1_0._icon

	arg_1_0._unfill = var_2.Find(var_1_0, "unfill/unfill")

	local var_1_1 = arg_1_0._icon

	arg_1_0._unfillShade = var_2.Find(var_1_1, "unfill/unfill_1")

	return
end

function var_0_1.OnFilled(arg_2_0)
	var_0_1.super.OnFilled(arg_2_0)

	SetActive = var_1

	var_1(arg_2_0._unfillShade, false)

	return
end

function var_0_1.OnUnfill(arg_3_0)
	var_0_1.super.OnUnfill(arg_3_0)

	SetActive = var_1

	var_1(arg_3_0._unfillShade, true)

	return
end

function var_0_1.SwitchIcon(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0, var_4_1 = var_0_1.super.SwitchIcon(arg_4_0, arg_4_1, arg_4_2)

	setImageSprite = var_5

	local var_4_2 = arg_4_0._unfillShade

	LoadSprite = var_1_10007

	var_5(var_4_2, var_1_10007("ui/CombatUI" .. var_4_0 .. "_atlas", "weapon_unfill_" .. var_4_1))

	return
end

return
