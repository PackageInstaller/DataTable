local BountyResultSeasonRankComp = class("BountyResultSeasonRankComp", require("app.fairyGUI.bounty.UI_BountyResultSeasonRankComp"))

function BountyResultSeasonRankComp:ctor()
	self.m_rankList:setVirtual()
	self.m_rankList:setItemRenderer(handler(self, self._onRankRenderer))
end

function BountyResultSeasonRankComp:onLoad()
	self.m_rankList:transitionShowCells("enter_left", 0.03)
end

function BountyResultSeasonRankComp:updateResultRankInfo(arg_3_1, arg_3_2)
	self._resultRankData = arg_3_1

	if self._resultRankData then
		self.m_rankList:setNumItems(#self._resultRankData)
		self.m_rankList:transitionShowCells("enter_left", 0.03)
	end

	self.m_ourTeamRankTxt:setText((arg_3_2 == 0 or nil) and g.core.lang:get(410300))
end

function BountyResultSeasonRankComp:_onRankRenderer(arg_4_1, arg_4_2)
	if self._resultRankData[arg_4_1 + 1] then
		arg_4_2:updateCell(self._resultRankData[arg_4_1 + 1], arg_4_1 + 1)
	end
end

return BountyResultSeasonRankComp
