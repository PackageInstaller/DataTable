local var_0_0 = g.core.common.Path
local EasterEggShareComp = class("EasterEggShareComp", require("app.fairyGUI.easterEgg.UI_EasterEggShareComp"))

function EasterEggShareComp:updateView(arg_1_1)
	self.m_eggName:setText(arg_1_1.title)
	self.m_eggDescComp:setTitle(arg_1_1.des)
	self.m_eggImage:setURL(var_0_0:getEasterEggImage(arg_1_1.icon))
end

return EasterEggShareComp
