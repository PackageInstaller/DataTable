local var_0_0 = g.core.config.resource_info
local var_0_1 = g.core.common.Goods
local var_0_2 = g.core.common.Path
local PABettingPopPayoffCell = class("PABettingPopPayoffCell", require("app.fairyGUI.peakArena.UI_PABettingPopPayoffCell"))

function PABettingPopPayoffCell:ctor()
	local var_1_0 = var_0_0.get(var_0_1.RESOURCE.TYPE_PA_STARLIGHT_STAMP)

	self.m_resIconLoader:setURL((var_0_2:getResourceIconById(var_1_0.icon, true)))
	self.m_resNameTxt:setText(var_1_0.name)
	self.m_payoffTxt:enableRich()
end

function PABettingPopPayoffCell:updateCell(arg_2_1)
	self.m_honorTxt:setText((self:_getHonorTitle(arg_2_1.honorTitleType)))
	self.m_oddsTxt:setText((string.format("%.2f", math.floor(arg_2_1.odds / 10) / 100)))
	self.m_payoffTxt:setText((g.core.lang:get(307049, {
		num1 = self:_getPayoffNum(arg_2_1.betNum, arg_2_1.odds),
		num2 = self:_getPayoffNum(arg_2_1.addNum, arg_2_1.odds)
	})))
	self.m_showWhiteBgController:setSelectedIndex(arg_2_1.showBg and 1 or 0)
end

function PABettingPopPayoffCell:_getPayoffNum(arg_3_1, arg_3_2)
	return math.ceil(arg_3_1 * (arg_3_2 / 1000))
end

function PABettingPopPayoffCell:_getHonorTitle(arg_4_1)
	return g.core.lang:get(307041 + arg_4_1)
end

return PABettingPopPayoffCell
