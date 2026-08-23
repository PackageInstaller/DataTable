local var_0_0 = g.core.const.ConstMgr.PreciousConst
local PreciousSuitNameComp = class("PreciousSuitNameComp", require("app.fairyGUI.precious.UI_PreciousSuitNameComp"))

function PreciousSuitNameComp:updateSuitName(arg_1_1)
	local var_1_0 = arg_1_1:getStatus()

	if var_1_0 == var_0_0.PRECIOUS_SUIT_STATUS.CAN_ACTIVATED then
		self.m_stateController:setSelectedIndex(2)
	elseif var_1_0 == var_0_0.PRECIOUS_SUIT_STATUS.CAN_STARUP then
		self.m_stateController:setSelectedIndex(1)
	else
		self.m_stateController:setSelectedIndex(0)
	end

	self.m_suitNameTxt:setText(arg_1_1:getCfg().name)
	self.m_starComp:initStar({
		style = 2,
		index = 3,
		gap = -2,
		max = var_0_0.SUIT_MAX_STAR_NUM,
		num = arg_1_1:getStar()
	})
	self.m_starComp:setVisible(var_1_0 ~= var_0_0.PRECIOUS_SUIT_STATUS.CANNOT_ACTIVATE)
end

return PreciousSuitNameComp
