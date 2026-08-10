local var_0_0 = class("DormCharaterFatigueShowView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI(arg_3_0.go)
end

function var_0_0.OnEnter(arg_4_0)
	return
end

function var_0_0.RefreshView(arg_5_0, arg_5_1)
	local var_5_0 = DormData:GetHeroTemplateInfo(arg_5_1)

	arg_5_0.curFatigue.text = var_5_0:GetFatigue()
	arg_5_0.maxFatigue.text = "/" .. GameSetting.canteen_hero_fatigue_max.value[1]
	arg_5_0.recoverFatigue.text = string.format(GetTips("DORM_FATIGUE_PER_HOUR"), var_5_0:GetRecoverFatigueNum())
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
