ys = ys or {}

local var_0_0 = ys
local var_0_1 = class("BattleBuffAddAttr", ys.Battle.BattleBuffEffect)

ys.Battle.BattleBuffAddAttr = var_0_1
var_0_1.__name = "BattleBuffAddAttr"
var_0_1.FX_TYPE = ys.Battle.BattleBuffEffect.FX_TYPE_MOD_ATTR

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_1.GetEffectType(arg_2_0)
	return var_0_1.FX_TYPE
end

function var_0_1.SetArgs(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._group = arg_3_0._tempData.arg_list.group or arg_3_2:GetID()
	arg_3_0._attr = arg_3_0._tempData.arg_list.comboDamage and var_0_0.Battle.BattleAttr.GetCurrent(arg_3_0._caster, "comboTag") or arg_3_0._tempData.arg_list.attr
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
	arg_5_0._number = arg_5_0._numberBase * math.min(arg_5_2._stackCap, arg_5_2._stack)

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
	assert(arg_8_0._attr ~= "velocity", ">>BattleBuffAddAttr(Ratio)不可用于修改速度，使用BattleBuffFixVelocity!")

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

	for iter_10_0, iter_10_1 in pairs((arg_10_1:GetBuffList())) do
		for iter_10_2, iter_10_3 in ipairs(iter_10_1._effectList) do
			if iter_10_3:GetEffectType() == var_0_1.FX_TYPE and iter_10_3:IsSameAttr(arg_10_0._attr) then
				local var_10_2 = ({})[iter_10_3._group]

				if not ({})[iter_10_3._group] then
					var_10_2 = 0
				end

				local var_10_3 = ({})[iter_10_3._group]

				if not ({})[iter_10_3._group] then
					var_10_3 = 0
				end

				if var_10_2 < iter_10_3._number and iter_10_3._number > 0 then
					var_10_0 = var_10_0 * (1 + iter_10_3._number) / (1 + var_10_2)
					var_10_2 = iter_10_3._number
				end

				if iter_10_3._number < var_10_3 and iter_10_3._number < 0 then
					var_10_1 = var_10_1 * (1 + iter_10_3._number) / (1 + var_10_3)
					var_10_3 = iter_10_3._number
				end

				;({})[iter_10_3._group] = var_10_2
				;({})[iter_10_3._group] = var_10_3
			end
		end
	end

	var_0_0.Battle.BattleAttr.FlashByBuff(arg_10_1, arg_10_0._attr, var_10_0 * var_10_1 - 1)

	if arg_10_0:CheckWeapon() then
		arg_10_1:FlushReloadingWeapon()
	end

	return
end

function var_0_1.UpdateAttrAdd(arg_11_0, arg_11_1)
	local var_11_0, var_11_1 = arg_11_1:GetHP()
	local var_11_2 = 0
	local var_11_3 = 0

	for iter_11_0, iter_11_1 in pairs((arg_11_1:GetBuffList())) do
		for iter_11_2, iter_11_3 in ipairs(iter_11_1._effectList) do
			if iter_11_3:GetEffectType() == var_0_1.FX_TYPE and iter_11_3:IsSameAttr(arg_11_0._attr) then
				local var_11_4 = ({})[iter_11_3._group]

				if not ({})[iter_11_3._group] then
					var_11_4 = 0
				end

				local var_11_5 = ({})[iter_11_3._group]

				if not ({})[iter_11_3._group] then
					var_11_5 = 0
				end

				if var_11_4 < iter_11_3._number and iter_11_3._number > 0 then
					var_11_2 = var_11_2 + iter_11_3._number - var_11_4
					var_11_4 = iter_11_3._number
				end

				if iter_11_3._number < var_11_5 and iter_11_3._number < 0 then
					var_11_3 = var_11_3 + iter_11_3._number - var_11_5
					var_11_5 = iter_11_3._number
				end

				;({})[iter_11_3._group] = var_11_4
				;({})[iter_11_3._group] = var_11_5
			end
		end
	end

	var_0_0.Battle.BattleAttr.FlashByBuff(arg_11_1, arg_11_0._attr, var_11_2 + var_11_3)

	local var_11_6 = arg_11_1:GetMaxHP()

	arg_11_1:SetCurrentHP((math.min(var_11_6, var_11_0 + math.max(0, var_11_6 - var_11_1))))

	if arg_11_0:CheckWeapon() then
		arg_11_1:FlushReloadingWeapon()
	end

	arg_11_1._move:ImmuneAreaLimit(var_0_0.Battle.BattleAttr.IsImmuneAreaLimit(arg_11_1))
	arg_11_1._move:ImmuneMaxAreaLimit(var_0_0.Battle.BattleAttr.IsImmuneMaxAreaLimit(arg_11_1))

	return
end

return
