local IslandAddDelegationCommand = class("IslandAddDelegationCommand", pm.SimpleCommand)

IslandAddDelegationCommand.END_DELEGATION = "IslandAddDelegationCommand:END_DELEGATION"

function IslandAddDelegationCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.build_id
	local var_1_2 = var_1_0.area_id
	local var_1_3 = var_1_0.add_num
	local var_1_4 = var_1_0.extraCost or 0
	local var_1_5 = getProxy(IslandProxy):GetIsland()
	local var_1_6 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()
	local var_1_7 = var_1_5:GetBuildingAgency()

	pg.ConnectionMgr.GetInstance():Send(21537, {
		build_id = var_1_0.build_id,
		area_id = var_1_0.area_id,
		add_num = var_1_0.add_num
	}, 21538, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_1_7:GetBuilding(var_1_1):GetDelegationSlotData(var_1_2)
			local var_2_1 = var_2_0:GetSlotRoleData()

			var_2_1:AddCostList(arg_2_0.cost_time_list)
			var_2_1:AddExtraList(arg_2_0.times_extra)

			local var_2_2 = pg.island_formula[var_2_0:GetFormulaId()]

			for iter_2_0, iter_2_1 in ipairs(var_2_2.commission_cost) do
				var_1_6:RemoveItem(iter_2_1[1], (iter_2_1[2] + var_1_4) * var_1_3)
			end

			local var_2_3 = var_1_5:GetCharacterAgency():GetShipById(var_2_1.ship_id)

			var_2_3:UpdateEnergy(var_2_3:GetCurrentEnergy() - math.max(math.floor(var_2_2.stamina_cost * (1 - IslandProductCostHelper.GetReducePercentInPlace(var_2_1.ship_id, var_1_1))), 1) * var_1_3)
			var_2_3:UpdateEnergyBeginRecoverTime(var_2_1:GetFinishTime())
			self:sendNotification(GAME.ISLAND_FINISH_DELEGATION_DONE, {
				slotId = var_1_2
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return IslandAddDelegationCommand
