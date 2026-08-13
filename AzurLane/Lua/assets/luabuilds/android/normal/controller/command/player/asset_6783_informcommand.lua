class = var_0_10000

local var_0_0 = "InformCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().playerId
	local var_1_1 = var_2.info
	local var_1_2 = var_2.content

	if not var_1_0 or not var_1_1 or not var_1_2 then
		return
	end

	getProxy = var_1_10006
	PlayerProxy = var_1_10007

	local var_1_3 = var_1_10006(var_1_10007)
	local var_1_5

	if var_6.getRawData(var_1_3).level < 20 then
		pg = var_1_5

		local var_1_4 = var_1_5.TipsMgr.GetInstance()

		var_1_5 = var_1_5.ShowTips
		i18n = var_1_10009

		var_1_5(var_1_4, var_1_10009("inform_level_limit"))

		return
	end

	pg = var_1_5

	local var_1_6 = var_1_5.ConnectionMgr.GetInstance()

	var_7.Send(var_1_6, 50111, {
		id = var_1_0,
		info = var_1_1,
		content = var_1_2
	}, 50112, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			getProxy = var_2_0
			ChatProxy = var_2_10002
			var_2_0 = var_2_0(var_2_10002)
			table = var_2_10002

			var_2_10002.insert(var_2_0.informs, var_1_0 .. var_1_2)

			pg = var_2
			var_2_10003 = var_2.TipsMgr.GetInstance()

			local var_2_1 = var_2.ShowTips

			i18n = var_4

			var_2_1(var_2_10003, var_4("inform_sueecss"))

			var_2_10003 = arg_1_0

			local var_2_2 = var_2.sendNotification

			GAME = var_4

			var_2_2(var_2_10003, var_4.INFORM_DONE)
		else
			pg = var_2_0

			local var_2_3 = var_2_0.TipsMgr.GetInstance()
			local var_2_4 = var_1.ShowTips

			i18n = var_2_10003

			var_2_4(var_2_3, var_2_10003("inform_failed"))
		end

		return
	end)

	return
end

return var_0_1
