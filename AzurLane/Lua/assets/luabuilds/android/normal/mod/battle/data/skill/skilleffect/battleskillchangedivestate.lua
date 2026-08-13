ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleSkillChangeDiveState = var_0_10002("BattleSkillChangeDiveState", var_0.Battle.BattleSkillEffect)
var_0.Battle.BattleSkillChangeDiveState.__name = "BattleSkillChangeDiveState"

local var_0_2 = var_0.Battle.BattleSkillChangeDiveState

function var_0_2.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_2.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._state = arg_1_0._tempData.arg_list.state
	arg_1_0._expose = arg_1_0._tempData.arg_list.expose

	return
end

function var_0_2.DoDataEffect(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_2:IsAlive() then
		local var_2_0

		if not arg_2_2:GetOxyState() then
			var_2_0 = arg_2_2:InitOxygen()
		end

		arg_2_2:ChangeOxygenState(arg_2_0._state)
		var_2_0:SetForceExpose(arg_2_0._expose)
	end

	return
end

return
