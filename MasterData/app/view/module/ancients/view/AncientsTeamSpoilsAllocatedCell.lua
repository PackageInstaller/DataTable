local AncientsTeamSpoilsAllocatedCell = class("AncientsTeamSpoilsAllocatedCell", require("app.fairyGUI.ancients.UI_AncientsTeamSpoilsAllocatedCell"))

function var_0_0.ctor(arg_1_0)
	arg_1_0._info = nil
	arg_1_0._dice = nil
end

function var_0_0:updateCell(arg_2_1, arg_2_2)
	self.m_hasBgController:setSelectedIndex(arg_2_2 % 2)

	self._info = arg_2_1.info
	self._dices = arg_2_1.dices

	local var_2_0 = g.core.common.Goods:convert({
		type = self._info.type,
		value = self._info.value
	})

	if var_2_0 == nil then
		dumpError(self._info, "goods is nil")
	else
		self.m_Txt_goodsName:setText(var_2_0.name)
	end

	if self._dices and self._dices[1] then
		local var_2_1 = g.core.config.knight_info.get(self._dices[1].base_id)

		self.m_Txt_playerName:setText(self._dices[1].name)
		self.m_Txt_maxPoint:setText(self._dices[1].points)
		self.m_stateController:setSelectedIndex(0)
		self.m_is_myController:setSelectedIndex(self._dices[1].uid == g.core.model.User:getId() and 1 or 0)
	else
		self.m_stateController:setSelectedIndex(1)
	end
end

return var_0_0
