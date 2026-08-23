local SummonSignCell = class("SummonSignCell", require("app.fairyGUI.summonOldPlayer.UI_SummonSignCell"))

function SummonSignCell:ctor()
	self:addClickListener(handler(self, self._onClickCell))
end

function SummonSignCell:updateSummonSignCell(arg_2_1)
	local var_2_0 = g.core.common.Goods:convert({
		type = arg_2_1.reward_type,
		value = arg_2_1.reward_value,
		size = arg_2_1.reward_size
	})

	if var_2_0 then
		self._item = var_2_0

		self.m_itemIcon:setURL(var_2_0.icon)
		self.m_numTxt:setText("x" .. arg_2_1.reward_size)
	end
end

function SummonSignCell:_onClickCell()
	if self._item then
		g.core.common.GlobalFunc.pushInfoPop(self._item)
	end
end

return SummonSignCell
