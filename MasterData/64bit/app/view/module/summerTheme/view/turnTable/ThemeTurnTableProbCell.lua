local ThemeTurnTableProbCell = class("ThemeTurnTableProbCell", require("app.fairyGUI.summerThemeGame.UI_ThemeTurnTableProbCell"))

function ThemeTurnTableProbCell:ctor()
	return
end

function ThemeTurnTableProbCell:updateCell(arg_2_1, arg_2_2)
	self.m_probIcon:updateIcon({
		type = arg_2_1.cfg.reward_type,
		value = arg_2_1.cfg.reward_value,
		size = arg_2_1.cfg.reward_size,
		prob = string.format("%.2f%%", 100 * arg_2_1.cfg.size / arg_2_2)
	})
	self.m_probIcon:updateTagType()

	if arg_2_1.cfg.times == 0 then
		self.m_lastNumText:setText(g.core.lang:get(405902))
	else
		self.m_lastNumText:setText(arg_2_1.cfg.times - arg_2_1.turnNum)
		self.m_isAllGetController:setSelectedIndex(arg_2_1.cfg.times <= arg_2_1.turnNum and 1 or 0)
	end
end

return ThemeTurnTableProbCell
