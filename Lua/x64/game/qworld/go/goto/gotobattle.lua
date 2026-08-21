local var_0_0 = class("GotoBattle", BaseGoto)

function var_0_0.GetBasePath(arg_1_0)
	return "game.qworld.go.gotoBattleImpl."
end

function var_0_0.Ctor(arg_2_0)
	arg_2_0.template = {
		DEFAULT = "GotoBattleBase",
		[BattleConst.STAGE_TYPE_NEW.SEA_WARFARE] = "GotoSeaWarfareBattle",
		[BattleConst.STAGE_TYPE_NEW.SAND_PLAY] = "GotoSandPlayBattle"
	}
end

function var_0_0.GetTemplateName(arg_3_0, arg_3_1)
	return arg_3_0.template[arg_3_1] or arg_3_0.template.DEFAULT
end

function var_0_0.Go(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, ...)
	local var_4_0 = arg_4_2[1]

	arg_4_0:InstantiateEntity(var_4_0):OnEnter(arg_4_2, arg_4_3)
end

return var_0_0
