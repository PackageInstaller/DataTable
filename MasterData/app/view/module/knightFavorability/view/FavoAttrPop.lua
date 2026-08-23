local var_0_0 = g.core.model.User.knightFavoData
local FavoAttrPop = class("FavoAttrPop", require("app.fairyGUI.knightFavorability.UI_FavoAttrPop"), function()
	return fgui.GComponent:create({
		resName = "FavoAttrPop",
		pkgPath = "ui/knightFavorability/knightFavorability",
		isFullScreen = false,
		pkgName = "knightFavorability"
	}, ...)
end)

function FavoAttrPop:ctor()
	self:showAtCenter()
	self.m_isMaxController:setSelectedIndex(var_0_0:getTotalFavoLevel() == var_0_0:getMaxTotalFavoLevel() and 1 or 0)
	self.m_attrComp:updateComp()
end

return FavoAttrPop
