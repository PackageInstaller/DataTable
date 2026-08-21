local var_0_0 = class("IslandDataConvertor")

function var_0_0.Island2SceneData(arg_1_0)
	local var_1_0 = arg_1_0:GetMapId()

	var_0_0.SceneData2IslandUnits({}, {}, arg_1_0:GetVisitorAgency():GetMapVisitorList(), var_1_0, arg_1_0:GetSpawnPointId(), arg_1_0:GetLastExitPosition(), arg_1_0.id)
	var_0_0.SystemData2IslandUnits({}, {}, {}, arg_1_0, var_1_0, {})
	var_0_0.CollectSystems({}, {}, arg_1_0, var_1_0, {})
	var_0_0.CollectStrollUnits({}, arg_1_0, var_1_0)
	var_0_0.CollectFollowUnits({}, {}, arg_1_0, var_1_0)

	return {
		mapId = var_1_0,
		unitList = {},
		sceneName = pg.island_map[var_1_0].sceneName,
		systemList = {},
		systemUnits = {},
		strollUnits = {},
		productSystems = {},
		giftUnits = {},
		followUnits = {},
		delayInitUnits = {},
		activityUnits = {},
		camreaZoomData = var_0_0.CollectCamreaZoomData(var_1_0)
	}
end

function var_0_0.Island2SceneName(arg_2_0)
	local var_2_0 = arg_2_0:GetMapId()

	return pg.island_map[var_2_0].sceneName, var_2_0, pg.island_map[var_2_0].default_bgm
end

function var_0_0.CollectCamreaZoomData(arg_3_0)
	local var_3_0 = pg.island_map[arg_3_0].camera_zoom[3] or 0.5

	return {
		min = pg.island_map[arg_3_0].camera_zoom[1],
		max = pg.island_map[arg_3_0].camera_zoom[2],
		value = var_3_0
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
	for iter_5_0, iter_5_1 in ipairs(pg.island_fish_point.all) do
		if pg.island_world_objects[pg.island_fish_point[iter_5_1].objId].mapId == arg_5_2 then
			table.insert(arg_5_0, IslandFishPointVO.New(iter_5_1, pg.island_fish_point[iter_5_1].objId))
		end
	end

	return
end

function var_0_0.CollectBuildingSystemUnits(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	local var_6_0 = arg_6_2:GetBuildingAgency()
	local var_6_1 = pg.island_production_place.get_id_list_by_map_id[arg_6_3] or {}

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		if arg_6_3 == pg.island_production_place[iter_6_1].map_id then
			local var_6_2 = IslandProductSystemVO.New(iter_6_1, var_6_0:GetBuilding(iter_6_1), arg_6_2.id)

			for iter_6_2, iter_6_3 in ipairs(var_6_2:GetUnitDatas()) do
				if iter_6_3 then
					if iter_6_3.delayTime then
						table.insert(arg_6_1, iter_6_3)
					else
						table.insert(arg_6_0, iter_6_3)
					end
				end
			end

			table.insert(arg_6_4, var_6_2)
		end
	end

	return
end

function var_0_0.CollectOrderSystemUnits(arg_7_0, arg_7_1, arg_7_2)
	for iter_7_0, iter_7_1 in pairs((arg_7_1:GetOrderAgency():GetShipSlotList())) do
		if not iter_7_1:IsLock() and iter_7_1:GetWorldObjId() > 0 then
			local var_7_0 = pg.island_world_objects[iter_7_1:GetWorldObjId()]

			if var_7_0 and var_7_0.mapId == arg_7_2 then
				table.insert(arg_7_0, (var_0_0.WorldObj2IslandUnit(var_7_0, {})))
			end
		end
	end

	return
end

function var_0_0.CollectSignInSystemUnits(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = arg_8_2:GetSignInAgency()
	local var_8_1 = pg.island_world_objects.get_id_list_by_mapId[arg_8_3] or {}
	local var_8_2 = 0

	for iter_8_0, iter_8_1 in ipairs(var_8_1) do
		if pg.island_world_objects[iter_8_1].unitId > 0 and pg.island_world_objects[iter_8_1].gen_type == IslandConst.UNIT_GEN_TYPE_GIFT then
			var_8_2 = var_8_2 + 1

			table.insert(arg_8_1, (var_0_0.WorldObj2IslandUnit(pg.island_world_objects[iter_8_1], {
				index = var_8_2
			})))
		end
	end

	return
end

function var_0_0.CollectWildCollectInSystemUnits(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	for iter_9_0, iter_9_1 in ipairs((arg_9_2:GetWildCollectAgency():GetUnitList())) do
		if pg.island_world_objects[iter_9_1.unitId].unitId > 0 then
			table.insert(arg_9_0, (var_0_0.WorldObj2IslandUnit(pg.island_world_objects[iter_9_1.unitId], {
				index = arg_9_2.id,
				typ = iter_9_1.gatherType
			})))
		end
	end

	return
end

function var_0_0.CollectStrollUnits(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_1:GetAblityAgency()
	local var_10_1 = arg_10_1:GetCharacterAgency():GetShips()

	for iter_10_0, iter_10_1 in ipairs(pg.island_strollnpc.all) do
		if _.any(pg.island_strollnpc[iter_10_1].mapId, function(arg_13_0)
			local var_13_1

			if arg_13_0[1] == arg_10_2 then
				local var_13_0 = arg_13_0[3] or 100

				var_13_1 = IslandCalcUtil.IsHappen(var_13_0)
			else
				var_13_1 = false
			end

			if false then
				var_13_1 = true
			end

			return var_13_1
		end) then
			local var_10_2, var_10_3, var_10_4 = (function(arg_11_0, arg_11_1)
				if arg_11_0 == -1 then
					local var_11_0 = arg_10_1:GetFollowerAgency()
					local var_11_1 = _.detect(var_10_1, function(arg_12_0)
						return not var_11_0:Following(arg_12_0.id) and arg_12_0:getConfig("unit_id") == arg_11_1
					end)

					return var_11_1 ~= nil, var_11_1 and var_11_1:GetModelUnit(), var_11_1 and var_11_1.id
				else
					return arg_11_0 == 0 or var_10_0:HasAbility(arg_11_0), nil, 0
				end

				return
			end)(pg.island_strollnpc[iter_10_1].unlock, pg.island_strollnpc[iter_10_1].unit_id)

			if var_10_2 then
				table.insert(arg_10_0, IslandStrollUnitVO.New(var_10_4, iter_10_1, var_10_3))
			end
		end
	end

	var_0_0.DistributeAward4StrollUnits(arg_10_0, arg_10_1)

	return
end

function var_0_0.DistributeActionFeedbackAward4StrollUnits(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_1:GetNpcFeedbackAgency():GetNpcList()

	for iter_14_0, iter_14_1 in ipairs(arg_14_0) do
		if pg.island_strollnpc[iter_14_1.id].action_feedback == 1 and _.all(var_14_0, function(arg_15_0)
			return iter_14_1.id ~= arg_15_0
		end) then
			table.insert({}, iter_14_1)
		end
	end

	if #{} <= 0 then
		return
	end

	shuffle({})

	for iter_14_2 = 1, pg.island_set.island_feedback_award_times.key_value_int - #var_14_0 do
		if ({})[iter_14_2] then
			({})[iter_14_2]:SetActionFeedback(arg_14_2[math.random(1, #arg_14_2)])
		end
	end

	return
end

function var_0_0.DistributeShipSkillAward4StrollUnits(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_1:GetCharacterAgency()

	for iter_16_0, iter_16_1 in ipairs(arg_16_0) do
		local var_16_1 = var_16_0:GetShipById((iter_16_1:GetShipId()))

		if var_16_1 and var_16_1:HasGreetingSkill() then
			local var_16_2 = var_16_1:GetSkill()

			if var_16_2:CanUse4Ship(var_16_1, {
				IslandBuffType.SHIP_POWER_RECOVER_BY_GREETING,
				IslandBuffType.SHIP_AWARD_BY_GREETING
			}) then
				iter_16_1:SetSkillActionFeedback(arg_16_2[math.random(1, #arg_16_2)])
			end
		end
	end

	return
end

function var_0_0.GetOwnActions(arg_17_0)
	local var_17_0 = arg_17_0:GetActionAgency()

	return (_.select(pg.island_action.get_id_list_by_type[IslandConst.ANIMATION_OP_SIGNLE], function(arg_18_0)
		return var_17_0:ExistAction(arg_18_0)
	end))
end

function var_0_0.DistributeAward4StrollUnits(arg_19_0, arg_19_1)
	if #arg_19_0 > 0 and arg_19_1:IsPrivate() then
		local var_19_0 = var_0_0.GetOwnActions(arg_19_1)

		if #var_19_0 <= 0 then
			return
		end

		var_0_0.DistributeActionFeedbackAward4StrollUnits(arg_19_0, arg_19_1, var_19_0)
		var_0_0.DistributeShipSkillAward4StrollUnits(arg_19_0, arg_19_1, var_19_0)
	end

	return
end

function var_0_0.CollectFollowUnits(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0

	for iter_20_0, iter_20_1 in ipairs(arg_20_0) do
		if iter_20_1:IsPlayer() then
			var_20_0 = iter_20_1

			break
		end
	end

	if not var_20_0 then
		return
	end

	for iter_20_2, iter_20_3 in ipairs(arg_20_2:GetFollowerAgency():GetFollowers()) do
		local var_20_3 = arg_20_2:GetCharacterAgency():GetShipById(iter_20_3)

		table.insert(arg_20_1, IslandFollowerUnitVO.New(var_20_3.id, iter_20_3, var_20_3:GetModelUnit(), var_20_1, var_20_2, iter_20_2 == 1))
	end

	return
end

function var_0_0.CollectSystems(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	var_0_0.CollectPordunctSystem(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	var_0_0.CollectManageSystem(arg_21_0, arg_21_1, arg_21_2, arg_21_3)

	if pg.island_map[arg_21_3].minigame_id > 0 then
		table.insert(arg_21_0, IslandSeekGameSystemVO.New(pg.island_map[arg_21_3].minigame_id, IslandConst.SEEK_GAME_SYSTEM_ID))
	elseif arg_21_3 == IslandConst.AGORA_MAP_ID then
		table.insert(arg_21_0, IslandGroundSystemVO.New(IslandConst.AGORA_GROUND_SYSTEM_ID))
		table.insert(arg_21_0, IslandGrassLandSystemVO.New(IslandConst.AGORA_GRASSLAND))
	end

	return
end

function var_0_0.CollectManageSystem(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	for iter_22_0, iter_22_1 in pairs((arg_22_2:GetManageAgency():GetRestaurants())) do
		if iter_22_1:getConfig("map_id") == arg_22_3 then
			local var_22_0 = IslandManageSystemVO.New(iter_22_1.id, iter_22_1)

			table.insert(arg_22_0, var_22_0)

			if iter_22_1:GetStatus() == IslandRestaurant.STATUS.OPENING then
				for iter_22_2, iter_22_3 in ipairs(var_22_0:GetUnits()) do
					table.insert(arg_22_1, iter_22_3)
				end
			end
		end
	end

	return
end

function var_0_0.CollectPordunctSystem(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	local var_23_0 = pg.island_production_place.get_id_list_by_map_id[arg_23_3] or {}
	local var_23_1 = arg_23_2:GetBuildingAgency()

	for iter_23_0, iter_23_1 in ipairs(IslandProductConst.FactorytPlaces) do
		table.insert({
			IslandProductConst.PasturePlaceId,
			IslandProductConst.FarmlandPlaceId,
			IslandProductConst.OrchardPlaceId,
			IslandProductConst.GardenPlaceId
		}, iter_23_1)
	end

	for iter_23_2, iter_23_3 in ipairs(var_23_0) do
		local var_23_2 = (function(arg_24_0)
			local var_24_0

			for iter_24_0, iter_24_1 in ipairs(arg_23_4) do
				if iter_24_1.id == arg_24_0 then
					var_24_0 = iter_24_1
				end
			end

			return var_24_0
		end)(iter_23_3)
		local var_23_3 = IslandCharacterSystemVO.New(iter_23_3, var_23_2, arg_23_2.id)
		local var_23_4 = var_23_1:GetBuilding(iter_23_3)
		local var_23_5 = 0

		if var_23_4 then
			local var_23_6 = var_23_4:GetShipIdAndAreaIdList()

			for iter_23_4, iter_23_5 in ipairs(var_23_6) do
				if iter_23_3 ~= IslandProductConst.MinePlaceId then
					table.insert(arg_23_1, (var_23_3:GetUnit(iter_23_5.ship_id, iter_23_5.area_id, table.contains({
						IslandProductConst.PasturePlaceId,
						IslandProductConst.FarmlandPlaceId,
						IslandProductConst.OrchardPlaceId,
						IslandProductConst.GardenPlaceId
					}, iter_23_3))))
				end

				var_23_5 = var_23_5 + 1
			end

			var_23_3:SetkCurrentWorkerList(var_23_6)
		end

		var_23_3:SetWorkerCnt(var_23_5)
		table.insert(arg_23_0, var_23_3)

		if var_23_2 and table.contains(IslandProductConst.havePerformPlace, iter_23_3) then
			if var_23_4 then
				for iter_23_6, iter_23_7 in ipairs((var_23_4:GetDelegateingSlotAndFormulaList())) do
					for iter_23_8, iter_23_9 in ipairs((var_23_2:GetDelegateUnitsByBuildIdAndSlotId(iter_23_3, iter_23_7.area_id, iter_23_7.formula_id))) do
						table.insert(arg_23_1, iter_23_9)
					end

					local var_23_7 = var_23_2:GetDelegateEffectsByCommissonId(iter_23_7.area_id)

					if var_23_7 then
						local var_23_8 = var_23_2:GenUnitByDelegateEffectId(var_23_7)

						if var_23_8 then
							table.insert(arg_23_1, var_23_8)
						end
					end
				end
			end

			table.insert(arg_23_0, var_23_2)
		end
	end

	return
end

function var_0_0.SceneData2IslandUnits(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4, arg_25_5, arg_25_6)
	local var_25_0 = pg.island_world_objects.get_id_list_by_mapId[arg_25_3] or {}

	for iter_25_0, iter_25_1 in ipairs(var_25_0) do
		if pg.island_world_objects[iter_25_1].unitId > 0 then
			if pg.island_world_objects[iter_25_1].gen_type ~= IslandConst.UNIT_GEN_TYPE_STATIC then
				if pg.island_world_objects[iter_25_1].gen_type == IslandConst.UNIT_GEN_TYPE_DYNAMIC then
					table.insert(arg_25_0, (var_0_0.WorldObj2IslandUnit(pg.island_world_objects[iter_25_1])))

					goto label_25_0
				end

				if pg.island_world_objects[iter_25_1].unitId > 0 and pg.island_world_objects[iter_25_1].gen_type == IslandConst.UNIT_GEN_TYPE_ACTIVITY then
					table.insert(arg_25_1, (var_0_0.WorldObj2IslandUnit(pg.island_world_objects[iter_25_1])))
				end

				::label_25_0::
			end
		end
	end

	if arg_25_3 == IslandConst.CheaterTavernMapId then
		return
	end

	for iter_25_2, iter_25_3 in pairs(arg_25_2) do
		if iter_25_3:IsSelf() then
			table.insert(arg_25_0, (var_0_0.PlayerData2IslandUnit(iter_25_3, arg_25_3, arg_25_6, arg_25_4, arg_25_5)))
		end
	end

	table.insert(arg_25_0, (var_0_0.TakePhotoData2IslandUnit(2)))
	table.insert(arg_25_0, (var_0_0.TakePhotoData2IslandUnit(3)))

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
	local var_27_2 = pg.island_world_objects.get_id_list_by_mapId[arg_27_1] or {}

	for iter_27_0, iter_27_1 in ipairs(var_27_2) do
		if pg.island_world_objects[iter_27_1].unitId == 0 then
			var_27_0 = pg.island_world_objects[iter_27_1]

			break
		end
	end

	assert(var_27_0)

	if arg_27_0:IsSelf() then
		local var_27_3 = {
			id = arg_27_0.id,
			unitId = arg_27_0:GetModelId(),
			typ = IslandConst.UNIT_TYPE_PLAYER
		}

		if arg_27_3 then
			local var_27_4 = pg.island_world_objects[arg_27_3] or var_27_0

			if var_27_4.mapId ~= arg_27_1 then
				var_27_4 = var_27_0
			end

			var_0_1(arg_27_1, arg_27_3, arg_27_4, var_27_3)

			var_27_1 = var_0_0.WorldObj2IslandUnit(var_27_4, var_27_3)

			if false then
				var_27_1 = var_0_0.WorldObj2IslandUnit(var_27_0, {
					behaviourTree = "Island/NodeCanvas/Visitor",
					id = arg_27_0.id,
					unitId = arg_27_0:GetModelId(),
					typ = IslandConst.UNIT_TYPE_VISITOR,
					islandId = arg_27_2
				})
			end

			return var_27_1
		end
	end
end

function var_0_0.ModelId2IslandUnit(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	local var_28_0 = pg.island_world_objects[arg_28_0] or {}
	local var_28_1

	if var_28_0.mapId == arg_28_2 then
		var_28_1 = var_0_0.WorldObj2IslandUnit(var_28_0, {
			unitId = arg_28_1,
			typ = arg_28_3
		})
	end

	return var_28_1
end

function var_0_0.WorldObj2IslandUnit(arg_29_0, arg_29_1)
	arg_29_1 = arg_29_1 or {}

	local var_29_0 = arg_29_1.typ or arg_29_0.type
	local var_29_1 = var_29_0 == IslandConst.UNIT_TYPE_ITEM_INTERACT and IslandInteractUnitVO or (var_29_0 == IslandConst.UNIT_TYPE_ITEM_GATHER_ITEM or var_29_0 == IslandConst.UNIT_TYPE_ITEM_WILD_COLLECT_ITEM) and IslandGatherUnitVO or var_29_0 == IslandConst.UNIT_TYPE_VISITOR and IslandVistorUnitVO or IslandUnitVO

	;({}).id = arg_29_1.id or arg_29_0.id
	;({}).modelId = arg_29_1.unitId or arg_29_0.unitId
	;({}).type = arg_29_1.typ or arg_29_0.type
	;({}).name = arg_29_0.name
	;({}).position = arg_29_1.position or arg_29_0.param.position
	;({}).rotation = arg_29_1.rotation or arg_29_0.param.rotation
	;({}).scale = arg_29_0.param.scale or {
		1,
		1,
		1
	}
	;({}).behaviourTree = arg_29_1.behaviourTree or arg_29_0.behaviourTree
	;({}).genType = arg_29_0.gen_type
	;({}).showCondition = arg_29_0.show_param or {}
	;({}).hideCondition = arg_29_0.hide_param or {}
	;({}).index = arg_29_1.index or 0
	;({}).islandId = arg_29_1.islandId

	return (var_29_2({}))
end

function var_0_0.TakePhotoData2IslandUnit(arg_30_0)
	return (IslandUnitVO.New({
		behaviourTree = "",
		index = 0,
		genType = 1,
		id = ({
			unitId = 20024,
			id = arg_30_0,
			typ = IslandConst.UNIT_TYPE_FIRST_TAKE_PHOTO_ITEM
		}).id,
		modelId = ({
			unitId = 20024,
			id = arg_30_0,
			typ = IslandConst.UNIT_TYPE_FIRST_TAKE_PHOTO_ITEM
		}).unitId,
		type = ({
			unitId = 20024,
			id = arg_30_0,
			typ = IslandConst.UNIT_TYPE_FIRST_TAKE_PHOTO_ITEM
		}).typ,
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
	local var_31_0 = {
		id = arg_31_0.id,
		unitId = CheaterTavernHelper.GetModelDataByViewData(arg_31_0.user_view).unitId,
		typ = IslandConst.UNIT_TYPE_CHEATERTAVERN_PLAYER
	}

	;({
		behaviourTree = "",
		index = 0,
		genType = 1,
		id = var_31_0.id,
		modelId = var_31_0.unitId,
		type = var_31_0.typ,
		name = arg_31_0.id
	}).position = var_31_0.position or pg.island_world_objects[10110000 + arg_31_0.seat].param.position
	;({
		behaviourTree = "",
		index = 0,
		genType = 1,
		id = var_31_0.id,
		modelId = var_31_0.unitId,
		type = var_31_0.typ,
		name = arg_31_0.id
	}).rotation = var_31_0.rotation or pg.island_world_objects[10110000 + arg_31_0.seat].param.rotation
	;({
		behaviourTree = "",
		index = 0,
		genType = 1,
		id = var_31_0.id,
		modelId = var_31_0.unitId,
		type = var_31_0.typ,
		name = arg_31_0.id
	}).scale = pg.island_world_objects[10110000 + arg_31_0.seat].param.scale or {
		1,
		1,
		1
	}
	;({
		behaviourTree = "",
		index = 0,
		genType = 1,
		id = var_31_0.id,
		modelId = var_31_0.unitId,
		type = var_31_0.typ,
		name = arg_31_0.id
	}).scale = {
		1,
		1,
		1
	}
	;({
		behaviourTree = "",
		index = 0,
		genType = 1,
		id = var_31_0.id,
		modelId = var_31_0.unitId,
		type = var_31_0.typ,
		name = arg_31_0.id
	}).showCondition = {}
	;({
		behaviourTree = "",
		index = 0,
		genType = 1,
		id = var_31_0.id,
		modelId = var_31_0.unitId,
		type = var_31_0.typ,
		name = arg_31_0.id
	}).hideCondition = {}

	return (IslandUnitVO.New({
		behaviourTree = "",
		index = 0,
		genType = 1,
		id = var_31_0.id,
		modelId = var_31_0.unitId,
		type = var_31_0.typ,
		name = arg_31_0.id
	}))
end

function var_0_0.GenDelayRecycleIslandUnit(arg_32_0)
	return var_0_0.WorldObj2IslandDelayRecycleUnit(pg.island_world_objects[arg_32_0.id], {
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
	})
end

function var_0_0.WorldObj2IslandDelayRecycleUnit(arg_33_0, arg_33_1)
	arg_33_1 = arg_33_1 or {}
	;({}).id = arg_33_1.id or arg_33_0.id
	;({}).modelId = arg_33_1.unitId or arg_33_0.unitId
	;({}).type = IslandConst.UNIT_TYPE_ITEM_DELAY_RECYCLE
	;({}).name = arg_33_0.name .. "delay"
	;({}).position = arg_33_1.position or arg_33_0.param.position
	;({}).rotation = arg_33_1.rotation or arg_33_0.param.rotation
	;({}).scale = arg_33_0.param.scale or {
		1,
		1,
		1
	}
	;({}).behaviourTree = arg_33_1.behaviourTree or arg_33_0.behaviourTree
	;({}).genType = arg_33_0.gen_type
	;({}).showCondition = arg_33_0.show_param or {}
	;({}).hideCondition = arg_33_0.hide_param or {}
	;({}).index = arg_33_1.index or 0
	;({}).delayRecycleTime = arg_33_1.delayRecycleTime
	;({}).recycleAssetType = arg_33_1.recycleAssetType

	return (var_33_0({}))
end

function var_0_0.GenWildGatherUnit(arg_34_0)
	return (var_0_0.WorldObj2IslandUnit(pg.island_world_objects[arg_34_0.unitId], {
		index = arg_34_0.islandId,
		typ = arg_34_0.gatherType
	}))
end

function var_0_0.GenInteractUnitByAgoraFurniture(arg_35_0)
	return (IslandVirtualInteractUnitVO.New({
		index = 0,
		id = arg_35_0.id,
		modelId = arg_35_0.pointId,
		type = IslandConst.UNIT_TYPE_VIRTUAL_INTERACT,
		name = "AgoraInteract" .. arg_35_0.id,
		position = arg_35_0.position,
		rotation = arg_35_0.rotation,
		scale = {
			1,
			1,
			1
		},
		genType = IslandConst.UNIT_GEN_TYPE_SYSTEM,
		showCondition = {},
		hideCondition = {}
	}))
end

return var_0_0
