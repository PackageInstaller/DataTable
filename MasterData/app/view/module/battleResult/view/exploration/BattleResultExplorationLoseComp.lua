class("BattleResultExplorationLoseComp", require("app.fairyGUI.battleResult.UI_BattleResultExplorationLoseComp")).ctor = function(self)
	self._awardItems = {}

	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardListRenderer))
end
