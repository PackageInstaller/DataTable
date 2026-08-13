class = var_0_10000

local var_0_0 = "RefreshTechnologysCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	getProxy = var_1_0
	TechnologyProxy = var_1_10004

	if var_1_0(var_1_10004).refreshTechnologysFlag ~= 0 then
		return
	end

	tobool = var_4

	if var_4(var_3:getActivateTechnology()) then
		return
	end

	pg = var_4

	local var_1_2 = var_4.ConnectionMgr.GetInstance()

	var_4.Send(var_1_2, 31, {
		type = 1
	}, 63008, function(arg_2_0)
		local var_2_3

		if arg_2_0.result == 0 then
			local var_2_0 = var_0

			var_2_3.updateTechnologys(var_2_0, arg_2_0.refresh_list)

			local var_2_1 = var_0

			var_2_3.updateRefreshFlag(var_2_1, 1)

			local var_2_2 = arg_1_0

			var_2_3 = var_2_3.sendNotification
			GAME = var_2_10003

			var_2_3(var_2_2, var_2_10003.REFRESH_TECHNOLOGYS_DONE)

			pg = var_2_3

			local var_2_4 = var_2_3.TipsMgr.GetInstance()

			var_2_3 = var_2_3.ShowTips
			i18n = var_2_10003

			var_2_3(var_2_4, var_2_10003("technology_refresh_sucess"))
		else
			pg = var_2_3

			local var_2_5 = var_2_3.TipsMgr.GetInstance()
			local var_2_6 = var_1.ShowTips

			i18n = var_2_10003

			var_2_6(var_2_5, var_2_10003("technology_refresh_erro") .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
