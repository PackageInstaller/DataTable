local var_0_0 = class("WorldFleetRedeployCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(1, arg_1_1:getBody(), 2, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = nowWorld()

			var_2_0:SetFleets(getProxy(WorldProxy):NetBuildMapFleetList(arg_2_0.group_list))

			local var_2_1 = var_2_0:GetActiveMap()

			var_2_1:SetValid(false)
			var_2_1:UnbindFleets()

			var_2_1.findex = table.indexof(var_2_0.fleets, var_2_0:GetFleet(arg_2_0.group_list[1].id))

			var_2_1:BindFleets(var_2_0.fleets)
			var_2_0.staminaMgr:ConsumeStamina((var_2_0:CalcOrderCost(WorldConst.OpReqRedeploy)))
			var_2_0:SetReqCDTime(WorldConst.OpReqRedeploy, pg.TimeMgr.GetInstance():GetServerTime())
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_instruction_redeploy_2"))
			var_2_0:GetBossProxy():GenFleet()
			arg_1_0:sendNotification(GAME.WORLD_FLEET_REDEPLOY_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("world_fleet_redeploy_error_", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
