local MysteryBossPosAwardCell = class("MysteryBossPosAwardCell", require("app.fairyGUI.mystery.UI_MysteryBossPosAwardCell"))

function MysteryBossPosAwardCell:ctor()
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardItemRender))
end

function MysteryBossPosAwardCell:_onAwardItemRender(arg_2_1, arg_2_2)
	arg_2_2:updateIcon(self._awards[arg_2_1 + 1])
end

function MysteryBossPosAwardCell:updateCell(arg_3_1, arg_3_2)
	if arg_3_1.rankIdx == 0 then
		self.m_isPlaceHolderController:setSelectedIndex(1)
	else
		self.m_isPlaceHolderController:setSelectedIndex(0)
	end

	self.m_idxTxt:setText(arg_3_1.rankIdx)
	self.m_addValueTxt:setText(g.core.lang:get(423511, {
		value = arg_3_1.damage
	}))

	self._awards = arg_3_1.award

	self.m_awardList:setNumItems(#self._awards)
	self.m_isHaveBgController:setSelectedIndex(arg_3_2 % 2)
end

return MysteryBossPosAwardCell
