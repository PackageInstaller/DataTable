local var_0_0 = class("SwimsuitBattleVoteRankItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
end

function var_0_0.SetData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.nameText_.text = HeroTools.GetHeroFullName(SwimsuitVoteHeroCfg[arg_2_1].hero_id)
	arg_2_0.voteNum_.text = arg_2_2
end

function var_0_0.Dispose(arg_3_0)
	var_0_0.super.Dispose(arg_3_0)
end

return var_0_0
