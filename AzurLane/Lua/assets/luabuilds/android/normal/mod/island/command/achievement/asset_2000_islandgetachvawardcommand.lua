class = var_0_10000

local var_0_0 = "IslandGetAchvAwardCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().ids

	pg = var_1_10004

	local var_1_1 = var_1_10004.ConnectionMgr.GetInstance()

	var_4.Send(var_1_1, 21050, {
		id_list = var_1_0
	}, 21051, function(arg_2_0)
		local var_2_3

		if arg_2_0.result == 0 then
			getProxy = var_2_3
			IslandProxy = var_2_10002

			local var_2_0 = var_2_3(var_2_10002)
			local var_2_1 = var_2_3.GetIsland(var_2_0)
			local var_2_2 = var_2_3.GetAchievementAgency(var_2_1)

			var_2_3.AddGotIds(var_2_2, var_1_0)

			IslandTaskHelper = var_2_3
			var_2_3 = var_2_3.UpdateRuntimeTaskByTargetType
			IslandTaskTargetType = var_2_2

			var_2_3(var_2_2.ACHIEVEMENT)

			IslandDropHelper = var_2_3
			var_2_3 = var_2_3.AddItems(arg_2_0)
			var_2_10003 = arg_1_0

			local var_2_4 = var_2.sendNotification

			GAME = var_2_10004

			var_2_4(var_2_10003, var_2_10004.ISLAND_GET_ACHV_AWARD_DONE, {
				dropData = var_2_3,
				id = var_1_0[1]
			})
		else
			pg = var_2_3

			local var_2_5 = var_2_3.TipsMgr.GetInstance()
			local var_2_6 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_6(var_2_5, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
