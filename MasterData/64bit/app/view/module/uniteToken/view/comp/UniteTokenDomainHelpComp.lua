local var_0_0 = g.core.config.help_text_info
local UniteTokenDomainHelpComp = class("UniteTokenDomainHelpComp", require("app.fairyGUI.uniteToken.UI_UniteTokenDomainHelpComp"))

function UniteTokenDomainHelpComp:ctor()
	local var_1_0 = var_0_0.get(6000001, 1)

	self.m_nameTxt:setText(var_1_0.name)
	self.m_descTxt:setText(var_1_0.text)
end

function UniteTokenDomainHelpComp:updateHelpId(arg_2_1, arg_2_2)
	local var_2_0 = var_0_0.get(arg_2_1, arg_2_2)

	self.m_nameTxt:setText(var_2_0.name)
	self.m_descTxt:setText(var_2_0.text)
end

return UniteTokenDomainHelpComp
