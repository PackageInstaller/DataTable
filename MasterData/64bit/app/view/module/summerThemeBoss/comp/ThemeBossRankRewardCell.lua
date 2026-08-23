local ThemeBossRankRewardCell = class("ThemeBossRankRewardCell", require("app.fairyGUI.summerThemeBoss.UI_ThemeBossRankRewardCell"))

function ThemeBossRankRewardCell:ctor(arg_1_1)
	self._tmpRankAwardArr = nil

	self:_initRankReward()
end

function ThemeBossRankRewardCell:refreshRankCell(arg_2_1, arg_2_2, arg_2_3)
	self.m_haveBgController:setSelectedIndex(arg_2_2 % 2)

	local var_2_0 = arg_2_1.min_rank

	if arg_2_1.min_rank ~= arg_2_1.max_rank then
		var_2_0 = var_2_0 .. "-" .. arg_2_1.max_rank
	end

	self.m_numTxt:setText(var_2_0)

	if arg_2_1.min_rank < 4 and arg_2_1.min_rank == arg_2_1.max_rank then
		self.m_numController:setSelectedIndex(arg_2_1.min_rank)
	else
		self.m_numController:setSelectedIndex(0)
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

function ThemeBossRankRewardCell:_initRankReward()
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onRenderAwardList))
end

function ThemeBossRankRewardCell:_onRenderAwardList(arg_4_1, arg_4_2)
	self._tmpRankAwardArr[arg_4_1 + 1].scaleIndex = 4
	self._tmpRankAwardArr[arg_4_1 + 1].hideNum = false

	arg_4_2:updateIcon(self._tmpRankAwardArr[arg_4_1 + 1])
end

return ThemeBossRankRewardCell
