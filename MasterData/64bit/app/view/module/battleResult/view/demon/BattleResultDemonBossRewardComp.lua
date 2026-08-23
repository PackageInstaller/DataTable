local BattleResultDemonBossRewardComp = class("BattleResultDemonBossRewardComp", require("app.fairyGUI.battleResult.UI_BattleResultDemonBossRewardComp"))

function BattleResultDemonBossRewardComp:ctor()
	self._rewardItems = {}

	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._onRewardListRenderer))
end

function BattleResultDemonBossRewardComp:update(arg_2_1)
	self._rewardItems = arg_2_1.awards or {}

	self.m_rewardList:setNumItems(#self._rewardItems)
	self.m_rewardList:transitionShowCells("listIconUiLeftIn", 0.03, 1)
	self.m_scoreTxt:setText(arg_2_1.score)

	arg_2_1.bossAwardId = arg_2_1.bossAwardId
end

function BattleResultDemonBossRewardComp:_onRewardListRenderer(arg_3_1, arg_3_2)
	arg_3_2._inAnim = arg_3_2._inAnim or arg_3_2.getSharedTrans(arg_3_2, "listIconUiLeftIn", "ItemBagList", arg_3_2)

	arg_3_2:updateIcon(self._rewardItems[arg_3_1 + 1])
end

return BattleResultDemonBossRewardComp
