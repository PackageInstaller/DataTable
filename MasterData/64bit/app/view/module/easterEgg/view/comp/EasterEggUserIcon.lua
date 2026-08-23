local var_0_0 = g.core.common.Path
local EasterEggUserIcon = class("EasterEggUserIcon", require("app.fairyGUI.easterEgg.UI_EasterEggUserIcon"))

function EasterEggUserIcon:updateView(arg_1_1)
	if arg_1_1 and arg_1_1 > 0 then
		self.m_iconComp:setIcon(var_0_0:getKnightQQIconById(arg_1_1))
	end
end

return EasterEggUserIcon
