class = var_0_10000

local var_0_0 = "ChangeRefreshTechnologysTendencyCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().pool_id
	local var_1_1 = var_2.tendency

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 63009, {
		id = var_1_0,
		target = var_1_1
	}, 63010, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			getProxy = var_2_2
			TechnologyProxy = var_2_10002

			local var_2_0 = var_2_2(var_2_10002)

			var_2_2.setTendency(var_2_0, var_1_0, var_1_1)

			local var_2_1 = arg_1_0

			var_2_2 = var_2_2.sendNotification
			GAME = var_2_10003

			var_2_2(var_2_1, var_2_10003.CHANGE_REFRESH_TECHNOLOGYS_TENDENCY_DONE)
		else
			pg = var_2_2

			local var_2_3 = var_2_2.TipsMgr.GetInstance()
			local var_2_4 = var_1.ShowTips

			i18n = var_2_10003

			var_2_4(var_2_3, var_2_10003("change_technology_refresh_erro") .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
