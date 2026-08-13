class = var_0_10000

local var_0_0 = "GuildBuySupplyCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	getProxy = var_1_10003
	GuildProxy = var_1_10005

	local var_1_1 = var_1_10003(var_1_10005)

	if not var_3.getData(var_1_1) then
		pg = var_1_10005

		local var_1_2 = var_1_10005.TipsMgr.GetInstance()

		var_1_10005 = var_1_10005.ShowTips
		i18n = var_1_10008

		var_1_10005(var_1_2, var_1_10008("guild_no_exist"))

		return
	end

	GuildMember = var_1_10005

	if not var_1_10005.IsAdministrator(var_4:getSelfDuty()) then
		pg = var_5

		local var_1_3 = var_5.TipsMgr.GetInstance()
		local var_1_4 = var_5.ShowTips

		i18n = var_1_10008

		var_1_4(var_1_3, var_1_10008("guild_op_only_administrator"))

		return
	end

	local var_1_5 = var_4

	if var_4.getSupplyConsume(var_1_5) > var_4:getCapital() then
		pg = var_1_5

		local var_1_6 = var_1_5.TipsMgr.GetInstance()

		var_1_5 = var_1_5.ShowTips
		i18n = var_1_10010

		var_1_5(var_1_6, var_1_10010("common_no_resource"))

		return
	end

	pg = var_1_5

	local var_1_7 = var_1_5.ConnectionMgr.GetInstance()

	var_7.Send(var_1_7, 62007, {
		type = 0
	}, 62008, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			local var_2_0 = arg_1_0

			var_2_1 = var_2_1.sendNotification
			GAME = var_2_10004

			var_2_1(var_2_0, var_2_10004.GUILD_BUY_SUPPLY_DONE)
		else
			pg = var_2_1

			local var_2_2 = var_2_1.TipsMgr.GetInstance()
			local var_2_3 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_3(var_2_2, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
