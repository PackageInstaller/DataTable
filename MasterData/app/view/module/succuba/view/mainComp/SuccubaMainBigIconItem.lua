local SuccubaMainBigIconItem = class("SuccubaMainBigIconItem", require("app.fairyGUI.succuba.UI_SuccubaMainBigIconItem"))

function SuccubaMainBigIconItem:ctor()
	self._succuba = nil
	self._pos = 0
end

function SuccubaMainBigIconItem:updateIconItem(arg_2_1)
	self._succuba = arg_2_1

	self.m_iconComp:setIcon(g.core.common.Path:getSuccubaIconById(self._succuba:getShowCfg().res))
	self.m_levelTxt:setText(arg_2_1:getLevel())
	self:setTitle(arg_2_1:getCurCfg().name)
end

return SuccubaMainBigIconItem
