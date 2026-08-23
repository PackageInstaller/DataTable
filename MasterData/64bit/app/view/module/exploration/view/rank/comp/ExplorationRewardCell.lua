local ExplorationRewardCell = class("ExplorationRewardCell", require("app.fairyGUI.exploration.UI_ExplorationRewardCell"))

function ExplorationRewardCell:ctor()
	self._rewardList = {}

	self.m_rewardList:setVirtual()
	self.m_rewardList:doFairyBatching(false)
	self.m_rewardList:setItemRenderer(handler(self, self._onRenderRewardList))
end

function ExplorationRewardCell:updateCell(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	self.m_hasBgController:setSelectedIndex((arg_2_1 + 1) % 2)

	self._rewardList = arg_2_4

	if arg_2_2 == arg_2_3 then
		self.m_rankTxt:updateRankIndex({
			rank = arg_2_2
		})
	else
		self.m_rankTxt:setCtrlState("rank", {
			index = 0
		})
		self.m_rankTxt:setTitle(g.core.lang:get(302510, {
			rank1 = arg_2_2,
			rank2 = arg_2_3
		}))
	end

	self.m_rewardList:setNumItems(#self._rewardList)
end

function ExplorationRewardCell:_onRenderRewardList(arg_3_1, arg_3_2)
	self._rewardList[arg_3_1 + 1].scaleIndex = 4

	arg_3_2:updateIcon(self._rewardList[arg_3_1 + 1])
end

return ExplorationRewardCell
