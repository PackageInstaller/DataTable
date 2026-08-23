local var_0_0 = g.core.config.outpost_item_info
local var_0_1 = g.core.common.Path
local OutpostResComp = class("OutpostResComp", require("app.fairyGUI.outpost.UI_OutpostResComp"))

function OutpostResComp:showResCompById(arg_1_1, arg_1_2)
	self:showResComp(var_0_0.get(arg_1_1), arg_1_2)
end

function OutpostResComp:showResComp(arg_2_1, arg_2_2)
	self.m_tipTxt:setText(g.core.lang:get(408904, {
		name = arg_2_1.name,
		num = arg_2_2
	}))
	self.m_icon:setURL(var_0_1:getOutpostItemIcon(arg_2_1.id, true))
end

function OutpostResComp:playResTopAnim(arg_3_1)
	self.m_enterTransition:play(arg_3_1)
end

return OutpostResComp
