local BattleResultStormAwardComp = class("BattleResultStormAwardComp", require("app.fairyGUI.battleResult.UI_BattleResultStormAwardComp"))

function BattleResultStormAwardComp:ctor()
	self._awards = {}

	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardListRenderer))
	self.m_enterTransition:setHook("listLeftIn", handler(self, self._onTransAward))
end

function BattleResultStormAwardComp:_onTransAward()
	if self._awards then
		self.m_awardList:setNumItems(#self._awards)
		self.m_awardList:transitionShowCells("listIconUiLeftIn", 0.03, 1)
	end
end

function BattleResultStormAwardComp:_onAwardListRenderer(arg_3_1, arg_3_2)
	arg_3_2._inAnim = arg_3_2._inAnim or arg_3_2.getSharedTrans(arg_3_2, "listIconUiLeftIn", "ItemBagList", arg_3_2)

	arg_3_2:updateIcon(self._awards[arg_3_1 + 1])
end

function BattleResultStormAwardComp:update(arg_4_1)
	self._awards = {}

	if arg_4_1.challenge_award then
		table.insert(self._awards, arg_4_1.challenge_award)
	end

	if arg_4_1.score_award then
		table.insert(self._awards, arg_4_1.score_award)
	end

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.awards) do
		table.insert(self._awards, iter_4_1)
	end
end

return BattleResultStormAwardComp
