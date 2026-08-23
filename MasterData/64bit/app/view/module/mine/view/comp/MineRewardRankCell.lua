local MineRewardRankCell = class("MineRewardRankCell", require("app.fairyGUI.mine.UI_MineRewardRankCell"))

function MineRewardRankCell:ctor()
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardListRenderer))
	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)
end

function MineRewardRankCell:updateCell(arg_2_1, arg_2_2)
	self.m_bgController:setSelectedIndex(arg_2_2 % 2 == 0 and 1 or 0)

	local var_2_0
	local var_2_1

	self._awardList = arg_2_1.data

	if arg_2_1.maxRank == arg_2_1.minRank then
		var_2_0 = arg_2_1.maxRank
	else
		var_2_1 = arg_2_1.minRank .. "-" .. arg_2_1.maxRank
	end

	if var_2_0 and var_2_0 < 4 then
		self.m_rankController:setSelectedIndex(var_2_0 - 1)
	else
		self.m_rankController:setSelectedIndex(3)
		self.m_rankTxt:setText(var_2_1)
	end

	self.m_awardList:setNumItems(#self._awardList)
end

function MineRewardRankCell:_onAwardListRenderer(arg_3_1, arg_3_2)
	arg_3_2:updateIcon(self._awardList[arg_3_1 + 1])
end

return MineRewardRankCell
