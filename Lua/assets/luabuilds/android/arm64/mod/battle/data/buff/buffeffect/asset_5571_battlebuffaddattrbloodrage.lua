ys = ys or {}

local var_0_0 = ys
local BattleBuffAddAttrBloodrage = class("BattleBuffAddAttrBloodrage", ys.Battle.BattleBuffAddAttr)

ys.Battle.BattleBuffAddAttrBloodrage = BattleBuffAddAttrBloodrage
BattleBuffAddAttrBloodrage.__name = "BattleBuffAddAttrBloodrage"

function BattleBuffAddAttrBloodrage:Ctor(arg_1_1)
	BattleBuffAddAttrBloodrage.super.Ctor(self, arg_1_1)

	return
end

function BattleBuffAddAttrBloodrage:GetEffectType()
	return var_0_0.Battle.BattleBuffEffect.FX_TYPE_MOD_ATTR
end

function BattleBuffAddAttrBloodrage:SetArgs(arg_3_1, arg_3_2)
	self._group = self._tempData.arg_list.group or arg_3_2:GetID()
	self._attr = self._tempData.arg_list.attr
	self._threshold = self._tempData.arg_list.threshold
	self._value = self._tempData.arg_list.value
	self._attrBound = self._tempData.arg_list.attrBound
	self._number = 0

	return
end

function BattleBuffAddAttrBloodrage:calcBloodRageNumber(arg_4_1)
	local var_4_0 = arg_4_1:GetHPRate()

	if var_4_0 > self._threshold then
		self._number = 0
	else
		self._number = (self._threshold - var_4_0) / self._value

		if self._attrBound then
			self._number = math.min(self._number, self._attrBound)
		end
	end

	return
end

function BattleBuffAddAttrBloodrage:doOnHPRatioUpdate(arg_5_1, arg_5_2)
	self:calcBloodRageNumber(arg_5_1)
	self:UpdateAttr(arg_5_1)

	return
end

function BattleBuffAddAttrBloodrage:onRemove(arg_6_1, arg_6_2)
	self._number = 0

	self:UpdateAttr(arg_6_1)

	return
end

return
