local var_0_0 = g.core.model.User.furnitureData
local FurnitureFloorTab = class("FurnitureFloorTab", require("app.fairyGUI.furniture.UI_FurnitureFloorTab"))

function FurnitureFloorTab:ctor()
	return
end

function FurnitureFloorTab:updateTabComp(arg_2_1, arg_2_2, arg_2_3)
	self:setTitle(g.core.lang:get(112536, {
		num = arg_2_1
	}))
	self.m_unlockedController:setSelectedIndex(var_0_0:isDormUnlocked(arg_2_1, arg_2_2) and 1 or 0)

	if arg_2_3 then
		if arg_2_1 == arg_2_3 then
			self.m_cleanTag:setVisible(true)
		else
			self.m_cleanTag:setVisible(false)
		end
	else
		self.m_cleanTag:setVisible(false)
	end
end

return FurnitureFloorTab
