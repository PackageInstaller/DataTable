local var_0_0 = class("IslandStopHandPlantHalfWayCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_9000
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(IslandProxy)
	local var_1_2 = var_1_1.GetIsland(var_1_9000)
	local var_1_3 = var_1_1.GetIsland(var_1_9000):GetBuildingAgency()

	pg.ConnectionMgr.GetInstance().Send(var_1_1, 21516, {
		build_id = var_1_0.build_id,
		slot_list = var_1_0.slot_list
	}, 21517, function(arg_2_0)
		if arg_2_0.result == 0 then
			for iter_2_0, iter_2_1 in ipairs(var_0) do
				var_1_3:GetBuilding(var_0):UpdateHandPlantDataBySlotId({
					formula_id = 0,
					end_time = 0,
					state = 0,
					id = iter_2_1
				})
				var_1_2:DispatchEvent(IslandSlotHandPlantAwardCommand.START_HANDPLANT_AWARD_DONE, {
					build_id = var_0,
					area_id = iter_2_1
				})
			end
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
