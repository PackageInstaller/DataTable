local HellaSlayerRewardView = class("HellaSlayerRewardView", (import("game.views.activity.Submodule.slayer.HellaSlayerRewardView")))

function HellaSlayerRewardView:Refresh()
	local var_1_0 = 0
	local var_1_1 = 0

	for iter_1_0 = #self.regionList, 1, -1 do
		local var_1_2 = ActivitySlayerPointRewardCfg.get_id_list_by_activity_id[self.regionList[iter_1_0]] or {}

		var_1_0 = var_1_0 + #var_1_2

		local var_1_3 = SlayerData:GetPoint(self.slayer_activity_id, self.regionList[iter_1_0])

		for iter_1_1, iter_1_2 in ipairs(var_1_2) do
			if var_1_3 >= ActivitySlayerPointRewardCfg[iter_1_2].need and not SlayerData:GetReceivedReward(self.slayer_activity_id, iter_1_2) then
				var_1_1 = iter_1_0
			end
		end
	end

	self.m_receiveLab.text = 0 + SlayerData:GetRewardCount(self.slayer_activity_id) .. "/" .. var_1_0

	for iter_1_3 = 1, #self.regionList do
		self.rewardItems[iter_1_3] = self.rewardItems[iter_1_3] or SlayerTools.GetRewardItemClass(self.slayer_activity_id).New((Object.Instantiate(self.m_item, self.m_content)))

		self.rewardItems[iter_1_3]:SetData(self.slayer_activity_id, self.regionList[iter_1_3])
		self.rewardItems[iter_1_3]:SetActive(true)
	end

	for iter_1_4 = #self.regionList + 1, #self.rewardItems do
		self.rewardItems[iter_1_4]:SetActive(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_content)

	if var_1_1 ~= 0 then
		local var_1_4 = 0

		for iter_1_5 = 1, var_1_1 - 1 do
			var_1_4 = var_1_4 + (self.rewardItems[iter_1_5] and self.rewardItems[iter_1_5]:GetHeight() or 0)
		end

		self.m_content.anchoredPosition = Vector2.New(0, var_1_4)
	end
end

return HellaSlayerRewardView
