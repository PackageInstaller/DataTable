local ElderUserRankComp = class("ElderUserRankComp", require("app.fairyGUI.elderBoss.UI_ElderUserRankComp"))

function ElderUserRankComp:ctor()
	self.m_rankList:setVirtual()
	self.m_rankList:setItemRenderer(handler(self, self._onRankListRenderer))
	self.m_rankList:doFairyBatching(false)
end

function ElderUserRankComp:_onRankListRenderer(arg_2_1, arg_2_2)
	arg_2_2:updateView(self._rankList[arg_2_1 + 1], self._rankAwardType, arg_2_1)
end

function ElderUserRankComp:updateView(arg_3_1, arg_3_2)
	if arg_3_1 == nil or #arg_3_1 == 0 then
		self.m_emptyController:setSelectedIndex(0)

		return
	end

	self.m_emptyController:setSelectedIndex(1)

	self._rankList = arg_3_1
	self._rankAwardType = arg_3_2

	self.m_rankList:setNumItems(#self._rankList)
end

return ElderUserRankComp
