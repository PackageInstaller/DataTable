class = var_0_10000

local var_0_0 = "IslandSlotCollectCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

var_0_1.START_HAND_COLLECT_DONE = "IslandSlotCollectCommand:START_HAND_COLLECT_DONE"

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().build_id
	local var_1_1 = var_2.area_id

	getProxy = var_1_10005
	IslandProxy = var_1_10007

	local var_1_2 = var_1_10005(var_1_10007)
	local var_1_3 = var_5.GetIsland(var_1_2)
	local var_1_4 = var_5.GetBuildingAgency(var_1_3)
	local var_1_5 = var_2.type

	pg = var_1_3

	local var_1_6 = var_1_3.ConnectionMgr.GetInstance()

	var_8.Send(var_1_6, 21507, {
		build_id = var_1_0,
		area_id = var_1_1,
		type = var_1_5
	}, 21508, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			local var_2_0 = var_1_4

			var_2_1 = var_2_1.GetBuilding(var_2_0, var_1_0)

			local var_2_2 = {
				id = var_1_1
			}

			if var_1_5 == 2 then
				var_2_2 = {
					id = var_1_1
				}
			end

			local var_2_3 = var_2_1:GetBuildingCollectData()

			var_3.UpdateCollectRefreshtTime(var_2_3, arg_2_0.refresh_time)

			local var_2_4 = var_2_1:GetBuildingCollectData()

			var_3.UpdateGetCollectNum(var_2_4, var_1_5)
			var_2_1:UpdateCollectDataBySlotId(var_2_2, var_1_5)

			IslandDropHelper = var_3

			local var_2_5 = var_3.AddItems(arg_2_0)
			local var_2_6 = arg_1_0

			var_2_10004 = var_2_10004.sendNotification
			GAME = var_7

			var_2_10004(var_2_6, var_7.ISLAND_DROPMAIN_AWARD, {
				dropData = var_2_5
			})

			local var_2_7 = var_0

			var_2_10004.DispatchEvent(var_2_7, var_0_1.START_HAND_COLLECT_DONE, {
				build_id = var_1_0,
				area_id = var_1_1
			})
		else
			pg = var_2_1

			local var_2_8 = var_2_1.TipsMgr.GetInstance()
			local var_2_9 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_9(var_2_8, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
