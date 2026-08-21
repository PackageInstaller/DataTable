local var_0_0 = class("HellaSlayerRewardItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.GetHeight(arg_4_0)
	return arg_4_0.hight or 0
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.slayer_activity_id = arg_5_1
	arg_5_0.region_activity_id = arg_5_2
	arg_5_0.pointRewards = ActivitySlayerPointRewardCfg.get_id_list_by_activity_id[arg_5_2] or {}

	arg_5_0:RefreshItem()

	arg_5_0.hight = 100 + 190 * #arg_5_0.pointRewards
	arg_5_0.transform_.sizeDelta = Vector2.New(arg_5_0.transform_.rect.width, arg_5_0.hight)
	arg_5_0.m_title.text = ActivitySlayerCfg[arg_5_2] and GetI18NText(ActivitySlayerCfg[arg_5_2].name) or ""
end

function var_0_0.RefreshItem(arg_6_0)
	if not arg_6_0.list then
		arg_6_0.list = LuaList.New(handler(arg_6_0, arg_6_0.IndexItem), arg_6_0.m_list, SlayerTools.GetRewardFolderItemClass(arg_6_0.slayer_activity_id))
	end

	arg_6_0.list:StartScroll(#arg_6_0.pointRewards)
end

function var_0_0.SetActive(arg_7_0, arg_7_1)
	SetActive(arg_7_0.gameObject_, arg_7_1)

	if not arg_7_1 then
		arg_7_0.hight = 0
	end
end

function var_0_0.IndexItem(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.pointRewards[arg_8_1]

	arg_8_2:SetData(arg_8_0.slayer_activity_id, var_8_0)
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0.list:Dispose()
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
