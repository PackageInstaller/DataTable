local GuildsRefreshCommand = class("GuildsRefreshCommand", pm.SimpleCommand)

function GuildsRefreshCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(60024, {
		type = 0
	}, 60025, function(arg_2_0)
		local var_2_0 = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_0.guild_list) do
			local var_2_1 = Guild.New(iter_2_1)

			var_2_1:SetMaxMemberCntAddition(iter_2_1.tech_seat)

			local var_2_2 = GuildMember.New(iter_2_1.leader)

			var_2_2:setDuty(GuildConst.DUTY_COMMANDER)
			var_2_1:addMember(var_2_2)
			table.insert(var_2_0, var_2_1)
		end

		self:sendNotification(GAME.GUILD_LIST_REFRESH_DONE, var_2_0)
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_list_refresh_sucess"))

		return
	end)

	return
end

return GuildsRefreshCommand
