class = var_0_10000

local var_0_0 = "GetIslandDataCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.list
	local var_1_2 = var_2.isCardRequest
	local var_1_3 = var_2.callback
	local var_1_4 = var_2.reconnect
	local var_1_5 = var_2.checkCanEnterMap

	arg_1_0:GetIslandData(var_1_0, var_1_1, var_1_2, var_1_3, var_1_4, var_1_5)

	return
end

function var_0_1.GetIslandData(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6)
	LOCK_ISLAND_DISPLAY = var_1_10007

	if var_1_10007 then
		return
	end

	pg = var_1_10007

	local var_2_0 = var_1_10007.ConnectionMgr.GetInstance()

	var_7.Send(var_2_0, 21200, {
		island_id = arg_2_1
	}, 21201, function(arg_3_0)
		local var_3_0 = arg_2_0

		if var_1.IsSelf(var_3_0, arg_2_1) then
			Island = var_3_0

			if not var_3_0 then
				SharedIsland = var_3_0
			end

			local var_3_1 = var_3_0.New(arg_3_0.island)

			if arg_3_0.player_position then
				local var_3_2 = arg_3_0.player_position.map_id

				Vector3 = var_2_10005
				var_2_10005 = var_2_10005(arg_3_0.player_position.position.x, arg_3_0.player_position.position.y, arg_3_0.player_position.position.z)
				Vector3 = var_6

				local var_3_3 = var_6(arg_3_0.player_position.rotation.x, arg_3_0.player_position.rotation.y, arg_3_0.player_position.rotation.z)

				var_3_1:SetMapId(var_3_2)
				var_3_1:SetLastExitPosition(var_3_2, var_2_10005, var_3_3)
			end

			if arg_2_5 then
				getProxy = var_4
				IslandProxy = var_2_10005
				var_2_10005 = var_4(var_2_10005)

				if var_4.GetTempPlayerPosition(var_2_10005) then
					unpack = var_2_10005

					local var_3_4, var_3_5

					var_2_10005, var_3_4, var_3_5 = var_2_10005(var_4)

					var_3_1:SetMapId(var_2_10005)
					var_3_1:SetLastExitPosition(var_2_10005, var_3_4, var_3_5)
				end
			end

			local var_3_6 = {}

			ipairs = var_2_10005

			for iter_3_0, iter_3_1 in var_2_10005(arg_2_2) do
				IslandPlayer = var_2_10010
				var_2_10010 = var_2_10010.New(iter_3_1)
				var_3_6[iter_3_1.id] = var_2_10010
			end

			local var_3_7 = var_3_1:GetVisitorAgency()

			var_5.SetPlayerList(var_3_7, var_3_6)

			if var_1 then
				getProxy = var_5
				IslandProxy = var_3_7
				var_3_7 = var_5(var_3_7)

				var_5.SetIsland(var_3_7, var_3_1)
			else
				getProxy = var_5
				IslandProxy = var_3_7

				local var_3_8 = var_5(var_3_7)

				var_5.SetSharedIsland(var_3_8, var_3_1)
			end

			if arg_2_3 then
				existCall = var_5

				var_5(arg_2_4)

				return
			end

			local var_3_9 = arg_2_0

			var_5.AfterIslandInit(var_3_9)

			if arg_2_6 then
				existCall = var_5

				var_5(arg_2_6)

				return
			end

			local var_3_10 = arg_2_0
			local var_3_11 = var_5.sendNotification

			GAME = var_7

			var_3_11(var_3_10, var_7.ISLAND_ENTER_MAP, {
				islandId = arg_2_1,
				mapId = var_3_1:GetMapId(),
				callback = function()
					local var_4_0 = arg_2_0

					var_0.GoScene(var_4_0, arg_2_1)

					return
				end
			})

			return
		end
	end)

	return
end

function var_0_1.IsSelf(arg_5_0, arg_5_1)
	getProxy = var_1_10002
	PlayerProxy = var_1_10003

	local var_5_0 = var_1_10002(var_1_10003)

	return var_2.getRawData(var_5_0).id == arg_5_1
end

function var_0_1.GoScene(arg_6_0, arg_6_1)
	local var_6_2

	if arg_6_0:IsSelf(arg_6_1) then
		local var_6_0 = arg_6_0
		local var_6_1 = arg_6_0.sendNotification

		GAME = var_6_2
		var_6_2 = var_6_2.GO_SCENE
		SCENE = var_1_10005

		var_6_1(var_6_0, var_6_2, var_1_10005.ISLAND, {
			id = arg_6_1
		})
	else
		local var_6_3 = arg_6_0
		local var_6_4 = arg_6_0.sendNotification

		GAME = var_6_2

		local var_6_5 = var_6_2.GO_SCENE

		SCENE = var_1_10005

		var_6_4(var_6_3, var_6_5, var_1_10005.SHARED_ISLAND, {
			id = arg_6_1
		})
	end

	return
end

function var_0_1.AfterIslandInit(arg_7_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10002

	local var_7_0 = var_1_10001(var_1_10002)
	local var_7_1 = var_1.GetIsland(var_7_0)
	local var_7_2 = var_1.GetAchievementAgency(var_7_1)

	var_2.InitRuntimeRecords(var_7_2)

	local var_7_3 = var_1:GetTechnologyAgency()

	var_2.InitLockData(var_7_3)

	local var_7_4 = var_1:GetGlobalBuffAgency()

	var_2.InitShipSkillGlobalBuff(var_7_4)

	local var_7_5 = var_1:GetBookAgency()

	var_2.InitRuntimeTypesData(var_7_5)

	return
end

return var_0_1
