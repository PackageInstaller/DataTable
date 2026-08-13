class = var_0_10000

local var_0_0 = "GuildEventStartCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	getProxy = var_1_10002
	GuildProxy = var_1_10003

	local var_1_0 = var_1_10002(var_1_10003)

	if var_2.getData(var_1_0) then
		pg = var_1_0

		local var_1_1 = var_1_0.TipsMgr.GetInstance()
		local var_1_2 = var_4.ShowTips

		i18n = var_1_10006

		var_1_2(var_1_1, var_1_10006("guild_boss_appear"))

		var_2.eventTip = true

		local var_1_3 = arg_1_0
		local var_1_4 = arg_1_0.sendNotification

		GAME = var_6

		var_1_4(var_1_3, var_6.BOSS_EVENT_START_DONE)
	end

	return
end

return var_0_1
