local var_0_0 = g.core.model.User.monopolyDataMgr
local MonopolyNumRewardComp = class("MonopolyNumRewardComp", require("app.fairyGUI.monopoly.UI_MonopolyNumRewardComp"))

function MonopolyNumRewardComp:ctor()
	self.m_itemList:setVirtual()
	self.m_itemList:setItemRenderer(handler(self, self._onItemRenderer))

	self._data = var_0_0:getMonopolyData()

	self:onUpdateRewardComp()
end

function MonopolyNumRewardComp:onUpdateRewardComp()
	self._curScore = self._data:getCurScore()
	self._showRewards = self._data:getRewardItems()

	self.m_itemList:setNumItems(#self._showRewards)
	self.m_numTxt:setText(self._curScore)
	self:updateUnrealProgress()

	local var_2_0

	for iter_2_0, iter_2_1 in ipairs(self._showRewards) do
		if not self._data:isNodeReward(iter_2_1.id) then
			var_2_0 = iter_2_0 - 1

			break
		end
	end

	if var_2_0 then
		self.m_itemList:scrollToView(var_2_0)
	else
		self.m_itemList:scrollToView(#self._showRewards - 1)
	end
end

function MonopolyNumRewardComp:updateUnrealProgress()
	if self._showRewards[1].num <= self._curScore then
		self.m_progressImg:setScaleX(17)
	else
		self.m_progressImg:setScaleX(17 * self._curScore / self._showRewards[1].num)
	end
end

function MonopolyNumRewardComp:_onItemRenderer(arg_4_1, arg_4_2)
	arg_4_2:updatePointItem(self._showRewards[arg_4_1 + 1], arg_4_1 + 1 >= #self._showRewards, self._showRewards[arg_4_1 + 2])
end

return MonopolyNumRewardComp
