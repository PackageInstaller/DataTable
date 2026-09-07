local IslandStopHandPlantHalfWayCommand = class("IslandStopHandPlantHalfWayCommand", pm.SimpleCommand)

function IslandStopHandPlantHalfWayCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.build_id
	local var_1_2 = var_1_0.slot_list
	local var_1_3 = getProxy(IslandProxy):GetIsland()
	local var_1_4 = var_1_3:GetBuildingAgency()

	pg.ConnectionMgr.GetInstance():Send(21516, {
		build_id = var_1_0.build_id,
		slot_list = var_1_0.slot_list
	}, 21517, function(arg_2_0)
		if arg_2_0.result == 0 then
			for iter_2_0, iter_2_1 in ipairs(var_1_2) do
				var_1_4:GetBuilding(var_1_1):UpdateHandPlantDataBySlotId({
					formula_id = 0,
					end_time = 0,
					state = 0,
					id = iter_2_1
				})
				var_1_3:DispatchEvent(IslandSlotHandPlantAwardCommand.START_HANDPLANT_AWARD_DONE, {
					build_id = var_1_1,
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

return IslandStopHandPlantHalfWayCommand
