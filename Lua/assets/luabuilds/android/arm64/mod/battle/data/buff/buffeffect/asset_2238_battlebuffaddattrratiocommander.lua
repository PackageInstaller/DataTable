ys = ys or {}

local var_0_0 = ys
local BattleBuffAddAttrRatioCommander = class("BattleBuffAddAttrRatioCommander", ys.Battle.BattleBuffAddAttrRatio)

ys.Battle.BattleBuffAddAttrRatioCommander = BattleBuffAddAttrRatioCommander
BattleBuffAddAttrRatioCommander.__name = "BattleBuffAddAttrRatioCommander"

function BattleBuffAddAttrRatioCommander:Ctor(arg_1_1)
	BattleBuffAddAttrRatioCommander.super.Ctor(self, arg_1_1)

	return
end

function BattleBuffAddAttrRatioCommander:GetEffectType()
	return var_0_0.Battle.BattleBuffEffect.FX_TYPE_MOD_ATTR
end

function BattleBuffAddAttrRatioCommander:SetArgs(arg_3_1, arg_3_2)
	self._group = self._tempData.arg_list.group or arg_3_2:GetID()
	self._attr = self._tempData.arg_list.convertAttr
	self._number = self._commander:getAbilitys()[self._tempData.arg_list.ability].value * self._tempData.arg_list.convertRate * var_0_0.Battle.BattleAttr.GetBase(arg_3_1, self._attr) * 0.0001
	self._numberBase = self._number

	return
end

return
