local CompetitionCommonRankAwardCell = class("CompetitionCommonRankAwardCell", require("app.fairyGUI.competition.UI_CompetitionCommonRankAwardCell"))

function CompetitionCommonRankAwardCell:ctor()
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onRenderAwardList))
end

function CompetitionCommonRankAwardCell:updateCell(arg_2_1)
	if arg_2_1.min_rank == arg_2_1.max_rank then
		self.m_indexComp:setCtrlState("rank", {
			index = 1
		})
		self.m_indexComp:updateRankIndex({
			rank = arg_2_1.min_rank
		})
	else
		self.m_indexComp:setCtrlState("rank", {
			index = 0
		})
		self.m_indexComp:setTitle(arg_2_1.min_rank .. "-" .. arg_2_1.max_rank)
	end

	self._tmpRankAwardArr = {}

	for iter_2_0 = 1, 4 do
		if arg_2_1["reward_type" .. iter_2_0] ~= 0 then
			table.insert(self._tmpRankAwardArr, {
				type = arg_2_1["reward_type" .. iter_2_0],
				value = arg_2_1["reward_value" .. iter_2_0],
				size = arg_2_1["reward_size" .. iter_2_0]
			})
		end
	end

	self.m_awardList:setNumItems(#self._tmpRankAwardArr)
end

function CompetitionCommonRankAwardCell:_onRenderAwardList(arg_3_1, arg_3_2)
	if self._tmpRankAwardArr[arg_3_1 + 1] then
		arg_3_2:updateIcon(self._tmpRankAwardArr[arg_3_1 + 1])
	end
end

return CompetitionCommonRankAwardCell
