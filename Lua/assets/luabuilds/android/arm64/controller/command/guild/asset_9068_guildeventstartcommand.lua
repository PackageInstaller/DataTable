local GuildEventStartCommand = class("GuildEventStartCommand", pm.SimpleCommand)

function GuildEventStartCommand:execute(arg_1_1)
	local var_1_0 = getProxy(GuildProxy)

	if var_1_0:getData() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_boss_appear"))

		var_1_0.eventTip = true

		self:sendNotification(GAME.BOSS_EVENT_START_DONE)
	end

	return
end

return GuildEventStartCommand
