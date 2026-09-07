ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleBuffSize = class("BattleBuffSize", ys.Battle.BattleBuffEffect)
ys.Battle.BattleBuffSize.__name = "BattleBuffSize"

local var_0_1 = ys.Battle.BattleBuffSize

ys.Battle.BattleBuffSize.FX_TYPE = ys.Battle.BattleBuffEffect.FX_TYPE_MOD_MODEL_SCALE

function ys.Battle.BattleBuffSize.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleBuffSize.GetEffectType(arg_2_0)
	return var_0_1.FX_TYPE
end

function ys.Battle.BattleBuffSize:SetArgs(arg_3_1, arg_3_2)
	self._group = self._tempData.arg_list.group or arg_3_2:GetID()
	self._base = self._tempData.arg_list.number or 1
	self._hpScale = self._tempData.arg_list.hp_scale or 0
	self._attr = "modelScale"

	return
end

function ys.Battle.BattleBuffSize:onHPRatioUpdate(arg_4_1, arg_4_2)
	self:doScale(arg_4_1)
	self:UpdateScale(arg_4_1)

	return
end

function ys.Battle.BattleBuffSize:onAttach(arg_5_1, arg_5_2)
	self:doScale(arg_5_1)
	self:UpdateScale(arg_5_1)

	return
end

function ys.Battle.BattleBuffSize:onStack(arg_6_1, arg_6_2)
	self:doScale(arg_6_1)

	local var_6_0 = self._number

	for iter_6_0 = 1, arg_6_2._stack do
		var_6_0 = var_6_0 * self._number
	end

	self._number = var_6_0

	self:UpdateScale(arg_6_1)

	return
end

function ys.Battle.BattleBuffSize:onRemove(arg_7_1, arg_7_2)
	self._number = 1

	self:UpdateScale(arg_7_1)

	return
end

function ys.Battle.BattleBuffSize.UpdateScale(arg_8_0, arg_8_1)
	local var_8_0 = 1
	local var_8_1 = 1
	local var_8_2 = {}
	local var_8_3 = {}

	for iter_8_0, iter_8_1 in pairs((arg_8_1:GetBuffList())) do
		for iter_8_2, iter_8_3 in ipairs(iter_8_1._effectList) do
			if iter_8_3:GetEffectType() == var_0_1.FX_TYPE then
				local var_8_4 = var_8_2[iter_8_3._group] or 1
				local var_8_5 = var_8_3[iter_8_3._group] or 1

				if var_8_4 < iter_8_3._number and iter_8_3._number > 1 then
					var_8_0 = var_8_0 * iter_8_3._number / var_8_4
					var_8_4 = iter_8_3._number
				end

				if iter_8_3._number < var_8_5 and iter_8_3._number < 1 then
					var_8_1 = var_8_1 * iter_8_3._number / var_8_5
					var_8_5 = iter_8_3._number
				end

				var_8_2[iter_8_3._group] = var_8_4
				var_8_3[iter_8_3._group] = var_8_5
			end
		end
	end

	var_0_0.Battle.BattleAttr.SetCurrent(arg_8_1, "modelScale", var_0_0.Battle.BattleAttr.GetCurrent(arg_8_1, "baseScale") * var_8_0 * var_8_1)
	arg_8_1:DispatchEvent(var_0_0.Event.New(var_0_0.Battle.BattleBuffEvent.BUFF_EFFECT_CHNAGE_SIZE))

	return
end

function ys.Battle.BattleBuffSize:doScale(arg_9_1)
	self._number = self._base + arg_9_1:GetHPRate() * self._hpScale

	return
end

return
