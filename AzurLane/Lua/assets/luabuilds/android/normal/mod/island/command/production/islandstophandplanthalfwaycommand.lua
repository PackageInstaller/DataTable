class = var_0_10000

local var_0_0 = "IslandStopHandPlantHalfWayCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().build_id
	local var_1_1 = var_2.slot_list

	getProxy = var_1_10005
	IslandProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006)
	local var_1_3 = var_5.GetIsland(var_1_2)
	local var_1_4 = var_5.GetBuildingAgency(var_1_3)

	pg = var_1_3

	local var_1_5 = var_1_3.ConnectionMgr.GetInstance()

	var_7.Send(var_1_5, 21516, {
		build_id = var_1_0,
		slot_list = var_1_1
	}, 21517, function(arg_2_0)
		if arg_2_0.result == 0 then
			ipairs = var_1

			for iter_2_0, iter_2_1 in var_1(var_1_1) do
				local var_2_0 = var_1_4
				local var_2_1 = var_6.GetBuilding(var_2_0, var_1_0)

				var_6.UpdateHandPlantDataBySlotId(var_2_1, {
					formula_id = 0,
					end_time = 0,
					state = 0,
					id = iter_2_1
				})

				local var_2_2 = var_0
				local var_2_3 = var_7.DispatchEvent

				IslandSlotHandPlantAwardCommand = var_9

				var_2_3(var_2_2, var_9.START_HANDPLANT_AWARD_DONE, {
					build_id = var_1_0,
					area_id = iter_2_1
				})
			end
		else
			pg = var_1

			local var_2_4 = var_1.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_5(var_2_4, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
