ys = ys or {}

local var_0_0 = class("BattleBuffHP", ys.Battle.BattleBuffEffect)

ys.Battle.BattleBuffHP = var_0_0
var_0_0.__name = "BattleBuffHP"

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_0.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._number = arg_2_0._tempData.arg_list.number or 0
	arg_2_0._numberBase = arg_2_0._number
	arg_2_0._currentHPRatio = 0

	if arg_2_0._tempData.arg_list.currentHPRatio then
		arg_2_0._currentHPRatio = arg_2_0._tempData.arg_list.currentHPRatio * 0.0001
	end

	local var_2_0, var_2_1 = arg_2_1:GetHP()
	local var_2_2, var_2_3 = arg_2_0._caster:GetHP()

	arg_2_0._maxHPRatio = arg_2_0._tempData.arg_list.maxHPRatio or 0
	arg_2_0._maxHPNumber = var_2_1 * arg_2_0._maxHPRatio
	arg_2_0._castMaxHPRatio = arg_2_0._tempData.arg_list.casterMaxHPRatio or 0
	arg_2_0._castMaxHPNumber = arg_2_0._castMaxHPRatio * var_2_3
	arg_2_0._castHPRatio = arg_2_0._tempData.arg_list.casterHPRatio or 0
	arg_2_0._weaponType = arg_2_0._tempData.arg_list.weaponType
	arg_2_0._damageConvert = 0

	if arg_2_0._tempData.arg_list.damageConvertRatio then
		arg_2_0._damageConvert = arg_2_0._tempData.arg_list.damageConvertRatio * 0.0001
	end

	arg_2_0._incorruptible = arg_2_0._tempData.arg_list.incorrupt

	return
end

function var_0_0.onBulletHit(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if not arg_3_0:equipIndexRequire(arg_3_3.equipIndex) then
		return
	end

	if not arg_3_0:bulletTagRequire(arg_3_3.bulletTag) then
		return
	end

	if not arg_3_0:victimRequire(arg_3_3.target, arg_3_1) then
		return
	end

	local var_3_0 = arg_3_1:GetAttrByName("healingRate")

	if not arg_3_0._weaponType then
		local var_3_2 = arg_3_0._number
		local var_3_3 = arg_3_0._number > 0

		if arg_3_0._number > 0 then
			var_3_2 = math.floor(var_3_2 * var_3_0)
		end

		var_3_1:UpdateHP(var_3_2, {
			isMiss = false,
			isCri = false,
			isHeal = var_3_3
		})
	elseif arg_3_3.weaponType == arg_3_0._weaponType then
		arg_3_1:UpdateHP(math.floor(arg_3_3.damage * arg_3_0._damageConvert * var_3_0), {
			isMiss = false,
			isCri = false,
			isHeal = true,
			incorrupt = arg_3_0._incorruptible
		})
	end

	return
end

function var_0_0.onAttach(arg_4_0, arg_4_1, arg_4_2)
	onDelayTick(function()
		var_0_0.super.onAttach(arg_4_0, arg_4_1, arg_4_2)

		return
	end, 0.03)

	return
end

function var_0_0.onTrigger(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0:CalcNumber(arg_6_1)
	local var_6_1 = var_6_0 > 0

	if var_6_0 > 0 then
		var_6_0 = math.floor(var_6_0 * arg_6_1:GetAttrByName("healingRate"))
	end

	arg_6_1:UpdateHP(var_6_0, {
		isMiss = false,
		isCri = false,
		isHeal = var_6_1,
		incorrupt = arg_6_0._incorruptible
	})

	return
end

function var_0_0.CalcNumber(arg_7_0, arg_7_1)
	return math.floor((arg_7_1:GetHP() * arg_7_0._currentHPRatio + arg_7_0._maxHPNumber + arg_7_0._number + arg_7_0._castMaxHPNumber + arg_7_0._caster:GetHP() * arg_7_0._castHPRatio) * (arg_7_0._caster:GetAttrByName("healingEnhancement") + 1))
end

return
