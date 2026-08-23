local var_0_0 = g.core.common.Path
local EasterEggItemComp = class("EasterEggItemComp", require("app.fairyGUI.gameEntertainment.UI_EasterEggItemComp"))

function EasterEggItemComp:ctor()
	self._state = nil
end

function EasterEggItemComp:updateItem(arg_2_1)
	self._state = arg_2_1.isUnlock and 1 or 0

	self.m_lockController:setSelectedIndex(self._state)

	if self._state == 1 then
		self.m_maskInfoLabel:setTitle(arg_2_1.cfg.title)
		self.m_maskInfoLabel:setIcon(var_0_0:getEasterEggImage(arg_2_1.cfg.icon))
	end
end

function EasterEggItemComp:getState()
	return self._state
end

return EasterEggItemComp
