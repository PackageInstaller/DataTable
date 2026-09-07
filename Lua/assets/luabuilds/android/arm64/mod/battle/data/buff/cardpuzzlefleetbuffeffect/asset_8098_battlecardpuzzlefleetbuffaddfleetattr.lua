ys = ys or {}

local var_0_0 = ys.Battle.BattleCardPuzzleFormulas
local BattleCardPuzzleFleetBuffAddFleetAttr = class("BattleCardPuzzleFleetBuffAddFleetAttr", ys.Battle.BattleFleetBuffEffect)

ys.Battle.BattleCardPuzzleFleetBuffAddFleetAttr = BattleCardPuzzleFleetBuffAddFleetAttr
BattleCardPuzzleFleetBuffAddFleetAttr.__name = "BattleCardPuzzleFleetBuffAddFleetAttr"
BattleCardPuzzleFleetBuffAddFleetAttr.FX_TYPE = ys.Battle.BattleBuffEffect.FX_TYPE_MOD_ATTR

function BattleCardPuzzleFleetBuffAddFleetAttr:Ctor(arg_1_1)
	self._tempData = Clone(arg_1_1)
	self._type = self._tempData.type

	self:SetActive()

	return
end

function BattleCardPuzzleFleetBuffAddFleetAttr:GetEffectType()
	return BattleCardPuzzleFleetBuffAddFleetAttr.FX_TYPE
end

function BattleCardPuzzleFleetBuffAddFleetAttr:SetArgs(arg_3_1, arg_3_2)
	BattleCardPuzzleFleetBuffAddFleetAttr.super.SetArgs(self, arg_3_1, arg_3_2)

	self._group = self._tempData.arg_list.group or self._fleetBuff:GetID()
	self._attr = self._tempData.arg_list.attr
	self._number = self._tempData.arg_list.number

	if self._tempData.arg_list.enhance_formula then
		self._number = var_0_0.parseFormula(self._tempData.arg_list.enhance_formula, arg_3_1:GetAttrManager()) + self._number
	end

	self._cache = self._tempData.arg_list.maintain
	self._numberBase = self._number

	return
end

function BattleCardPuzzleFleetBuffAddFleetAttr:onRemove()
	if self._cache then
		self._number = 0
	end

	self:onTrigger()

	return
end

function BattleCardPuzzleFleetBuffAddFleetAttr:GetGroup()
	return self._group
end

function BattleCardPuzzleFleetBuffAddFleetAttr:GetNumber()
	return self._number * self._fleetBuff:GetStack()
end

function BattleCardPuzzleFleetBuffAddFleetAttr:IsSameAttr(arg_7_1)
	return self._attr == arg_7_1
end

function BattleCardPuzzleFleetBuffAddFleetAttr:onTrigger()
	if self._cache then
		local var_8_0 = 0
		local var_8_1 = 0
		local var_8_2 = {}
		local var_8_3 = {}

		for iter_8_0, iter_8_1 in pairs((self._cardPuzzleComponent:GetBuffManager():GetCardPuzzleBuffList())) do
			for iter_8_2, iter_8_3 in ipairs(iter_8_1._effectList) do
				if iter_8_3:GetEffectType() == BattleCardPuzzleFleetBuffAddFleetAttr.FX_TYPE and iter_8_3:IsSameAttr(self._attr) then
					local var_8_4 = iter_8_3:GetNumber()
					local var_8_5 = iter_8_3:GetGroup()
					local var_8_6 = var_8_2[var_8_5] or 0
					local var_8_7 = var_8_3[var_8_5] or 0

					if var_8_6 < var_8_4 and var_8_4 > 0 then
						var_8_0 = var_8_0 + var_8_4 - var_8_6
						var_8_6 = var_8_4
					end

					if var_8_4 < var_8_7 and var_8_4 < 0 then
						var_8_1 = var_8_1 + var_8_4 - var_8_7
						var_8_7 = var_8_4
					end

					var_8_2[var_8_5] = var_8_6
					var_8_3[var_8_5] = var_8_7
				end
			end
		end

		self._cardPuzzleComponent:UpdateAttrByBuff(self._attr, var_8_0 + var_8_1)
	else
		self._cardPuzzleComponent:AddAttrBySkill(self._attr, self:GetNumber())
	end

	return
end

return
