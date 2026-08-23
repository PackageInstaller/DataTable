local var_0_0 = g.core.model.User.wushTowerData
local BattleResultWushTowerAwardComp = class("BattleResultWushTowerAwardComp", require("app.fairyGUI.battleResult.UI_BattleResultWushTowerAwardComp"))

function BattleResultWushTowerAwardComp:ctor()
	self.getSharedTrans(self, "listIconUiLeftIn", "ItemBagList", self)

	self._rewardItems = {}

	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._onRewardListRenderer))
end

function BattleResultWushTowerAwardComp:update(arg_2_1)
	self._rewardItems = arg_2_1.awards or {}

	self.m_rewardList:setNumItems(#self._rewardItems)
	self.m_rewardList:transitionShowCells("listIconUiLeftIn", 0.03, 1)

	local var_2_0 = var_0_0:getSumUserHp()
	local var_2_1 = table.nums((var_0_0:getWushTowerFormationHpMap())) * 1000

	self.m_hpProgBar:setPercent({
		cur = var_2_0,
		max = var_2_1
	})
	self.m_userHpTxt:setText(math.floor(var_2_0 / var_2_1 * 100) .. "%")
	self.m_stepCountTxt:setText((var_0_0:getCanChallengeCount()))
end

function BattleResultWushTowerAwardComp:_onRewardListRenderer(arg_3_1, arg_3_2)
	arg_3_2._inAnim = arg_3_2._inAnim or arg_3_2.getSharedTrans(arg_3_2, "listIconUiLeftIn", "ItemBagList", arg_3_2)

	arg_3_2:updateIcon(self._rewardItems[arg_3_1 + 1])
end

function BattleResultWushTowerAwardComp:play()
	self.m_enterTransition:play(handler(self, function()
		self:dispatchCompEvent("BattleResult_continue")
	end))

	return true
end

return BattleResultWushTowerAwardComp
