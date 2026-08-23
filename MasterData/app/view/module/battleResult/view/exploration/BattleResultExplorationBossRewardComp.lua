local BattleResultExplorationBossRewardComp = class("BattleResultExplorationBossRewardComp", require("app.fairyGUI.battleResult.UI_BattleResultExplorationBossRewardComp"))

function BattleResultExplorationBossRewardComp:ctor()
	self._awardItems = {}

	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._onAwardListRenderer))
end

function BattleResultExplorationBossRewardComp:update(arg_2_1)
	self._awardItems = arg_2_1.awardList or {}

	self.m_rewardList:setNumItems(#self._awardItems)
	self.m_rewardList:transitionShowCells("listIconUiLeftIn", 0.03, 1)
	self.m_demageTxt:setText(arg_2_1.damage or 0)
end

function BattleResultExplorationBossRewardComp:_onAwardListRenderer(arg_3_1, arg_3_2)
	arg_3_2._inAnim = arg_3_2._inAnim or arg_3_2.getSharedTrans(arg_3_2, "listIconUiLeftIn", "ItemBagList", arg_3_2)

	arg_3_2:updateIcon(self._awardItems[arg_3_1 + 1])
end

return BattleResultExplorationBossRewardComp
