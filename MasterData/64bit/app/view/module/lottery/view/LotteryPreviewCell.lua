local LotteryPreviewCell = class("LotteryPreviewCell", require("app.fairyGUI.lottery.UI_LotteryPreviewCell"))

function LotteryPreviewCell:ctor()
	self._rewardList = nil

	self.m_list:setVirtual()
	self.m_list:setItemRenderer(handler(self, self._onItemRenderer))
	self.m_list:doFairyBatching(false)
end

function LotteryPreviewCell:updateComp(arg_2_1)
	self._rewardList = arg_2_1.awards

	self.m_list:setNumItems(#self._rewardList)

	if arg_2_1.isRare then
		self.m_title:setText(g.core.lang:get(420004))
	else
		self.m_title:setText(g.core.lang:get(420005))
		self.m_list:resizeToFit(#self._rewardList)
	end
end

function LotteryPreviewCell:_onItemRenderer(arg_3_1, arg_3_2)
	arg_3_2:getChild("icon"):updateIcon(self._rewardList[arg_3_1 + 1])
	arg_3_2:setTitle(self._rewardList[arg_3_1 + 1].size)
end

return LotteryPreviewCell
