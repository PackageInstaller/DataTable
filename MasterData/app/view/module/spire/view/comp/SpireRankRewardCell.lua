local SpireRankRewardCell = class("SpireRankRewardCell", require("app.fairyGUI.spire.UI_SpireRankRewardCell"))

function SpireRankRewardCell:ctor()
	self._rewardList = {}

	self:_initListView()
end

function SpireRankRewardCell:_initListView()
	self.m_rewardList:setVirtual()
	self.m_rewardList:doFairyBatching(false)
	self.m_rewardList:setItemRenderer(handler(self, self._onRenderRewardList))
end

function SpireRankRewardCell:_onRenderRewardList(arg_3_1, arg_3_2)
	self._rewardList[arg_3_1 + 1].scaleIndex = 4

	arg_3_2:updateIcon(self._rewardList[arg_3_1 + 1])
end

function SpireRankRewardCell:updateCell(arg_4_1, arg_4_2)
	if arg_4_1.minRank == arg_4_1.maxRank then
		self.m_rankComp:updateRankIndex({
			rank = arg_4_1.minRank
		})
	else
		self.m_rankComp:setCtrlState("rank", {
			index = 0
		})
		self.m_rankComp:setTitle(g.core.lang:get(302510, {
			rank1 = arg_4_1.minRank,
			rank2 = arg_4_1.maxRank
		}))
	end

	self._rewardList = arg_4_1.data

	self.m_rewardList:setNumItems(#self._rewardList)
	self.m_hasBgController:setSelectedIndex(arg_4_2 % 2)
end

return SpireRankRewardCell
