local var_0_0 = g.core.common.Path
local GuildWarFightResultShowComp = class("GuildWarFightResultShowComp", require("app.fairyGUI.guildWar.UI_GuildWarFightResultShowComp"))
local var_0_2 = 240

function GuildWarFightResultShowComp:updateComp(arg_1_1, arg_1_2)
	local var_1_0 = arg_1_1.guildSnapshot or {}

	self.m_guildIcon:setURL((var_0_0:getGuildMidIconById(var_1_0.icon or 5)))
	self.m_guildNameText:setText(var_1_0.name)
	self.m_serverText:setText(var_1_0.server_name)

	local var_1_1 = arg_1_1.todayDefendScore or 0
	local var_1_2 = arg_1_1.todayRobScore or 0
	local var_1_3 = var_1_1 + var_1_2

	self.m_fightScoreText:setText(var_1_2)
	self.m_buildScoreText:setText(var_1_1)
	self.m_finalScoreText:setText(var_1_3)

	local var_1_4 = math.floor(var_0_2 * (var_1_3 / arg_1_2) * (var_1_1 / var_1_3))

	self.m_guildImage:setSize(var_1_4, 8)
	self.m_fightImage:setSize(var_0_2 * (var_1_3 / arg_1_2) - var_1_4, 8)

	local var_1_5 = self.m_guildImage:getPosition()

	self.m_fightImage:setPosition(var_1_5.x + var_1_4, var_1_5.y)
	self.m_joinNumText:setText(arg_1_1.joinNum or 0)
end

return GuildWarFightResultShowComp
