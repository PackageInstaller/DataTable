local var_0_0 = class("BuffDescriptionView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.scrollHelper_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.listGo_, BuffDescriptionItem)
end

function var_0_0.IndexItem(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2:RefreshUI(arg_4_0.list_[arg_4_1])
end

function var_0_0.AddUIListeners(arg_5_0)
	return
end

function var_0_0.OnEnter(arg_6_0)
	return
end

function var_0_0.RefreshUI(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.id_ = arg_7_1
	arg_7_0.type_ = arg_7_2
	arg_7_0.cfg_ = ActivityLimitCalculationCfg[arg_7_0.id_]

	if arg_7_0.type_ == "buff" then
		arg_7_0.title_.text = string.format(GetTips("ACTIVITY_LIMIT_CALCULATION_PLAYER_LEVEL"), arg_7_0.cfg_.player_level)
		arg_7_0.list_ = arg_7_0.cfg_.player_affix
	elseif arg_7_0.type_ == "debuff" then
		arg_7_0.title_.text = string.format(GetTips("ACTIVITY_LIMIT_CALCULATION_ENEMY_LEVEL"), arg_7_0.cfg_.enemy_level)
		arg_7_0.list_ = arg_7_0.cfg_.enemy_affix
	end

	arg_7_0.scrollHelper_:StartScroll(#arg_7_0.list_)
end

function var_0_0.OnExit(arg_8_0)
	return
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0:RemoveAllListeners()
	arg_9_0.scrollHelper_:Dispose()
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
