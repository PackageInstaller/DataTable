ys = ys or {}

local var_0_0 = ys
local BattleBuffAddAttr = class("BattleBuffAddAttr", ys.Battle.BattleBuffEffect)

ys.Battle.BattleBuffAddAttr = BattleBuffAddAttr
BattleBuffAddAttr.__name = "BattleBuffAddAttr"
BattleBuffAddAttr.FX_TYPE = ys.Battle.BattleBuffEffect.FX_TYPE_MOD_ATTR

function BattleBuffAddAttr:Ctor(arg_1_1)
	BattleBuffAddAttr.super.Ctor(self, arg_1_1)

	return
end

function BattleBuffAddAttr:GetEffectType()
	return BattleBuffAddAttr.FX_TYPE
end

function BattleBuffAddAttr:SetArgs(arg_3_1, arg_3_2)
	self._group = self._tempData.arg_list.group or arg_3_2:GetID()
	self._attr = self._tempData.arg_list.comboDamage and var_0_0.Battle.BattleAttr.GetCurrent(self._caster, "comboTag") or self._tempData.arg_list.attr
	self._number = self._tempData.arg_list.number
	self._numberBase = self._number
	self._attrID = self._tempData.arg_list.attr_group_ID

	return
end

function BattleBuffAddAttr:onAttach(arg_4_1, arg_4_2)
	self:UpdateAttr(arg_4_1)

	return
end

function BattleBuffAddAttr:onStack(arg_5_1, arg_5_2)
	self._number = self._numberBase * math.min(arg_5_2._stackCap, arg_5_2._stack)

	self:UpdateAttr(arg_5_1)

	return
end

function BattleBuffAddAttr:onRemove(arg_6_1, arg_6_2)
	self._number = 0

	self:UpdateAttr(arg_6_1)

	return
end

function BattleBuffAddAttr:IsSameAttr(arg_7_1)
	return self._attr == arg_7_1
end

function BattleBuffAddAttr:UpdateAttr(arg_8_1)
	assert(self._attr ~= "velocity", ">>BattleBuffAddAttr(Ratio)不可用于修改速度，使用BattleBuffFixVelocity!")

	if self._attr == "injureRatio" then
		self:UpdateAttrMul(arg_8_1)
	else
		self:UpdateAttrAdd(arg_8_1)
	end

	if self._attr == "cloakExposeExtra" or self._attr == "cloakRestore" or self._attr == "cloakRecovery" then
		arg_8_1:UpdateCloakConfig()
	end

	if self._attr == "lockAimBias" then
		arg_8_1:UpdateAimBiasSkillState()
	end

	return
end

function BattleBuffAddAttr:CheckWeapon()
	if self._attr == "loadSpeed" then
		return true
	else
		return false
	end

	return
end

function BattleBuffAddAttr:UpdateAttrMul(arg_10_1)
	local var_10_0 = 1
	local var_10_1 = 1
	local var_10_2 = {}
	local var_10_3 = {}

	for iter_10_0, iter_10_1 in pairs((arg_10_1:GetBuffList())) do
		for iter_10_2, iter_10_3 in ipairs(iter_10_1._effectList) do
			if iter_10_3:GetEffectType() == BattleBuffAddAttr.FX_TYPE and iter_10_3:IsSameAttr(self._attr) then
				local var_10_4 = var_10_2[iter_10_3._group] or 0
				local var_10_5 = var_10_3[iter_10_3._group] or 0

				if var_10_4 < iter_10_3._number and iter_10_3._number > 0 then
					var_10_0 = var_10_0 * (1 + iter_10_3._number) / (1 + var_10_4)
					var_10_4 = iter_10_3._number
				end

				if iter_10_3._number < var_10_5 and iter_10_3._number < 0 then
					var_10_1 = var_10_1 * (1 + iter_10_3._number) / (1 + var_10_5)
					var_10_5 = iter_10_3._number
				end

				var_10_2[iter_10_3._group] = var_10_4
				var_10_3[iter_10_3._group] = var_10_5
			end
		end
	end

	var_0_0.Battle.BattleAttr.FlashByBuff(arg_10_1, self._attr, var_10_0 * var_10_1 - 1)

	if self:CheckWeapon() then
		arg_10_1:FlushReloadingWeapon()
	end

	return
end

function BattleBuffAddAttr:UpdateAttrAdd(arg_11_1)
	local var_11_0, var_11_1 = arg_11_1:GetHP()
	local var_11_2 = 0
	local var_11_3 = 0
	local var_11_4 = {}
	local var_11_5 = {}

	for iter_11_0, iter_11_1 in pairs((arg_11_1:GetBuffList())) do
		for iter_11_2, iter_11_3 in ipairs(iter_11_1._effectList) do
			if iter_11_3:GetEffectType() == BattleBuffAddAttr.FX_TYPE and iter_11_3:IsSameAttr(self._attr) then
				local var_11_6 = var_11_4[iter_11_3._group] or 0
				local var_11_7 = var_11_5[iter_11_3._group] or 0

				if var_11_6 < iter_11_3._number and iter_11_3._number > 0 then
					var_11_2 = var_11_2 + iter_11_3._number - var_11_6
					var_11_6 = iter_11_3._number
				end

				if iter_11_3._number < var_11_7 and iter_11_3._number < 0 then
					var_11_3 = var_11_3 + iter_11_3._number - var_11_7
					var_11_7 = iter_11_3._number
				end

				var_11_4[iter_11_3._group] = var_11_6
				var_11_5[iter_11_3._group] = var_11_7
			end
		end
	end

	var_0_0.Battle.BattleAttr.FlashByBuff(arg_11_1, self._attr, var_11_2 + var_11_3)

	local var_11_8 = arg_11_1:GetMaxHP()

	arg_11_1:SetCurrentHP((math.min(var_11_8, var_11_0 + math.max(0, var_11_8 - var_11_1))))

	if self:CheckWeapon() then
		arg_11_1:FlushReloadingWeapon()
	end

	arg_11_1._move:ImmuneAreaLimit(var_0_0.Battle.BattleAttr.IsImmuneAreaLimit(arg_11_1))
	arg_11_1._move:ImmuneMaxAreaLimit(var_0_0.Battle.BattleAttr.IsImmuneMaxAreaLimit(arg_11_1))

	return
end

return
