ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleSkillEditFleetAttr", var_0.Battle.BattleSkillEffect)

var_0.Battle.BattleSkillEditFleetAttr = var_0_1
var_0_1.__name = "BattleSkillEditFleetAttr"

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._fleetAttrName = arg_1_0._tempData.arg_list.attr
	arg_1_0._value = arg_1_0._tempData.arg_list.value

	return
end

function var_0_1.DoDataEffect(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1:GetFleetVO() then
		local var_2_0 = arg_2_1:GetFleetVO()
		local var_2_1 = var_3.GetFleetAttr(var_2_0)
		local var_2_2 = var_3.GetCurrent(var_2_1, arg_2_0._fleetAttrName) + arg_2_0._value

		var_3:SetCurrent(arg_2_0._fleetAttrName, var_2_2)
	end

	return
end

return
