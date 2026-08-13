class = var_0_10000

local var_0_0 = "IslandSlotHandPlantAwardCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

var_0_1.START_HANDPLANT_AWARD_DONE = "IslandSlotHandPlantCommand:START_HANDPLANT_AWARD_DONE"

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().slot_list[1]

	pg = var_1_10005

	local var_1_1 = var_1_10005.island_production_slot[var_1_0].place

	getProxy = var_1_10006
	IslandProxy = var_1_10007

	local var_1_2 = var_1_10006(var_1_10007)
	local var_1_3 = var_6.GetIsland(var_1_2)
	local var_1_4 = var_6.GetBuildingAgency(var_1_3)

	pg = var_1_3

	local var_1_5 = var_1_3.ConnectionMgr.GetInstance()

	var_8.Send(var_1_5, 21511, {
		build_id = var_1_1,
		area_ids = var_3
	}, 21512, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			var_2_0 = {}
			ipairs = var_2_10002

			for iter_2_0, iter_2_1 in var_2_10002(arg_2_0.drop_list) do
				table = var_2_10007

				var_2_10007.insert(var_2_0, iter_2_1)
			end

			IslandDropHelper = var_2

			local var_2_1 = var_2.AddItems({
				drop_list = var_2_0
			})
			local var_2_2 = arg_1_0

			var_2_10003 = var_2_10003.sendNotification
			GAME = iter_2_0

			var_2_10003(var_2_2, iter_2_0.ISLAND_DROPMAIN_AWARD, {
				dropData = var_2_1
			})

			local var_2_3 = var_1_4

			var_2_10003 = var_2_10003.GetBuilding(var_2_3, var_1_1)
			ipairs = var_2_3

			for iter_2_2, iter_2_3 in var_2_3(var_0) do
				var_2_10003:UpdateHandPlantDataBySlotId({
					formula_id = 0,
					end_time = 0,
					state = 0,
					id = iter_2_3
				})

				local var_2_4 = var_0

				var_9.DispatchEvent(var_2_4, var_0_1.START_HANDPLANT_AWARD_DONE, {
					build_id = var_1_1,
					area_id = iter_2_3
				})
			end
		else
			pg = var_2_0

			local var_2_5 = var_2_0.TipsMgr.GetInstance()
			local var_2_6 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_6(var_2_5, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
