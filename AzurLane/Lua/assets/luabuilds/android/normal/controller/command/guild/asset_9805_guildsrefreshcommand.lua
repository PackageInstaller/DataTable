class = var_0_10000

local var_0_0 = "GuildsRefreshCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_3.Send(var_1_2, 60024, {
		type = 0
	}, 60025, function(arg_2_0)
		local var_2_0 = {}

		ipairs = var_2_10002

		for iter_2_0, iter_2_1 in var_2_10002(arg_2_0.guild_list) do
			Guild = var_2_10007

			local var_2_1 = var_2_10007.New(iter_2_1)

			var_2_10007.SetMaxMemberCntAddition(var_2_1, iter_2_1.tech_seat)

			GuildMember = var_8

			local var_2_2 = var_8.New(iter_2_1.leader)
			local var_2_3 = var_8.setDuty

			GuildConst = var_2_10011

			var_2_3(var_2_2, var_2_10011.DUTY_COMMANDER)
			var_2_10007:addMember(var_8)

			table = var_9

			var_9.insert(var_2_0, var_2_10007)
		end

		local var_2_4 = arg_1_0
		local var_2_5 = var_2.sendNotification

		GAME = var_4

		var_2_5(var_2_4, var_4.GUILD_LIST_REFRESH_DONE, var_2_0)

		pg = var_2_5

		local var_2_6 = var_2_5.TipsMgr.GetInstance()
		local var_2_7 = var_2.ShowTips

		i18n = var_4

		var_2_7(var_2_6, var_4("guild_list_refresh_sucess"))

		return
	end)

	return
end

return var_0_1
