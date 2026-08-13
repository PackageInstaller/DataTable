class = var_0_10000

local var_0_0 = "ReSelectTecTargetCatchupCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().charID

	pg = var_1_10004

	local var_1_1 = var_1_10004.ConnectionMgr.GetInstance()

	var_4.Send(var_1_1, 63013, {
		target = var_1_0
	}, 63014, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			TechnologyProxy = var_2_10002

			local var_2_0 = var_1(var_2_10002)
			local var_2_1 = var_1.getNewestCatchupTecID(var_2_0)
			local var_2_2 = var_1_0

			var_1:setCurCatchupTecInfo(var_2_1, var_2_2)

			local var_2_3 = arg_1_0
			local var_2_4 = var_4.sendNotification

			GAME = var_6

			var_2_4(var_2_3, var_6.RESELECT_TEC_TARGET_CATCHUP_DONE)
		else
			pg = var_1

			local var_2_5 = var_1.TipsMgr.GetInstance()

			var_1.ShowTips(var_2_5, "Error Code" .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
