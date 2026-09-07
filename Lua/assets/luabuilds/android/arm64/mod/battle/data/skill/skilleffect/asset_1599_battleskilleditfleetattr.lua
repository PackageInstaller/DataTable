ys = ys or {}

local BattleSkillEditFleetAttr = class("BattleSkillEditFleetAttr", ys.Battle.BattleSkillEffect)

ys.Battle.BattleSkillEditFleetAttr = BattleSkillEditFleetAttr
BattleSkillEditFleetAttr.__name = "BattleSkillEditFleetAttr"

function BattleSkillEditFleetAttr:Ctor(arg_1_1, arg_1_2)
	BattleSkillEditFleetAttr.super.Ctor(self, arg_1_1, arg_1_2)

	self._fleetAttrName = self._tempData.arg_list.attr
	self._value = self._tempData.arg_list.value

	return
end

function BattleSkillEditFleetAttr:DoDataEffect(arg_2_1, arg_2_2)
	if arg_2_1:GetFleetVO() then
		local var_2_0 = arg_2_1:GetFleetVO():GetFleetAttr()

		var_2_0:SetCurrent(self._fleetAttrName, var_2_0:GetCurrent(self._fleetAttrName) + self._value)
	end

	return
end

return
