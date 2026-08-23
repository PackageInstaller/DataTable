local MysteryBossRankAwardCell = class("MysteryBossRankAwardCell", require("app.fairyGUI.mystery.UI_MysteryBossRankAwardCell"))

function MysteryBossRankAwardCell:ctor()
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardItemRender))
end

function MysteryBossRankAwardCell:_onAwardItemRender(arg_2_1, arg_2_2)
	arg_2_2:updateIcon(self._awards[arg_2_1 + 1])
end

function MysteryBossRankAwardCell:updateCell(arg_3_1, arg_3_2)
	if arg_3_1.minRank == arg_3_1.maxRank then
		self.m_rankIdxTxt:setText(arg_3_1.minRank)
	else
		self.m_rankIdxTxt:setText(g.core.lang:get(423520, {
			min = arg_3_1.minRank,
			max = arg_3_1.maxRank
		}))
	end

	self._awards = arg_3_1.data

	self.m_awardList:setNumItems(#self._awards)
	self.m_isHaveBgController:setSelectedIndex(arg_3_2 % 2)
end

return MysteryBossRankAwardCell
