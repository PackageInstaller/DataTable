local GuildWarDrillResultPopCell = class("GuildWarDrillResultPopCell", require("app.fairyGUI.guildWar.UI_GuildWarDrillResultPopCell"))

function GuildWarDrillResultPopCell:ctor()
	self._guildList = nil

	self.m_guildList:setIniter()
	self.m_guildList:setItemRenderer(handler(self, self._onRenderGuildList))
end

function GuildWarDrillResultPopCell:_onRenderGuildList(arg_2_1, arg_2_2)
	arg_2_2:updateCell(self._guildList[arg_2_1 + 1], arg_2_1)
end

function GuildWarDrillResultPopCell:updateCell(arg_3_1, arg_3_2)
	self._guildList = arg_3_1 or {}

	self.m_showGroupController:setSelectedIndex(arg_3_2)
	self.m_groupNameText:setText(g.core.lang:get(308601 + arg_3_2))
	self.m_guildList:setNumItems(#self._guildList)
	self.m_guildList:resizeToFit(#self._guildList)
end

return GuildWarDrillResultPopCell
