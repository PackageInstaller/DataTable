local SpringFestivalZumaRankView = class("SpringFestivalZumaRankView", (import("game.views.activity.Submodule.Zuma.Normal.View.ZumaRankView")))

function SpringFestivalZumaRankView:UIName()
	return "Widget/Version/CORGUI_3_11/SandPlay_3_11/SandPlay_3_11_Zuma/SandPlay_3_11_ZumaRankUI"
end

local var_0_1 = {
	ALL = 1,
	GUILD = 2
}

function SpringFestivalZumaRankView:Init()
	self:InitUI()
	self:AddUIListener()

	self.titleTxt_.text = GetI18NText(ActivityCfg[ActivityConst.ACTIVITY_3_11_ZUMA].remark)
	self.curRankType_ = var_0_1.ALL
end

return SpringFestivalZumaRankView
