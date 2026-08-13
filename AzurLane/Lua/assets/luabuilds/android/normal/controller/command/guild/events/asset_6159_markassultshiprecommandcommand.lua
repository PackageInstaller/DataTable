class = var_0_10000

local var_0_0 = "MarkAssultShipRecommandCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().shipId
	local var_1_1 = var_2.cmd

	getProxy = var_1_10005
	GuildProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006)

	if not var_5.getRawData(var_1_2) then
		pg = var_1_2

		local var_1_3 = var_1_2.TipsMgr.GetInstance()

		var_1_2 = var_1_2.ShowTips
		i18n = var_1_10009

		var_1_2(var_1_3, var_1_10009("guild_no_exist"))

		return
	end

	GuildMember = var_1_2

	local var_1_5

	if not var_1_2.IsAdministrator(var_6:getSelfDuty()) then
		pg = var_1_5

		local var_1_4 = var_1_5.TipsMgr.GetInstance()

		var_1_5 = var_1_5.ShowTips
		i18n = var_1_10010

		var_1_5(var_1_4, var_1_10010("guild_commander_and_sub_op"))

		return
	end

	GuildAssaultFleet = var_1_5

	local var_1_6 = var_1_5.GetUserId(var_1_0)

	GuildAssaultFleet = var_9

	local var_1_7 = var_9.GetRealId(var_1_0)

	print = var_10

	var_10(var_1_6, var_1_7, var_1_1)

	pg = var_10

	local var_1_8 = var_10.ConnectionMgr.GetInstance()

	var_10.Send(var_1_8, 61033, {
		recommend_uid = var_1_6,
		recommend_shipid = var_1_7,
		cmd = var_1_1
	}, 61034, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_0

			var_2_10003 = var_1.getData(var_2_0)

			local var_2_1 = var_1.getMemberById(var_2_10003, var_1_6)

			assert = var_2_10003

			var_2_10003(var_2_1)

			var_2_10003 = var_2_1:GetAssaultFleet()

			local var_2_2 = var_1_1

			GuildConst = var_2_10005

			local var_2_3

			if var_2_2 == var_2_10005.RECOMMAND_SHIP then
				var_2_3 = var_2_10003

				var_2_10003.SetShipBeRecommanded(var_2_3, var_1_7, true)

				pg = var_4
				var_2_3 = var_4.TipsMgr.GetInstance()

				local var_2_4 = var_4.ShowTips

				i18n = var_6

				var_2_4(var_2_3, var_6("guild_assult_ship_recommend"))
			else
				local var_2_5 = var_1_1

				GuildConst = var_2_3

				if var_2_5 == var_2_3.CANCEL_RECOMMAND_SHIP then
					var_2_10003:SetShipBeRecommanded(var_1_7, false)

					pg = var_4

					local var_2_6 = var_4.TipsMgr.GetInstance()
					local var_2_7 = var_4.ShowTips

					i18n = var_6

					var_2_7(var_2_6, var_6("guild_cancel_assult_ship_recommend"))
				end
			end

			local var_2_8 = var_0

			var_4.updateGuild(var_2_8, var_1)

			local var_2_9 = arg_1_0
			local var_2_10 = var_4.sendNotification

			GAME = var_6

			var_2_10(var_2_9, var_6.GUILD_RECOMMAND_ASSULT_SHIP_DONE, {
				shipId = var_1_0
			})
		else
			pg = var_1

			local var_2_11 = var_1.TipsMgr.GetInstance()
			local var_2_12 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_12(var_2_11, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
