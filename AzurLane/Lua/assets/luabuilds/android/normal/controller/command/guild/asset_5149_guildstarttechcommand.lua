class = var_0_10000

local var_0_0 = "GuildStartTechCommand"

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
	local var_1_3 = var_5.getData(var_1_2)
	local var_1_4 = var_1_1
	local var_1_5 = var_1_1.getData(var_1_4)

	if not var_1_3 then
		pg = var_1_4

		local var_1_6 = var_1_4.TipsMgr.GetInstance()
		local var_1_7 = var_8.ShowTips

		i18n = var_1_10010

		var_1_7(var_1_6, var_1_10010("guild_no_exist"))

		return
	end

	local var_1_8 = var_1_3

	if not var_1_3.getTechnologyById(var_1_8, var_1_0) then
		pg = var_1_8

		local var_1_9 = var_1_8.TipsMgr.GetInstance()
		local var_1_10 = var_9.ShowTips

		i18n = var_1_10011

		var_1_10(var_1_9, var_1_10011("guild_not_exist_tech"))

		return
	end

	if not var_8:CanUpgrade() then
		pg = var_9

		local var_1_11 = var_9.TipsMgr.GetInstance()
		local var_1_12 = var_9.ShowTips

		i18n = var_1_10011

		var_1_12(var_1_11, var_1_10011("guild_tech_is_max_level"))

		return
	end

	local var_1_13, var_1_14 = var_8:GetConsume()

	if var_1_5.gold < var_1_14 then
		pg = var_11

		local var_1_15 = var_11.TipsMgr.GetInstance()
		local var_1_16 = var_11.ShowTips

		i18n = var_1_10013

		var_1_16(var_1_15, var_1_10013("guild_tech_gold_no_enough"))

		return
	end

	local var_1_18

	if var_1_5.guildCoin < var_1_13 then
		pg = var_1_18

		local var_1_17 = var_1_18.TipsMgr.GetInstance()

		var_1_18 = var_1_18.ShowTips
		i18n = var_1_10013

		var_1_18(var_1_17, var_1_10013("guild_tech_guildgold_no_enough"))

		return
	end

	pg = var_1_18

	local var_1_19 = var_1_18.ConnectionMgr.GetInstance()

	var_11.Send(var_1_19, 62015, {
		id = var_8.id
	}, 62016, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_0
			local var_2_1 = var_1.getData(var_2_0)

			var_2_10003 = var_1_5

			var_2.consume(var_2_10003, {
				gold = var_1_14,
				guildCoin = var_1_13
			})

			var_2_10003 = var_1_1

			var_2.updatePlayer(var_2_10003, var_1_5)

			var_2_10003 = var_2_1
			var_0 = var_2_1.getTechnologyById(var_2_10003, var_1_0)
			var_2_10003 = var_0

			var_2.levelUp(var_2_10003)

			var_2_10003 = var_0

			var_2.updateGuild(var_2_10003, var_2_1)

			var_2_10003 = arg_1_0

			local var_2_2 = var_2.sendNotification

			GAME = var_4

			var_2_2(var_2_10003, var_4.GUILD_START_TECH_DONE)

			pg = var_2_2
			var_2_10003 = var_2_2.TipsMgr.GetInstance()

			local var_2_3 = var_2.ShowTips

			i18n = var_4

			var_2_3(var_2_10003, var_4("guild_tech_upgrade_done"))
		else
			local var_2_5

			if arg_2_0.result == 4305 then
				pg = var_2_5

				local var_2_4 = var_2_5.TipsMgr.GetInstance()

				var_2_5 = var_2_5.ShowTips
				i18n = var_2_10003

				var_2_5(var_2_4, var_2_10003("guild_is_frozen_when_start_tech"))
			else
				pg = var_2_5

				local var_2_6 = var_2_5.TipsMgr.GetInstance()
				local var_2_7 = var_1.ShowTips

				ERROR_MESSAGE = var_2_10003

				var_2_7(var_2_6, var_2_10003[arg_2_0.result] .. arg_2_0.result)
			end
		end

		return
	end)

	return
end

return var_0_1
