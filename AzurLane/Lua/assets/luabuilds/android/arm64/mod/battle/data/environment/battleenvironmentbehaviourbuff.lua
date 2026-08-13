ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst
local var_0_2 = var_0.Battle.BattleConfig

class = var_0_10003

local var_0_3 = var_0_10003("BattleEnvironmentBehaviourBuff", var_0.Battle.BattleEnvironmentBehaviour)

var_0.Battle.BattleEnvironmentBehaviourBuff = var_0_3
var_0_3.__name = "BattleEnvironmentBehaviourBuff"

function var_0_3.Ctor(arg_1_0)
	var_0_3.super.Ctor(arg_1_0)

	return
end

function var_0_3.SetTemplate(arg_2_0, arg_2_1)
	var_0_3.super.SetTemplate(arg_2_0, arg_2_1)

	arg_2_0._buffID = arg_2_0._tmpData.buff_id

	local var_2_0

	if not arg_2_0._tmpData.level then
		var_2_0 = 1
	end

	arg_2_0._buffLevel = var_2_0

	return
end

function var_0_3.doBehaviour(arg_3_0)
	ipairs = var_1_10001

	for iter_3_0, iter_3_1 in var_1_10001(arg_3_0._cldUnitList) do
		if iter_3_1:IsAlive() then
			local var_3_0 = var_0.Battle.BattleBuffUnit.New(arg_3_0._buffID, arg_3_0._buffLevel)

			iter_3_1:AddBuff(var_3_0)
		end
	end

	var_0_3.super.doBehaviour(arg_3_0)

	return
end

return
