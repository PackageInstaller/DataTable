local GuildLogCell = class("GuildLogCell", require("app.fairyGUI.guild.UI_GuildLogCell"))

function GuildLogCell:setData(arg_1_1)
	self.m_typeController:setSelectedIndex(arg_1_1.type)

	if arg_1_1.type == 1 then
		self.m_descTxt:setText(arg_1_1.info, true)
	else
		self.m_dateTxt:setText(arg_1_1.info)
	end
end

return GuildLogCell
