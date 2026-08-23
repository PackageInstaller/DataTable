local var_0_0 = g.core.config.rank_award_info
local GveSeasonAwardCell = class("GveSeasonAwardCell", require("app.fairyGUI.gve.UI_GveSeasonAwardCell"))

function GveSeasonAwardCell:ctor()
	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onRenderAwardList))
end

function GveSeasonAwardCell:updateSeasonAwardCell(arg_2_1)
	if arg_2_1.min_rank ~= arg_2_1.max_rank then
		self.m_indexComp:setCtrlState("rank", {
			index = 0
		})
		self.m_indexComp:setTitle(arg_2_1.min_rank .. "-" .. arg_2_1.max_rank)
	else
		self.m_indexComp:updateRankIndex({
			rank = arg_2_1.min_rank
		})
	end

	self._tmpRankAwardArr = {}

	while var_0_0.hasKey("reward_type" .. 1) do
		if arg_2_1["reward_type" .. 1] ~= 0 then
			table.insert(self._tmpRankAwardArr, {
				type = arg_2_1["reward_type" .. 1],
				value = arg_2_1["reward_value" .. 1],
				size = arg_2_1["reward_size" .. 1]
			})
		end
	end

	self.m_awardList:setNumItems(#self._tmpRankAwardArr)
end

function GveSeasonAwardCell:_onRenderAwardList(arg_3_1, arg_3_2)
	if self._tmpRankAwardArr[arg_3_1 + 1] then
		arg_3_2:updateIcon(self._tmpRankAwardArr[arg_3_1 + 1])
	end
end

return GveSeasonAwardCell
