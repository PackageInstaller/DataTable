class = var_0_10000

local var_0_0 = "MarkAssultShipRecommandCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().shipId
	local var_1_1 = var_2.cmd

	getProxy = var_1_10005
	GuildProxy = var_1_10007

	local var_1_2 = var_1_10005(var_1_10007)

	if not var_5.getRawData(var_1_2) then
		pg = var_1_10007

		local var_1_3 = var_1_10007.TipsMgr.GetInstance()

		var_1_10007 = var_1_10007.ShowTips
		i18n = var_1_10010

		var_1_10007(var_1_3, var_1_10010("guild_no_exist"))

		return
	end

	GuildMember = var_1_10007

	local var_1_4 = var_1_10007.IsAdministrator
	local var_1_5 = var_6

	if not var_1_4(var_6.getSelfDuty(var_1_5)) then
		pg = var_1_2

		local var_1_6 = var_1_2.TipsMgr.GetInstance()

		var_1_2 = var_1_2.ShowTips
		i18n = var_1_5

		var_1_2(var_1_6, var_1_5("guild_commander_and_sub_op"))

		return
	end

	GuildAssaultFleet = var_1_2

	local var_1_7 = var_1_2.GetUserId(var_1_0)

	GuildAssaultFleet = var_9

	local var_1_8 = var_9.GetRealId(var_1_0)

	print = var_10

	var_10(var_1_7, var_1_8, var_1_1)

	pg = var_10

	local var_1_9 = var_10.ConnectionMgr.GetInstance()

	var_10.Send(var_1_9, 61033, {
		recommend_uid = var_1_7,
		recommend_shipid = var_1_8,
		cmd = var_1_1
	}, 61034, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_0

			var_2_10004 = var_1.getData(var_2_0)

			local var_2_1 = var_1.getMemberById(var_2_10004, var_1_7)

			assert = var_2_0

			var_2_0(var_2_1)

			local var_2_2 = var_2_1
			local var_2_3 = var_2_1.GetAssaultFleet(var_2_2)

			var_2_10004 = var_1_1
			GuildConst = var_2_2

			if var_2_10004 == var_2_2.RECOMMAND_SHIP then
				var_2_3:SetShipBeRecommanded(var_1_8, true)

				pg = var_2_10004

				local var_2_4 = var_2_10004.TipsMgr.GetInstance()

				var_2_10004 = var_2_10004.ShowTips
				i18n = var_7

				var_2_10004(var_2_4, var_7("guild_assult_ship_recommend"))
			else
				var_2_10004 = var_1_1
				GuildConst = var_5

				if var_2_10004 == var_5.CANCEL_RECOMMAND_SHIP then
					var_2_3:SetShipBeRecommanded(var_1_8, false)

					pg = var_2_10004

					local var_2_5 = var_2_10004.TipsMgr.GetInstance()

					var_2_10004 = var_2_10004.ShowTips
					i18n = var_7

					var_2_10004(var_2_5, var_7("guild_cancel_assult_ship_recommend"))
				end
			end

			local var_2_6 = var_0

			var_2_10004.updateGuild(var_2_6, var_1)

			local var_2_7 = arg_1_0

			var_2_10004 = var_2_10004.sendNotification
			GAME = var_7

			var_2_10004(var_2_7, var_7.GUILD_RECOMMAND_ASSULT_SHIP_DONE, {
				shipId = var_1_0
			})
		else
			pg = var_1

			local var_2_8 = var_1.TipsMgr.GetInstance()
			local var_2_9 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_9(var_2_8, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
