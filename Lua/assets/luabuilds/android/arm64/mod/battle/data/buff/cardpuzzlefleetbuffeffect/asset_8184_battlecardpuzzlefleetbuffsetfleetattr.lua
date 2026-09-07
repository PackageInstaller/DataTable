ys = ys or {}

local BattleCardPuzzleFleetBuffSetFleetAttr = class("BattleCardPuzzleFleetBuffSetFleetAttr", ys.Battle.BattleFleetBuffEffect)

ys.Battle.BattleCardPuzzleFleetBuffSetFleetAttr = BattleCardPuzzleFleetBuffSetFleetAttr
BattleCardPuzzleFleetBuffSetFleetAttr.__name = "BattleCardPuzzleFleetBuffSetFleetAttr"
BattleCardPuzzleFleetBuffSetFleetAttr.FX_TYPE = ys.Battle.BattleBuffEffect.FX_TYPE_MOD_ATTR

function BattleCardPuzzleFleetBuffSetFleetAttr:Ctor(arg_1_1)
	self._tempData = Clone(arg_1_1)
	self._type = self._tempData.type

	self:SetActive()

	return
end

function BattleCardPuzzleFleetBuffSetFleetAttr:GetEffectType()
	return BattleCardPuzzleFleetBuffSetFleetAttr.FX_TYPE
end

function BattleCardPuzzleFleetBuffSetFleetAttr:SetArgs(arg_3_1, arg_3_2)
	BattleCardPuzzleFleetBuffSetFleetAttr.super.SetArgs(self, arg_3_1, arg_3_2)

	self._group = self._tempData.arg_list.group or self._fleetBuff:GetID()
	self._attr = self._tempData.arg_list.attr
	self._number = self._tempData.arg_list.number

	if self._tempData.arg_list.enhance_formula then
		self._number = DBGformula.parseFormula(self._tempData.arg_list.enhance_formula, arg_3_1:GetAttrManager()) + self._number
	end

	self._cache = self._tempData.arg_list.maintain
	self._numberBase = self._number

	return
end

function BattleCardPuzzleFleetBuffSetFleetAttr:onRemove()
	if self._cache then
		self._number = 0
	end

	self:onTrigger()

	return
end

function BattleCardPuzzleFleetBuffSetFleetAttr:GetGroup()
	return self._group
end

function BattleCardPuzzleFleetBuffSetFleetAttr:GetNumber()
	return self._number * self._fleetBuff:GetStack()
end

function BattleCardPuzzleFleetBuffSetFleetAttr:IsSameAttr(arg_7_1)
	return self._attr == arg_7_1
end

function BattleCardPuzzleFleetBuffSetFleetAttr:onTrigger()
	self._cardPuzzleComponent:UpdateAttrBySet(self._attr, self:GetNumber())

	return
end

return
