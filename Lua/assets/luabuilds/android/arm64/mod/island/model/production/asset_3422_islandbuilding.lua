local IslandBuilding = class("IslandBuilding", import("model.vo.BaseVO"))

function IslandBuilding:Ctor(arg_1_1, arg_1_2)
	self.isSelf = arg_1_2
	self.timer = {}
	self.configId = arg_1_1.id
	self.level = arg_1_1.lv or 1
	self.delegationSlotData = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.appoint_list or {}) do
		self.delegationSlotData[iter_1_1.id] = IslandRoleDelegationSlot.New(self.configId, iter_1_1, self.isSelf)
	end

	for iter_1_2, iter_1_3 in ipairs(arg_1_1.ship_appoint_list or {}) do
		self:UpdateDeleationRoleDataBySlotId(iter_1_3.id, iter_1_3)
	end

	for iter_1_4, iter_1_5 in ipairs(arg_1_1.award_list or {}) do
		self:UpdateDeleationRewardDataBySlotId(iter_1_5.id, iter_1_5)
	end

	self.handSlotData = {}

	for iter_1_6, iter_1_7 in ipairs(arg_1_1.hand_list or {}) do
		self.handSlotData[iter_1_7.id] = IslandHandSlot.New(self.configId, iter_1_7)
	end

	if arg_1_1.build_collect then
		self.collectPlaceSystem = IslandCollectSlotPlace.New(arg_1_1.id, arg_1_1.build_collect)
	end

	return
end

function IslandBuilding:GetBuildingCollectData()
	return self.collectPlaceSystem
end

function IslandBuilding:bindConfigTable()
	return pg.island_production_place
end

function IslandBuilding:GetDelegationSlotData(arg_4_1)
	return self.delegationSlotData[arg_4_1]
end

function IslandBuilding:GetDelegationSlotDatas()
	return self.delegationSlotData
end

function IslandBuilding:GetDelegationSlotDataByFormulaId(arg_6_1)
	for iter_6_0, iter_6_1 in pairs(self.delegationSlotData) do
		if iter_6_1:GetFormulaId() and iter_6_1:GetFormulaId() == arg_6_1 then
			return iter_6_1
		end
	end

	return nil
end

function IslandBuilding:GetHandPlantSlotData(arg_7_1)
	return self.handSlotData[arg_7_1]
end

function IslandBuilding:InitSlotRoleDataByAbility(arg_8_1)
	if self.delegationSlotData[arg_8_1] then
		warning("已经存在当前槽位的信息了")

		return
	end

	local var_8_0 = {}
	local var_8_1 = getProxy(IslandProxy):GetIsland()

	if pg.island_production_slot[arg_8_1].type == 3 then
		for iter_8_0, iter_8_1 in ipairs(pg.island_production_slot[arg_8_1].animal == "" and {} or pg.island_production_slot[arg_8_1].animal) do
			if pg.island_ranch_animal[iter_8_1].unlock_type == 0 then
				table.insert(var_8_0, iter_8_1)
			end
		end

		var_8_1:DispatchEvent(IslandBuildingAgency.GEN_ANIMAL_INT, {
			aniList = var_8_0,
			slotId = arg_8_1
		})
	end

	if pg.island_production_slot[arg_8_1].type == 9 then
		var_8_1:DispatchEvent(IslandBuildingAgency.SLOT_DELEGATE_INIT, {
			slotId = arg_8_1
		})
	end

	self.delegationSlotData[arg_8_1] = IslandRoleDelegationSlot.New(self.configId, {
		id = arg_8_1,
		part_list = var_8_0,
		formula_list = {}
	}, true)

	return
end

function IslandBuilding:InitSlotHandPlantByAbility(arg_9_1)
	if self.handSlotData[arg_9_1] then
		warning("已经存在当前槽位的信息了")

		return
	end

	self.handSlotData[arg_9_1] = IslandHandSlot.New(arg_9_1, {
		formula_id = 0,
		state = 0,
		end_time = 0,
		start_time = 0,
		id = arg_9_1
	})

	return
end

function IslandBuilding:InitHandSlotData(arg_10_1)
	if self.collectPlaceSystem then
		self.collectPlaceSystem:InitHandSlotData(arg_10_1)
	end

	return
end

function IslandBuilding:UpdateDeleationRoleDataBySlotId(arg_11_1, arg_11_2)
	local var_11_0 = self:GetDelegationSlotData(arg_11_1)

	if not var_11_0 then
		warning("下发数据有问题,下发的槽位id不是当前区域能委派的槽位,下发的槽位id为" .. arg_11_1)

		return
	end

	var_11_0:UpdateSlotRoleData(arg_11_2)

	return
end

function IslandBuilding:UpdateDeleationRewardDataBySlotId(arg_12_1, arg_12_2)
	local var_12_0 = self:GetDelegationSlotData(arg_12_1)

	if not var_12_0 then
		warning("下发数据有问题,下发的槽位id不是当前区域能委派的槽位,下发的槽位id为" .. arg_12_1)

		return
	end

	var_12_0:UpdateSlotRewardData(arg_12_2)

	return
end

function IslandBuilding:GetShipAddExpData(arg_13_1)
	local var_13_1 = self:GetDelegationSlotData(arg_13_1):GetSlotRewardData()

	return (var_13_1 or nil) and {
		addShipId = var_13_1.ship_id,
		addExp = var_13_1.exp
	}
end

function IslandBuilding:UpdateCollectDataBySlotId(arg_14_1, arg_14_2)
	if self.collectPlaceSystem then
		self.collectPlaceSystem:UpdateCollectDataBySlotId(arg_14_1, arg_14_2)
	end

	return
end

function IslandBuilding:UpdateHandPlantDataBySlotId(arg_15_1)
	local var_15_0 = self:GetHandPlantSlotData(arg_15_1.id)

	if not var_15_0 then
		warning("下发数据有问题,下发的槽位id不是当前区域能委派的槽位,下发的槽位id为" .. arg_15_1.id)

		return
	end

	var_15_0:UpdateData(arg_15_1)

	return
end

function IslandBuilding:GetFormulaList()
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in pairs(self.formulaData) do
		table.insert(var_16_0, iter_16_1)
	end

	return var_16_0
end

function IslandBuilding:GetLevel()
	return self.level
end

function IslandBuilding:IsMaxLevel()
	return self:GetUpgradeCost() == ""
end

function IslandBuilding:GetName()
	return self:getConfig("name")
end

function IslandBuilding:UpdatePerSecond()
	for iter_20_0, iter_20_1 in pairs(self.delegationSlotData) do
		iter_20_1:UpdatePerSecond(self.isSelf)
	end

	if self.collectPlaceSystem then
		self.collectPlaceSystem:UpdatePerSecond()
	end

	return
end

function IslandBuilding:GetSlotUnitDataByModelData()
	local var_21_0 = {}

	for iter_21_0, iter_21_1 in pairs(self.collectionSlotData) do
		local var_21_1 = iter_21_1:GetUnitData()

		if var_21_1 then
			table.insert(var_21_0, var_21_1)
		end
	end

	return var_21_0
end

function IslandBuilding:GetMinRoleDeleGationTime()
	local var_22_0

	for iter_22_0, iter_22_1 in pairs(self.delegationSlotData) do
		local var_22_1 = iter_22_1:GetRoleDelegateFinishTime()

		if var_22_1 ~= -1 then
			var_22_0 = var_22_0 and math.min(var_22_1, var_22_0) or var_22_1
		end
	end

	return var_22_0 and var_22_0 or -1
end

function IslandBuilding:GetShipIdAndAreaIdList()
	local var_23_0 = {}

	for iter_23_0, iter_23_1 in pairs(self.delegationSlotData) do
		local var_23_1 = iter_23_1:GetRoleShipData()

		if var_23_1 then
			table.insert(var_23_0, var_23_1)
		end
	end

	return var_23_0
end

function IslandBuilding:GetDelegateingSlotAndFormulaList()
	local var_24_0 = {}

	for iter_24_0, iter_24_1 in pairs(self.delegationSlotData) do
		local var_24_1 = iter_24_1:GetRoleSlotAndFormulaData()

		if var_24_1 then
			table.insert(var_24_0, var_24_1)
		end
	end

	return var_24_0
end

function IslandBuilding:IsPostTip()
	for iter_25_0, iter_25_1 in pairs(self.delegationSlotData) do
		if iter_25_1:CanStartDelegationTip() or iter_25_1:GetSlotRewardData() then
			return true
		end
	end

	return false
end

function IslandBuilding:GetCollectSlotData(arg_26_1)
	if self.collectPlaceSystem then
		return self.collectPlaceSystem:GetCollectSlotData(arg_26_1)
	end

	return
end

return IslandBuilding
