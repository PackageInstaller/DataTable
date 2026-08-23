local GuildStatueItemCell = class("GuildStatueItemCell", require("app.fairyGUI.guildStatue.UI_GuildStatueItemCell"))

function GuildStatueItemCell:updateIcon(arg_1_1)
	self.m_itemIcon:updateIcon(arg_1_1)
	self.m_nameTxt:setScaleText(140)
	self.m_nameTxt:setText(arg_1_1.name)
end

return GuildStatueItemCell
