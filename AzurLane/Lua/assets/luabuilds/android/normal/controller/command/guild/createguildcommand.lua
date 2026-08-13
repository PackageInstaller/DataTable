class = var_0_10000

local var_0_0 = "CreateGuildCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_2.getName(var_1_0)

	pg = var_1_0

	local var_1_2 = var_1_0.gameset.create_guild_cost.key_value

	getProxy = var_1_10005
	PlayerProxy = var_1_10006

	local var_1_3 = var_1_10005(var_1_10006)
	local var_1_4 = var_5.getData(var_1_3)
	local var_1_6

	if var_6.getTotalGem(var_1_4) < var_1_2 then
		pg = var_1_6

		local var_1_5 = var_1_6.TipsMgr.GetInstance()

		var_1_6 = var_1_6.ShowTips
		i18n = var_1_10009

		var_1_6(var_1_5, var_1_10009("guild_create_error_nomoney"))

		return
	end

	pg = var_1_6

	local var_1_7 = var_1_6.ConnectionMgr.GetInstance()

	var_7.Send(var_1_7, 60001, {
		faction = var_2:getFaction(),
		policy = var_2:getPolicy(),
		name = var_1_1,
		manifesto = var_2:getManifesto()
	}, 60002, function(arg_2_0)
		if arg_2_0.result == 0 then
			Guild = var_1
			var_2_10003 = var_1.New({
				base = var_0
			})

			var_1.setId(var_2_10003, arg_2_0.id)

			getProxy = var_2
			GuildProxy = var_2_10003

			local var_2_0 = var_2(var_2_10003)

			GuildMember = var_2_10003
			var_2_10003 = var_2_10003.New

			local var_2_1 = {
				liveness = 0,
				online = 1,
				id = var_0.id,
				name = var_0.name,
				lv = var_0.level,
				adv = var_0.manifesto,
				display = {
					icon = var_0.icon,
					character = var_0.character,
					icon_theme = var_0.iconTheme,
					transform_flag = var_0.transformFlag,
					skin = var_0.skinId,
					marry_flag = var_0.proposeTime
				}
			}

			pg = var_5

			local var_2_2 = var_5.TimeMgr.GetInstance()

			var_2_1.join_time = var_5.GetServerTime(var_2_2)

			local var_2_3 = var_2_10003(var_2_1)
			local var_2_4 = var_2_10003.setDuty

			GuildConst = var_2_2

			var_2_4(var_2_3, var_2_2.DUTY_COMMANDER)
			var_1:addMember(var_2_10003)

			pg = var_4

			local var_2_5 = var_4.guildset.guild_tech_default.key_value

			var_1:StartTech(var_2_5)
			var_2_0:addGuild(var_1)

			local var_2_6 = var_0

			var_5.consume(var_2_6, {
				gem = var_1_2
			})

			local var_2_7 = var_0

			var_5.updatePlayer(var_2_7, var_0)

			local var_2_8 = arg_1_0
			local var_2_9 = var_5.sendNotification

			GAME = var_7

			var_2_9(var_2_8, var_7.HANDLE_GUILD_AND_PUBLIC_GUILD_TECH)

			local var_2_10 = arg_1_0
			local var_2_11 = var_5.sendNotification

			GAME = var_7

			var_2_11(var_2_10, var_7.CREATE_GUILD_DONE)

			local var_2_12 = arg_1_0
			local var_2_13 = var_5.sendNotification

			GAME = var_7

			var_2_13(var_2_12, var_7.GUILD_GET_USER_INFO)

			pg = var_2_13

			local var_2_14 = var_2_13.TipsMgr.GetInstance()
			local var_2_15 = var_5.ShowTips

			i18n = var_7

			var_2_15(var_2_14, var_7("guild_create_sucess"))
		else
			local var_2_17

			if arg_2_0.result == 2015 then
				pg = var_2_17

				local var_2_16 = var_2_17.TipsMgr.GetInstance()

				var_2_17 = var_2_17.ShowTips
				i18n = var_2_10003

				var_2_17(var_2_16, var_2_10003("guild_name_invaild"))
			else
				pg = var_2_17

				local var_2_18 = var_2_17.TipsMgr.GetInstance()
				local var_2_19 = var_1.ShowTips

				errorTip = var_2_10003

				var_2_19(var_2_18, var_2_10003("guild_create_error", arg_2_0.result))
			end
		end

		return
	end)

	return
end

return var_0_1
