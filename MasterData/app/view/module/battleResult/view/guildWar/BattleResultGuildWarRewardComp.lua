local BattleResultGuildWarRewardComp = class("BattleResultGuildWarRewardComp", require("app.fairyGUI.battleResult.UI_BattleResultGuildWarRewardComp"))

function BattleResultGuildWarRewardComp:ctor()
	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._onRewardRenderer))
end

function BattleResultGuildWarRewardComp:update(arg_2_1)
	self.m_scoreTxt:setText(arg_2_1.score)

	self._rewards = arg_2_1.awards

	self.m_rewardList:setNumItems(#self._rewards)
end

function BattleResultGuildWarRewardComp:_onRewardRenderer(arg_3_1, arg_3_2)
	arg_3_2:updateIcon(self._rewards[arg_3_1 + 1])
end

return BattleResultGuildWarRewardComp
