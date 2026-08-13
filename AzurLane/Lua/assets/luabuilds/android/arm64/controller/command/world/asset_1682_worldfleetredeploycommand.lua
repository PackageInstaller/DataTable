class = var_0_10000

local var_0_0 = "WorldFleetRedeployCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg = var_1_10003

	local var_1_1 = var_1_10003.ConnectionMgr.GetInstance()

	var_3.Send(var_1_1, 1, var_1_0, 2, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			getProxy = var_2_0
			WorldProxy = var_2_10003
			var_2_0 = var_2_0(var_2_10003)
			nowWorld = var_2_10002

			local var_2_1 = var_2_10002()

			var_2.SetFleets(var_2_1, var_2_0:NetBuildMapFleetList(arg_2_0.group_list))

			local var_2_2 = var_2
			local var_2_3 = var_2.GetActiveMap(var_2_2)

			var_3.SetValid(var_2_3, false)
			var_3:UnbindFleets()

			var_2_10004 = arg_2_0.group_list[1].id
			table = var_2_2

			local var_2_4 = var_2_2.indexof
			local var_2_5 = var_2.fleets
			local var_2_6 = var_2

			var_3.findex = var_2_4(var_2_5, var_2.GetFleet(var_2_6, var_2_10004))

			var_3:BindFleets(var_2.fleets)

			local var_2_7 = var_2
			local var_2_8 = var_2.CalcOrderCost

			WorldConst = var_8

			local var_2_9 = var_2_8(var_2_7, var_8.OpReqRedeploy)
			local var_2_10 = var_2.staminaMgr

			var_6.ConsumeStamina(var_2_10, var_2_9)

			local var_2_11 = var_2
			local var_2_12 = var_2.SetReqCDTime

			WorldConst = var_9

			local var_2_13 = var_9.OpReqRedeploy

			pg = var_2_6

			local var_2_14 = var_2_6.TimeMgr.GetInstance()

			var_2_12(var_2_11, var_2_13, var_10.GetServerTime(var_2_14))

			pg = var_2_12

			local var_2_15 = var_2_12.TipsMgr.GetInstance()
			local var_2_16 = var_6.ShowTips

			i18n = var_2_13

			var_2_16(var_2_15, var_2_13("world_instruction_redeploy_2"))

			local var_2_17 = var_2:GetBossProxy()

			var_6.GenFleet(var_2_17)

			local var_2_18 = arg_1_0
			local var_2_19 = var_7.sendNotification

			GAME = var_10

			var_2_19(var_2_18, var_10.WORLD_FLEET_REDEPLOY_DONE)
		else
			pg = var_2_0

			local var_2_20 = var_2_0.TipsMgr.GetInstance()
			local var_2_21 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_21(var_2_20, var_2_10004("world_fleet_redeploy_error_", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
