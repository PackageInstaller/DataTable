ys = ys or {}

local var_0_0 = ys
local BattleBuffAddAttrCommander = class("BattleBuffAddAttrCommander", ys.Battle.BattleBuffAddAttr)

ys.Battle.BattleBuffAddAttrCommander = BattleBuffAddAttrCommander
BattleBuffAddAttrCommander.__name = "BattleBuffAddAttrCommander"

function BattleBuffAddAttrCommander:Ctor(arg_1_1)
	BattleBuffAddAttrCommander.super.Ctor(self, arg_1_1)

	return
end

function BattleBuffAddAttrCommander:GetEffectType()
	return var_0_0.Battle.BattleBuffEffect.FX_TYPE_MOD_ATTR
end

function BattleBuffAddAttrCommander:SetArgs(arg_3_1, arg_3_2)
	self._group = self._tempData.arg_list.group or arg_3_2:GetID()
	self._attr = self._tempData.arg_list.convertAttr
	self._number = self._commander:getAbilitys()[self._tempData.arg_list.ability].value * self._tempData.arg_list.convertRate
	self._numberBase = self._number

	return
end

return
