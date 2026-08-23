local OutpostBuildItemCell = class("OutpostBuildItemCell", require("app.fairyGUI.outpost.UI_OutpostBuildItemCell"))

function OutpostBuildItemCell:updateItemCell(arg_1_1)
	self:setIcon(arg_1_1.res and arg_1_1.res or g.core.common.Path:getIconByTypeValue(arg_1_1.type, arg_1_1.value))
	self.m_itemNameTxt:setText(arg_1_1.name)
	self.m_qualityLoader:setURL((table.concat({
		"ui://outpost/pic_hxsz_djpinzhi",
		arg_1_1.quality + 1
	})))
end

return OutpostBuildItemCell
