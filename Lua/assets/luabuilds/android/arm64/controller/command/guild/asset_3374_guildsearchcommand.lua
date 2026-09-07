local GuildSearchCommand = class("GuildSearchCommand", pm.SimpleCommand)

function GuildSearchCommand:execute(arg_1_1)
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
			local var_2_0 = {}

			for iter_2_0, iter_2_1 in ipairs(arg_2_0.guild) do
				local var_2_1 = Guild.New(iter_2_1)

				var_2_1:SetMaxMemberCntAddition(iter_2_1.tech_seat)

				local var_2_2 = GuildMember.New(iter_2_1.leader)

				var_2_2:setDuty(GuildConst.DUTY_COMMANDER)
				var_2_1:addMember(var_2_2)
				table.insert(var_2_0, var_2_1)
			end

			self:sendNotification(GAME.GUILD_SEARCH_DONE, var_2_0)
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_search_sucess"))
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_no_exist"))
		end

		return
	end)

	return
end

return GuildSearchCommand
