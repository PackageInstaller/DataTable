local var_0_0 = class("PublicGuildUpgradeTechCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = getProxy(PlayerProxy)
	local var_1_1 = getProxy(PlayerProxy):getData()
	local var_1_2 = getProxy(GuildProxy):GetPublicGuild():GetTechnologyById(arg_1_1:getBody().id)

	if not var_1_2 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_not_exist_tech"))

		return
	end

	if var_1_2:isMaxLevel() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_tech_is_max_level"))

		return
	end

	local var_1_3, var_1_4 = var_1_2:GetConsume()

	if var_1_4 > var_1_1.gold then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_tech_gold_no_enough"))

		return
	end

	if var_1_3 > var_1_1.guildCoin then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_tech_guildgold_no_enough"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(62015, {
		id = var_1_2.id
	}, 62016, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_1:consume({
				gold = var_1_4,
				guildCoin = var_1_3
			})
			var_1_0:updatePlayer(var_1_1)
			var_1_2:levelUp()
			arg_1_0:sendNotification(GAME.PULIC_GUILD_UPGRADE_TECH_DONE, {
				id = var_0
			})
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_tech_upgrade_done"))
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
