local GuildDungeonLeftRightArrowBtn = class("GuildDungeonLeftRightArrowBtn", require("app.fairyGUI.guildDungeon.UI_GuildDungeonLeftRightArrowBtn"))

function GuildDungeonLeftRightArrowBtn:setRedPointVisible(arg_1_1)
	self.m_redPointComp:setShow(arg_1_1)
end

return GuildDungeonLeftRightArrowBtn
