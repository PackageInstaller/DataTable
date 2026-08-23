local BattleResultSpireBossAwardComp = class("BattleResultSpireBossAwardComp", require("app.fairyGUI.battleResult.UI_BattleResultSpireBossAwardComp"))

function BattleResultSpireBossAwardComp:ctor()
	self._awardItems = {}

	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardListRenderer))
end

function BattleResultSpireBossAwardComp:update(arg_2_1)
	self._awardItems = arg_2_1.awardList or {}

	self.m_awardList:setNumItems(#self._awardItems)

	if #self._awardItems > 0 then
		self.m_awardList:transitionShowCells("listIconUiLeftIn", 0.03, 1)
		self.m_stateController:setSelectedIndex(0)
	else
		self.m_stateController:setSelectedIndex(1)
	end

	self.m_scoreTxt:setText(arg_2_1.score)
	self.m_scoreBTxt:setText(arg_2_1.score)

	if arg_2_1.score - arg_2_1.lastScore > 0 then
		self.m_upScoreTxt:setText(arg_2_1.score - arg_2_1.lastScore)
		self.m_upScoreBTxt:setText(arg_2_1.score - arg_2_1.lastScore)
		self.m_showUpScoreController:setSelectedIndex(1)
	else
		self.m_showUpScoreController:setSelectedIndex(0)
	end

	self.m_damageTxt:setText(arg_2_1.damage)
	self.m_ratioTxt:setText(arg_2_1.ratio)
end

function BattleResultSpireBossAwardComp:_onAwardListRenderer(arg_3_1, arg_3_2)
	arg_3_2._inAnim = arg_3_2._inAnim or arg_3_2.getSharedTrans(arg_3_2, "listIconUiLeftIn", "ItemBagList", arg_3_2)

	arg_3_2:updateIcon(self._awardItems[arg_3_1 + 1])
end

return BattleResultSpireBossAwardComp
