class = var_0_10000

local var_0_0 = "IslandRecordLastPositionCommmand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().islandId
	local var_1_1 = var_2.mapId
	local var_1_2 = var_2.position
	local var_1_3 = var_2.rotation

	pg = var_1_10007

	local var_1_4 = var_1_10007.ConnectionMgr.GetInstance()

	var_7.Send(var_1_4, 21229, {
		island_id = var_1_0,
		player_position = {
			map_id = var_1_1,
			position = {
				x = var_1_2.x,
				y = var_1_2.y,
				z = var_1_2.z
			},
			rotation = {
				x = var_1_3.x,
				y = var_1_3.y,
				z = var_1_3.z
			}
		}
	})

	getProxy = var_7
	IslandProxy = var_1_4

	local var_1_5 = var_7(var_1_4)
	local var_1_6 = var_7.GetIsland(var_1_5)

	var_7.SetLastExitPosition(var_1_6, var_1_1, var_1_2, var_1_3)

	return
end

return var_0_1
