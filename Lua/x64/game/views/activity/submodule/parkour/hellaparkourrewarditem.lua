local var_0_0 = class("HellaParkourRewardItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()

	arg_2_0.list = LuaList.New(handler(arg_2_0, arg_2_0.IndexItem), arg_2_0.m_list, HellaParkourRewardInfoItem)
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	arg_5_0.entrust_activity_id = arg_5_1

	local var_5_0 = ActivityParkourCfg[arg_5_1]

	arg_5_0.infos = var_5_0 and var_5_0.star_reward or {}

	arg_5_0.list:StartScroll(#arg_5_0.infos)

	arg_5_0.m_title.text = GetI18NText(var_5_0.name)
end

function var_0_0.IndexItem(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.infos[arg_6_1]

	arg_6_2:SetData(arg_6_1, arg_6_0.entrust_activity_id, var_6_0)
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0.list:Dispose()
	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
