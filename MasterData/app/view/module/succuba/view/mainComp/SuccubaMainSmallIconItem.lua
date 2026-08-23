local SuccubaMainSmallIconItem = class("SuccubaMainSmallIconItem", require("app.fairyGUI.succuba.UI_SuccubaMainSmallIconItem"))

function SuccubaMainSmallIconItem:ctor()
	self._succuba = nil
	self._pos = 0
end

function SuccubaMainSmallIconItem:updateIconItem(arg_2_1, arg_2_2)
	self._succuba = arg_2_1
	self._pos = arg_2_2

	if arg_2_1 then
		self.m_iconComp:setIcon(g.core.common.Path:getSuccubaIconById(self._succuba:getShowCfg().res))
		self.m_hasOwnController:setSelectedIndex(1)
	else
		self.m_hasOwnController:setSelectedIndex(0)
	end

	self:setTitle(string.format("%02d", arg_2_2))
end

return SuccubaMainSmallIconItem
