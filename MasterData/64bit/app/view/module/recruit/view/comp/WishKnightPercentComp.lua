local WishKnightPercentComp = class("WishKnightPercentComp", require("app.fairyGUI.recruitKnight.UI_WishKnightPercentComp"))

function WishKnightPercentComp:updatePercent(arg_1_1, arg_1_2)
	self.m_percentText:setText(g.core.config.parameter_info.get(15003).parameter .. "%")
end

function WishKnightPercentComp:updatePercentByPercent(arg_2_1)
	self.m_percentText:setText(arg_2_1 .. "%")
end

return WishKnightPercentComp
