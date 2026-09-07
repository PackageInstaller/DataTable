ys = ys or {}

local var_0_0 = ys
local BattleBuffFixVelocity = class("BattleBuffFixVelocity", ys.Battle.BattleBuffAddAttr)

ys.Battle.BattleBuffFixVelocity = BattleBuffFixVelocity
BattleBuffFixVelocity.__name = "BattleBuffFixVelocity"
BattleBuffFixVelocity.FX_TYPE = ys.Battle.BattleBuffEffect.FX_TYPE_MOD_VELOCTIY

function BattleBuffFixVelocity:Ctor(arg_1_1)
	BattleBuffFixVelocity.super.Ctor(self, arg_1_1)

	return
end

function BattleBuffFixVelocity:GetEffectType()
	return var_0_0.Battle.BattleBuffEffect.FX_TYPE_MOD_VELOCTIY
end

function BattleBuffFixVelocity:SetArgs(arg_3_1, arg_3_2)
	self._group = self._tempData.arg_list.group or arg_3_2:GetID()
	self._baseAdd = var_0_0.Battle.BattleFormulas.ConvertShipSpeed(self._tempData.arg_list.add or 0)
	self._addValue = self._baseAdd
	self._baseMul = (self._tempData.arg_list.mul or 0) * 0.0001
	self._mulValue = self._baseMul

	return
end

function BattleBuffFixVelocity:onStack(arg_4_1, arg_4_2)
	self._addValue = self._baseAdd * arg_4_2._stack
	self._mulValue = self._baseMul * arg_4_2._stack

	self:UpdateAttr(arg_4_1)

	return
end

function BattleBuffFixVelocity:onRemove(arg_5_1, arg_5_2)
	self._addValue = 0
	self._mulValue = 0

	self:UpdateAttr(arg_5_1)

	return
end

function BattleBuffFixVelocity:UpdateAttr(arg_6_1)
	var_0_0.Battle.BattleAttr.FlashVelocity(arg_6_1, self:calcMulValue(arg_6_1), (self:calcAddValue(arg_6_1)))

	return
end

function BattleBuffFixVelocity:calcMulValue(arg_7_1)
	local var_7_0 = 1
	local var_7_1 = 1
	local var_7_2 = {}
	local var_7_3 = {}

	for iter_7_0, iter_7_1 in pairs((arg_7_1:GetBuffList())) do
		for iter_7_2, iter_7_3 in ipairs(iter_7_1._effectList) do
			if iter_7_3:GetEffectType() == BattleBuffFixVelocity.FX_TYPE then
				local var_7_4 = var_7_2[iter_7_3._group] or 1
				local var_7_5 = var_7_3[iter_7_3._group] or 1
				local var_7_6 = 1 + iter_7_3._mulValue

				if iter_7_3._mulValue > 0 and var_7_4 < var_7_6 then
					var_7_0 = var_7_0 / var_7_4 * var_7_6
					var_7_4 = var_7_6
				end

				if iter_7_3._mulValue < 0 and var_7_6 < var_7_5 then
					var_7_1 = var_7_1 / var_7_5 * var_7_6
					var_7_5 = var_7_6
				end

				var_7_2[iter_7_3._group] = var_7_4
				var_7_3[iter_7_3._group] = var_7_5
			end
		end
	end

	return var_7_0 * var_7_1
end

function BattleBuffFixVelocity:calcAddValue(arg_8_1)
	local var_8_0 = 0
	local var_8_1 = 0
	local var_8_2 = {}
	local var_8_3 = {}

	for iter_8_0, iter_8_1 in pairs((arg_8_1:GetBuffList())) do
		for iter_8_2, iter_8_3 in ipairs(iter_8_1._effectList) do
			if iter_8_3:GetEffectType() == BattleBuffFixVelocity.FX_TYPE then
				local var_8_4 = var_8_2[iter_8_3._group] or 0
				local var_8_5 = var_8_3[iter_8_3._group] or 0

				if var_8_4 < iter_8_3._addValue and iter_8_3._addValue > 0 then
					var_8_0 = var_8_0 + iter_8_3._addValue - var_8_4
					var_8_4 = iter_8_3._addValue
				end

				if iter_8_3._addValue < var_8_5 and iter_8_3._addValue < 0 then
					var_8_1 = var_8_1 + iter_8_3._addValue - var_8_5
					var_8_5 = iter_8_3._addValue
				end

				var_8_2[iter_8_3._group] = var_8_4
				var_8_3[iter_8_3._group] = var_8_5
			end
		end
	end

	return var_8_0 + var_8_1
end

return
