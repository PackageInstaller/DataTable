local PublicGuildUpgradeTechCommand = class("PublicGuildUpgradeTechCommand", pm.SimpleCommand)

function PublicGuildUpgradeTechCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = getProxy(PlayerProxy)
	local var_1_2 = var_1_1:getData()
	local var_1_3 = getProxy(GuildProxy):GetPublicGuild():GetTechnologyById(var_1_0)

	if not var_1_3 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_not_exist_tech"))

		return
	end

	if var_1_3:isMaxLevel() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_tech_is_max_level"))

		return
	end

	local var_1_4, var_1_5 = var_1_3:GetConsume()

	if var_1_5 > var_1_2.gold then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_tech_gold_no_enough"))

		return
	end

	if var_1_4 > var_1_2.guildCoin then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_tech_guildgold_no_enough"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(62015, {
		id = var_1_3.id
	}, 62016, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_2:consume({
				gold = var_1_5,
				guildCoin = var_1_4
			})
			var_1_1:updatePlayer(var_1_2)
			var_1_3:levelUp()
			self:sendNotification(GAME.PULIC_GUILD_UPGRADE_TECH_DONE, {
				id = var_1_0
			})
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_tech_upgrade_done"))
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return PublicGuildUpgradeTechCommand
