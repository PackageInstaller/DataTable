ys = ys or {}

local var_0_3 = class("BattleSubCharacter", ys.Battle.BattlePlayerCharacter)

ys.Battle.BattleSubCharacter = var_0_3
var_0_3.__name = "BattleSubCharacter"

function var_0_3.Ctor(arg_1_0)
	var_0_3.super.Ctor(arg_1_0)

	return
end

function var_0_3.AddArrowBar(arg_2_0, arg_2_1)
	var_0_3.super.AddArrowBar(arg_2_0, arg_2_1)

	arg_2_0._vectorOxygenSlider = arg_2_0._arrowBarTf:Find("submarine/oxygenBar/oxygen"):GetComponent(typeof(Slider))
	arg_2_0._vectorOxygenSlider.value = 1
	arg_2_0._vectorAmmoCount = arg_2_0._arrowBarTf:Find("submarine/Count/CountText"):GetComponent(typeof(Text))

	local var_2_0 = #arg_2_0._unitData:GetTorpedoList()

	arg_2_0._vectorAmmoCount.text = var_2_0 .. "/" .. var_2_0

	return
end

function var_0_3.Update(arg_3_0)
	var_0_3.super.Update(arg_3_0)

	if not arg_3_0._inViewArea then
		arg_3_0:updateOxygenVector()
	end

	return
end

function var_0_3.updateOxygenVector(arg_4_0)
	arg_4_0._vectorOxygenSlider.value = arg_4_0._unitData:GetOxygenProgress()

	return
end

function var_0_3.onTorpedoWeaponFire(arg_5_0, arg_5_1)
	var_0_3.super.onTorpedoWeaponFire(arg_5_0, arg_5_1)

	local var_5_0 = 0

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._unitData:GetTorpedoList()) do
		if iter_5_1:GetCurrentState() == iter_5_1.STATE_READY then
			var_5_0 = var_5_0 + 1
		end
	end

	arg_5_0._vectorAmmoCount.text = var_5_0 .. "/" .. #arg_5_0._unitData:GetTorpedoList()

	return
end

return
