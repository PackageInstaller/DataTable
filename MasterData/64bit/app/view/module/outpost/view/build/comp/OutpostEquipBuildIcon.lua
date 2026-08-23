local OutpostEquipBuildIcon = class("OutpostEquipBuildIcon", require("app.fairyGUI.outpost.UI_OutpostEquipBuildIcon"))

function OutpostEquipBuildIcon:ctor()
	self.m_equipIcon:setStarCompVisible(false)
end

function OutpostEquipBuildIcon:updateItemIcon(arg_2_1, arg_2_2, arg_2_3)
	if arg_2_1 then
		self.m_equipIcon:updateEquip(arg_2_1, arg_2_2)
		self.m_isEmptyController:setSelectedIndex(0)
		self.m_starComp:initStar({
			gap = -20,
			style = 1,
			index = arg_2_1:getStarIndex(),
			num = arg_2_1:getStar()
		})
		self.m_starComp:setVisible(true)
	else
		self.m_equipIcon:updateEquip(nil, arg_2_2, arg_2_3)
		self.m_starComp:setVisible(false)
	end
end

return OutpostEquipBuildIcon
