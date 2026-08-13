ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleBuffHP", var_0.Battle.BattleBuffEffect)

var_0.Battle.BattleBuffHP = var_0_1
var_0_1.__name = "BattleBuffHP"

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_1.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0

	if not arg_2_0._tempData.arg_list.number then
		var_2_0 = 0
	end

	arg_2_0._number = var_2_0
	arg_2_0._numberBase = arg_2_0._number
	arg_2_0._currentHPRatio = 0

	if arg_2_0._tempData.arg_list.currentHPRatio then
		arg_2_0._currentHPRatio = arg_2_0._tempData.arg_list.currentHPRatio * 0.0001
	end

	local var_2_1, var_2_2 = arg_2_1:GetHP()
	local var_2_3 = arg_2_0._caster
	local var_2_4, var_2_5 = var_5.GetHP(var_2_3)
	local var_2_6

	if not arg_2_0._tempData.arg_list.maxHPRatio then
		var_2_6 = 0
	end

	arg_2_0._maxHPRatio = var_2_6
	arg_2_0._maxHPNumber = var_2_2 * arg_2_0._maxHPRatio

	local var_2_7

	if not arg_2_0._tempData.arg_list.casterMaxHPRatio then
		var_2_7 = 0
	end

	arg_2_0._castMaxHPRatio = var_2_7
	arg_2_0._castMaxHPNumber = arg_2_0._castMaxHPRatio * var_2_5

	local var_2_8

	if not arg_2_0._tempData.arg_list.casterHPRatio then
		var_2_8 = 0
	end

	arg_2_0._castHPRatio = var_2_8
	arg_2_0._weaponType = arg_2_0._tempData.arg_list.weaponType
	arg_2_0._damageConvert = 0

	if arg_2_0._tempData.arg_list.damageConvertRatio then
		arg_2_0._damageConvert = arg_2_0._tempData.arg_list.damageConvertRatio * 0.0001
	end

	arg_2_0._incorruptible = arg_2_0._tempData.arg_list.incorrupt

	return
end

function var_0_1.onBulletHit(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
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
	local var_3_1 = arg_3_3.target

	if not arg_3_0._weaponType then
		local var_3_2

		if arg_3_0._number > 0 then
			math = var_1_10008
			var_3_2 = var_1_10008.floor(var_3_2 * var_3_0)
		end

		local var_3_3 = {
			isMiss = false,
			isCri = false,
			isHeal = var_7
		}

		var_3_1:UpdateHP(var_3_2, var_3_3)
	elseif arg_3_3.weaponType == arg_3_0._weaponType then
		math = var_6

		local var_3_4 = var_6.floor(arg_3_3.damage * arg_3_0._damageConvert * var_3_0)
		local var_3_5 = {
			isMiss = false,
			isCri = false,
			isHeal = true,
			incorrupt = arg_3_0._incorruptible
		}

		arg_3_1:UpdateHP(var_3_4, var_3_5)
	end

	return
end

function var_0_1.onAttach(arg_4_0, arg_4_1, arg_4_2)
	onDelayTick = var_1_10003

	var_1_10003(function()
		var_0_1.super.onAttach(arg_4_0, arg_4_1, arg_4_2)

		return
	end, 0.03)

	return
end

function var_0_1.onTrigger(arg_6_0, arg_6_1, arg_6_2)
	local var_6_2

	if arg_6_0:CalcNumber(arg_6_1) > 0 then
		local var_6_0 = arg_6_1
		local var_6_1 = arg_6_1.GetAttrByName(var_6_0, "healingRate")

		math = var_6_0
		var_6_2 = var_6_0.floor(var_6_2 * var_6_1)
	end

	local var_6_3 = {
		isMiss = false,
		isCri = false,
		isHeal = var_4,
		incorrupt = arg_6_0._incorruptible
	}

	arg_6_1:UpdateHP(var_6_2, var_6_3)

	return
end

function var_0_1.CalcNumber(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1:GetHP()
	local var_7_1 = arg_7_0._caster
	local var_7_2 = var_3.GetHP(var_7_1)
	local var_7_3 = arg_7_0._caster
	local var_7_4 = var_4.GetAttrByName(var_7_3, "healingEnhancement") + 1

	math = var_7_3

	return var_7_3.floor((var_7_0 * arg_7_0._currentHPRatio + arg_7_0._maxHPNumber + arg_7_0._number + arg_7_0._castMaxHPNumber + var_7_2 * arg_7_0._castHPRatio) * var_7_4)
end

return
