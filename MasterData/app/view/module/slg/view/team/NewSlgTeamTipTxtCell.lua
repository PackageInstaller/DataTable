local NewSlgTeamTipTxtCell = class("NewSlgTeamTipTxtCell", require("app.fairyGUI.newSlg.UI_NewSlgTeamTipTxtCell"))

function NewSlgTeamTipTxtCell:ctor()
	return
end

function NewSlgTeamTipTxtCell:updateTipCell(arg_2_1)
	self.m_text:setText((g.core.lang:get(429765, {
		num = arg_2_1.cfg.num,
		value = math.floor(arg_2_1.cfg.affect_value_1 / 100)
	})))

	if arg_2_1.isMatch then
		self.m_matchController:setSelectedIndex(1)
	else
		self.m_matchController:setSelectedIndex(0)
	end
end

return NewSlgTeamTipTxtCell
