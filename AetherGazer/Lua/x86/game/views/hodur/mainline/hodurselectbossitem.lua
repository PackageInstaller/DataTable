local var_0_0 = class("HodurSelectBossItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
end

function var_0_0.SetData(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.bossID_ = arg_3_1
	arg_3_0.skillIndex_ = arg_3_2

	arg_3_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_4_0)
	local var_4_0 = MonsterCfg[arg_4_0.bossID_]

	arg_4_0.nameText_.text = var_4_0["skill" .. arg_4_0.skillIndex_]
	arg_4_0.descText_.text = var_4_0["skill_desc" .. arg_4_0.skillIndex_]

	if var_4_0["skill" .. arg_4_0.skillIndex_] == "" then
		arg_4_0:Show(false)
	else
		arg_4_0:Show(true)
	end
end

function var_0_0.Show(arg_5_0, arg_5_1)
	SetActive(arg_5_0.gameObject_, arg_5_1)
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
