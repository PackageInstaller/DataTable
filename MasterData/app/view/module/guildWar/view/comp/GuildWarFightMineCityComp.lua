local var_0_0 = g.core.model.User.guildWarData
local var_0_1 = g.core.const.ConstMgr.GuildWarConst
local GuildWarFightMineCityComp = class("GuildWarFightMineCityComp", require("app.fairyGUI.guildWar.UI_GuildWarFightMineCityComp"))

function GuildWarFightMineCityComp:ctor()
	return
end

function GuildWarFightMineCityComp:onLoad()
	return
end

function GuildWarFightMineCityComp:setGuildId(arg_3_1, arg_3_2)
	self.m_cityComp:setGuildId(arg_3_1, arg_3_2)

	self._guildStruct = var_0_0:getGuildWarGuildStruct(arg_3_1)

	if arg_3_2 == var_0_1.CityPos.DOWN then
		self.m_bgLoader:setURL("bg/guildWar/bg_jtzf_bushu0.jpg")
	elseif arg_3_2 == var_0_1.CityPos.LEFT then
		self.m_bgLoader:setURL("bg/guildWar/bg_jtzf_bushu1.jpg")
	else
		self.m_bgLoader:setURL("bg/guildWar/bg_jtzf_bushu2.jpg")
	end
end

return GuildWarFightMineCityComp
