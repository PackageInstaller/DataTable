class = var_0_10000

local var_0_0 = "EducateUpgradeFavorCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody() and var_2.callback

	getProxy = var_1_10004
	EducateProxy = var_1_10005

	local var_1_1 = var_1_10004(var_1_10005)
	local var_1_2 = var_4.GetCharData(var_1_1)
	local var_1_3 = var_4.GetFavorPerformIds(var_1_2)

	pg = var_1_2

	local var_1_4 = var_1_2.ConnectionMgr.GetInstance()

	var_5.Send(var_1_4, 27006, {
		type = 0
	}, 27007, function(arg_2_0)
		local var_2_3

		if arg_2_0.result == 0 then
			EducateHelper = var_2_3

			var_2_3.UpdateDropsData(arg_2_0.drops)

			getProxy = var_2_3
			EducateProxy = var_2

			local var_2_0 = var_2_3(var_2)
			local var_2_1 = var_2_3.GetCharData(var_2_0)

			var_2_3.UpgradeFavor(var_2_1)

			local var_2_2 = arg_1_0

			var_2_3 = var_2_3.sendNotification
			GAME = var_2_10003

			var_2_3(var_2_2, var_2_10003.EDUCATE_UPGRADE_FAVOR_DONE, {
				drops = arg_2_0.drops,
				performs = var_1_3,
				cb = var_1_0
			})
		else
			pg = var_2_3

			local var_2_4 = var_2_3.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_5(var_2_4, var_2_10003("educate upgrad favor error: ", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
