local GetIslandDataCommand = class("GetIslandDataCommand", pm.SimpleCommand)

function GetIslandDataCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	self:GetIslandData(var_1_0.id, var_1_0.list, var_1_0.isCardRequest, var_1_0.callback, var_1_0.reconnect, var_1_0.checkCanEnterMap)

	return
end

function GetIslandDataCommand:GetIslandData(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6)
	if LOCK_ISLAND_DISPLAY then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(21200, {
		island_id = arg_2_1
	}, 21201, function(arg_3_0)
		local var_3_0 = self:IsSelf(arg_2_1)
		local var_3_1 = ((var_3_0 or nil) and (Island or SharedIsland)).New(arg_3_0.island)

		if arg_3_0.player_position then
			var_3_1:SetMapId(arg_3_0.player_position.map_id)
			var_3_1:SetLastExitPosition(arg_3_0.player_position.map_id, Vector3(arg_3_0.player_position.position.x, arg_3_0.player_position.position.y, arg_3_0.player_position.position.z), (Vector3(arg_3_0.player_position.rotation.x, arg_3_0.player_position.rotation.y, arg_3_0.player_position.rotation.z)))
		end

		if arg_2_5 then
			local var_3_2 = getProxy(IslandProxy):GetTempPlayerPosition()

			if var_3_2 then
				local var_3_3, var_3_4, var_3_5 = unpack(var_3_2)

				var_3_1:SetMapId(var_3_3)
				var_3_1:SetLastExitPosition(var_3_3, var_3_4, var_3_5)
			end
		end

		local var_3_6 = {}

		for iter_3_0, iter_3_1 in ipairs(arg_2_2) do
			var_3_6[iter_3_1.id] = IslandPlayer.New(iter_3_1)
		end

		var_3_1:GetVisitorAgency():SetPlayerList(var_3_6)

		if var_3_0 then
			getProxy(IslandProxy):SetIsland(var_3_1)
		else
			getProxy(IslandProxy):SetSharedIsland(var_3_1)
		end

		if arg_2_3 then
			existCall(arg_2_4)

			return
		end

		self:AfterIslandInit()

		if arg_2_6 then
			existCall(arg_2_6)

			return
		end

		self:sendNotification(GAME.ISLAND_ENTER_MAP, {
			islandId = arg_2_1,
			mapId = var_3_1:GetMapId(),
			callback = function()
				self:GoScene(arg_2_1)

				return
			end
		})

		return
	end)

	return
end

function GetIslandDataCommand:IsSelf(arg_5_1)
	return getProxy(PlayerProxy):getRawData().id == arg_5_1
end

function GetIslandDataCommand:GoScene(arg_6_1)
	if self:IsSelf(arg_6_1) then
		self:sendNotification(GAME.GO_SCENE, SCENE.ISLAND, {
			id = arg_6_1
		})
	else
		self:sendNotification(GAME.GO_SCENE, SCENE.SHARED_ISLAND, {
			id = arg_6_1
		})
	end

	return
end

function GetIslandDataCommand:AfterIslandInit()
	local var_7_0 = getProxy(IslandProxy):GetIsland()

	var_7_0:GetAchievementAgency():InitRuntimeRecords()
	var_7_0:GetTechnologyAgency():InitLockData()
	var_7_0:GetGlobalBuffAgency():InitShipSkillGlobalBuff()
	var_7_0:GetBookAgency():InitRuntimeTypesData()

	return
end

return GetIslandDataCommand
