ys = ys or {}

local var_0_2 = class("BattleEnvironmentBehaviourPlaySFX", ys.Battle.BattleEnvironmentBehaviour)

ys.Battle.BattleEnvironmentBehaviourPlaySFX = var_0_2
var_0_2.__name = "BattleEnvironmentBehaviourPlaySFX"

function var_0_2.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	return
end

function var_0_2.SetTemplate(arg_2_0, arg_2_1)
	var_0_2.super.SetTemplate(arg_2_0, arg_2_1)

	arg_2_0._sfx = arg_2_0._tmpData.SFX_ID

	return
end

function var_0_2.doBehaviour(arg_3_0)
	var_0.Battle.PlayBattleSFX(arg_3_0._sfx)
	var_0_2.super.doBehaviour(arg_3_0)

	return
end

return
