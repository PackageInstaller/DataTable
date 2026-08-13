ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleUnitEvent
local var_0_2 = var_0.Battle.BattleConfig
local var_0_3 = var_0.Battle.BattleConst

class = var_0_10004

local var_0_4 = var_0_10004("BattleSubCharacter", var_0.Battle.BattlePlayerCharacter)

var_0.Battle.BattleSubCharacter = var_0_4
var_0_4.__name = "BattleSubCharacter"

function var_0_4.Ctor(arg_1_0)
	var_0_4.super.Ctor(arg_1_0)

	return
end

function var_0_4.AddArrowBar(arg_2_0, arg_2_1)
	var_0_4.super.AddArrowBar(arg_2_0, arg_2_1)

	local var_2_0 = arg_2_0._arrowBarTf
	local var_2_1 = var_2.Find(var_2_0, "submarine/oxygenBar/oxygen")
	local var_2_2 = var_2.GetComponent

	typeof = var_4
	Slider = var_1_10005
	arg_2_0._vectorOxygenSlider = var_2_2(var_2_1, var_4(var_1_10005))
	arg_2_0._vectorOxygenSlider.value = 1

	local var_2_3 = arg_2_0._arrowBarTf
	local var_2_4 = var_2.Find(var_2_3, "submarine/Count/CountText")
	local var_2_5 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_2_0._vectorAmmoCount = var_2_5(var_2_4, var_4(var_1_10005))

	local var_2_6 = arg_2_0._unitData
	local var_2_7 = #var_2.GetTorpedoList(var_2_6)

	arg_2_0._vectorAmmoCount.text = var_2_7 .. "/" .. var_2_7

	return
end

function var_0_4.Update(arg_3_0)
	var_0_4.super.Update(arg_3_0)

	if not arg_3_0._inViewArea then
		arg_3_0:updateOxygenVector()
	end

	return
end

function var_0_4.updateOxygenVector(arg_4_0)
	local var_4_0 = arg_4_0._vectorOxygenSlider
	local var_4_1 = arg_4_0._unitData

	var_4_0.value = var_2.GetOxygenProgress(var_4_1)

	return
end

function var_0_4.onTorpedoWeaponFire(arg_5_0, arg_5_1)
	var_0_4.super.onTorpedoWeaponFire(arg_5_0, arg_5_1)

	local var_5_0 = 0

	ipairs = var_3

	local var_5_1 = arg_5_0._unitData

	for iter_5_0, iter_5_1 in var_3(var_4.GetTorpedoList(var_5_1)) do
		if iter_5_1:GetCurrentState() == iter_5_1.STATE_READY then
			var_5_0 = var_5_0 + 1
		end
	end

	local var_5_2 = arg_5_0._vectorAmmoCount
	local var_5_3 = var_5_0
	local var_5_4 = "/"
	local var_5_5 = arg_5_0._unitData

	var_5_2.text = var_5_3 .. var_5_4 .. #var_6.GetTorpedoList(var_5_5)

	return
end

return
