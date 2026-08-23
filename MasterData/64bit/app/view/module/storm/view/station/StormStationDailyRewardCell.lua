local StormStationDailyRewardCell = class("StormStationDailyRewardCell", require("app.fairyGUI.storm.UI_StormStationDailyRewardCell"))

function StormStationDailyRewardCell:ctor()
	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)
	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._onRewardListRenderer))
	self.m_rewardList:doFairyBatching(true)
end

function StormStationDailyRewardCell:updateView(arg_2_1, arg_2_2)
	self.m_rankTxt:setText(arg_2_1.description)
	self.m_playerNameTxt:setText(arg_2_1.name)
	self.m_rankIcon:setURL(g.core.common.Path:getOfficialIcon(arg_2_1.res))

	self._awardData = {}

	self.m_bgController:setSelectedIndex(arg_2_2 % 2 == 0 and 0 or 1)

	for iter_2_0 = 1, 4 do
		if arg_2_1["reward_type" .. iter_2_0] > 0 then
			table.insert(self._awardData, {
				type = arg_2_1["reward_type" .. iter_2_0],
				value = arg_2_1["reward_value" .. iter_2_0],
				size = arg_2_1["reward_size" .. iter_2_0]
			})
		end
	end

	self.m_rewardList:setNumItems(#self._awardData)
end

function StormStationDailyRewardCell:_onRewardListRenderer(arg_3_1, arg_3_2)
	arg_3_2:updateIcon(self._awardData[arg_3_1 + 1])
end

return StormStationDailyRewardCell
