ys = ys or {}

local var_0_0 = class("BattleSkillEditFleetAttr", ys.Battle.BattleSkillEffect)

ys.Battle.BattleSkillEditFleetAttr = var_0_0
var_0_0.__name = "BattleSkillEditFleetAttr"

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._fleetAttrName = arg_1_0._tempData.arg_list.attr
	arg_1_0._value = arg_1_0._tempData.arg_list.value

	return
end

function var_0_0.DoDataEffect(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1:GetFleetVO() then
		local var_2_0 = arg_2_1:GetFleetVO():GetFleetAttr()

		var_2_0:SetCurrent(arg_2_0._fleetAttrName, var_2_0:GetCurrent(arg_2_0._fleetAttrName) + arg_2_0._value)
	end

	return
end

return
