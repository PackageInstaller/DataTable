local CreateGuildCommand = class("CreateGuildCommand", pm.SimpleCommand)

function CreateGuildCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = pg.gameset.create_guild_cost.key_value
	local var_1_2 = getProxy(PlayerProxy)
	local var_1_3 = var_1_2:getData()

	if pg.gameset.create_guild_cost.key_value > var_1_3:getTotalGem() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_create_error_nomoney"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(60001, {
		faction = var_1_0:getFaction(),
		policy = var_1_0:getPolicy(),
		name = var_1_0:getName(),
		manifesto = var_1_0:getManifesto()
	}, 60002, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = Guild.New({
				base = var_1_0
			})

			var_2_0:setId(arg_2_0.id)

			local var_2_1 = {
				liveness = 0,
				online = 1,
				id = var_1_3.id,
				name = var_1_3.name,
				lv = var_1_3.level,
				adv = var_1_3.manifesto,
				display = {
					icon = var_1_3.icon,
					character = var_1_3.character,
					icon_theme = var_1_3.iconTheme,
					transform_flag = var_1_3.transformFlag,
					skin = var_1_3.skinId,
					marry_flag = var_1_3.proposeTime
				}
			}

			var_2_1.join_time = pg.TimeMgr.GetInstance():GetServerTime()

			local var_2_2 = GuildMember.New(var_2_1)

			var_2_2:setDuty(GuildConst.DUTY_COMMANDER)
			var_2_0:addMember(var_2_2)
			var_2_0:StartTech(pg.guildset.guild_tech_default.key_value)
			getProxy(GuildProxy):addGuild(var_2_0)
			var_1_3:consume({
				gem = var_1_1
			})
			var_1_2:updatePlayer(var_1_3)
			self:sendNotification(GAME.HANDLE_GUILD_AND_PUBLIC_GUILD_TECH)
			self:sendNotification(GAME.CREATE_GUILD_DONE)
			self:sendNotification(GAME.GUILD_GET_USER_INFO)
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_create_sucess"))
		elseif arg_2_0.result == 2015 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_name_invaild"))
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("guild_create_error", arg_2_0.result))
		end

		return
	end)

	return
end

return CreateGuildCommand
