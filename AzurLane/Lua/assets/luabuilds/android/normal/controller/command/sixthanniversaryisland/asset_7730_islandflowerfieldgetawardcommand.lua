class = var_0_10000

local var_0_0 = "IslandFlowerFieldGetAwardCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_3.Send(var_1_2, 11202, {
		cmd = 1,
		activity_id = var_1_1.act_id
	}, 11203, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			ActivityProxy = var_2_10002

			local var_2_0 = var_1(var_2_10002)
			local var_2_1 = var_1.getActivityById(var_2_0, var_1_1.act_id)

			var_2_1.data1 = arg_2_0.number[1]
			var_2_1.data2 = arg_2_0.number[2]

			var_1:updateActivity(var_2_1)

			PlayerConst = var_3

			local var_2_2 = var_3.addTranDrop(arg_2_0.award_list)

			pg = var_4

			local var_2_3 = var_4.m02
			local var_2_4 = var_4.sendNotification

			GAME = var_2_10006

			var_2_4(var_2_3, var_2_10006.ISLAND_FLOWER_GET_DONE, {
				isAuto = var_1_1.isAuto,
				awards = var_2_2
			})
		else
			pg = var_1

			local var_2_5 = var_1.TipsMgr.GetInstance()

			var_1.ShowTips(var_2_5, "flower award get failed:" .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
