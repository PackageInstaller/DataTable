local var_0_0 = g.core.model.User.elderBossData
local ElderBossResultRankComp = class("ElderBossResultRankComp", require("app.fairyGUI.elderBoss.UI_ElderBossResultRankComp"))

function ElderBossResultRankComp:ctor()
	self.m_rankList:setVirtual()
	self.m_rankList:setItemRenderer(handler(self, self._onRankListItemRender))
end

function ElderBossResultRankComp:_onRankListItemRender(arg_2_1, arg_2_2)
	arg_2_2:updateElement(self._rankList[arg_2_1 + 1])
end

function ElderBossResultRankComp:updateResultRank()
	self._rankList = var_0_0:getElderBossResultRankData()

	self.m_rankList:setNumItems(#self._rankList)
end

return ElderBossResultRankComp
