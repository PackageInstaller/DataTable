ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleSkillAddBuff = var_0_10002("BattleSkillAddBuff", var_0.Battle.BattleSkillEffect)
var_0.Battle.BattleSkillAddBuff.__name = "BattleSkillAddBuff"

function var_0.Battle.BattleSkillAddBuff.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0.Battle.BattleSkillAddBuff.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._buffID = arg_1_0._tempData.arg_list.buff_id

	return
end

function var_0.Battle.BattleSkillAddBuff.DoDataEffect(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_2:IsAlive() then
		local var_2_0 = var_0.Battle.BattleBuffUnit.New(arg_2_0._buffID, arg_2_0._level, arg_2_1)

		var_3.SetCommander(var_2_0, arg_2_0._commander)
		arg_2_2:AddBuff(var_3)
	end

	return
end

return
