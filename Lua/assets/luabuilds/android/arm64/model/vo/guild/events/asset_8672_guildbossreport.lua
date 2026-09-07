local GuildBossReport = class("GuildBossReport", import(".GuildReport"))

function GuildBossReport:bindConfigTable()
	return pg.guild_boss_event
end

function GuildBossReport:IsBoss()
	return true
end

function GuildBossReport:GetReportDesc()
	return self:getConfig("report")
end

function GuildBossReport:GetDrop()
	return self:getConfig("award_report"), 0
end

function GuildBossReport:GetType()
	return 3
end

return GuildBossReport
