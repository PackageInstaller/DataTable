local OutpostItemIcon = class("OutpostItemIcon", require("app.fairyGUI.outpost.UI_OutpostItemIcon"))

function OutpostItemIcon:ctor()
	self.m_starComp:initStar({
		num = 0,
		gap = -10,
		index = 3,
		style = 1,
		type = 1
	})
end

function OutpostItemIcon:updateItemIcon(arg_2_1)
	if arg_2_1 then
		self.m_icon:updateIcon(arg_2_1)
		self.m_isEmptyController:setSelectedIndex(0)
	else
		self.m_icon:setIconEmpty(true)
		self.m_isEmptyController:setSelectedIndex(1)
	end
end

function OutpostItemIcon:setStar(arg_3_1)
	self.m_starComp:setStarNum(arg_3_1)
end

return OutpostItemIcon
