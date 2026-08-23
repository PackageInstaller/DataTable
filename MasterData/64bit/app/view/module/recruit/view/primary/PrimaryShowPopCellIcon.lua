local PrimaryShowPopCellIcon = class("PrimaryShowPopCellIcon", require("app.fairyGUI.recruitKnight.UI_PrimaryShowPopCellIcon"))

function PrimaryShowPopCellIcon:updateIcon(arg_1_1)
	self:setIcon((g.core.common.Path:getMiddleKnightPicById(arg_1_1.value)))
	self:setTitle(g.core.config.knight_info.get(arg_1_1.value).name)
end

return PrimaryShowPopCellIcon
