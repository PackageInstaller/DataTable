class = var_0_10000

local var_0_0 = "FinishCampTecCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().tecID
	local var_1_1 = var_2.levelID

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 3, {
		tech_group_id = var_1_0
	}, 4, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			TechnologyNationProxy = var_2_10002
			var_2_10003 = var_1(var_2_10002)

			var_1.updateTecItem(var_2_10003, var_1_0, var_1_1, 0, 0)

			var_2_10003 = var_1

			var_1.setTimer(var_2_10003)

			var_2_10003 = var_1

			var_1.calculateTecBuff(var_2_10003)

			var_2_10003 = arg_1_0

			local var_2_0 = var_2.sendNotification

			TechnologyConst = var_4

			var_2_0(var_2_10003, var_4.FINISH_TEC_SUCCESS, var_1_0)

			var_2_10003 = var_1

			var_1.refreshRedPoint(var_2_10003)

			var_2_10003 = arg_1_0

			local var_2_1 = var_2.sendNotification

			TechnologyConst = var_4

			var_2_1(var_2_10003, var_4.UPDATE_REDPOINT_ON_TOP)
		else
			pg = var_1

			local var_2_2 = var_1.TipsMgr.GetInstance()
			local var_2_3 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_3(var_2_2, var_2_10003("coloring_cell", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
