ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleBuffAddAttr", var_0.Battle.BattleBuffEffect)

var_0.Battle.BattleBuffAddAttr = var_0_1
var_0_1.__name = "BattleBuffAddAttr"
var_0_1.FX_TYPE = var_0.Battle.BattleBuffEffect.FX_TYPE_MOD_ATTR

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_1.GetEffectType(arg_2_0)
	return var_0_1.FX_TYPE
end

function var_0_1.SetArgs(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0

	if not arg_3_0._tempData.arg_list.group then
		var_3_0 = arg_3_2:GetID()
	end

	arg_3_0._group = var_3_0

	if arg_3_0._tempData.arg_list.comboDamage then
		arg_3_0._attr = var_0.Battle.BattleAttr.GetCurrent(arg_3_0._caster, "comboTag")
	else
		arg_3_0._attr = arg_3_0._tempData.arg_list.attr
	end

	arg_3_0._number = arg_3_0._tempData.arg_list.number
	arg_3_0._numberBase = arg_3_0._number
	arg_3_0._attrID = arg_3_0._tempData.arg_list.attr_group_ID

	return
end

function var_0_1.onAttach(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0:UpdateAttr(arg_4_1)

	return
end

function var_0_1.onStack(arg_5_0, arg_5_1, arg_5_2)
	math = var_1_10003

	local var_5_0 = var_1_10003.min(arg_5_2._stackCap, arg_5_2._stack)

	arg_5_0._number = arg_5_0._numberBase * var_5_0

	arg_5_0:UpdateAttr(arg_5_1)

	return
end

function var_0_1.onRemove(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0._number = 0

	arg_6_0:UpdateAttr(arg_6_1)

	return
end

function var_0_1.IsSameAttr(arg_7_0, arg_7_1)
	return arg_7_0._attr == arg_7_1
end

function var_0_1.UpdateAttr(arg_8_0, arg_8_1)
	assert = var_1_10002

	var_1_10002(arg_8_0._attr ~= "velocity", ">>BattleBuffAddAttr(Ratio)不可用于修改速度，使用BattleBuffFixVelocity!")

	if arg_8_0._attr == "injureRatio" then
		arg_8_0:UpdateAttrMul(arg_8_1)
	else
		arg_8_0:UpdateAttrAdd(arg_8_1)
	end

	if arg_8_0._attr == "cloakExposeExtra" or arg_8_0._attr == "cloakRestore" or arg_8_0._attr == "cloakRecovery" then
		arg_8_1:UpdateCloakConfig()
	end

	if arg_8_0._attr == "lockAimBias" then
		arg_8_1:UpdateAimBiasSkillState()
	end

	return
end

function var_0_1.CheckWeapon(arg_9_0)
	if arg_9_0._attr == "loadSpeed" then
		return true
	else
		return false
	end

	return
end

function var_0_1.UpdateAttrMul(arg_10_0, arg_10_1)
	local var_10_0 = 1
	local var_10_1 = 1
	local var_10_2 = {}
	local var_10_3 = {}
	local var_10_4 = arg_10_1
	local var_10_5 = arg_10_1.GetBuffList(var_10_4)

	pairs = var_10_4

	for iter_10_0, iter_10_1 in var_10_4(var_10_5) do
		ipairs = var_1_10012

		for iter_10_2, iter_10_3 in var_1_10012(iter_10_1._effectList) do
			if iter_10_3:GetEffectType() == var_0_1.FX_TYPE and iter_10_3:IsSameAttr(arg_10_0._attr) then
				local var_10_6 = iter_10_3._number
				local var_10_7

				if not var_10_2[iter_10_3._group] then
					var_10_7 = 0
				end

				local var_10_8

				if not var_10_3[var_18] then
					var_10_8 = 0
				end

				if var_10_7 < var_10_6 and var_10_6 > 0 then
					var_10_0 = var_10_0 * (1 + var_10_6) / (1 + var_10_7)
					var_10_7 = var_10_6
				end

				if var_10_6 < var_10_8 and var_10_6 < 0 then
					var_10_1 = var_10_1 * (1 + var_10_6) / (1 + var_10_8)
					var_10_8 = var_10_6
				end

				var_10_2[var_18] = var_10_7
				var_10_3[var_18] = var_10_8
			end
		end
	end

	var_0.Battle.BattleAttr.FlashByBuff(arg_10_1, arg_10_0._attr, var_10_0 * var_10_1 - 1)

	if arg_10_0:CheckWeapon() then
		arg_10_1:FlushReloadingWeapon()
	end

	return
end

function var_0_1.UpdateAttrAdd(arg_11_0, arg_11_1)
	local var_11_0, var_11_1 = arg_11_1:GetHP()
	local var_11_2 = arg_11_1:GetBuffList()
	local var_11_3 = 0
	local var_11_4 = 0
	local var_11_5 = {}
	local var_11_6 = {}

	pairs = var_1_10009

	for iter_11_0, iter_11_1 in var_1_10009(var_11_2) do
		ipairs = var_1_10014

		for iter_11_2, iter_11_3 in var_1_10014(iter_11_1._effectList) do
			if iter_11_3:GetEffectType() == var_0_1.FX_TYPE and iter_11_3:IsSameAttr(arg_11_0._attr) then
				local var_11_7 = iter_11_3._number
				local var_11_8

				if not var_11_5[iter_11_3._group] then
					var_11_8 = 0
				end

				local var_11_9

				if not var_11_6[var_20] then
					var_11_9 = 0
				end

				if var_11_8 < var_11_7 and var_11_7 > 0 then
					var_11_3 = var_11_3 + var_11_7 - var_11_8
					var_11_8 = var_11_7
				end

				if var_11_7 < var_11_9 and var_11_7 < 0 then
					var_11_4 = var_11_4 + var_11_7 - var_11_9
					var_11_9 = var_11_7
				end

				var_11_5[var_20] = var_11_8
				var_11_6[var_20] = var_11_9
			end
		end
	end

	var_0.Battle.BattleAttr.FlashByBuff(arg_11_1, arg_11_0._attr, var_11_3 + var_11_4)

	local var_11_10 = arg_11_1
	local var_11_11 = arg_11_1.GetMaxHP(var_11_10)

	math = var_11_10

	local var_11_12 = var_11_10.min
	local var_11_13 = var_11_11

	math = var_12

	local var_11_14 = var_11_12(var_11_13, var_11_0 + var_12.max(0, var_11_11 - var_11_1))

	arg_11_1:SetCurrentHP(var_11_14)

	if arg_11_0:CheckWeapon() then
		arg_11_1:FlushReloadingWeapon()
	end

	local var_11_15 = arg_11_1._move

	var_11.ImmuneAreaLimit(var_11_15, var_0.Battle.BattleAttr.IsImmuneAreaLimit(arg_11_1))

	local var_11_16 = arg_11_1._move

	var_11.ImmuneMaxAreaLimit(var_11_16, var_0.Battle.BattleAttr.IsImmuneMaxAreaLimit(arg_11_1))

	return
end

return
