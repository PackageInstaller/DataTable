local var_0_0 = class("GetIslandDataCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	arg_1_0:GetIslandData(var_1_0.id, var_1_0.list, var_1_0.isCardRequest, var_1_0.callback, var_1_0.reconnect, var_1_0.checkCanEnterMap)

	return
end

function var_0_0.GetIslandData(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6)
	if LOCK_ISLAND_DISPLAY then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(21200, {
		island_id = arg_2_1
	}, 21201, function(arg_3_0)
		local var_3_0 = arg_2_0:IsSelf(arg_2_1)

		if var_3_0 then
			local var_3_2 = var_3_1.New(arg_3_0.island)

			if arg_3_0.player_position then
				var_3_2:SetMapId(arg_3_0.player_position.map_id)
				var_3_2:SetLastExitPosition(arg_3_0.player_position.map_id, Vector3(arg_3_0.player_position.position.x, arg_3_0.player_position.position.y, arg_3_0.player_position.position.z), (Vector3(arg_3_0.player_position.rotation.x, arg_3_0.player_position.rotation.y, arg_3_0.player_position.rotation.z)))
			end

			if arg_2_5 then
				local var_3_3 = getProxy(IslandProxy):GetTempPlayerPosition()

				if var_3_3 then
					local var_3_4, var_3_5, var_3_6 = unpack(var_3_3)

					var_3_2:SetMapId(var_3_4)
					var_3_2:SetLastExitPosition(var_3_4, var_3_5, var_3_6)
				end
			end

			local var_3_7 = {}

			for iter_3_0, iter_3_1 in ipairs(arg_2_2) do
				var_3_7[iter_3_1.id] = IslandPlayer.New(iter_3_1)
			end

			var_3_2:GetVisitorAgency():SetPlayerList(var_3_7)

			if var_3_0 then
				getProxy(IslandProxy):SetIsland(var_3_2)
			else
				getProxy(IslandProxy):SetSharedIsland(var_3_2)
			end

			if arg_2_3 then
				existCall(arg_2_4)

				return
			end

			arg_2_0:AfterIslandInit()

			if arg_2_6 then
				existCall(arg_2_6)

				return
			end

			arg_2_0:sendNotification(GAME.ISLAND_ENTER_MAP, {
				islandId = arg_2_1,
				mapId = var_3_2:GetMapId(),
				callback = function()
					arg_2_0:GoScene(arg_2_1)

					return
				end
			})

			return
		end
	end)

	return
end

function var_0_0.IsSelf(arg_5_0, arg_5_1)
	local var_5_0 = getProxy(PlayerProxy)

	return var_5_0:getRawData().id == arg_5_1
end

function var_0_0.GoScene(arg_6_0, arg_6_1)
	if arg_6_0:IsSelf(arg_6_1) then
		arg_6_0:sendNotification(GAME.GO_SCENE, SCENE.ISLAND, {
			id = arg_6_1
		})
	else
		arg_6_0:sendNotification(GAME.GO_SCENE, SCENE.SHARED_ISLAND, {
			id = arg_6_1
		})
	end

	return
end

function var_0_0.AfterIslandInit(arg_7_0)
	local var_7_0 = getProxy(IslandProxy):GetIsland()

	var_7_0:GetAchievementAgency():InitRuntimeRecords()
	var_7_0:GetTechnologyAgency():InitLockData()
	var_7_0:GetGlobalBuffAgency():InitShipSkillGlobalBuff()
	var_7_0:GetBookAgency():InitRuntimeTypesData()

	return
end

return var_0_0
