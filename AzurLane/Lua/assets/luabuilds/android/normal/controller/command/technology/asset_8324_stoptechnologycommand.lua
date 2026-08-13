class = var_0_10000

local var_0_0 = "StopTechnologyCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.pool_id

	getProxy = var_1_10005
	TechnologyProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006)

	if not var_5.getTechnologyById(var_1_2, var_1_0) or not var_6:isActivate() or var_6:isCompleted() then
		return
	end

	pg = var_1_2

	local var_1_3 = var_1_2.ConnectionMgr.GetInstance()

	var_7.Send(var_1_3, 29, {
		tech_id = var_1_0,
		refresh_id = var_1_1
	}, 30, function(arg_2_0)
		local var_2_3

		if arg_2_0.result == 0 then
			local var_2_0 = var_0

			var_2_3.reset(var_2_0)

			local var_2_1 = var_0

			var_2_3.updateTechnology(var_2_1, var_0)

			local var_2_2 = arg_1_0

			var_2_3 = var_2_3.sendNotification
			GAME = var_2_10003

			var_2_3(var_2_2, var_2_10003.STOP_TECHNOLOGY_DONE)
		else
			pg = var_2_3

			local var_2_4 = var_2_3.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips

			i18n = var_2_10003

			var_2_5(var_2_4, var_2_10003("blueprint_stop_erro") .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
