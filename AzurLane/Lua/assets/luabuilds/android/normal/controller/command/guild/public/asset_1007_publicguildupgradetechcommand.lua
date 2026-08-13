class = var_0_10000

local var_0_0 = "PublicGuildUpgradeTechCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id

	getProxy = var_1_10004
	PlayerProxy = var_1_10005

	local var_1_1 = var_1_10004(var_1_10005)

	getProxy = var_1_10005
	GuildProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006)
	local var_1_3 = var_5.GetPublicGuild(var_1_2)
	local var_1_4 = var_1_1:getData()
	local var_1_5 = var_1_3

	if not var_1_3.GetTechnologyById(var_1_5, var_1_0) then
		pg = var_1_5

		local var_1_6 = var_1_5.TipsMgr.GetInstance()
		local var_1_7 = var_9.ShowTips

		i18n = var_1_10011

		var_1_7(var_1_6, var_1_10011("guild_not_exist_tech"))

		return
	end

	if var_8:isMaxLevel() then
		pg = var_9

		local var_1_8 = var_9.TipsMgr.GetInstance()
		local var_1_9 = var_9.ShowTips

		i18n = var_1_10011

		var_1_9(var_1_8, var_1_10011("guild_tech_is_max_level"))

		return
	end

	local var_1_10, var_1_11 = var_8:GetConsume()

	if var_1_4.gold < var_1_11 then
		pg = var_11

		local var_1_12 = var_11.TipsMgr.GetInstance()
		local var_1_13 = var_11.ShowTips

		i18n = var_1_10013

		var_1_13(var_1_12, var_1_10013("guild_tech_gold_no_enough"))

		return
	end

	local var_1_15

	if var_1_4.guildCoin < var_1_10 then
		pg = var_1_15

		local var_1_14 = var_1_15.TipsMgr.GetInstance()

		var_1_15 = var_1_15.ShowTips
		i18n = var_1_10013

		var_1_15(var_1_14, var_1_10013("guild_tech_guildgold_no_enough"))

		return
	end

	pg = var_1_15

	local var_1_16 = var_1_15.ConnectionMgr.GetInstance()

	var_11.Send(var_1_16, 62015, {
		id = var_8.id
	}, 62016, function(arg_2_0)
		local var_2_4

		if arg_2_0.result == 0 then
			local var_2_0 = var_1_4

			var_2_4.consume(var_2_0, {
				gold = var_1_11,
				guildCoin = var_1_10
			})

			local var_2_1 = var_1_1

			var_2_4.updatePlayer(var_2_1, var_1_4)

			local var_2_2 = var_0

			var_2_4.levelUp(var_2_2)

			local var_2_3 = arg_1_0

			var_2_4 = var_2_4.sendNotification
			GAME = var_2_10003

			var_2_4(var_2_3, var_2_10003.PULIC_GUILD_UPGRADE_TECH_DONE, {
				id = var_1_0
			})

			pg = var_2_4

			local var_2_5 = var_2_4.TipsMgr.GetInstance()

			var_2_4 = var_2_4.ShowTips
			i18n = var_2_10003

			var_2_4(var_2_5, var_2_10003("guild_tech_upgrade_done"))
		else
			pg = var_2_4

			local var_2_6 = var_2_4.TipsMgr.GetInstance()
			local var_2_7 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_7(var_2_6, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
