local BattleResultRichmanMonsterWinComp = class("BattleResultRichmanMonsterWinComp", require("app.fairyGUI.battleResult.UI_BattleResultRichmanMonsterWinComp"))

function BattleResultRichmanMonsterWinComp:ctor()
	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._renderRewardItem))
end

function BattleResultRichmanMonsterWinComp:update(arg_2_1)
	self._rewardItems = arg_2_1.awards or {}

	self.m_rewardList:setNumItems(#self._rewardItems)
	self.m_expTxt:setText(arg_2_1.exp)
end

function BattleResultRichmanMonsterWinComp:_renderRewardItem(arg_3_1, arg_3_2)
	arg_3_2:updateIcon(self._rewardItems[arg_3_1 + 1])
end

return BattleResultRichmanMonsterWinComp
