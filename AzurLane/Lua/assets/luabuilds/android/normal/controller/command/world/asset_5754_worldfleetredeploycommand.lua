class = var_0_10000

local var_0_0 = "WorldFleetRedeployCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_3.Send(var_1_2, 1, var_1_1, 2, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			getProxy = var_2_0
			WorldProxy = var_2_10002
			var_2_0 = var_2_0(var_2_10002)
			nowWorld = var_2_10002

			local var_2_1 = var_2_10002()

			var_2.SetFleets(var_2_1, var_2_0:NetBuildMapFleetList(arg_2_0.group_list))

			local var_2_2 = var_2:GetActiveMap()

			var_2_10003.SetValid(var_2_2, false)

			local var_2_3 = var_2_10003

			var_2_10003.UnbindFleets(var_2_3)

			local var_2_4 = arg_2_0.group_list[1].id

			table = var_2_3
			var_2_10003.findex = var_2_3.indexof(var_2.fleets, var_2:GetFleet(var_2_4))

			var_2_10003:BindFleets(var_2.fleets)

			local var_2_5 = var_2
			local var_2_6 = var_2.CalcOrderCost

			WorldConst = var_7

			local var_2_7 = var_2_6(var_2_5, var_7.OpReqRedeploy)
			local var_2_8 = var_2.staminaMgr

			var_6.ConsumeStamina(var_2_8, var_2_7)

			local var_2_9 = var_2
			local var_2_10 = var_2.SetReqCDTime

			WorldConst = var_8

			local var_2_11 = var_8.OpReqRedeploy

			pg = var_9

			local var_2_12 = var_9.TimeMgr.GetInstance()

			var_2_10(var_2_9, var_2_11, var_9.GetServerTime(var_2_12))

			pg = var_2_10

			local var_2_13 = var_2_10.TipsMgr.GetInstance()
			local var_2_14 = var_6.ShowTips

			i18n = var_2_11

			var_2_14(var_2_13, var_2_11("world_instruction_redeploy_2"))

			local var_2_15 = var_2:GetBossProxy()

			var_6.GenFleet(var_2_15)

			local var_2_16 = arg_1_0
			local var_2_17 = var_7.sendNotification

			GAME = var_9

			var_2_17(var_2_16, var_9.WORLD_FLEET_REDEPLOY_DONE)
		else
			pg = var_2_0

			local var_2_18 = var_2_0.TipsMgr.GetInstance()
			local var_2_19 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_19(var_2_18, var_2_10003("world_fleet_redeploy_error_", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
