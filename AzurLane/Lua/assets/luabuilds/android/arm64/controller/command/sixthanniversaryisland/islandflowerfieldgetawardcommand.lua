local var_0_0 = class("IslandFlowerFieldGetAwardCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(11202, {
		cmd = 1,
		activity_id = arg_1_1:getBody().act_id
	}, 11203, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(ActivityProxy)
			local var_2_1 = var_2_0:getActivityById(var_0.act_id)

			var_2_1.data1 = arg_2_0.number[1]
			var_2_1.data2 = arg_2_0.number[2]

			var_2_0:updateActivity(var_2_1)
			pg.m02:sendNotification(GAME.ISLAND_FLOWER_GET_DONE, {
				isAuto = var_0.isAuto,
				awards = PlayerConst.addTranDrop(arg_2_0.award_list)
			})
		else
			pg.TipsMgr.GetInstance():ShowTips("flower award get failed:" .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
