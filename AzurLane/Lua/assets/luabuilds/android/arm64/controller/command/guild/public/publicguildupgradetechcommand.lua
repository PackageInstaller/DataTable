class = var_0_10000

local var_0_0 = "PublicGuildUpgradeTechCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).id

	getProxy = var_1_0
	PlayerProxy = var_1_10006

	local var_1_2 = var_1_0(var_1_10006)

	getProxy = var_1_10005
	GuildProxy = var_1_10007

	local var_1_3 = var_1_10005(var_1_10007)
	local var_1_4 = var_5.GetPublicGuild(var_1_3)
	local var_1_5 = var_1_2
	local var_1_6 = var_1_2.getData(var_1_5)

	if not var_1_4:GetTechnologyById(var_1_1) then
		pg = var_1_5

		local var_1_7 = var_1_5.TipsMgr.GetInstance()
		local var_1_8 = var_9.ShowTips

		i18n = var_1_10012

		var_1_8(var_1_7, var_1_10012("guild_not_exist_tech"))

		return
	end

	if var_8:isMaxLevel() then
		pg = var_9

		local var_1_9 = var_9.TipsMgr.GetInstance()
		local var_1_10 = var_9.ShowTips

		i18n = var_1_10012

		var_1_10(var_1_9, var_1_10012("guild_tech_is_max_level"))

		return
	end

	local var_1_11, var_1_12 = var_8:GetConsume()

	if var_1_6.gold < var_1_12 then
		pg = var_11

		local var_1_13 = var_11.TipsMgr.GetInstance()
		local var_1_14 = var_11.ShowTips

		i18n = var_1_10014

		var_1_14(var_1_13, var_1_10014("guild_tech_gold_no_enough"))

		return
	end

	local var_1_16

	if var_1_6.guildCoin < var_1_11 then
		pg = var_1_16

		local var_1_15 = var_1_16.TipsMgr.GetInstance()

		var_1_16 = var_1_16.ShowTips
		i18n = var_1_10014

		var_1_16(var_1_15, var_1_10014("guild_tech_guildgold_no_enough"))

		return
	end

	pg = var_1_16

	local var_1_17 = var_1_16.ConnectionMgr.GetInstance()

	var_11.Send(var_1_17, 62015, {
		id = var_8.id
	}, 62016, function(arg_2_0)
		local var_2_4

		if arg_2_0.result == 0 then
			local var_2_0 = var_1_6

			var_2_4.consume(var_2_0, {
				gold = var_1_12,
				guildCoin = var_1_11
			})

			local var_2_1 = var_1_2

			var_2_4.updatePlayer(var_2_1, var_1_6)

			local var_2_2 = var_0

			var_2_4.levelUp(var_2_2)

			local var_2_3 = arg_1_0

			var_2_4 = var_2_4.sendNotification
			GAME = var_2_10004

			var_2_4(var_2_3, var_2_10004.PULIC_GUILD_UPGRADE_TECH_DONE, {
				id = var_1_1
			})

			pg = var_2_4

			local var_2_5 = var_2_4.TipsMgr.GetInstance()

			var_2_4 = var_2_4.ShowTips
			i18n = var_2_10004

			var_2_4(var_2_5, var_2_10004("guild_tech_upgrade_done"))
		else
			pg = var_2_4

			local var_2_6 = var_2_4.TipsMgr.GetInstance()
			local var_2_7 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_7(var_2_6, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
