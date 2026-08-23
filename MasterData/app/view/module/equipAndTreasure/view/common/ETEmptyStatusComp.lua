local ETEmptyStatusComp = class("ETEmptyStatusComp", require("app.fairyGUI.equipAndTreasure.UI_ETEmptyStatusComp"))

function ETEmptyStatusComp:updateView(arg_1_1)
	arg_1_1 = arg_1_1 or {}

	local var_1_0 = arg_1_1.text2 or ""

	self.m_title1:setText(arg_1_1.text1 or "")
	self.m_title2:setText(var_1_0)
end

return ETEmptyStatusComp
