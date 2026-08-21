ys = ys or {}
ys.Battle.BattleSkillChangeDiveState = class("BattleSkillChangeDiveState", ys.Battle.BattleSkillEffect)
ys.Battle.BattleSkillChangeDiveState.__name = "BattleSkillChangeDiveState"

local var_0_0 = ys.Battle.BattleSkillChangeDiveState

function ys.Battle.BattleSkillChangeDiveState.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._state = arg_1_0._tempData.arg_list.state
	arg_1_0._expose = arg_1_0._tempData.arg_list.expose

	return
end

function ys.Battle.BattleSkillChangeDiveState.DoDataEffect(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_2:IsAlive() then
		local var_2_0 = arg_2_2:GetOxyState() or arg_2_2:InitOxygen()

		arg_2_2:ChangeOxygenState(arg_2_0._state)
		var_2_0:SetForceExpose(arg_2_0._expose)
	end

	return
end

return
