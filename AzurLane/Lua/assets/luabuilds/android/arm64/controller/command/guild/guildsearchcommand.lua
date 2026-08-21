local var_0_0 = class("GuildSearchCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	if not var_1_0 or var_1_0 == "" then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_should_input_keyword"))

		return
	end

	var_1_0 = var_1_0 and string.gsub(var_1_0, "^%s*(.-)%s*$", "%1")

	pg.ConnectionMgr.GetInstance():Send(60028, {
		type = tonumber(var_1_0) and 0 or 1,
		keyword = var_1_0
	}, 60029, function(arg_2_0)
		if arg_2_0.result == 0 then
			for iter_2_0, iter_2_1 in ipairs(arg_2_0.guild) do
				local var_2_0 = Guild.New(iter_2_1)

				var_2_0:SetMaxMemberCntAddition(iter_2_1.tech_seat)

				local var_2_1 = GuildMember.New(iter_2_1.leader)

				var_2_1:setDuty(GuildConst.DUTY_COMMANDER)
				var_2_0:addMember(var_2_1)
				table.insert({}, var_2_0)
			end

			arg_1_0:sendNotification(GAME.GUILD_SEARCH_DONE, {})
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_search_sucess"))
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_no_exist"))
		end

		return
	end)

	return
end

return var_0_0
