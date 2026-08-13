ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst
local var_0_2 = var_0.Battle.BattleConfig

class = var_0_10003

local var_0_3 = var_0_10003("BattleEnvironmentBehaviourPlaySFX", var_0.Battle.BattleEnvironmentBehaviour)

var_0.Battle.BattleEnvironmentBehaviourPlaySFX = var_0_3
var_0_3.__name = "BattleEnvironmentBehaviourPlaySFX"

function var_0_3.Ctor(arg_1_0)
	var_0_3.super.Ctor(arg_1_0)

	return
end

function var_0_3.SetTemplate(arg_2_0, arg_2_1)
	var_0_3.super.SetTemplate(arg_2_0, arg_2_1)

	arg_2_0._sfx = arg_2_0._tmpData.SFX_ID

	return
end

function var_0_3.doBehaviour(arg_3_0)
	var_0.Battle.PlayBattleSFX(arg_3_0._sfx)
	var_0_3.super.doBehaviour(arg_3_0)

	return
end

return
