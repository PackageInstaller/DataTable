ys = ys or {}

local var_0_0 = ys
local BattleBuffAddAttrRatio = class("BattleBuffAddAttrRatio", ys.Battle.BattleBuffAddAttr)

ys.Battle.BattleBuffAddAttrRatio = BattleBuffAddAttrRatio
BattleBuffAddAttrRatio.__name = "BattleBuffAddAttrRatio"

function BattleBuffAddAttrRatio:Ctor(arg_1_1)
	BattleBuffAddAttrRatio.super.Ctor(self, arg_1_1)

	return
end

function BattleBuffAddAttrRatio:GetEffectType()
	return var_0_0.Battle.BattleBuffEffect.FX_TYPE_MOD_ATTR
end

function BattleBuffAddAttrRatio:SetArgs(arg_3_1, arg_3_2)
	self._group = self._tempData.arg_list.group or arg_3_2:GetID()
	self._attr = self._tempData.arg_list.attr
	self._attrBound = self._tempData.arg_list.attrBound
	self._number = self._tempData.arg_list.number * var_0_0.Battle.BattleAttr.GetBase(arg_3_1, self._tempData.arg_list.convertAttr or self._attr) * 0.0001
	self._numberBase = self._number

	if self._attrBound then
		self._numberBase = math.min(self._numberBase, self._attrBound)
	end

	self._attrID = self._tempData.arg_list.attr_group_ID

	return
end

return
