local IslandDataConvertor = class("IslandDataConvertor")

function IslandDataConvertor:Island2SceneData()
	local var_1_0 = self:GetMapId()
	local var_1_1 = self:GetVisitorAgency()
	local var_1_2 = {}
	local var_1_3 = {}
	local var_1_4 = {}
	local var_1_5 = {}
	local var_1_6 = {}
	local var_1_7 = {}
	local var_1_8 = {}
	local var_1_9 = {}
	local var_1_10 = {}

	IslandDataConvertor.SceneData2IslandUnits(var_1_1, var_1_10, var_1_1:GetMapVisitorList(), var_1_0, self:GetSpawnPointId(), self:GetLastExitPosition(), self.id)
	IslandDataConvertor.SystemData2IslandUnits(var_1_2, var_1_8, var_1_7, self, var_1_0, var_1_6)
	IslandDataConvertor.CollectSystems(var_1_3, var_1_4, self, var_1_0, var_1_6)
	IslandDataConvertor.CollectStrollUnits(var_1_5, self, var_1_0)
	IslandDataConvertor.CollectFollowUnits(var_1_2, var_1_9, self, var_1_0)

	return {
		mapId = var_1_0,
		unitList = var_1_2,
		sceneName = pg.island_map[var_1_0].sceneName,
		systemList = var_1_3,
		systemUnits = var_1_4,
		strollUnits = var_1_5,
		productSystems = var_1_6,
		giftUnits = var_1_7,
		followUnits = var_1_9,
		delayInitUnits = var_1_8,
		activityUnits = var_1_10,
		camreaZoomData = IslandDataConvertor.CollectCamreaZoomData(var_1_0)
	}
end

function IslandDataConvertor:Island2SceneName()
	local var_2_0 = self:GetMapId()

	return pg.island_map[var_2_0].sceneName, var_2_0, pg.island_map[var_2_0].default_bgm
end

function IslandDataConvertor:CollectCamreaZoomData()
	local var_3_0 = pg.island_map[self].camera_zoom[3] or 0.5

	return {
		min = pg.island_map[self].camera_zoom[1],
		max = pg.island_map[self].camera_zoom[2],
		value = var_3_0
	}
end

function IslandDataConvertor:SystemData2IslandUnits(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	IslandDataConvertor.CollectSignInSystemUnits(self, arg_4_2, arg_4_3, arg_4_4)
	IslandDataConvertor.CollectWildCollectInSystemUnits(self, arg_4_2, arg_4_3, arg_4_4)
	IslandDataConvertor.CollectBuildingSystemUnits(self, arg_4_1, arg_4_3, arg_4_4, arg_4_5)
	IslandDataConvertor.CollectFishPointUnits(self, arg_4_3, arg_4_4)

	if arg_4_3:IsPrivate() then
		IslandDataConvertor.CollectOrderSystemUnits(self, arg_4_3, arg_4_4)
	end

	return
end

function IslandDataConvertor:CollectFishPointUnits(arg_5_1, arg_5_2)
	for iter_5_0, iter_5_1 in ipairs(pg.island_fish_point.all) do
		if pg.island_world_objects[pg.island_fish_point[iter_5_1].objId].mapId == arg_5_2 then
			table.insert(self, IslandFishPointVO.New(iter_5_1, pg.island_fish_point[iter_5_1].objId))
		end
	end

	return
end

function IslandDataConvertor:CollectBuildingSystemUnits(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	local var_6_0 = arg_6_2:GetBuildingAgency()

	for iter_6_0, iter_6_1 in ipairs(pg.island_production_place.get_id_list_by_map_id[arg_6_3] or {}) do
		if arg_6_3 == pg.island_production_place[iter_6_1].map_id then
			local var_6_1 = IslandProductSystemVO.New(iter_6_1, var_6_0:GetBuilding(iter_6_1), arg_6_2.id)

			for iter_6_2, iter_6_3 in ipairs(var_6_1:GetUnitDatas()) do
				if iter_6_3 then
					if iter_6_3.delayTime then
						table.insert(arg_6_1, iter_6_3)
					else
						table.insert(self, iter_6_3)
					end
				end
			end

			table.insert(arg_6_4, var_6_1)
		end
	end

	return
end

function IslandDataConvertor:CollectOrderSystemUnits(arg_7_1, arg_7_2)
	for iter_7_0, iter_7_1 in pairs((arg_7_1:GetOrderAgency():GetShipSlotList())) do
		if not iter_7_1:IsLock() and iter_7_1:GetWorldObjId() > 0 then
			local var_7_0 = pg.island_world_objects[iter_7_1:GetWorldObjId()]

			if var_7_0 and var_7_0.mapId == arg_7_2 then
				table.insert(self, (IslandDataConvertor.WorldObj2IslandUnit(var_7_0, {})))
			end
		end
	end

	return
end

function IslandDataConvertor:CollectSignInSystemUnits(arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = arg_8_2:GetSignInAgency()
	local var_8_1 = 0

	for iter_8_0, iter_8_1 in ipairs(pg.island_world_objects.get_id_list_by_mapId[arg_8_3] or {}) do
		if pg.island_world_objects[iter_8_1].unitId > 0 and pg.island_world_objects[iter_8_1].gen_type == IslandConst.UNIT_GEN_TYPE_GIFT then
			var_8_1 = var_8_1 + 1

			table.insert(arg_8_1, (IslandDataConvertor.WorldObj2IslandUnit(pg.island_world_objects[iter_8_1], {
				index = var_8_1
			})))
		end
	end

	return
end

function IslandDataConvertor:CollectWildCollectInSystemUnits(arg_9_1, arg_9_2, arg_9_3)
	for iter_9_0, iter_9_1 in ipairs((arg_9_2:GetWildCollectAgency():GetUnitList())) do
		if pg.island_world_objects[iter_9_1.unitId].unitId > 0 then
			table.insert(self, (IslandDataConvertor.WorldObj2IslandUnit(pg.island_world_objects[iter_9_1.unitId], {
				index = arg_9_2.id,
				typ = iter_9_1.gatherType
			})))
		end
	end

	return
end

function IslandDataConvertor:CollectStrollUnits(arg_10_1, arg_10_2)
	local var_10_0 = arg_10_1:GetAblityAgency()
	local var_10_1 = arg_10_1:GetCharacterAgency():GetShips()

	local function var_10_2(arg_11_0, arg_11_1)
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
	end

	for iter_10_0, iter_10_1 in ipairs(pg.island_strollnpc.all) do
		if _.any(pg.island_strollnpc[iter_10_1].mapId, function(arg_13_0)
			local var_13_1 = arg_13_0[1] == arg_10_2 and IslandCalcUtil.IsHappen(arg_13_0[3] or 100) or false

			return (false or nil) and true
		end) then
			local var_10_3, var_10_4, var_10_5 = var_10_2(pg.island_strollnpc[iter_10_1].unlock, pg.island_strollnpc[iter_10_1].unit_id)

			if var_10_3 then
				table.insert(self, IslandStrollUnitVO.New(var_10_5, iter_10_1, var_10_4))
			end
		end
	end

	IslandDataConvertor.DistributeAward4StrollUnits(self, arg_10_1)

	return
end

function IslandDataConvertor:DistributeActionFeedbackAward4StrollUnits(arg_14_1, arg_14_2)
	local var_14_0 = arg_14_1:GetNpcFeedbackAgency():GetNpcList()
	local var_14_1 = {}

	for iter_14_0, iter_14_1 in ipairs(self) do
		if pg.island_strollnpc[iter_14_1.id].action_feedback == 1 and _.all(var_14_0, function(arg_15_0)
			return iter_14_1.id ~= arg_15_0
		end) then
			table.insert(var_14_1, iter_14_1)
		end
	end

	if #var_14_1 <= 0 then
		return
	end

	shuffle(var_14_1)

	for iter_14_2 = 1, pg.island_set.island_feedback_award_times.key_value_int - #var_14_0 do
		if var_14_1[iter_14_2] then
			var_14_1[iter_14_2]:SetActionFeedback(arg_14_2[math.random(1, #arg_14_2)])
		end
	end

	return
end

function IslandDataConvertor:DistributeShipSkillAward4StrollUnits(arg_16_1, arg_16_2)
	local var_16_0 = arg_16_1:GetCharacterAgency()

	for iter_16_0, iter_16_1 in ipairs(self) do
		local var_16_1 = var_16_0:GetShipById((iter_16_1:GetShipId()))

		if var_16_1 and var_16_1:HasGreetingSkill() then
			if var_16_1:GetSkill():CanUse4Ship(var_16_1, {
				IslandBuffType.SHIP_POWER_RECOVER_BY_GREETING,
				IslandBuffType.SHIP_AWARD_BY_GREETING
			}) then
				iter_16_1:SetSkillActionFeedback(arg_16_2[math.random(1, #arg_16_2)])
			end
		end
	end

	return
end

function IslandDataConvertor:GetOwnActions()
	local var_17_0 = self:GetActionAgency()

	return (_.select(pg.island_action.get_id_list_by_type[IslandConst.ANIMATION_OP_SIGNLE], function(arg_18_0)
		return var_17_0:ExistAction(arg_18_0)
	end))
end

function IslandDataConvertor:DistributeAward4StrollUnits(arg_19_1)
	if #self > 0 and arg_19_1:IsPrivate() then
		local var_19_0 = IslandDataConvertor.GetOwnActions(arg_19_1)

		if #var_19_0 <= 0 then
			return
		end

		IslandDataConvertor.DistributeActionFeedbackAward4StrollUnits(self, arg_19_1, var_19_0)
		IslandDataConvertor.DistributeShipSkillAward4StrollUnits(self, arg_19_1, var_19_0)
	end

	return
end

function IslandDataConvertor:CollectFollowUnits(arg_20_1, arg_20_2, arg_20_3)
	local var_20_0

	for iter_20_0, iter_20_1 in ipairs(self) do
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

	for iter_20_2, iter_20_3 in ipairs(arg_20_2:GetFollowerAgency():GetFollowers()) do
		local var_20_3 = arg_20_2:GetCharacterAgency():GetShipById(iter_20_3)

		table.insert(arg_20_1, IslandFollowerUnitVO.New(var_20_3.id, iter_20_3, var_20_3:GetModelUnit(), var_20_1, var_20_2, iter_20_2 == 1))
	end

	return
end

function IslandDataConvertor:CollectSystems(arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	IslandDataConvertor.CollectPordunctSystem(self, arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	IslandDataConvertor.CollectManageSystem(self, arg_21_1, arg_21_2, arg_21_3)

	if pg.island_map[arg_21_3].minigame_id > 0 then
		table.insert(self, IslandSeekGameSystemVO.New(pg.island_map[arg_21_3].minigame_id, IslandConst.SEEK_GAME_SYSTEM_ID))
	elseif arg_21_3 == IslandConst.AGORA_MAP_ID then
		table.insert(self, IslandGroundSystemVO.New(IslandConst.AGORA_GROUND_SYSTEM_ID))
		table.insert(self, IslandGrassLandSystemVO.New(IslandConst.AGORA_GRASSLAND))
	end

	return
end

function IslandDataConvertor:CollectManageSystem(arg_22_1, arg_22_2, arg_22_3)
	for iter_22_0, iter_22_1 in pairs((arg_22_2:GetManageAgency():GetRestaurants())) do
		if iter_22_1:getConfig("map_id") == arg_22_3 then
			local var_22_0 = IslandManageSystemVO.New(iter_22_1.id, iter_22_1)

			table.insert(self, var_22_0)

			if iter_22_1:GetStatus() == IslandRestaurant.STATUS.OPENING then
				for iter_22_2, iter_22_3 in ipairs(var_22_0:GetUnits()) do
					table.insert(arg_22_1, iter_22_3)
				end
			end
		end
	end

	return
end

function IslandDataConvertor:CollectPordunctSystem(arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	local var_23_0 = pg.island_production_place.get_id_list_by_map_id[arg_23_3] or {}
	local var_23_1 = arg_23_2:GetBuildingAgency()

	local function var_23_2(arg_24_0)
		local var_24_0

		for iter_24_0, iter_24_1 in ipairs(arg_23_4) do
			if iter_24_1.id == arg_24_0 then
				var_24_0 = iter_24_1
			end
		end

		return var_24_0
	end

	local var_23_3 = {
		IslandProductConst.PasturePlaceId,
		IslandProductConst.FarmlandPlaceId,
		IslandProductConst.OrchardPlaceId,
		IslandProductConst.GardenPlaceId
	}

	for iter_23_0, iter_23_1 in ipairs(IslandProductConst.FactorytPlaces) do
		table.insert(var_23_3, iter_23_1)
	end

	for iter_23_2, iter_23_3 in ipairs(var_23_0) do
		local var_23_4 = var_23_2(iter_23_3)
		local var_23_5 = IslandCharacterSystemVO.New(iter_23_3, var_23_4, arg_23_2.id)
		local var_23_6 = var_23_1:GetBuilding(iter_23_3)
		local var_23_7 = 0

		if var_23_6 then
			local var_23_8 = var_23_6:GetShipIdAndAreaIdList()

			for iter_23_4, iter_23_5 in ipairs(var_23_8) do
				if iter_23_3 ~= IslandProductConst.MinePlaceId then
					table.insert(arg_23_1, (var_23_5:GetUnit(iter_23_5.ship_id, iter_23_5.area_id, table.contains(var_23_3, iter_23_3))))
				end

				var_23_7 = var_23_7 + 1
			end

			var_23_5:SetkCurrentWorkerList(var_23_8)
		end

		var_23_5:SetWorkerCnt(var_23_7)
		table.insert(self, var_23_5)

		if var_23_4 and table.contains(IslandProductConst.havePerformPlace, iter_23_3) then
			if var_23_6 then
				for iter_23_6, iter_23_7 in ipairs((var_23_6:GetDelegateingSlotAndFormulaList())) do
					for iter_23_8, iter_23_9 in ipairs((var_23_4:GetDelegateUnitsByBuildIdAndSlotId(iter_23_3, iter_23_7.area_id, iter_23_7.formula_id))) do
						table.insert(arg_23_1, iter_23_9)
					end

					local var_23_9 = var_23_4:GetDelegateEffectsByCommissonId(iter_23_7.area_id)

					if var_23_9 then
						local var_23_10 = var_23_4:GenUnitByDelegateEffectId(var_23_9)

						if var_23_10 then
							table.insert(arg_23_1, var_23_10)
						end
					end
				end
			end

			table.insert(self, var_23_4)
		end
	end

	return
end

function IslandDataConvertor:SceneData2IslandUnits(arg_25_1, arg_25_2, arg_25_3, arg_25_4, arg_25_5, arg_25_6)
	for iter_25_0, iter_25_1 in ipairs(pg.island_world_objects.get_id_list_by_mapId[arg_25_3] or {}) do
		if pg.island_world_objects[iter_25_1].unitId > 0 then
			if pg.island_world_objects[iter_25_1].gen_type ~= IslandConst.UNIT_GEN_TYPE_STATIC then
				if pg.island_world_objects[iter_25_1].gen_type == IslandConst.UNIT_GEN_TYPE_DYNAMIC then
					table.insert(self, (IslandDataConvertor.WorldObj2IslandUnit(pg.island_world_objects[iter_25_1])))
				elseif pg.island_world_objects[iter_25_1].unitId > 0 and pg.island_world_objects[iter_25_1].gen_type == IslandConst.UNIT_GEN_TYPE_ACTIVITY then
					table.insert(arg_25_1, (IslandDataConvertor.WorldObj2IslandUnit(pg.island_world_objects[iter_25_1])))
				end
			end
		end
	end

	if arg_25_3 == IslandConst.CheaterTavernMapId then
		return
	end

	for iter_25_2, iter_25_3 in pairs(arg_25_2) do
		if iter_25_3:IsSelf() then
			table.insert(self, (IslandDataConvertor.PlayerData2IslandUnit(iter_25_3, arg_25_3, arg_25_6, arg_25_4, arg_25_5)))
		end
	end

	table.insert(self, (IslandDataConvertor.TakePhotoData2IslandUnit(2)))
	table.insert(self, (IslandDataConvertor.TakePhotoData2IslandUnit(3)))

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

function IslandDataConvertor:PlayerData2IslandUnit(arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	local var_27_0
	local var_27_1

	for iter_27_0, iter_27_1 in ipairs(pg.island_world_objects.get_id_list_by_mapId[arg_27_1] or {}) do
		if pg.island_world_objects[iter_27_1].unitId == 0 then
			var_27_0 = pg.island_world_objects[iter_27_1]

			break
		end
	end

	assert(var_27_0)

	if self:IsSelf() then
		local var_27_2 = {
			id = self.id,
			unitId = self:GetModelId(),
			typ = IslandConst.UNIT_TYPE_PLAYER
		}
		local var_27_3

		if arg_27_3 then
			var_27_3 = pg.island_world_objects[arg_27_3] or var_27_0

			if var_27_3.mapId ~= arg_27_1 then
				var_27_3 = var_27_0
			end
		end

		var_0_1(arg_27_1, arg_27_3, arg_27_4, var_27_2)

		var_27_1 = IslandDataConvertor.WorldObj2IslandUnit(var_27_3, var_27_2)
	else
		var_27_1 = IslandDataConvertor:WorldObj2IslandUnit({
			behaviourTree = "Island/NodeCanvas/Visitor",
			id = self.id,
			unitId = self:GetModelId(),
			typ = IslandConst.UNIT_TYPE_VISITOR,
			islandId = arg_27_2
		})
	end

	return var_27_1
end

function IslandDataConvertor:ModelId2IslandUnit(arg_28_1, arg_28_2, arg_28_3)
	local var_28_0 = pg.island_world_objects[self] or {}

	return (var_28_0.mapId == arg_28_2 or nil) and IslandDataConvertor.WorldObj2IslandUnit(var_28_0, {
		unitId = arg_28_1,
		typ = arg_28_3
	})
end

function IslandDataConvertor:WorldObj2IslandUnit(arg_29_1)
	arg_29_1 = arg_29_1 or {}

	local var_29_0 = arg_29_1.typ or self.type
	local var_29_1

	if var_29_0 == IslandConst.UNIT_TYPE_ITEM_INTERACT then
		var_29_1 = IslandInteractUnitVO
	elseif var_29_0 == IslandConst.UNIT_TYPE_ITEM_GATHER_ITEM or var_29_0 == IslandConst.UNIT_TYPE_ITEM_WILD_COLLECT_ITEM then
		var_29_1 = IslandGatherUnitVO
	elseif var_29_0 == IslandConst.UNIT_TYPE_VISITOR then
		var_29_1 = IslandVistorUnitVO
	end

	local var_29_2 = {}

	var_29_2.id = arg_29_1.id or self.id
	var_29_2.modelId = arg_29_1.unitId or self.unitId
	var_29_2.type = arg_29_1.typ or self.type
	var_29_2.name = self.name
	var_29_2.position = arg_29_1.position or self.param.position
	var_29_2.rotation = arg_29_1.rotation or self.param.rotation
	var_29_2.scale = self.param.scale or {
		1,
		1,
		1
	}
	var_29_2.behaviourTree = arg_29_1.behaviourTree or self.behaviourTree
	var_29_2.genType = self.gen_type
	var_29_2.showCondition = self.show_param or {}
	var_29_2.hideCondition = self.hide_param or {}
	var_29_2.index = arg_29_1.index or 0
	var_29_2.islandId = arg_29_1.islandId

	return (IslandUnitVO.New(var_29_2))
end

function IslandDataConvertor:TakePhotoData2IslandUnit()
	local var_30_0 = {
		unitId = 20024,
		id = self,
		typ = IslandConst.UNIT_TYPE_FIRST_TAKE_PHOTO_ITEM
	}

	return (IslandUnitVO.New({
		behaviourTree = "",
		index = 0,
		genType = 1,
		id = var_30_0.id,
		modelId = var_30_0.unitId,
		type = var_30_0.typ,
		name = "TakePhoto" .. self,
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

function IslandDataConvertor:IslandCheaterTavernPlayerDataToUnit()
	local var_31_0 = {
		id = self.id,
		unitId = CheaterTavernHelper.GetModelDataByViewData(self.user_view).unitId,
		typ = IslandConst.UNIT_TYPE_CHEATERTAVERN_PLAYER
	}
	local var_31_1 = {
		behaviourTree = "",
		index = 0,
		genType = 1,
		id = var_31_0.id,
		modelId = var_31_0.unitId,
		type = var_31_0.typ,
		name = self.id
	}

	var_31_1.position = var_31_0.position or pg.island_world_objects[10110000 + self.seat].param.position
	var_31_1.rotation = var_31_0.rotation or pg.island_world_objects[10110000 + self.seat].param.rotation
	var_31_1.scale = pg.island_world_objects[10110000 + self.seat].param.scale or {
		1,
		1,
		1
	}
	var_31_1.scale = {
		1,
		1,
		1
	}
	var_31_1.showCondition = {}
	var_31_1.hideCondition = {}

	return (IslandUnitVO.New(var_31_1))
end

function IslandDataConvertor:GenDelayRecycleIslandUnit()
	return IslandDataConvertor.WorldObj2IslandDelayRecycleUnit(pg.island_world_objects[self.id], {
		id = self.id,
		unitId = self.unitId,
		position = {
			self.position.x,
			self.position.y,
			self.position.z
		},
		rotation = {
			self.rotation.x,
			self.rotation.y,
			self.rotation.z
		},
		behaviourTree = self.behaviourTree,
		recycleAssetType = self.recycleAssetType,
		delayRecycleTime = self.delayRecycleTime
	})
end

function IslandDataConvertor:WorldObj2IslandDelayRecycleUnit(arg_33_1)
	arg_33_1 = arg_33_1 or {}

	local var_33_0 = {}

	var_33_0.id = arg_33_1.id or self.id
	var_33_0.modelId = arg_33_1.unitId or self.unitId
	var_33_0.type = IslandConst.UNIT_TYPE_ITEM_DELAY_RECYCLE
	var_33_0.name = self.name .. "delay"
	var_33_0.position = arg_33_1.position or self.param.position
	var_33_0.rotation = arg_33_1.rotation or self.param.rotation
	var_33_0.scale = self.param.scale or {
		1,
		1,
		1
	}
	var_33_0.behaviourTree = arg_33_1.behaviourTree or self.behaviourTree
	var_33_0.genType = self.gen_type
	var_33_0.showCondition = self.show_param or {}
	var_33_0.hideCondition = self.hide_param or {}
	var_33_0.index = arg_33_1.index or 0
	var_33_0.delayRecycleTime = arg_33_1.delayRecycleTime
	var_33_0.recycleAssetType = arg_33_1.recycleAssetType

	return (IslandDelayRecycleUnitVO.New(var_33_0))
end

function IslandDataConvertor:GenWildGatherUnit()
	return (IslandDataConvertor.WorldObj2IslandUnit(pg.island_world_objects[self.unitId], {
		index = self.islandId,
		typ = self.gatherType
	}))
end

function IslandDataConvertor:GenInteractUnitByAgoraFurniture()
	return (IslandVirtualInteractUnitVO.New({
		index = 0,
		id = self.id,
		modelId = self.pointId,
		type = IslandConst.UNIT_TYPE_VIRTUAL_INTERACT,
		name = "AgoraInteract" .. self.id,
		position = self.position,
		rotation = self.rotation,
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

return IslandDataConvertor
