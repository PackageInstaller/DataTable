local var_0_0 = g.core.model.User.richmanData
local BattleResultRichmanRobPlayerWinComp = class("BattleResultRichmanRobPlayerWinComp", require("app.fairyGUI.battleResult.UI_BattleResultRichmanRobPlayerWinComp"))

function BattleResultRichmanRobPlayerWinComp:ctor()
	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._renderRewardItem))
end

function BattleResultRichmanRobPlayerWinComp:update(arg_2_1)
	self.m_winStateController:setSelectedIndex(arg_2_1.winIndex)

	self._rewardItems = var_0_0:getRobReward()

	self.m_rewardList:setNumItems(#self._rewardItems)

	if #self._rewardItems == 0 then
		self.m_withOutAward:setVisible(true)
		self.m_rewardList:setVisible(false)
	end
end

function BattleResultRichmanRobPlayerWinComp:_renderRewardItem(arg_3_1, arg_3_2)
	arg_3_2:updateIcon(self._rewardItems[arg_3_1 + 1])
end

return BattleResultRichmanRobPlayerWinComp
