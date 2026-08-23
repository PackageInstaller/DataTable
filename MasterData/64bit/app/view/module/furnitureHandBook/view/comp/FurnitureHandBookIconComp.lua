local var_0_0 = g.core.model.User.bagData
local FurnitureHandBookIconComp = class("FurnitureHandBookIconComp", require("app.fairyGUI.furnitureHandBook.UI_FurnitureHandBookIconComp"))

function FurnitureHandBookIconComp:updateIcon(arg_1_1, arg_1_2)
	self.m_iconComp:updateIcon({
		type = arg_1_1,
		value = arg_1_2
	})
	self.m_isActivateController:setSelectedIndex(var_0_0:isOwnItem(arg_1_1, arg_1_2) and 1 or 0)
end

return FurnitureHandBookIconComp
