local var_0_0 = class("StrongholdBattleResultAchieveItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.levelController = ControllerUtil.GetController(arg_3_0.transform_, "state")
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	local var_5_0 = ActivityStrongholdAchievementCfg[arg_5_1]

	arg_5_0.m_name.text = var_5_0.name

	arg_5_0.levelController:SetSelectedIndex(math.max(0, var_5_0.level - 1))
end

return var_0_0
