local var_0_0 = class("EntityManager")
local var_0_1 = class("EntityManager.SpawnImpl")

function var_0_1.OnSpawn(arg_1_0, arg_1_1)
	return
end

function var_0_1.OnRemove(arg_2_0, arg_2_1)
	Dorm.DormEntityManager.Instance:RemoveEntity(arg_2_1)
end

local function var_0_2()
	return nil
end

local var_0_3 = class("EntityManager.CreateModel", var_0_1)

function var_0_3.Ctor(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0.modelPathGetter = arg_4_1
	arg_4_0.spawnPosGetter = arg_4_2 or var_0_2
	arg_4_0.delay = arg_4_3 or 0
end

function var_0_3.OnSpawn(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.modelPathGetter(arg_5_1)
	local var_5_1 = arg_5_0.spawnPosGetter(arg_5_1)

	return Dorm.DormEntityManager.Instance:SpawnEntity(var_5_0, var_5_1, arg_5_1.complex or false, arg_5_1.pooled or false)
end

function var_0_3.OnRemove(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0.delay == nil or arg_6_0.delay == 0 or arg_6_2 then
		Dorm.DormEntityManager.Instance:RemoveEntity(arg_6_1)
	else
		local var_6_0 = arg_6_0.delay

		if type(var_6_0) == "function" then
			var_6_0 = var_6_0()
		end

		Dorm.DormEntityManager.Instance:RemoveEntity(arg_6_1, var_6_0)
	end
end

var_0_0.CreateModel = var_0_3

local var_0_4 = class("EntityManager.CreatePlayer", var_0_1)

function var_0_4.Ctor(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.modelPathGetter = arg_7_1
	arg_7_0.spawnPosGetter = arg_7_2 or var_0_2
end

function var_0_4.OnSpawn(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.modelPathGetter(arg_8_1)
	local var_8_1 = arg_8_0.spawnPosGetter(arg_8_1)

	return Dorm.DormEntityManager.Instance:SpawnPlayerEntity(var_8_0, var_8_1)
end

var_0_0.CreatePlayer = var_0_4

local var_0_5 = class("EntityManager.CreateFurniture", var_0_1)

function var_0_5.OnSpawn(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1.cfgID
	local var_9_1 = arg_9_1.state or 0
	local var_9_2 = arg_9_1.complex or false
	local var_9_3 = nullable(BackHomeFurnitureSubtype, nullable(BackHomeFurnitureSubtype, "get_id_list_by_furniture_cfg", var_9_0, var_9_1)) or BackHomeFurniture[var_9_0]
	local var_9_4 = var_9_1 ~= 0 and var_9_3.tile_size or var_9_3.title
	local var_9_5 = DormLuaBridge.GenerateFurniture(var_9_0, var_9_1, var_9_3.model, var_9_4[1], var_9_4[2], var_9_4[3], var_9_3.sub_type ~= 0, var_9_2)

	if var_9_3.display_type ~= 0 then
		DormLuaBridge.SnapWallMountFurniture(var_9_5)
	end

	return var_9_5
end

function var_0_5.OnRemove(arg_10_0, arg_10_1)
	local var_10_0 = DormUtils.GetEntityData(arg_10_1)
	local var_10_1 = false

	if var_10_0 then
		var_10_1 = var_10_0.noOccupy or false
	end

	DormLuaBridge.RemoveFurniture(arg_10_1, not var_10_1)
end

var_0_0.CreateFurniture = var_0_5

local var_0_6 = class("EntityManager.CreateFurniture", var_0_1)

function var_0_6.OnSpawn(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1.cfgID
	local var_11_1 = arg_11_1.state or 0
	local var_11_2 = nullable(BackHomeFurnitureSubtype, nullable(BackHomeFurnitureSubtype, "get_id_list_by_furniture_cfg", var_11_0, var_11_1)) or BackHomeFurniture[var_11_0]
	local var_11_3 = var_11_1 ~= 0 and var_11_2.tile_size or var_11_2.title

	return (DormLuaBridge.GenerateFurniture(var_11_0, var_11_1, var_11_2.model, var_11_3[1], var_11_3[2], var_11_3[3] or 1, var_11_2.sub_type ~= 0))
end

function var_0_6.OnRemove(arg_12_0, arg_12_1)
	local var_12_0 = DormUtils.GetEntityData(arg_12_1)
	local var_12_1 = false

	if var_12_0 then
		var_12_1 = var_12_0.noOccupy or false
	end

	DormLuaBridge.RemoveFurniture(arg_12_1, not var_12_1)
end

var_0_0.CreateIlluFurniture = var_0_6

local var_0_7 = class("EntityManager.AttachToModel", var_0_1)

function var_0_7.Ctor(arg_13_0, arg_13_1)
	arg_13_0.attachRootGetter = arg_13_1
end

function var_0_7.OnSpawn(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.attachRootGetter(arg_14_1)

	return Dorm.DormEntityManager.Instance:MakeModelEntity(var_14_0)
end

var_0_0.AttachToModel = var_0_7
var_0_0.all = {}

setmetatable(var_0_0.all, {
	__mode = "v"
})

function var_0_0.Ctor(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0.managedEntityNum = 0
	arg_15_0.managed = {}
	arg_15_0.reverseQuery = {}
	arg_15_0.spawnImpl = arg_15_1
	arg_15_0.dataCtor = arg_15_2

	table.insert(var_0_0.all, arg_15_0)
end

function var_0_0.Create(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = arg_16_0.spawnImpl:OnSpawn(arg_16_2)

	arg_16_0.managed[arg_16_1] = var_16_0
	arg_16_0.reverseQuery[var_16_0] = arg_16_1
	arg_16_0.managedEntityNum = arg_16_0.managedEntityNum + 1
	arg_16_3 = arg_16_0:RecordNewEntityData(arg_16_1, var_16_0, arg_16_3 or arg_16_2)

	if arg_16_0.OnCreate then
		arg_16_0.OnCreate(arg_16_1, var_16_0, arg_16_2, arg_16_3)
	end

	return var_16_0
end

function var_0_0.Reload(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = arg_17_0.reverseQuery[arg_17_2]

	if var_17_0 == nil then
		arg_17_0.managedEntityNum = arg_17_0.managedEntityNum + 1
	else
		arg_17_1 = var_17_0
	end

	arg_17_0.managed[arg_17_1] = arg_17_2
	arg_17_0.reverseQuery[arg_17_2] = arg_17_1

	arg_17_0:RecordNewEntityData(arg_17_1, arg_17_2, arg_17_3)
end

DORM_ENTITY_REMOVED = "DORM_ENTITY_REMOVED"

function var_0_0.Remove(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0.managed[arg_18_1]

	if var_18_0 then
		manager.notify:Invoke(DORM_ENTITY_REMOVED, var_18_0)

		if arg_18_0.OnRemove then
			arg_18_0.OnRemove(arg_18_1, var_18_0)
		end

		arg_18_0.spawnImpl:OnRemove(var_18_0)
		arg_18_0:RemoveEntityData(var_18_0)

		arg_18_0.managed[arg_18_1] = nil
		arg_18_0.reverseQuery[var_18_0] = nil
		arg_18_0.managedEntityNum = arg_18_0.managedEntityNum - 1
	end

	return var_18_0
end

function var_0_0.Update(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = arg_19_0.managed[arg_19_1]
	local var_19_1

	if var_19_0 then
		arg_19_0:Remove(arg_19_1)
	end

	if arg_19_2 then
		var_19_1 = arg_19_0:Create(arg_19_1, arg_19_2, arg_19_3)
	end

	return var_19_1, var_19_0
end

function var_0_0.GetEntityID(arg_20_0, arg_20_1)
	return arg_20_0.managed[arg_20_1]
end

function var_0_0.GetAll(arg_21_0)
	local var_21_0 = {}

	for iter_21_0, iter_21_1 in pairs(arg_21_0.reverseQuery) do
		table.insert(var_21_0, iter_21_0)
	end

	return var_21_0
end

function var_0_0.Find(arg_22_0, arg_22_1)
	return arg_22_0.reverseQuery[arg_22_1]
end

function var_0_0.Clear(arg_23_0, arg_23_1)
	for iter_23_0, iter_23_1 in pairs(arg_23_0.managed) do
		if arg_23_0.OnRemove then
			arg_23_0.OnRemove(iter_23_0, iter_23_1)
		end

		arg_23_0:RemoveEntityData(iter_23_1)
		arg_23_0.spawnImpl:OnRemove(iter_23_1, arg_23_1)

		arg_23_0.managed[iter_23_0] = nil
		arg_23_0.reverseQuery[iter_23_1] = nil
	end

	arg_23_0.managedEntityNum = 0
end

function var_0_0.EntityNum(arg_24_0)
	return arg_24_0.managedEntityNum
end

function var_0_0.RecordNewEntityData(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = DormEnum.Namespace.EntityData

	if arg_25_0.dataCtor then
		arg_25_3 = arg_25_0.dataCtor(arg_25_1, arg_25_2, arg_25_3)
	end

	Dorm.storage:RecordData(var_25_0, arg_25_2, arg_25_3 or {})

	return arg_25_3
end

function var_0_0.RemoveAllEntityData(arg_26_0)
	for iter_26_0, iter_26_1 in pairs(arg_26_0.managed) do
		arg_26_0:RemoveEntityData(iter_26_1)
	end
end

function var_0_0.RemoveEntityData(arg_27_0, arg_27_1)
	local var_27_0 = DormEnum.Namespace.EntityData

	Dorm.storage:RecordData(var_27_0, arg_27_1, nil)
end

function var_0_0.MapToDormStorageData(arg_28_0, arg_28_1, arg_28_2)
	if arg_28_1 then
		Dorm.storage:MapToData(arg_28_1, arg_28_0.managed)
	end

	if arg_28_2 then
		Dorm.storage:MapToData(arg_28_2, arg_28_0.reverseQuery)
	end
end

function var_0_0.FindAndRemoveEntity(arg_29_0, arg_29_1)
	for iter_29_0, iter_29_1 in pairs(arg_29_0) do
		local var_29_0 = iter_29_1:Find(arg_29_1)

		if var_29_0 then
			return iter_29_1:Remove(var_29_0)
		end
	end
end

function var_0_0.ValidateEntity(arg_30_0, arg_30_1)
	for iter_30_0, iter_30_1 in pairs(arg_30_0) do
		local var_30_0 = iter_30_1:Find(arg_30_1)

		if var_30_0 then
			return var_30_0, iter_30_1
		end
	end
end

return var_0_0
