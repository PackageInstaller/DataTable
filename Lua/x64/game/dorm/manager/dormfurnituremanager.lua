local var_0_0 = singletonClass("DormFurnitureManager")

var_0_0.FurnitureState = {
	Placed = 1,
	Editing = 2,
	Hanging = 0
}

local var_0_1 = 0

local function var_0_2(arg_1_0)
	return arg_1_0.prefab
end

function var_0_0.Ctor(arg_2_0)
	arg_2_0.listener = EventListener.New()

	local var_2_0 = EntityManager.CreateFurniture.New()

	arg_2_0.entityManager = EntityManager.New(var_2_0, var_0_0.dataCtor)

	local var_2_1 = EntityManager.CreateModel.New(var_0_2)

	arg_2_0.tileEntityManager = EntityManager.New(var_2_1)
	arg_2_0.nextIdx, arg_2_0.nextTileEntityIdx = var_0_1, var_0_1

	function arg_2_0.tileEntityManager.OnRemove(arg_3_0, arg_3_1)
		local var_3_0 = DormUtils.GetEntityData(arg_3_1).OnRemove

		if var_3_0 then
			var_3_0(arg_3_0, arg_3_1)
		end
	end
end

function var_0_0.Init(arg_4_0)
	arg_4_0:RegisterEvent()
end

function var_0_0.Reset(arg_5_0)
	arg_5_0:RemoveEvent()
	arg_5_0:Clear()
end

function var_0_0.RegisterEvent(arg_6_0)
	return
end

function var_0_0.RemoveEvent(arg_7_0)
	arg_7_0.listener:RemoveAll()
end

function var_0_0.OnBeginStory(arg_8_0, arg_8_1)
	if DormEnum.HasFlag(arg_8_1, DormEnum.BeginStoryFlag.HideFurniture) then
		arg_8_0:Clear()
	end
end

function var_0_0.OnFinishStory(arg_9_0, arg_9_1)
	if DormEnum.HasFlag(arg_9_1, DormEnum.BeginStoryFlag.HideFurniture) then
		DormFurnitureTools:GenerateFurnitureWhenEnterScene()
	end
end

local function var_0_3(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = nullable(BackHomeFurniture, arg_10_2, "start_up_action")

	return (arg_10_0.entityManager:Update(arg_10_1, {
		cfgID = arg_10_2,
		state = arg_10_3 or 0,
		complex = var_10_0 and var_10_0 ~= 0
	}))
end

function var_0_0.Generate(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = var_0_3(arg_11_0, arg_11_0.nextIdx, arg_11_1, arg_11_2)

	arg_11_0.nextIdx = arg_11_0.nextIdx + 1

	return var_11_0
end

function var_0_0.GenerateTileEntity(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.tileEntityManager:Update(arg_12_0.nextTileEntityIdx, {
		prefab = arg_12_1,
		complex = arg_12_2
	})

	arg_12_0.nextTileEntityIdx = arg_12_0.nextTileEntityIdx + 1

	return var_12_0
end

function var_0_0.Remove(arg_13_0, arg_13_1)
	arg_13_0.entityManager:Remove(arg_13_1)
end

function var_0_0.Clear(arg_14_0)
	arg_14_0.tileEntityManager:Clear()
	arg_14_0.entityManager:Clear()
	DormLuaBridge.ClearFurnitureOccupy()
	DormLuaBridge.UpdateAllWallMountDitherAlphaControl()

	arg_14_0.nextIdx, arg_14_0.nextTileEntityIdx = var_0_1, var_0_1

	DormLuaBridge.ClearAllSuitEntity()
end

function var_0_0.dataCtor(arg_15_0, arg_15_1, arg_15_2)
	arg_15_2 = arg_15_2 or {}
	arg_15_2.interactEntities = {}

	return arg_15_2
end

local function var_0_4(arg_16_0, arg_16_1)
	arg_16_1 = arg_16_1 + 1

	if arg_16_1 < arg_16_0.Length then
		return arg_16_1, arg_16_0[arg_16_1]
	end
end

function var_0_0.ClearAndGenByFurList(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	arg_17_0:Clear()

	if arg_17_1 then
		if not arg_17_2 then
			DormLuaBridge.SyncRoomFurniture(arg_17_1)
		end

		for iter_17_0, iter_17_1 in var_0_4, arg_17_1, -1 do
			local var_17_0 = iter_17_1.id
			local var_17_1 = var_0_3(arg_17_0, iter_17_0, var_17_0, iter_17_1.state or 0)

			if arg_17_2 then
				local var_17_2 = iter_17_1.tileType
				local var_17_3 = iter_17_1.pos
				local var_17_4 = iter_17_1.rotation

				DormLuaBridge.SetFurniturePosition(var_17_1, var_17_2, var_17_3, var_17_4)
				DormLuaBridge.RecoverRoomFurnitureOccupyByLua(var_17_1)
			else
				DormLuaBridge.RecoverRoomFurnitureOccupy(iter_17_0, var_17_1)
			end

			DormLuaBridge.ChangeFurnitureState(var_17_1, var_0_0.FurnitureState.Placed)
		end

		arg_17_0.nextIdx = arg_17_1.Length
	else
		arg_17_0.nextIdx = 0
	end

	if arg_17_3 then
		DormSuitTools:GenerateSuitInfoList(arg_17_3, true)
	end

	DormLuaBridge.UpdateAllWallMountDitherAlphaControl()
	DormLuaBridge.UpdateAllFurnitureInteractAreaEnabled()
	arg_17_0:RefreshAllFurnitureConnection()

	for iter_17_2, iter_17_3 in pairs(arg_17_0.entityManager.managed) do
		var_0_0.StartFurnitureStartUpInteract(iter_17_3)
	end
end

function var_0_0.FindAndRemove(arg_18_0)
	local var_18_0 = var_0_0.GetInstance()

	EntityManager.FindAndRemoveEntity({
		var_18_0.entityManager
	}, arg_18_0)
end

function var_0_0.GetAllFurniture(arg_19_0)
	return arg_19_0.entityManager.managed
end

function var_0_0.RefreshAllFurnitureConnection(arg_20_0)
	arg_20_0.connectInfo = {}

	local var_20_0 = {}

	for iter_20_0, iter_20_1 in pairs(arg_20_0.entityManager.managed) do
		table.insert(var_20_0, iter_20_1)

		DormUtils.GetEntityData(iter_20_1).connect = {}
	end

	for iter_20_2 = 1, #var_20_0 do
		for iter_20_3 = iter_20_2 + 1, #var_20_0 do
			local var_20_1 = var_20_0[iter_20_2]
			local var_20_2 = var_20_0[iter_20_3]

			if DormLuaBridge.CheckFurnitureConnectReady(var_20_1, var_20_2) then
				table.insert(DormUtils.GetEntityData(var_20_1).connect, var_20_2)
				table.insert(DormUtils.GetEntityData(var_20_2).connect, var_20_1)
			end
		end
	end

	DormMultiFurnitureStructureManager.GetInstance():RefreshAllMultiFurnitureStructure(var_20_0)
end

function Dorm.FurnitureReloadData(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = var_0_0.GetInstance()
	local var_21_1 = var_21_0.entityManager:Find(arg_21_0)

	if var_21_1 == nil then
		var_21_1 = var_21_0.nextIdx
		var_21_0.nextIdx = var_21_0.nextIdx + 1
	end

	var_21_0.entityManager:Reload(var_21_1, arg_21_0, {
		cfgID = arg_21_1,
		state = arg_21_2 or 0
	})
end

function Dorm.TestRefreshFurnitureConnection()
	var_0_0.GetInstance():RefreshAllFurnitureConnection()
end

function var_0_0.BeginEdit(arg_23_0)
	arg_23_0.tileEntityManager:Clear()
end

function var_0_0.EndEdit(arg_24_0)
	arg_24_0:RefreshAllFurnitureConnection()

	for iter_24_0, iter_24_1 in pairs(arg_24_0.entityManager.managed) do
		var_0_0.StartFurnitureStartUpInteract(iter_24_1)
	end
end

function var_0_0.StartFurnitureStartUpInteract(arg_25_0)
	local var_25_0 = DormUtils.GetEntityData(arg_25_0).cfgID
	local var_25_1 = nullable(BackHomeFurniture, var_25_0, "start_up_action")

	if var_25_1 and var_25_1 ~= 0 then
		Dorm.DormEntityManager.SendInteractToEntityCMD(arg_25_0, arg_25_0, var_25_1, false)
	end
end

function var_0_0.FindAndRemoveTileEntity(arg_26_0, arg_26_1)
	EntityManager.FindAndRemoveEntity({
		arg_26_0.tileEntityManager
	}, arg_26_1)
end

return var_0_0
