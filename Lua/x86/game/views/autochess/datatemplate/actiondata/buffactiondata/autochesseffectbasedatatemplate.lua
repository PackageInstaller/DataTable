local var_0_0 = import("game.views.autoChess.dataTemplate.actionData.AutoChessActionBaseDataTemplate")
local var_0_1 = class("AutoChessEffectBaseDataTemplate", var_0_0)

function var_0_1.Init(arg_1_0, arg_1_1)
	var_0_1.super.Init(arg_1_0, arg_1_1)

	arg_1_0.actionEffectType = AutoChessConst.ACTION_EFFECT_TYPE.ADD_ATTR
	arg_1_0.buffUid = arg_1_1.buff_uid

	arg_1_0:InitActionEffectData(arg_1_1.action_effect_info)
end

function var_0_1.InitActionEffectData(arg_2_0, arg_2_1)
	arg_2_0.actionEffectType = arg_2_1.effect_enum
	arg_2_0.buffUid = arg_2_1.buff_uid
end

return var_0_1
