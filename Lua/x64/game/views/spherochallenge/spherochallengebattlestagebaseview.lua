local var_0_0 = class("SPHeroChallengeBattleStageBaseView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.activityID_ = arg_1_2

	local var_1_0 = Asset.Load(arg_1_0:UIName())

	arg_1_0.gameObject_ = Object.Instantiate(var_1_0, arg_1_1.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.GetUIName(arg_2_0)
	return
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.Show(arg_4_0, arg_4_1)
	SetActive(arg_4_0.gameObject_, arg_4_1)
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)
	Object.Destroy(arg_5_0.gameObject_)

	arg_5_0.transform_ = nil
	arg_5_0.gameObject_ = nil
end

return var_0_0
