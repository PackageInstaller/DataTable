local var_0_1 = g.core.model.User.guildData
local var_0_2 = g.core.model.User.allianceData
local AllianceHallMyGuildComp = class("AllianceHallMyGuildComp", require("app.fairyGUI.alliance.UI_AllianceHallMyGuildComp"))

function AllianceHallMyGuildComp:updateView()
	local var_1_0 = var_0_1:getGuildData()

	self.m_guildPic:setURL(g.core.common.Path:getGuildMidIconById(var_1_0.icon))
	self.m_level:setText(g.core.lang:get(2052, {
		level = var_1_0.level
	}))
	self.m_guildName:setText(var_1_0.name)
	self.m_guildServer:setText(var_0_2:getGuildServerName(var_1_0))
	self.m_guildMember:setText(var_1_0.member_num)
	self.m_guildPower:setText(var_1_0.fight_value)

	local var_1_1 = var_0_2:getMyAllianceGuild()

	self.m_guildToday:setText(var_1_1.daily_exp or 0)
	self.m_guildTotal:setText(var_1_1.total_exp or 0)
end

return AllianceHallMyGuildComp
