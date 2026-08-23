local TeamPVPRankRewardCell = class("TeamPVPRankRewardCell", require("app.fairyGUI.teamPVP.UI_TeamPVPRankRewardCell"))

function TeamPVPRankRewardCell:ctor()
	self._rewardData = {}

	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._onRenderRewardList))
end

function TeamPVPRankRewardCell:updateCell(arg_2_1, arg_2_2)
	self.m_hasBgController:setSelectedIndex(arg_2_2 % 2 == 0 and 1 or 0)

	self._rewardData = arg_2_1.data or {}

	self.m_rankIndexComp:setVisible(arg_2_1.minRank == arg_2_1.maxRank)
	self.m_rankRange:setVisible(arg_2_1.minRank ~= arg_2_1.maxRank)

	if arg_2_1.minRank == arg_2_1.maxRank then
		self.m_rankIndexComp:updateRankIndex({
			rank = arg_2_1.minRank
		})
	else
		self.m_rankRange:setText(g.core.lang:get(420451, {
			min = arg_2_1.minRank,
			max = arg_2_1.maxRank
		}), nil, true)
	end

	self.m_rewardList:setNumItems(#self._rewardData)
end

function TeamPVPRankRewardCell:_onRenderRewardList(arg_3_1, arg_3_2)
	arg_3_2:updateIcon((g.core.common.Goods:convert(self._rewardData[arg_3_1 + 1])))
end

return TeamPVPRankRewardCell
