local var_0_0 = import("game.views.activity.Submodule.slayer.HellaSlayerRewardItem")
local var_0_1 = class("SlayerRewardItem_1_7", var_0_0)

function var_0_1.SetData(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.slayer_activity_id = arg_1_1
	arg_1_0.region_activity_id = arg_1_2
	arg_1_0.pointRewards = ActivitySlayerPointRewardCfg.get_id_list_by_activity_id[arg_1_2] or {}

	arg_1_0:RefreshItem()

	arg_1_0.hight = arg_1_0.transform_.sizeDelta.y
	arg_1_0.m_title.text = ActivitySlayerCfg[arg_1_2] and GetI18NText(ActivitySlayerCfg[arg_1_2].name) or ""
end

return var_0_1
