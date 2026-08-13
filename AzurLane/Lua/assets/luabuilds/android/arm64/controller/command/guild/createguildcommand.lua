class = var_0_10000

local var_0_0 = "CreateGuildCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)
	local var_1_2 = var_2.getName(var_1_1)

	pg = var_1_0

	local var_1_3 = var_1_0.gameset.create_guild_cost.key_value

	getProxy = var_1_1
	PlayerProxy = var_1_10007

	local var_1_4 = var_1_1(var_1_10007)
	local var_1_5 = var_5.getData(var_1_4)
	local var_1_7

	if var_6.getTotalGem(var_1_5) < var_1_3 then
		pg = var_1_7

		local var_1_6 = var_1_7.TipsMgr.GetInstance()

		var_1_7 = var_1_7.ShowTips
		i18n = var_1_10010

		var_1_7(var_1_6, var_1_10010("guild_create_error_nomoney"))

		return
	end

	pg = var_1_7

	local var_1_8 = var_1_7.ConnectionMgr.GetInstance()

	var_7.Send(var_1_8, 60001, {
		faction = var_2:getFaction(),
		policy = var_2:getPolicy(),
		name = var_1_2,
		manifesto = var_2:getManifesto()
	}, 60002, function(arg_2_0)
		if arg_2_0.result == 0 then
			Guild = var_1
			var_2_10004 = var_1.New({
				base = var_0
			})

			var_1.setId(var_2_10004, arg_2_0.id)

			getProxy = var_2
			GuildProxy = var_2_10004

			local var_2_0 = var_2(var_2_10004)

			GuildMember = var_3

			local var_2_1 = var_3.New
			local var_2_2 = {
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

			pg = var_6

			local var_2_3 = var_6.TimeMgr.GetInstance()

			var_2_2.join_time = var_6.GetServerTime(var_2_3)

			local var_2_4 = var_2_1(var_2_2)

			var_2_10004 = var_3.setDuty
			GuildConst = var_7

			var_2_10004(var_2_4, var_7.DUTY_COMMANDER)
			var_1:addMember(var_3)

			pg = var_2_10004
			var_2_10004 = var_2_10004.guildset.guild_tech_default.key_value

			var_1:StartTech(var_2_10004)
			var_2_0:addGuild(var_1)

			local var_2_5 = var_0

			var_5.consume(var_2_5, {
				gem = var_1_3
			})

			local var_2_6 = var_0

			var_5.updatePlayer(var_2_6, var_0)

			local var_2_7 = arg_1_0
			local var_2_8 = var_5.sendNotification

			GAME = var_8

			var_2_8(var_2_7, var_8.HANDLE_GUILD_AND_PUBLIC_GUILD_TECH)

			local var_2_9 = arg_1_0
			local var_2_10 = var_5.sendNotification

			GAME = var_8

			var_2_10(var_2_9, var_8.CREATE_GUILD_DONE)

			local var_2_11 = arg_1_0
			local var_2_12 = var_5.sendNotification

			GAME = var_8

			var_2_12(var_2_11, var_8.GUILD_GET_USER_INFO)

			pg = var_2_12

			local var_2_13 = var_2_12.TipsMgr.GetInstance()
			local var_2_14 = var_5.ShowTips

			i18n = var_8

			var_2_14(var_2_13, var_8("guild_create_sucess"))
		else
			local var_2_16

			if arg_2_0.result == 2015 then
				pg = var_2_16

				local var_2_15 = var_2_16.TipsMgr.GetInstance()

				var_2_16 = var_2_16.ShowTips
				i18n = var_2_10004

				var_2_16(var_2_15, var_2_10004("guild_name_invaild"))
			else
				pg = var_2_16

				local var_2_17 = var_2_16.TipsMgr.GetInstance()
				local var_2_18 = var_1.ShowTips

				errorTip = var_2_10004

				var_2_18(var_2_17, var_2_10004("guild_create_error", arg_2_0.result))
			end
		end

		return
	end)

	return
end

return var_0_1
