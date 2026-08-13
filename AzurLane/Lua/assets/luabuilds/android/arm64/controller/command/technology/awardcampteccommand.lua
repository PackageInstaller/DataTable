class = var_0_10000

local var_0_0 = "AwardCampTecCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().groupID
	local var_1_1 = var_2.tecID
	local var_1_2 = {
		group_id = var_1_0,
		tech_id = var_1_1
	}

	print = var_1_10006

	var_1_10006("64005 Get TecCamp Award", var_1_0, var_1_1)

	pg = var_1_10006

	local var_1_3 = var_1_10006.ConnectionMgr.GetInstance()

	var_6.Send(var_1_3, 5, var_1_2, 6, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			PlayerConst = var_2_0
			var_2_0 = var_2_0.addTranDrop(arg_2_0.rewards)
			getProxy = var_2_10002
			TechnologyNationProxy = var_2_10004

			local var_2_1 = var_2_10002(var_2_10004)

			var_2.updateTecItemAward(var_2_1, var_1_0, var_1_1)

			local var_2_2 = arg_1_0
			local var_2_3 = var_3.sendNotification

			TechnologyConst = var_6

			var_2_3(var_2_2, var_6.GOT_TEC_CAMP_AWARD, {
				awardList = var_2_0,
				groupID = var_1_0,
				tecID = var_1_1
			})
			var_2:refreshRedPoint()

			local var_2_4 = arg_1_0
			local var_2_5 = var_3.sendNotification

			TechnologyConst = var_6

			var_2_5(var_2_4, var_6.UPDATE_REDPOINT_ON_TOP)
		else
			pg = var_2_0

			local var_2_6 = var_2_0.TipsMgr.GetInstance()

			var_1.ShowTips(var_2_6, "64005 Error Code:" .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
