class = var_0_10000

local var_0_0 = "BackYardDeleteThemeCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	getProxy = var_1_10003
	DormProxy = var_1_10005

	local var_1_1 = var_1_10003(var_1_10005)
	local var_1_3

	if not var_3.getThemeById(var_1_1, var_1_0) then
		pg = var_1_3

		local var_1_2 = var_1_3.TipsMgr.GetInstance()

		var_1_3 = var_1_3.ShowTips
		i18n = var_7

		var_1_3(var_1_2, var_7("backyard_theme_no_exist"))

		return
	end

	pg = var_1_3

	local var_1_4 = var_1_3.ConnectionMgr.GetInstance()

	var_4.Send(var_1_4, 19022, {
		id = var_1_0
	}, 19023, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			local var_2_0 = var_0

			var_2_2.deleteTheme(var_2_0, var_1_0)

			local var_2_1 = arg_1_0

			var_2_2 = var_2_2.sendNotification
			GAME = var_2_10004

			var_2_2(var_2_1, var_2_10004.DELETE_BACKYARD_THEME_DONE)

			pg = var_2_2

			local var_2_3 = var_2_2.TipsMgr.GetInstance()

			var_2_2 = var_2_2.ShowTips
			i18n = var_2_10004

			var_2_2(var_2_3, var_2_10004("backayrd_theme_delete_sucess"))
		else
			pg = var_2_2

			local var_2_4 = var_2_2.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips

			i18n = var_2_10004

			var_2_5(var_2_4, var_2_10004("backayrd_theme_delete_erro"))
		end

		return
	end)

	return
end

return var_0_1
