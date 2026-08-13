class = var_0_10000

local var_0_0 = "AwardCampTecCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = 1
	local var_1_1 = {
		type = var_1_0
	}

	print = var_1_10004

	var_1_10004("64007 Get TecCamp Award OneStep", var_1_0)

	pg = var_1_10004

	local var_1_2 = var_1_10004.ConnectionMgr.GetInstance()

	var_4.Send(var_1_2, 7, var_1_1, 8, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			PlayerConst = var_2_0
			var_2_0 = var_2_0.addTranDrop(arg_2_0.rewards)
			getProxy = var_2
			TechnologyNationProxy = var_2_10003

			local var_2_1 = var_2(var_2_10003)

			var_2.updateTecItemAwardOneStep(var_2_1)

			local var_2_2 = arg_1_0
			local var_2_3 = var_3.sendNotification

			TechnologyConst = var_2_10005

			var_2_3(var_2_2, var_2_10005.GOT_TEC_CAMP_AWARD_ONESTEP, {
				awardList = var_2_0
			})
			var_2:refreshRedPoint()

			local var_2_4 = arg_1_0
			local var_2_5 = var_3.sendNotification

			TechnologyConst = var_5

			var_2_5(var_2_4, var_5.UPDATE_REDPOINT_ON_TOP)
		else
			pg = var_2_0

			local var_2_6 = var_2_0.TipsMgr.GetInstance()

			var_1.ShowTips(var_2_6, "64007 Error Code:" .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
