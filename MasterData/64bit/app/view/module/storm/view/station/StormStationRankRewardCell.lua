local StormStationRankRewardCell = class("StormStationRankRewardCell", require("app.fairyGUI.storm.UI_StormStationRankRewardCell"))

function StormStationRankRewardCell:ctor()
	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)
	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._onRewardItemRenderer))
end

function StormStationRankRewardCell:updateView(arg_2_1, arg_2_2)
	self._awardList = {}

	for iter_2_0 = 1, 4 do
		if arg_2_1["reward_type" .. iter_2_0] > 0 then
			table.insert(self._awardList, {
				type = arg_2_1["reward_type" .. iter_2_0],
				value = arg_2_1["reward_value" .. iter_2_0],
				size = arg_2_1["reward_size" .. iter_2_0]
			})
		end
	end

	self.m_bgController:setSelectedIndex(arg_2_2 % 2 == 0 and 0 or 1)
	self.m_rewardList:setNumItems(#self._awardList)

	local var_2_0 = g.core.config.storm_city_lord_info.get(arg_2_1.lord_id)

	self.m_rankIcon:setURL(g.core.common.Path:getOfficialIcon(var_2_0.res))
	self.m_playerNameTxt:setText(var_2_0.name)

	if arg_2_1.min_rank == arg_2_1.max_rank then
		self.m_rankTxt:setText(arg_2_1.min_rank)
	else
		self.m_rankTxt:setText(arg_2_1.min_rank .. " - " .. arg_2_1.max_rank)
	end
end

function StormStationRankRewardCell:_onRewardItemRenderer(arg_3_1, arg_3_2)
	arg_3_2:updateIcon(self._awardList[arg_3_1 + 1])
end

return StormStationRankRewardCell
