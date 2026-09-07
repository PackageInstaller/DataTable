ys = ys or {}

local var_0_0 = ys
local BattleBuffAddAttrRatioBloodrage = class("BattleBuffAddAttrRatioBloodrage", ys.Battle.BattleBuffAddAttr)

ys.Battle.BattleBuffAddAttrRatioBloodrage = BattleBuffAddAttrRatioBloodrage
BattleBuffAddAttrRatioBloodrage.__name = "BattleBuffAddAttrRatioBloodrage"

function BattleBuffAddAttrRatioBloodrage:Ctor(arg_1_1)
	BattleBuffAddAttrRatioBloodrage.super.Ctor(self, arg_1_1)

	return
end

function BattleBuffAddAttrRatioBloodrage:GetEffectType()
	return var_0_0.Battle.BattleBuffEffect.FX_TYPE_MOD_ATTR
end

function BattleBuffAddAttrRatioBloodrage:SetArgs(arg_3_1, arg_3_2)
	self._group = self._tempData.arg_list.group or arg_3_2:GetID()
	self._attr = self._tempData.arg_list.attr
	self._threshold = self._tempData.arg_list.threshold
	self._value = self._tempData.arg_list.value
	self._attrBound = self._tempData.arg_list.attrBound
	self._number = 0

	return
end

function BattleBuffAddAttrRatioBloodrage:doOnHPRatioUpdate(arg_4_1, arg_4_2)
	self:UpdateAttr(arg_4_1)

	return
end

function BattleBuffAddAttrRatioBloodrage:calcBloodRageNumber(arg_5_1)
	local var_5_0 = arg_5_1:GetHPRate()

	if var_5_0 > self._threshold then
		self._number = 0
	else
		self._number = (self._threshold - var_5_0) / self._value * var_0_0.Battle.BattleAttr.GetBase(arg_5_1, self._attr) * 0.0001

		if self._attrBound then
			self._number = math.min(self._number, self._attrBound)
		end
	end

	return
end

function BattleBuffAddAttrRatioBloodrage:doOnHPRatioUpdate(arg_6_1, arg_6_2)
	self:calcBloodRageNumber(arg_6_1)
	self:UpdateAttr(arg_6_1)

	return
end

function BattleBuffAddAttrRatioBloodrage:onRemove(arg_7_1, arg_7_2)
	self._number = 0

	self:UpdateAttr(arg_7_1)

	return
end

return
