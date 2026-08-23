local PARankAwardCell = class("PARankAwardCell", require("app.fairyGUI.peakArena.UI_PARankingAwardCell"))

function PARankAwardCell:ctor()
	self._awardArr = {}

	self.m_iconList:setVirtual()
	self.m_iconList:setItemRenderer(handler(self, self._onIconListRenderer))
end

function PARankAwardCell:updateCell(arg_2_1, arg_2_2)
	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)

	self._awardArr = arg_2_2.data

	self.m_showBgController:setSelectedIndex(arg_2_1 and 1 or 0)
	self.m_rankingAliasComp:updateComp(arg_2_2.minRank)
	self.m_iconList:setNumItems(#self._awardArr)
end

function PARankAwardCell:_onIconListRenderer(arg_3_1, arg_3_2)
	self._awardArr[arg_3_1 + 1].scaleIndex = 4

	arg_3_2:updateIcon(self._awardArr[arg_3_1 + 1])
end

return PARankAwardCell
