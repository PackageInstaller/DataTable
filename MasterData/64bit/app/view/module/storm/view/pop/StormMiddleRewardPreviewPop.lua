local StormMiddleRewardPreviewPop = class("StormMiddleRewardPreviewPop", require("app.fairyGUI.storm.UI_StormMiddleRewardPreviewPop"), function()
	return fgui.GComponent:create({
		resName = "StormMiddleRewardPreviewPop",
		pkgName = "storm",
		pkgPath = "ui/storm/storm"
	}, ...)
end)

function StormMiddleRewardPreviewPop:ctor(arg_2_1)
	self.m_popPanel:setTitleName(g.core.lang:get(304530))
	self:showAtCenter()

	local var_2_0 = g.core.config.drop_info.get(g.core.config.storm_event_info.get(g.core.config.storm_cell_event_info.get((arg_2_1:getBindID())).event_id_1).challenge_reward, 1)
	local var_2_1 = {}

	for iter_2_0 = 1, 5 do
		if var_2_0["reward_type_" .. iter_2_0] and var_2_0["reward_type_" .. iter_2_0] ~= 0 then
			table.insert(var_2_1, {
				type = var_2_0["reward_type_" .. iter_2_0],
				value = var_2_0["reward_value_" .. iter_2_0],
				size = var_2_0["reward_min_" .. iter_2_0]
			})
		end
	end

	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._onRewardItemRenderer))

	self._rewards = var_2_1

	self.m_rewardList:setNumItems(#self._rewards)
end

function StormMiddleRewardPreviewPop:_onRewardItemRenderer(arg_3_1, arg_3_2)
	arg_3_2:updateIcon(self._rewards[arg_3_1 + 1])
end

return StormMiddleRewardPreviewPop
