local var_0_0 = class("IslandRecordLastPositionCommmand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(21229, {
		island_id = var_1_0.islandId,
		player_position = {
			map_id = var_1_0.mapId,
			position = {
				x = var_1_0.position.x,
				y = var_1_0.position.y,
				z = var_1_0.position.z
			},
			rotation = {
				x = var_1_0.rotation.x,
				y = var_1_0.rotation.y,
				z = var_1_0.rotation.z
			}
		}
	})
	getProxy(IslandProxy):GetIsland():SetLastExitPosition(var_1_0.mapId, var_1_0.position, var_1_0.rotation)

	return
end

return var_0_0
