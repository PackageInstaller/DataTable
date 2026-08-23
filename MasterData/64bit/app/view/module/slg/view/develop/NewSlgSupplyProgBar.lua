local var_0_0 = g.core.model.User.newSlgDevelopData
local NewSlgSupplyProgBar = class("NewSlgSupplyProgBar", require("app.fairyGUI.newSlg.UI_NewSlgSupplyProgBar"))

function NewSlgSupplyProgBar:ctor()
	self._curValue = 0
	self._maxValue = 0
	self._maxWidth = self.m_bg:getWidth()

	self:_initEff()
	self.m_efficiency:setText(var_0_0:getSupplyEfficientByProduction(var_0_0:getSupplyCfg().production_rate).desc)
	self.m_tip:setTitle(g.core.lang:get(429579, {
		time = g.core.common.ServerTime:getTimeStrSimple(var_0_0:getMaxSupplyProductTime())
	}))
	self.m_tipBtn:addClickListener(handler(self, self._onClickTipBtn))
end

function NewSlgSupplyProgBar:updateProgress(arg_2_1, arg_2_2)
	self:setValue(arg_2_1)
	self:setMax(arg_2_2)

	local var_2_0 = math.min(arg_2_1, arg_2_2)
	local var_2_1 = math.floor(var_2_0 / 3600)

	self.m_timeTxt:setText(string.format("%02d:%02d:%02d", var_2_1, math.floor((var_2_0 - var_2_1 * 3600) / 60), var_2_0 % 60))
	self.m_maskComp:setWidth(self._maxWidth * var_2_0 / arg_2_2)
	self.m_isMaxController:setSelectedIndex(arg_2_2 <= arg_2_1 and 1 or 0)
end

function NewSlgSupplyProgBar:_initEff()
	self.m_maskComp:getChild("eff"):addEffectSpine({
		anim = "play",
		isLoop = true,
		name = "eff_ui_newSlg_progBar"
	})
end

function NewSlgSupplyProgBar:_onClickTipBtn()
	self.m_showTipController:setSelectedIndex(self.m_showTipController:getSelectedIndex() == 1 and 0 or 1)
end

return NewSlgSupplyProgBar
