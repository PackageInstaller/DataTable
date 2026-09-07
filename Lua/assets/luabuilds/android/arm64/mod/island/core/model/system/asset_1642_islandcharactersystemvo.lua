local IslandCharacterSystemVO = class("IslandCharacterSystemVO", import(".IslandSystemVO"))
local var_0_1 = 0

function IslandCharacterSystemVO:Ctor(arg_1_1, arg_1_2, arg_1_3)
	IslandCharacterSystemVO.super.Ctor(self, arg_1_1)

	self.isSelf = self:IsSelf(arg_1_3)
	self.id = arg_1_1
	self.name = "_system_" .. self.id
	self.slotDic = {}

	self:InitCfgData(self.id)

	self.config = pg.island_production_place[self.id]
	self.behaviourTree = self.config.behaviourTree
	self.worker = 0
	self.productSystem = arg_1_2
	self.chickenId = arg_1_2.id % 10 * 100 + 1
	self.slotShipUnitDic = {}

	return
end

function IslandCharacterSystemVO:IsSelf(arg_2_1)
	return getProxy(PlayerProxy):getRawData().id == arg_2_1
end

function IslandCharacterSystemVO:GetType()
	return IslandConst.SYSTEM_TYPE_CHARACTER
end

function IslandCharacterSystemVO:InitCfgData(arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(pg.island_production_place[arg_4_1].commission_slot) do
		self.slotDic[pg.island_production_commission[iter_4_1].slot] = iter_4_1
	end

	return
end

function IslandCharacterSystemVO:GetUnit(arg_5_1, arg_5_2, arg_5_3)
	if not pg.island_world_objects[pg.island_production_commission[self.slotDic[arg_5_2]].birthplace] then
		return nil
	end

	local var_5_0
	local var_5_1

	if self.config.interactionType == var_0_1 and not arg_5_3 then
		local var_5_2 = IslandCalcUtil.GetRandomPointOnCircle(BuildVector3(pg.island_world_objects[self:GetObjId(arg_5_2)].param.position), 2)

		var_5_0 = {
			var_5_2.x,
			var_5_2.y,
			var_5_2.z
		}
	else
		var_5_0 = pg.island_world_objects[pg.island_production_commission[self.slotDic[arg_5_2]].birthplace].param.position
		var_5_1 = pg.island_world_objects[pg.island_production_commission[self.slotDic[arg_5_2]].birthplace].param.rotation
	end

	local var_5_3

	if self.isSelf then
		local var_5_4 = getProxy(IslandProxy)

		var_5_3 = var_5_4:GetIsland():GetCharacterAgency():GetShipById(arg_5_1).GetModelUnit(var_5_4)
	else
		var_5_3 = pg.island_chara_template[arg_5_1].unit_id
	end

	local var_5_5

	if arg_5_1 == 1 then
		var_5_5 = self.config.chickenbehaviourTree or self.config.npcbehaviourTree
	end

	local var_5_6 = false

	if arg_5_1 == 1 then
		self.chickenId = self.chickenId + 1
		arg_5_1 = self.chickenId
		self.slotShipUnitDic[arg_5_2] = self.chickenId
		var_5_6 = true
	end

	return IslandDelegateUnitVO.New({
		id = arg_5_1,
		isChicken = var_5_6,
		modelId = var_5_3,
		type = IslandConst.UNIT_TYPE_SYSTEM_DELEAGTION,
		name = "system_unit" .. arg_5_1,
		position = var_5_0,
		rotation = var_5_1 or Vector3.zero,
		scale = Vector3.one,
		behaviourTree = var_5_5
	})
end

function IslandCharacterSystemVO:GetUnitShipIdBySlotId(arg_6_1, arg_6_2)
	if arg_6_1 == 1 then
		return self.slotShipUnitDic[arg_6_2]
	end

	return arg_6_1
end

function IslandCharacterSystemVO:GetObjId(arg_7_1)
	return pg.island_production_commission[self.slotDic[arg_7_1]].performanceObjid
end

function IslandCharacterSystemVO:GetperformanceObjidList(arg_8_1)
	local var_8_0 = {}

	if table.contains({
		IslandProductConst.FarmlandPlaceId,
		IslandProductConst.OrchardPlaceId,
		IslandProductConst.GardenPlaceId
	}, self.id) then
		for iter_8_0, iter_8_1 in ipairs(pg.island_production_slot[arg_8_1].exclusion_slot) do
			table.insert(var_8_0, {
				unitId = self.productSystem:GetUnitIdBySlotId(iter_8_1),
				unitType = IslandConst.UNIT_LIST_OBJ
			})
		end
	elseif table.contains({
		IslandProductConst.MinePlaceId,
		IslandProductConst.FellingPlaceId,
		IslandProductConst.TechnologyPlaceId,
		IslandProductConst.FisheryPlaceId
	}, self.id) then
		table.insert(var_8_0, {
			unitId = pg.island_production_commission[self.slotDic[arg_8_1]].performanceObjid,
			unitType = IslandConst.UNIT_LIST_OBJ
		})
	elseif self.id == IslandProductConst.PasturePlaceId then
		for iter_8_2, iter_8_3 in ipairs(pg.island_production_slot[arg_8_1].animal) do
			table.insert(var_8_0, {
				unitId = iter_8_3,
				unitType = IslandConst.UNIT_LIST_DELEGATION_ANIMATION
			})
		end
	end

	return var_8_0
end

function IslandCharacterSystemVO:SetWorkerCnt(arg_9_1)
	self.worker = arg_9_1

	return
end

function IslandCharacterSystemVO:GetWorkerCnt()
	return self.worker
end

function IslandCharacterSystemVO:SetkCurrentWorkerList(arg_11_1)
	self.workerList = arg_11_1

	return
end

function IslandCharacterSystemVO:GetWorkerList()
	return self.workerList
end

function IslandCharacterSystemVO:GetBehaviourTree()
	if self.behaviourTree == "" then
		return nil
	end

	return self.behaviourTree
end

return IslandCharacterSystemVO
