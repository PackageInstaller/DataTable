local SlayerRewardItem_1_7 = class("SlayerRewardItem_1_7", (import("game.views.activity.Submodule.slayer.HellaSlayerRewardItem")))

function SlayerRewardItem_1_7:SetData(arg_1_1, arg_1_2)
	self.slayer_activity_id = arg_1_1
	self.region_activity_id = arg_1_2
	self.pointRewards = ActivitySlayerPointRewardCfg.get_id_list_by_activity_id[arg_1_2] or {}

	self:RefreshItem()

	self.hight = self.transform_.sizeDelta.y
	self.m_title.text = ActivitySlayerCfg[arg_1_2] and GetI18NText(ActivitySlayerCfg[arg_1_2].name) or ""
end

return SlayerRewardItem_1_7
