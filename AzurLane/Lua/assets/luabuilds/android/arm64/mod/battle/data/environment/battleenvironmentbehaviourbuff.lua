ys = ys or {}

local var_0_2 = class("BattleEnvironmentBehaviourBuff", ys.Battle.BattleEnvironmentBehaviour)

ys.Battle.BattleEnvironmentBehaviourBuff = var_0_2
var_0_2.__name = "BattleEnvironmentBehaviourBuff"

function var_0_2.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	return
end

function var_0_2.SetTemplate(arg_2_0, arg_2_1)
	var_0_2.super.SetTemplate(arg_2_0, arg_2_1)

	arg_2_0._buffID = arg_2_0._tmpData.buff_id
	arg_2_0._buffLevel = arg_2_0._tmpData.level or 1

	return
end

function var_0_2.doBehaviour(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0._cldUnitList) do
		if iter_3_1:IsAlive() then
			iter_3_1:AddBuff((var_0.Battle.BattleBuffUnit.New(arg_3_0._buffID, arg_3_0._buffLevel)))
		end
	end

	var_0_2.super.doBehaviour(arg_3_0)

	return
end

return
