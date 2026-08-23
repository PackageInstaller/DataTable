local OutpostBagItemComp = class("OutpostBagItemComp", require("app.fairyGUI.outpost.UI_OutpostBagItemComp"))

function OutpostBagItemComp:ctor()
	self._itemInfo = nil
end

function OutpostBagItemComp:updateBagItemComp(arg_2_1)
	self.m_iconComp:updateItemIcon(arg_2_1)
end

return OutpostBagItemComp
