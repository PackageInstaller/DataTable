local TeamBattleRewardComp = class("TeamBattleRewardComp", require("app.fairyGUI.battleResult.UI_TeamBattleRewardComp"))

function TeamBattleRewardComp:ctor()
	self._rewardItems = {}

	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onRewardListRenderer))
end

function TeamBattleRewardComp:update(arg_2_1)
	dump(arg_2_1, "TeamBattleRewardComp:update")

	self._rewardItems = arg_2_1.awards or {}

	self.m_awardList:setNumItems(#self._rewardItems)
	self.m_awardList:transitionShowCells("listIconUiLeftIn", 0.03, 1)
end

function TeamBattleRewardComp:_onRewardListRenderer(arg_3_1, arg_3_2)
	arg_3_2._inAnim = arg_3_2._inAnim or arg_3_2.getSharedTrans(arg_3_2, "listIconUiLeftIn", "ItemBagList", arg_3_2)

	arg_3_2:updateIcon(self._rewardItems[arg_3_1 + 1])
end

return TeamBattleRewardComp
