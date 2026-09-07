ys = ys or {}

local var_0_0 = ys
local BattleBuffAddAttrConvert = class("BattleBuffAddAttrConvert", ys.Battle.BattleBuffAddAttr)

ys.Battle.BattleBuffAddAttrConvert = BattleBuffAddAttrConvert
BattleBuffAddAttrConvert.__name = "BattleBuffAddAttrConvert"

function BattleBuffAddAttrConvert:Ctor(arg_1_1)
	BattleBuffAddAttrConvert.super.Ctor(self, arg_1_1)

	return
end

function BattleBuffAddAttrConvert:GetEffectType()
	return var_0_0.Battle.BattleBuffEffect.FX_TYPE_MOD_ATTR
end

function BattleBuffAddAttrConvert:SetArgs(arg_3_1, arg_3_2)
	self._group = self._tempData.arg_list.group or arg_3_2:GetID()
	self._attr = self._tempData.arg_list.attr
	self._convertAttr = self._tempData.arg_list.convertAttr
	self._convertAttrValue = var_0_0.Battle.BattleAttr.GetBase(arg_3_1, self._convertAttr)
	self._convertRate = self._tempData.arg_list.convertRate
	self._number = (self._tempData.arg_list.number or 0) + self._convertAttrValue * self._convertRate
	self._numberBase = self._number

	return
end

return
