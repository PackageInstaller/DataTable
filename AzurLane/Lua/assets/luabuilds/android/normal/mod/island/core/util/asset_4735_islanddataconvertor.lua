class = var_0_10000

local var_0_0 = var_0_10000("IslandDataConvertor")

function var_0_0.Island2SceneData(arg_1_0)
	local var_1_0 = arg_1_0:GetMapId()
	local var_1_1 = arg_1_0:GetSpawnPointId()
	local var_1_2 = arg_1_0:GetLastExitPosition()
	local var_1_3 = arg_1_0:GetVisitorAgency()
	local var_1_4 = var_4.GetMapVisitorList(var_1_3)

	pg = var_1_3

	local var_1_5 = var_1_3.island_map[var_1_0]
	local var_1_6 = {}
	local var_1_7 = {}
	local var_1_8 = {}
	local var_1_9 = {}
	local var_1_10 = {}
	local var_1_11 = {}
	local var_1_12 = {}
	local var_1_13 = {}
	local var_1_14 = {}

	var_0_0.SceneData2IslandUnits(var_1_6, var_1_14, var_1_4, var_1_0, var_1_1, var_1_2, arg_1_0.id)
	var_0_0.SystemData2IslandUnits(var_1_6, var_1_12, var_1_11, arg_1_0, var_1_0, var_1_10)
	var_0_0.CollectSystems(var_1_7, var_1_8, arg_1_0, var_1_0, var_1_10)
	var_0_0.CollectStrollUnits(var_1_9, arg_1_0, var_1_0)
	var_0_0.CollectFollowUnits(var_1_6, var_1_13, arg_1_0, var_1_0)

	local var_1_15 = var_0_0.CollectCamreaZoomData(var_1_0)

	return {
		mapId = var_1_0,
		unitList = var_1_6,
		sceneName = var_1_5.sceneName,
		systemList = var_1_7,
		systemUnits = var_1_8,
		strollUnits = var_1_9,
		productSystems = var_1_10,
		giftUnits = var_1_11,
		followUnits = var_1_13,
		delayInitUnits = var_1_12,
		activityUnits = var_1_14,
		camreaZoomData = var_1_15
	}
end

function var_0_0.Island2SceneName(arg_2_0)
	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.GetMapId(var_2_0)

	pg = var_2_0

	return var_2_0.island_map[var_2_1].sceneName, var_2_1, var_2.default_bgm
end

function var_0_0.CollectCamreaZoomData(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.island_map[arg_3_0].camera_zoom[1]
	local var_3_1 = var_1[2]
	local var_3_2

	if not var_1[3] then
		var_3_2 = 0.5
	end

	return {
		min = var_3_0,
		max = var_3_1,
		value = var_3_2
	}
end

function var_0_0.SystemData2IslandUnits(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	var_0_0.CollectSignInSystemUnits(arg_4_0, arg_4_2, arg_4_3, arg_4_4)
	var_0_0.CollectWildCollectInSystemUnits(arg_4_0, arg_4_2, arg_4_3, arg_4_4)
	var_0_0.CollectBuildingSystemUnits(arg_4_0, arg_4_1, arg_4_3, arg_4_4, arg_4_5)
	var_0_0.CollectFishPointUnits(arg_4_0, arg_4_3, arg_4_4)

	if arg_4_3:IsPrivate() then
		var_0_0.CollectOrderSystemUnits(arg_4_0, arg_4_3, arg_4_4)
	end

	return
end

function var_0_0.CollectFishPointUnits(arg_5_0, arg_5_1, arg_5_2)
	ipairs = var_1_10003
	pg = var_1_10004

	for iter_5_0, iter_5_1 in var_1_10003(var_1_10004.island_fish_point.all) do
		pg = var_1_10008
		var_1_10008 = var_1_10008.island_fish_point[iter_5_1]
		pg = var_1_10009

		if var_1_10009.island_world_objects[var_1_10008.objId].mapId == arg_5_2 then
			table = var_10

			local var_5_0 = var_10.insert
			local var_5_1 = arg_5_0

			IslandFishPointVO = var_1_10012

			var_5_0(var_5_1, var_1_10012.New(iter_5_1, var_1_10008.objId))
		end
	end

	return
end

function var_0_0.CollectBuildingSystemUnits(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	local var_6_0 = arg_6_2
	local var_6_1 = arg_6_2.GetBuildingAgency(var_6_0)

	pg = var_6_0

	local var_6_2

	if not var_6_0.island_production_place.get_id_list_by_map_id[arg_6_3] then
		var_6_2 = {}
	end

	ipairs = var_1_10007

	for iter_6_0, iter_6_1 in var_1_10007(var_6_2) do
		pg = var_1_10012

		if arg_6_3 == var_1_10012.island_production_place[iter_6_1].map_id then
			local var_6_3 = var_6_1

			var_1_10012 = var_6_1.GetBuilding(var_6_3, iter_6_1)
			IslandProductSystemVO = var_6_3

			local var_6_4 = var_6_3.New(iter_6_1, var_1_10012, arg_6_2.id)

			ipairs = var_14

			for iter_6_2, iter_6_3 in var_14(var_6_4:GetUnitDatas()) do
				if iter_6_3 then
					if iter_6_3.delayTime then
						table = var_19

						var_19.insert(arg_6_1, iter_6_3)
					else
						table = var_19

						var_19.insert(arg_6_0, iter_6_3)
					end
				end
			end

			table = var_14

			var_14.insert(arg_6_4, var_6_4)
		end
	end

	return
end

function var_0_0.CollectOrderSystemUnits(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_1:GetOrderAgency()
	local var_7_1 = var_3.GetShipSlotList(var_7_0)

	pairs = var_7_0

	for iter_7_0, iter_7_1 in var_7_0(var_7_1) do
		if not iter_7_1:IsLock() and iter_7_1:GetWorldObjId() > 0 then
			pg = var_10

			if var_10.island_world_objects[iter_7_1:GetWorldObjId()] and var_10.mapId == arg_7_2 then
				local var_7_2 = {}
				local var_7_3 = var_0_0.WorldObj2IslandUnit(var_10, var_7_2)

				table = var_13

				var_13.insert(arg_7_0, var_7_3)
			end
		end
	end

	return
end

function var_0_0.CollectSignInSystemUnits(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = arg_8_2
	local var_8_1 = arg_8_2.GetSignInAgency(var_8_0)

	pg = var_8_0

	local var_8_2

	if not var_8_0.island_world_objects.get_id_list_by_mapId[arg_8_3] then
		var_8_2 = {}
	end

	local var_8_3 = 0

	ipairs = var_1_10007

	for iter_8_0, iter_8_1 in var_1_10007(var_8_2) do
		pg = var_1_10012

		local var_8_4 = var_1_10012.island_world_objects[iter_8_1].unitId

		if 0 < var_8_4 then
			local var_8_5 = var_1_10012.gen_type

			IslandConst = var_14

			if var_8_5 == var_14.UNIT_GEN_TYPE_GIFT then
				var_8_3 = var_8_3 + 1

				local var_8_6 = var_0_0.WorldObj2IslandUnit(var_1_10012, {
					index = var_8_3
				})

				table = var_14

				var_14.insert(arg_8_1, var_8_6)
			end
		end
	end

	return
end

function var_0_0.CollectWildCollectInSystemUnits(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = arg_9_2:GetWildCollectAgency()
	local var_9_1 = var_4.GetUnitList(var_9_0)

	ipairs = var_9_0

	for iter_9_0, iter_9_1 in var_9_0(var_9_1) do
		pg = var_1_10011

		if var_1_10011.island_world_objects[iter_9_1.unitId].unitId > 0 then
			local var_9_2 = var_0_0.WorldObj2IslandUnit(var_1_10011, {
				index = arg_9_2.id,
				typ = iter_9_1.gatherType
			})

			table = var_13

			var_13.insert(arg_9_0, var_9_2)
		end
	end

	return
end

function var_0_0.CollectStrollUnits(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_1:GetAblityAgency()
	local var_10_1 = arg_10_1:GetCharacterAgency()
	local var_10_2 = var_4.GetShips(var_10_1)

	local function var_10_3(arg_11_0, arg_11_1)
		if arg_11_0 == -1 then
			local var_11_0 = arg_10_1
			local var_11_1 = var_2.GetFollowerAgency(var_11_0)

			_ = var_11_0

			return var_11_0.detect(var_10_2, function(arg_12_0)
				local var_12_0 = var_11_1

				return not var_1.Following(var_12_0, arg_12_0.id) and arg_12_0:getConfig("unit_id") == arg_11_1
			end) ~= nil, var_3 and var_3:GetModelUnit(), var_3 and var_3.id
		else
			local var_11_3

			if arg_11_0 ~= 0 then
				local var_11_2 = var_10_0

				var_11_3 = var_2.HasAbility(var_11_2, arg_11_0)

				if false then
					var_11_3 = false
				end
			else
				var_11_3 = true
			end

			return var_11_3, nil, 0
		end

		return
	end

	ipairs = var_1_10007
	pg = var_1_10008

	for iter_10_0, iter_10_1 in var_1_10007(var_1_10008.island_strollnpc.all) do
		pg = var_1_10012
		var_1_10012 = var_1_10012.island_strollnpc[iter_10_1]
		_ = var_1_10013

		if var_1_10013.any(var_1_10012.mapId, function(arg_13_0)
			local var_13_2

			if arg_13_0[1] == arg_10_2 then
				IslandCalcUtil = var_1

				local var_13_0 = var_1.IsHappen
				local var_13_1

				if not arg_13_0[3] then
					var_13_1 = 100
				end

				var_13_2 = var_13_0(var_13_1)
			else
				var_13_2 = false
			end

			if false then
				var_13_2 = true
			end

			return var_13_2
		end) then
			local var_10_4, var_10_5

			var_1_10013, var_10_4, var_10_5 = var_10_3(var_1_10012.unlock, var_1_10012.unit_id)

			if var_1_10013 then
				table = var_1_10016
				var_1_10016 = var_1_10016.insert

				local var_10_6 = arg_10_0

				IslandStrollUnitVO = var_1_10018

				var_1_10016(var_10_6, var_1_10018.New(var_10_5, iter_10_1, var_10_4))
			end
		end
	end

	var_0_0.DistributeAward4StrollUnits(arg_10_0, arg_10_1)

	return
end

function var_0_0.DistributeActionFeedbackAward4StrollUnits(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_1:GetNpcFeedbackAgency()
	local var_14_1 = var_3.GetNpcList(var_14_0)

	pg = var_14_0

	local var_14_2 = var_14_0.island_set.island_feedback_award_times.key_value_int - #var_14_1
	local var_14_3 = {}

	ipairs = var_1_10008

	for iter_14_0, iter_14_1 in var_1_10008(arg_14_0) do
		pg = var_1_10013

		if var_1_10013.island_strollnpc[iter_14_1.id].action_feedback == 1 then
			_ = var_14

			if var_14.all(var_14_1, function(arg_15_0)
				return iter_14_1.id ~= arg_15_0
			end) then
				table = var_14

				var_14.insert(var_14_3, iter_14_1)
			end
		end
	end

	if #var_14_3 <= 0 then
		return
	end

	shuffle = var_8

	var_8(var_14_3)

	for iter_14_2 = 1, var_14_2 do
		if var_14_3[iter_14_2] then
			math = var_1_10013

			local var_14_4 = arg_14_2[var_1_10013.random(1, #arg_14_2)]

			var_12:SetActionFeedback(var_14_4)
		end
	end

	return
end

function var_0_0.DistributeShipSkillAward4StrollUnits(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_1
	local var_16_1 = arg_16_1.GetCharacterAgency(var_16_0)

	ipairs = var_16_0

	for iter_16_0, iter_16_1 in var_16_0(arg_16_0) do
		local var_16_2 = iter_16_1:GetShipId()

		if var_16_1:GetShipById(var_16_2) and var_10:HasGreetingSkill() then
			local var_16_3 = var_10:GetSkill()
			local var_16_4 = var_11.CanUse4Ship
			local var_16_5 = var_10
			local var_16_6 = {}

			IslandBuffType = var_1_10016
			var_16_6[1] = var_1_10016.SHIP_POWER_RECOVER_BY_GREETING
			IslandBuffType = var_1_10016
			var_16_6[2] = var_1_10016.SHIP_AWARD_BY_GREETING

			if var_16_4(var_16_3, var_16_5, var_16_6) then
				math = var_12

				local var_16_7 = arg_16_2[var_12.random(1, #arg_16_2)]

				iter_16_1:SetSkillActionFeedback(var_16_7)
			end
		end
	end

	return
end

function var_0_0.GetOwnActions(arg_17_0)
	pg = var_1_10001

	local var_17_0 = var_1_10001.island_action.get_id_list_by_type

	IslandConst = var_1_10002

	local var_17_1 = var_17_0[var_1_10002.ANIMATION_OP_SIGNLE]
	local var_17_2 = arg_17_0
	local var_17_3 = arg_17_0.GetActionAgency(var_17_2)

	_ = var_17_2

	return (var_17_2.select(var_17_1, function(arg_18_0)
		local var_18_0 = var_17_3

		return var_1.ExistAction(var_18_0, arg_18_0)
	end))
end

function var_0_0.DistributeAward4StrollUnits(arg_19_0, arg_19_1)
	if #arg_19_0 > 0 and arg_19_1:IsPrivate() then
		if #var_0_0.GetOwnActions(arg_19_1) <= 0 then
			return
		end

		var_0_0.DistributeActionFeedbackAward4StrollUnits(arg_19_0, arg_19_1, var_2)
		var_0_0.DistributeShipSkillAward4StrollUnits(arg_19_0, arg_19_1, var_2)
	end

	return
end

function var_0_0.CollectFollowUnits(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0

	ipairs = var_1_10005

	for iter_20_0, iter_20_1 in var_1_10005(arg_20_0) do
		if iter_20_1:IsPlayer() then
			var_20_0 = iter_20_1

			break
		end
	end

	if not var_20_0 then
		return
	end

	local var_20_1 = var_20_0.position
	local var_20_2 = var_20_0.rotation
	local var_20_3 = arg_20_2
	local var_20_4 = arg_20_2.GetFollowerAgency(var_20_3)

	ipairs = var_20_3

	for iter_20_2, iter_20_3 in var_20_3(var_20_4:GetFollowers()) do
		local var_20_5 = arg_20_2:GetCharacterAgency()
		local var_20_6 = var_13.GetShipById(var_20_5, iter_20_3)
		local var_20_7 = var_14.GetModelUnit(var_20_6)

		table = var_20_6

		local var_20_8 = var_20_6.insert
		local var_20_9 = arg_20_1

		IslandFollowerUnitVO = var_1_10018

		var_20_8(var_20_9, var_1_10018.New(var_14.id, iter_20_3, var_20_7, var_20_1, var_20_2, iter_20_2 == 1))
	end

	return
end

function var_0_0.CollectSystems(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	var_0_0.CollectPordunctSystem(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	var_0_0.CollectManageSystem(arg_21_0, arg_21_1, arg_21_2, arg_21_3)

	pg = var_5

	local var_21_0, var_21_2, var_21_3

	if var_5.island_map[arg_21_3].minigame_id > 0 then
		table = var_21_0
		var_21_0 = var_21_0.insert

		local var_21_1 = arg_21_0

		IslandSeekGameSystemVO = var_21_2
		var_21_2 = var_21_2.New
		var_21_3 = var_5.minigame_id
		IslandConst = var_10

		var_21_0(var_21_1, var_21_2(var_21_3, var_10.SEEK_GAME_SYSTEM_ID))
	else
		IslandConst = var_21_0

		if arg_21_3 == var_21_0.AGORA_MAP_ID then
			table = var_6

			local var_21_4 = var_6.insert
			local var_21_5 = arg_21_0

			IslandGroundSystemVO = var_21_2

			local var_21_6 = var_21_2.New

			IslandConst = var_21_3

			var_21_4(var_21_5, var_21_6(var_21_3.AGORA_GROUND_SYSTEM_ID))

			table = var_21_4

			local var_21_7 = var_21_4.insert
			local var_21_8 = arg_21_0

			IslandGrassLandSystemVO = var_8

			local var_21_9 = var_8.New

			IslandConst = var_9

			var_21_7(var_21_8, var_21_9(var_9.AGORA_GRASSLAND))
		end
	end

	return
end

function var_0_0.CollectManageSystem(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = arg_22_2:GetManageAgency()
	local var_22_1 = var_4.GetRestaurants(var_22_0)

	pairs = var_22_0

	for iter_22_0, iter_22_1 in var_22_0(var_22_1) do
		if iter_22_1:getConfig("map_id") == arg_22_3 then
			IslandManageSystemVO = var_11

			local var_22_2 = var_11.New(iter_22_1.id, iter_22_1)

			table = var_12

			var_12.insert(arg_22_0, var_22_2)

			local var_22_3 = iter_22_1
			local var_22_4 = iter_22_1.GetStatus(var_22_3)

			IslandRestaurant = var_22_3

			if var_22_4 == var_22_3.STATUS.OPENING then
				ipairs = var_22_4

				for iter_22_2, iter_22_3 in var_22_4(var_22_2:GetUnits()) do
					table = var_1_10017

					var_1_10017.insert(arg_22_1, iter_22_3)
				end
			end
		end
	end

	return
end

function var_0_0.CollectPordunctSystem(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	pg = var_1_10005

	local var_23_0

	if not var_1_10005.island_production_place.get_id_list_by_map_id[arg_23_3] then
		var_23_0 = {}
	end

	local var_23_1 = arg_23_2:GetBuildingAgency()

	local function var_23_2(arg_24_0)
		local var_24_0

		ipairs = var_2_10002

		for iter_24_0, iter_24_1 in var_2_10002(arg_23_4) do
			if iter_24_1.id == arg_24_0 then
				var_24_0 = iter_24_1
			end
		end

		return var_24_0
	end

	local var_23_3 = {}

	IslandProductConst = var_1_10009
	var_23_3[1] = var_1_10009.PasturePlaceId
	IslandProductConst = var_9
	var_23_3[2] = var_9.FarmlandPlaceId
	IslandProductConst = var_9
	var_23_3[3] = var_9.OrchardPlaceId
	IslandProductConst = var_9
	var_23_3[4] = var_9.GardenPlaceId
	ipairs = var_9
	IslandProductConst = var_1_10010

	for iter_23_0, iter_23_1 in var_9(var_1_10010.FactorytPlaces) do
		table = var_1_10014

		var_1_10014.insert(var_23_3, iter_23_1)
	end

	ipairs = var_9

	for iter_23_2, iter_23_3 in var_9(var_23_0) do
		local var_23_4 = var_23_2(iter_23_3)

		IslandCharacterSystemVO = var_15

		local var_23_5 = var_15.New(iter_23_3, var_23_4, arg_23_2.id)
		local var_23_6 = var_23_1:GetBuilding(iter_23_3)
		local var_23_7 = 0

		if var_23_6 then
			local var_23_8 = var_23_6
			local var_23_9 = var_23_6.GetShipIdAndAreaIdList(var_23_8)

			ipairs = var_23_8

			for iter_23_4, iter_23_5 in var_23_8(var_23_9) do
				IslandProductConst = var_1_10024

				if iter_23_3 ~= var_1_10024.MinePlaceId then
					local var_23_10 = var_23_5

					var_1_10024 = var_23_5.GetUnit

					local var_23_11 = iter_23_5.ship_id
					local var_23_12 = iter_23_5.area_id

					table = iter_23_8
					var_1_10024 = var_1_10024(var_23_10, var_23_11, var_23_12, iter_23_8.contains(var_23_3, iter_23_3))
					table = var_23_10

					var_23_10.insert(arg_23_1, var_1_10024)
				end

				var_23_7 = var_23_7 + 1
			end

			var_23_5:SetkCurrentWorkerList(var_23_9)
		end

		var_23_5:SetWorkerCnt(var_23_7)

		table = var_18

		var_18.insert(arg_23_0, var_23_5)

		if var_23_4 then
			table = var_18

			local var_23_13 = var_18.contains

			IslandProductConst = var_19

			if var_23_13(var_19.havePerformPlace, iter_23_3) then
				local var_23_15

				if var_23_6 then
					local var_23_14 = var_23_6

					var_23_15 = var_23_6.GetDelegateingSlotAndFormulaList(var_23_14)
					ipairs = var_23_14

					for iter_23_6, iter_23_7 in var_23_14(var_23_15) do
						local var_23_16 = var_23_4

						var_1_10024 = var_23_4.GetDelegateUnitsByBuildIdAndSlotId(var_23_16, iter_23_3, iter_23_7.area_id, iter_23_7.formula_id)
						ipairs = var_23_16

						for iter_23_8, iter_23_9 in var_23_16(var_1_10024) do
							table = var_1_10030

							var_1_10030.insert(arg_23_1, iter_23_9)
						end

						if var_23_4:GetDelegateEffectsByCommissonId(iter_23_7.area_id) then
							local var_23_17 = var_23_4

							if var_23_4.GenUnitByDelegateEffectId(var_23_17, var_25) then
								table = var_23_17

								var_23_17.insert(arg_23_1, var_26)
							end
						end
					end
				end

				table = var_23_15

				var_23_15.insert(arg_23_0, var_23_4)
			end
		end
	end

	return
end

function var_0_0.SceneData2IslandUnits(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4, arg_25_5, arg_25_6)
	pg = var_1_10007

	local var_25_0

	if not var_1_10007.island_world_objects.get_id_list_by_mapId[arg_25_3] then
		var_25_0 = {}
	end

	ipairs = var_1_10008

	for iter_25_0, iter_25_1 in var_1_10008(var_25_0) do
		pg = var_1_10013

		local var_25_1 = var_1_10013.island_world_objects[iter_25_1].unitId

		if 0 < var_25_1 then
			local var_25_2 = var_1_10013.gen_type

			IslandConst = var_15

			if var_25_2 ~= var_15.UNIT_GEN_TYPE_STATIC then
				local var_25_3 = var_1_10013.gen_type

				IslandConst = var_15

				if var_25_3 == var_15.UNIT_GEN_TYPE_DYNAMIC then
					local var_25_4 = var_0_0.WorldObj2IslandUnit(var_1_10013)

					table = var_15

					var_15.insert(arg_25_0, var_25_4)

					goto label_25_0
				end

				do
					local var_25_5 = var_1_10013.unitId

					if 0 < var_25_5 then
						local var_25_6 = var_1_10013.gen_type

						IslandConst = var_15

						if var_25_6 == var_15.UNIT_GEN_TYPE_ACTIVITY then
							local var_25_7 = var_0_0.WorldObj2IslandUnit(var_1_10013)

							table = var_15

							var_15.insert(arg_25_1, var_25_7)
						end
					end
				end

				::label_25_0::
			end
		end
	end

	IslandConst = var_8

	if arg_25_3 == var_8.CheaterTavernMapId then
		return
	end

	pairs = var_8

	for iter_25_2, iter_25_3 in var_8(arg_25_2) do
		if iter_25_3:IsSelf() then
			local var_25_8 = var_0_0.PlayerData2IslandUnit(iter_25_3, arg_25_3, arg_25_6, arg_25_4, arg_25_5)

			table = var_14

			var_14.insert(arg_25_0, var_25_8)
		end
	end

	local var_25_9 = var_0_0.TakePhotoData2IslandUnit(2)

	table = var_9

	var_9.insert(arg_25_0, var_25_9)

	local var_25_10 = var_0_0.TakePhotoData2IslandUnit(3)

	table = var_10

	var_10.insert(arg_25_0, var_25_10)

	return
end

local function var_0_1(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	if arg_26_1 then
		return
	end

	if arg_26_0 ~= arg_26_2.mapId then
		return
	end

	arg_26_3.position = {
		arg_26_2.position.x,
		arg_26_2.position.y,
		arg_26_2.position.z
	}
	arg_26_3.rotation = {
		arg_26_2.rotation.x,
		arg_26_2.rotation.y,
		arg_26_2.rotation.z
	}

	return
end

function var_0_0.PlayerData2IslandUnit(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	local var_27_0
	local var_27_1

	pg = var_1_10007

	local var_27_2

	if not var_1_10007.island_world_objects.get_id_list_by_mapId[arg_27_1] then
		var_27_2 = {}
	end

	ipairs = var_1_10008

	for iter_27_0, iter_27_1 in var_1_10008(var_27_2) do
		pg = var_1_10013

		if var_1_10013.island_world_objects[iter_27_1].unitId == 0 then
			var_27_0 = var_1_10013

			break
		end
	end

	assert = var_8

	var_8(var_27_0)

	if arg_27_0:IsSelf() then
		local var_27_3 = {
			id = arg_27_0.id,
			unitId = arg_27_0:GetModelId()
		}

		IslandConst = var_9
		var_27_3.typ = var_9.UNIT_TYPE_PLAYER

		if arg_27_3 then
			pg = var_9

			local var_27_4

			if not var_9.island_world_objects[arg_27_3] then
				var_27_4 = var_27_0
			end

			if var_27_4.mapId ~= arg_27_1 then
				var_27_4 = var_27_0
			end

			var_0_1(arg_27_1, arg_27_3, arg_27_4, var_27_3)

			var_27_1 = var_0_0.WorldObj2IslandUnit(var_27_4, var_27_3)

			if false then
				local var_27_5 = {
					behaviourTree = "Island/NodeCanvas/Visitor",
					id = arg_27_0.id,
					unitId = arg_27_0:GetModelId()
				}

				IslandConst = var_9
				var_27_5.typ = var_9.UNIT_TYPE_VISITOR
				var_27_5.islandId = arg_27_2
				var_27_1 = var_0_0.WorldObj2IslandUnit(var_27_0, var_27_5)
			end

			return var_27_1
		end
	end
end

function var_0_0.ModelId2IslandUnit(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	pg = var_1_10004

	local var_28_0

	if not var_1_10004.island_world_objects[arg_28_0] then
		var_28_0 = {}
	end

	local var_28_1

	if var_28_0.mapId == arg_28_2 then
		local var_28_2 = {
			unitId = arg_28_1,
			typ = arg_28_3
		}

		var_28_1 = var_0_0.WorldObj2IslandUnit(var_28_0, var_28_2)
	end

	return var_28_1
end

function var_0_0.WorldObj2IslandUnit(arg_29_0, arg_29_1)
	arg_29_1 = arg_29_1 or {}

	local var_29_0

	if not arg_29_1.typ then
		var_29_0 = arg_29_0.type
	end

	local var_29_1

	IslandConst = var_1_10004

	if var_29_0 == var_1_10004.UNIT_TYPE_ITEM_INTERACT then
		IslandInteractUnitVO = var_29_1

		goto label_29_0
	end

	IslandConst = var_4

	if var_29_0 ~= var_4.UNIT_TYPE_ITEM_GATHER_ITEM then
		IslandConst = var_4

		if var_29_0 == var_4.UNIT_TYPE_ITEM_WILD_COLLECT_ITEM then
			IslandGatherUnitVO = var_29_1
		else
			IslandConst = var_4

			if var_29_0 == var_4.UNIT_TYPE_VISITOR then
				IslandVistorUnitVO = var_29_1
			else
				IslandUnitVO = var_29_1
			end
		end

		::label_29_0::

		local var_29_2 = var_29_1.New
		local var_29_3 = {}
		local var_29_4

		if not arg_29_1.id then
			var_29_4 = arg_29_0.id
		end

		var_29_3.id = var_29_4

		local var_29_5

		if not arg_29_1.unitId then
			var_29_5 = arg_29_0.unitId
		end

		var_29_3.modelId = var_29_5

		local var_29_6

		if not arg_29_1.typ then
			var_29_6 = arg_29_0.type
		end

		var_29_3.type = var_29_6
		var_29_3.name = arg_29_0.name

		local var_29_7

		if not arg_29_1.position then
			var_29_7 = arg_29_0.param.position
		end

		var_29_3.position = var_29_7

		local var_29_8

		if not arg_29_1.rotation then
			var_29_8 = arg_29_0.param.rotation
		end

		var_29_3.rotation = var_29_8

		local var_29_9

		if not arg_29_0.param.scale then
			var_29_9 = {
				1,
				1,
				1
			}
		end

		var_29_3.scale = var_29_9

		local var_29_10

		if not arg_29_1.behaviourTree then
			var_29_10 = arg_29_0.behaviourTree
		end

		var_29_3.behaviourTree = var_29_10
		var_29_3.genType = arg_29_0.gen_type

		local var_29_11

		if not arg_29_0.show_param then
			var_29_11 = {}
		end

		var_29_3.showCondition = var_29_11

		local var_29_12

		if not arg_29_0.hide_param then
			var_29_12 = {}
		end

		var_29_3.hideCondition = var_29_12

		local var_29_13

		if not arg_29_1.index then
			var_29_13 = 0
		end

		var_29_3.index = var_29_13
		var_29_3.islandId = arg_29_1.islandId

		return (var_29_2(var_29_3))
	end
end

function var_0_0.TakePhotoData2IslandUnit(arg_30_0)
	local var_30_0 = {
		unitId = 20024,
		id = arg_30_0
	}

	IslandConst = var_1_10002
	var_30_0.typ = var_1_10002.UNIT_TYPE_FIRST_TAKE_PHOTO_ITEM
	IslandUnitVO = var_2

	return (var_2.New({
		behaviourTree = "",
		index = 0,
		genType = 1,
		id = var_30_0.id,
		modelId = var_30_0.unitId,
		type = var_30_0.typ,
		name = "TakePhoto" .. arg_30_0,
		position = {
			0,
			0,
			0
		},
		rotation = {
			0,
			0,
			0
		},
		scale = {
			1,
			1,
			1
		},
		showCondition = {},
		hideCondition = {}
	}))
end

function var_0_0.IslandCheaterTavernPlayerDataToUnit(arg_31_0)
	CheaterTavernHelper = var_1_10001

	local var_31_0 = var_1_10001.GetModelDataByViewData(arg_31_0.user_view)
	local var_31_1 = 10110000 + arg_31_0.seat

	pg = var_1_10003

	local var_31_2 = var_1_10003.island_world_objects[var_31_1]
	local var_31_3 = {
		id = arg_31_0.id,
		unitId = var_31_0.unitId
	}

	IslandConst = var_5
	var_31_3.typ = var_5.UNIT_TYPE_CHEATERTAVERN_PLAYER
	IslandUnitVO = var_5

	local var_31_4 = var_5.New
	local var_31_5 = {
		behaviourTree = "",
		index = 0,
		genType = 1,
		id = var_31_3.id,
		modelId = var_31_3.unitId,
		type = var_31_3.typ,
		name = arg_31_0.id
	}
	local var_31_6

	if not var_31_3.position then
		var_31_6 = var_31_2.param.position
	end

	var_31_5.position = var_31_6

	local var_31_7

	if not var_31_3.rotation then
		var_31_7 = var_31_2.param.rotation
	end

	var_31_5.rotation = var_31_7

	local var_31_8

	if not var_31_2.param.scale then
		var_31_8 = {
			1,
			1,
			1
		}
	end

	var_31_5.scale = var_31_8
	var_31_5.scale = {
		1,
		1,
		1
	}
	var_31_5.showCondition = {}
	var_31_5.hideCondition = {}

	return (var_31_4(var_31_5))
end

function var_0_0.GenDelayRecycleIslandUnit(arg_32_0)
	pg = var_1_10001

	local var_32_0 = var_1_10001.island_world_objects[arg_32_0.id]
	local var_32_1 = {
		id = arg_32_0.id,
		unitId = arg_32_0.unitId,
		position = {
			arg_32_0.position.x,
			arg_32_0.position.y,
			arg_32_0.position.z
		},
		rotation = {
			arg_32_0.rotation.x,
			arg_32_0.rotation.y,
			arg_32_0.rotation.z
		},
		behaviourTree = arg_32_0.behaviourTree,
		recycleAssetType = arg_32_0.recycleAssetType,
		delayRecycleTime = arg_32_0.delayRecycleTime
	}

	return var_0_0.WorldObj2IslandDelayRecycleUnit(var_32_0, var_32_1)
end

function var_0_0.WorldObj2IslandDelayRecycleUnit(arg_33_0, arg_33_1)
	arg_33_1 = arg_33_1 or {}
	IslandDelayRecycleUnitVO = var_1_10002

	local var_33_0 = var_1_10002.New
	local var_33_1 = {}
	local var_33_2

	if not arg_33_1.id then
		var_33_2 = arg_33_0.id
	end

	var_33_1.id = var_33_2

	local var_33_3

	if not arg_33_1.unitId then
		var_33_3 = arg_33_0.unitId
	end

	var_33_1.modelId = var_33_3
	IslandConst = var_33_3
	var_33_1.type = var_33_3.UNIT_TYPE_ITEM_DELAY_RECYCLE
	var_33_1.name = arg_33_0.name .. "delay"

	local var_33_4

	if not arg_33_1.position then
		var_33_4 = arg_33_0.param.position
	end

	var_33_1.position = var_33_4

	local var_33_5

	if not arg_33_1.rotation then
		var_33_5 = arg_33_0.param.rotation
	end

	var_33_1.rotation = var_33_5

	local var_33_6

	if not arg_33_0.param.scale then
		var_33_6 = {
			1,
			1,
			1
		}
	end

	var_33_1.scale = var_33_6

	local var_33_7

	if not arg_33_1.behaviourTree then
		var_33_7 = arg_33_0.behaviourTree
	end

	var_33_1.behaviourTree = var_33_7
	var_33_1.genType = arg_33_0.gen_type

	local var_33_8

	if not arg_33_0.show_param then
		var_33_8 = {}
	end

	var_33_1.showCondition = var_33_8

	local var_33_9

	if not arg_33_0.hide_param then
		var_33_9 = {}
	end

	var_33_1.hideCondition = var_33_9

	local var_33_10

	if not arg_33_1.index then
		var_33_10 = 0
	end

	var_33_1.index = var_33_10
	var_33_1.delayRecycleTime = arg_33_1.delayRecycleTime
	var_33_1.recycleAssetType = arg_33_1.recycleAssetType

	return (var_33_0(var_33_1))
end

function var_0_0.GenWildGatherUnit(arg_34_0)
	pg = var_1_10001

	local var_34_0 = var_1_10001.island_world_objects[arg_34_0.unitId]

	return (var_0_0.WorldObj2IslandUnit(var_34_0, {
		index = arg_34_0.islandId,
		typ = arg_34_0.gatherType
	}))
end

function var_0_0.GenInteractUnitByAgoraFurniture(arg_35_0)
	IslandVirtualInteractUnitVO = var_1_10001

	local var_35_0 = var_1_10001.New
	local var_35_1 = {
		index = 0,
		id = arg_35_0.id,
		modelId = arg_35_0.pointId
	}

	IslandConst = var_3
	var_35_1.type = var_3.UNIT_TYPE_VIRTUAL_INTERACT
	var_35_1.name = "AgoraInteract" .. arg_35_0.id
	var_35_1.position = arg_35_0.position
	var_35_1.rotation = arg_35_0.rotation
	var_35_1.scale = {
		1,
		1,
		1
	}
	IslandConst = var_3
	var_35_1.genType = var_3.UNIT_GEN_TYPE_SYSTEM
	var_35_1.showCondition = {}
	var_35_1.hideCondition = {}

	return (var_35_0(var_35_1))
end

return var_0_0
