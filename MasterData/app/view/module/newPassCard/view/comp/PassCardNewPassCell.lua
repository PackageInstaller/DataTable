local PassCardNewPassCell = class("PassCardNewPassCell", require("app.fairyGUI.newPassCard.UI_PassCardNewPassCell"))

function PassCardNewPassCell:updatePassCardCell(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self._cfg = arg_1_1

	self.m_indexTxt:setText((g.core.utils.Number.getFormatNum(2, arg_1_2 + 1)))
	self.m_freeRewardIcon:updateIcon({
		type = arg_1_1.free_type,
		value = arg_1_1.free_value,
		size = arg_1_1.free_size
	})
	self.m_freeRewardIcon:updateState(arg_1_1, false)
	self.m_payRewardIcon:updateIcon({
		type = arg_1_1.pay_type,
		value = arg_1_1.pay_value,
		size = arg_1_1.pay_size
	})
	self.m_payRewardIcon:updateState(arg_1_1, true)
end

function PassCardNewPassCell:getCurLevel()
	if self._cfg then
		return self._cfg.level
	end

	return 0
end

return PassCardNewPassCell
