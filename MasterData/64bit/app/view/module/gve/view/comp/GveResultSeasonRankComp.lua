local var_0_0 = g.core.model.User.gveDataMgr
local GveResultSeasonRankCell = class("GveResultSeasonRankCell", require("app.fairyGUI.gve.UI_GveResultSeasonRankComp"))

function GveResultSeasonRankCell:ctor()
	self.m_rankList:setVirtual()
	self.m_rankList:setItemRenderer(handler(self, self._onRankRenderer))
end

function GveResultSeasonRankCell:updateResultRankInfo()
	self._resultRankData = var_0_0:getRankWorldGuild()

	if self._resultRankData then
		self.m_rankList:setNumItems(#self._resultRankData)
		self.m_rankList:transitionShowCells("enter_left", 0.03)
	end

	self.m_ourTeamRankTxt:setText((var_0_0:getMyRankIdx()))
end

function GveResultSeasonRankCell:_onRankRenderer(arg_3_1, arg_3_2)
	if self._resultRankData[arg_3_1 + 1] then
		arg_3_2:updateCell(self._resultRankData[arg_3_1 + 1], arg_3_1 + 1)
	end
end

return GveResultSeasonRankCell
