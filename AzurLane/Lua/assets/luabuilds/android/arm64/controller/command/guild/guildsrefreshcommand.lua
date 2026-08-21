local var_0_0 = class("GuildsRefreshCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(60024, {
		type = 0
	}, 60025, function(arg_2_0)
		for iter_2_0, iter_2_1 in ipairs(arg_2_0.guild_list) do
			local var_2_0 = Guild.New(iter_2_1)

			var_2_0:SetMaxMemberCntAddition(iter_2_1.tech_seat)

			local var_2_1 = GuildMember.New(iter_2_1.leader)

			var_2_1:setDuty(GuildConst.DUTY_COMMANDER)
			var_2_0:addMember(var_2_1)
			table.insert({}, var_2_0)
		end

		arg_1_0:sendNotification(GAME.GUILD_LIST_REFRESH_DONE, {})
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_list_refresh_sucess"))

		return
	end)

	return
end

return var_0_0
