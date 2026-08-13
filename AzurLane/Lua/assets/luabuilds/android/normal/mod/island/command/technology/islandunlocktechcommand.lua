class = var_0_10000

local var_0_0 = "IslandUnlockTechCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().techId
	local var_1_1 = var_2.callback

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 21520, {
		tech_id = var_1_0
	}, 21521, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			IslandProxy = var_2_10002

			local var_2_0 = var_1(var_2_10002)

			var_2_10003 = var_1.GetIsland(var_2_0)

			local var_2_1 = var_1.GetTechnologyAgency(var_2_10003)

			var_2.RemoveLockId(var_2_1, var_1_0)

			local var_2_2 = var_2:GetTechnology(var_1_0)

			var_2_10003 = var_2_10003.GetAbilityId(var_2_2)

			local var_2_3 = var_1:GetAblityAgency()

			var_4.AddAblity(var_2_3, var_2_10003)

			existCall = var_4

			var_4(var_1_1)

			local var_2_4 = arg_1_0
			local var_2_5 = var_4.sendNotification

			GAME = var_6

			var_2_5(var_2_4, var_6.ISLAND_UNLOCK_TECH_DONE)
		else
			pg = var_1

			local var_2_6 = var_1.TipsMgr.GetInstance()
			local var_2_7 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_7(var_2_6, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
