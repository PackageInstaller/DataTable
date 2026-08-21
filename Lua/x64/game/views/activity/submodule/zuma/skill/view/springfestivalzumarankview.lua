local var_0_0 = import("game.views.activity.Submodule.Zuma.Normal.View.ZumaRankView")
local var_0_1 = class("SpringFestivalZumaRankView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/Version/CORGUI_3_11/SandPlay_3_11/SandPlay_3_11_Zuma/SandPlay_3_11_ZumaRankUI"
end

local var_0_2 = {
	ALL = 1,
	GUILD = 2
}

function var_0_1.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()

	local var_2_0 = ActivityCfg[ActivityConst.ACTIVITY_3_11_ZUMA]

	arg_2_0.titleTxt_.text = GetI18NText(var_2_0.remark)
	arg_2_0.curRankType_ = var_0_2.ALL
end

return var_0_1
