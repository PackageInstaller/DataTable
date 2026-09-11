local EntityManager = class("EntityManager")
local var_0_1 = class("EntityManager.SpawnImpl")

function var_0_1:OnSpawn(arg_1_1)
	return
end

function var_0_1:OnRemove(arg_2_1)
	Dorm.DormEntityManager.Instance:RemoveEntity(arg_2_1)
end

local function var_0_2()
	return nil
end

local var_0_3 = class("EntityManager.CreateModel", var_0_1)

function var_0_3:Ctor(arg_4_1, arg_4_2, arg_4_3)
	self.modelPathGetter = arg_4_1
	self.spawnPosGetter = arg_4_2 or var_0_2
	self.delay = arg_4_3 or 0
end

function var_0_3:OnSpawn(arg_5_1)
	return Dorm.DormEntityManager.Instance:SpawnEntity(self.modelPathGetter(arg_5_1), self.spawnPosGetter(arg_5_1), arg_5_1.complex or false, arg_5_1.pooled or false)
end

function var_0_3:OnRemove(arg_6_1, arg_6_2)
	if self.delay == nil or self.delay == 0 or arg_6_2 then
		Dorm.DormEntityManager.Instance:RemoveEntity(arg_6_1)
	else
		local var_6_0 = self.delay

		if type(self.delay) == "function" then
			var_6_0 = var_6_0()
		end

		Dorm.DormEntityManager.Instance:RemoveEntity(arg_6_1, var_6_0)
	end
end

EntityManager.CreateModel = var_0_3

local var_0_4 = class("EntityManager.CreatePlayer", var_0_1)

function var_0_4:Ctor(arg_7_1, arg_7_2)
	self.modelPathGetter = arg_7_1
	self.spawnPosGetter = arg_7_2 or var_0_2
end

function var_0_4:OnSpawn(arg_8_1)
	return Dorm.DormEntityManager.Instance:SpawnPlayerEntity(self.modelPathGetter(arg_8_1), (self.spawnPosGetter(arg_8_1)))
end

EntityManager.CreatePlayer = var_0_4

local var_0_5 = class("EntityManager.CreateFurniture", var_0_1)

function var_0_5:OnSpawn(arg_9_1)
	local var_9_0 = arg_9_1.state or 0
	local var_9_1 = arg_9_1.complex or false
	local var_9_2 = nullable(BackHomeFurnitureSubtype, nullable(BackHomeFurnitureSubtype, "get_id_list_by_furniture_cfg", arg_9_1.cfgID, var_9_0)) or BackHomeFurniture[arg_9_1.cfgID]
	local var_9_3

	if var_9_0 ~= 0 then
		var_9_3 = var_9_2.tile_size or var_9_2.title
	end

	local var_9_4 = DormLuaBridge.GenerateFurniture(arg_9_1.cfgID, var_9_0, var_9_2.model, var_9_3[1], var_9_3[2], var_9_3[3], var_9_2.sub_type ~= 0, var_9_1)

	if var_9_2.display_type ~= 0 then
		DormLuaBridge.SnapWallMountFurniture(var_9_4)
	end

	return var_9_4
end

function var_0_5:OnRemove(arg_10_1)
	local var_10_0 = DormUtils.GetEntityData(arg_10_1)

	DormLuaBridge.RemoveFurniture(arg_10_1, not ((var_10_0 or nil) and (var_10_0.noOccupy or false)))
end

EntityManager.CreateFurniture = var_0_5

local var_0_6 = class("EntityManager.CreateFurniture", var_0_1)

function var_0_6:OnSpawn(arg_11_1)
	local var_11_0 = arg_11_1.state or 0
	local var_11_1 = nullable(BackHomeFurnitureSubtype, nullable(BackHomeFurnitureSubtype, "get_id_list_by_furniture_cfg", arg_11_1.cfgID, var_11_0)) or BackHomeFurniture[arg_11_1.cfgID]
	local var_11_2

	if var_11_0 ~= 0 then
		var_11_2 = var_11_1.tile_size or var_11_1.title
	end

	return (DormLuaBridge.GenerateFurniture(arg_11_1.cfgID, var_11_0, var_11_1.model, var_11_2[1], var_11_2[2], var_11_2[3] or 1, var_11_1.sub_type ~= 0))
end

function var_0_6:OnRemove(arg_12_1)
	local var_12_0 = DormUtils.GetEntityData(arg_12_1)

	DormLuaBridge.RemoveFurniture(arg_12_1, not ((var_12_0 or nil) and (var_12_0.noOccupy or false)))
end

EntityManager.CreateIlluFurniture = var_0_6

local var_0_7 = class("EntityManager.AttachToModel", var_0_1)

function var_0_7:Ctor(arg_13_1)
	self.attachRootGetter = arg_13_1
end

function var_0_7:OnSpawn(arg_14_1)
	return Dorm.DormEntityManager.Instance:MakeModelEntity((self.attachRootGetter(arg_14_1)))
end

EntityManager.AttachToModel = var_0_7
EntityManager.all = {}

setmetatable(EntityManager.all, {
	__mode = "v"
})

function EntityManager:Ctor(arg_15_1, arg_15_2)
	self.managedEntityNum = 0
	self.managed = {}
	self.reverseQuery = {}
	self.spawnImpl = arg_15_1
	self.dataCtor = arg_15_2

	table.insert(EntityManager.all, self)
end

function EntityManager:Create(arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = self.spawnImpl:OnSpawn(arg_16_2)

	self.managed[arg_16_1] = var_16_0
	self.reverseQuery[var_16_0] = arg_16_1
	self.managedEntityNum = self.managedEntityNum + 1
	arg_16_3 = self:RecordNewEntityData(arg_16_1, var_16_0, arg_16_3 or arg_16_2)

	if self.OnCreate then
		self.OnCreate(arg_16_1, var_16_0, arg_16_2, arg_16_3)
	end

	return var_16_0
end

function EntityManager:Reload(arg_17_1, arg_17_2, arg_17_3)
	if self.reverseQuery[arg_17_2] == nil then
		self.managedEntityNum = self.managedEntityNum + 1
	else
		arg_17_1 = self.reverseQuery[arg_17_2]
	end

	self.managed[arg_17_1] = arg_17_2
	self.reverseQuery[arg_17_2] = arg_17_1

	self:RecordNewEntityData(arg_17_1, arg_17_2, arg_17_3)
end

DORM_ENTITY_REMOVED = "DORM_ENTITY_REMOVED"

function EntityManager:Remove(arg_18_1)
	if self.managed[arg_18_1] then
		manager.notify:Invoke(DORM_ENTITY_REMOVED, self.managed[arg_18_1])

		if self.OnRemove then
			self.OnRemove(arg_18_1, self.managed[arg_18_1])
		end

		self.spawnImpl:OnRemove(self.managed[arg_18_1])
		self:RemoveEntityData(self.managed[arg_18_1])

		self.managed[arg_18_1] = nil
		self.reverseQuery[self.managed[arg_18_1]] = nil
		self.managedEntityNum = self.managedEntityNum - 1
	end

	return self.managed[arg_18_1]
end

function EntityManager:Update(arg_19_1, arg_19_2, arg_19_3)
	if self.managed[arg_19_1] then
		self:Remove(arg_19_1)
	end

	return (arg_19_2 or nil) and self:Create(arg_19_1, arg_19_2, arg_19_3), self.managed[arg_19_1]
end

function EntityManager:GetEntityID(arg_20_1)
	return self.managed[arg_20_1]
end

function EntityManager:GetAll()
	local var_21_0 = {}

	for iter_21_0, iter_21_1 in pairs(self.reverseQuery) do
		table.insert(var_21_0, iter_21_0)
	end

	return var_21_0
end

function EntityManager:Find(arg_22_1)
	return self.reverseQuery[arg_22_1]
end

function EntityManager:Clear(arg_23_1)
	for iter_23_0, iter_23_1 in pairs(self.managed) do
		if self.OnRemove then
			self.OnRemove(iter_23_0, iter_23_1)
		end

		self:RemoveEntityData(iter_23_1)
		self.spawnImpl:OnRemove(iter_23_1, arg_23_1)

		self.managed[iter_23_0] = nil
		self.reverseQuery[iter_23_1] = nil
	end

	self.managedEntityNum = 0
end

function EntityManager:EntityNum()
	return self.managedEntityNum
end

function EntityManager:RecordNewEntityData(arg_25_1, arg_25_2, arg_25_3)
	if self.dataCtor then
		arg_25_3 = self.dataCtor(arg_25_1, arg_25_2, arg_25_3)
	end

	Dorm.storage:RecordData(DormEnum.Namespace.EntityData, arg_25_2, arg_25_3 or {})

	return arg_25_3
end

function EntityManager:RemoveAllEntityData()
	for iter_26_0, iter_26_1 in pairs(self.managed) do
		self:RemoveEntityData(iter_26_1)
	end
end

function EntityManager:RemoveEntityData(arg_27_1)
	Dorm.storage:RecordData(DormEnum.Namespace.EntityData, arg_27_1, nil)
end

function EntityManager:MapToDormStorageData(arg_28_1, arg_28_2)
	if arg_28_1 then
		Dorm.storage:MapToData(arg_28_1, self.managed)
	end

	if arg_28_2 then
		Dorm.storage:MapToData(arg_28_2, self.reverseQuery)
	end
end

function EntityManager:FindAndRemoveEntity(arg_29_1)
	for iter_29_0, iter_29_1 in pairs(self) do
		local var_29_0 = iter_29_1:Find(arg_29_1)

		if var_29_0 then
			return iter_29_1:Remove(var_29_0)
		end
	end
end

function EntityManager:ValidateEntity(arg_30_1)
	for iter_30_0, iter_30_1 in pairs(self) do
		local var_30_0 = iter_30_1:Find(arg_30_1)

		if var_30_0 then
			return var_30_0, iter_30_1
		end
	end
end

return EntityManager
