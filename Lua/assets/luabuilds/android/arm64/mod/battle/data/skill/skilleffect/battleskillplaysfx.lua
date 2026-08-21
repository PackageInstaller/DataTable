ys = ys or {}

local var_0_0 = class("BattleSkillPlaySFX", ys.Battle.BattleSkillEffect)

ys.Battle.BattleSkillPlaySFX = var_0_0
var_0_0.__name = "BattleSkillPlaySFX"

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._SFXID = arg_1_0._tempData.arg_list.sound_effect

	return
end

function var_0_0.DoDataEffect(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:playSound()

	return
end

function var_0_0.DoDataEffectWithoutTarget(arg_3_0, arg_3_1)
	arg_3_0:playSound()

	return
end

function var_0_0.playSound(arg_4_0)
	var_0.Battle.PlayBattleSFX(arg_4_0._SFXID)

	return
end

return
