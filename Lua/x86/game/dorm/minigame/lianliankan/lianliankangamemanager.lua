local var_0_0 = singletonClass("LianLianKanGameManager")
local var_0_1 = {
	previewItemRemove = "Dorm/Effect/lianliankan/Fx_daoju_cx",
	itemNotMatch = "Dorm/Effect/lianliankan/Fx_effect_cuowu",
	itemEnter = "Dorm/Effect/lianliankan/Fx_effect_cai_xinzeng",
	itemRemove = "Dorm/Effect/lianliankan/Fx_gezi_effect"
}
local var_0_2 = "minigame_activity_2_1"
local var_0_3 = {
	ItemNotMatch = "minigame_activity_2_1_connect_fail",
	ItemPreviewClear = "minigame_activity_2_1_connect_tool02",
	Select = "minigame_activity_2_1_connect_choose",
	ItemMatch = "minigame_activity_2_1_connect_link",
	CancelSelect = "minigame_activity_2_1_connect_cancel"
}
local var_0_4 = "Dorm/Dormitory/HZ07_lianliankan2_gezi"
local var_0_5 = "Dorm/Dormitory/HZ07_placeholder"
local var_0_6 = "Dorm/Dormitory/HZ07_lianliankan_gezi"
local var_0_7 = "Dorm/Dormitory/HZ07_item_preview"
local var_0_8 = "Dorm/Food/120"

local function var_0_9(arg_1_0)
	return arg_1_0.model
end

local function var_0_10(arg_2_0)
	if arg_2_0.type ~= nil then
		local var_2_0 = "lianliankan.pos." .. arg_2_0.type
		local var_2_1 = Dorm.storage:GetData(var_2_0, "#") or 0

		if var_2_1 ~= 0 then
			local var_2_2 = ((arg_2_0.spawnAt or 1) - 1) % var_2_1 + 1
			local var_2_3 = Dorm.storage:GetData(var_2_0, var_2_2) or Dorm.storage:PickData(var_2_0)

			return nullable(var_2_3, "transform")
		end
	end
end

local function var_0_11(arg_3_0)
	for iter_3_0 = #arg_3_0, 2, -1 do
		local var_3_0 = math.random(iter_3_0)

		arg_3_0[iter_3_0], arg_3_0[var_3_0] = arg_3_0[var_3_0], arg_3_0[iter_3_0]
	end
end

function var_0_0.Ctor(arg_4_0)
	arg_4_0.workerIdx = {}
	arg_4_0.previewItemQueueCap = 10
	arg_4_0.entityManagers = {}

	local var_4_0 = EntityManager.CreateModel.New(var_0_9, var_0_10)
	local var_4_1 = EntityManager.CreateModel.New(var_0_9, var_0_10, 0.4)

	arg_4_0.placeholderEntityManager = EntityManager.New(var_4_0)
	arg_4_0.itemEntityManager = EntityManager.New(var_4_0)
	arg_4_0.customerFoodEntityManager = EntityManager.New(var_4_0)
	arg_4_0.previewEntityManager = EntityManager.New(var_4_1)
	arg_4_0.customerEntityManager = EntityManager.New(var_4_0)
	arg_4_0.workerEntityManager = EntityManager.New(var_4_0)

	table.insert(arg_4_0.entityManagers, arg_4_0.placeholderEntityManager)
	table.insert(arg_4_0.entityManagers, arg_4_0.itemEntityManager)
	table.insert(arg_4_0.entityManagers, arg_4_0.customerFoodEntityManager)
	table.insert(arg_4_0.entityManagers, arg_4_0.previewEntityManager)
	table.insert(arg_4_0.entityManagers, arg_4_0.customerEntityManager)
	table.insert(arg_4_0.entityManagers, arg_4_0.workerEntityManager)

	arg_4_0.itemEntityManager.OnCreate = handler(arg_4_0, arg_4_0.OnItemCreate)
	arg_4_0.itemEntityManager.OnRemove = handler(arg_4_0, arg_4_0.OnItemRemoved)

	function arg_4_0.customerFoodEntityManager.OnCreate(arg_5_0)
		DormCharacterActionManager.taskRunner:NewTask():WaitForSec(5):Then(function()
			arg_4_0.customerFoodEntityManager:Remove(arg_5_0)
		end):Start()
	end

	function arg_4_0.previewEntityManager.OnCreate(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
		local var_7_0 = Dorm.storage:GetData("lianliankan.path.preview", arg_7_0)

		Dorm.DormEntityManager.SetEntitySpeed(arg_7_1, 0.5)
		DormUtils.MoveByPath(arg_7_1, var_7_0, true)

		local var_7_1 = ActivityLinkGameCellCfg[arg_7_3.itemID]

		Dorm.LuaBridge.MiniGameBridge.SetupItemSprite(arg_7_1, var_7_1.path .. "/" .. var_7_1.album_id)
	end

	function arg_4_0.customerEntityManager.OnCreate(arg_8_0, arg_8_1)
		Dorm.DormEntityManager.ChangeEntityAnimeScheme(arg_8_1, "sit")
	end

	arg_4_0.listener = EventListener.New()
	arg_4_0.turn = 2
end

var_0_0.ItemQueueNamespace = "lianliankan.itemQueue"

function var_0_0.RegForwardAIEvent(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.listener:Register(arg_9_1, function(...)
		arg_9_0.ForwardToAI(arg_9_1, ...)

		if arg_9_2 then
			arg_9_2(...)
		end
	end)
end

function var_0_0.Init(arg_11_0, arg_11_1)
	arg_11_0.level = arg_11_1
	arg_11_0.gridMap = GridMap.New(8, 7)

	arg_11_0:RegisterEvents()

	arg_11_0.preparedSortInfo = nil
	arg_11_0.gridCoordOrigin = Dorm.storage:PickData("lianliankan.pos.origin").transform
	arg_11_0.items = {}

	for iter_11_0, iter_11_1 in Dorm.storage:ForeachData("lianliankan.pos.Pan", pairs) do
		local var_11_0 = iter_11_1.transform
		local var_11_1 = Dorm.DormEntityManager.Instance:MakeModelEntity(var_11_0)

		table.insert(arg_11_0.items, var_11_1)
		Dorm.storage:RecordData(var_0_0.ItemEidNameSpace(DormEnum.ItemType.Pan), iter_11_0, var_11_1)
	end

	local var_11_2 = Dorm.storage:PickData("lianliankan.pos.chuansongdai").transform
	local var_11_3 = Dorm.DormEntityManager.Instance:MakeModelEntity(var_11_2)

	table.insert(arg_11_0.items, var_11_3)

	arg_11_0.chuansongdai = var_11_3

	arg_11_0.previewEntityManager:MapToDormStorageData(arg_11_0.ItemQueueNamespace, nil)

	local var_11_4 = DormUtils.EIdNamespace(DormEnum.CharacterType.RestaurantNormalCustomer)

	arg_11_0.customerEntityManager:MapToDormStorageData(var_11_4, nil)

	arg_11_0.workerIdx = {}

	arg_11_0:GenWorkerEntity(arg_11_1)
	arg_11_0:GenCustomerEntity(arg_11_1)

	local var_11_5 = ActivityLinkGameCfg[arg_11_1]

	arg_11_0.placeholderEntityManager:Clear()

	if var_11_5.blank_pos and var_11_5.blank_pos ~= "" then
		for iter_11_2, iter_11_3 in ipairs(var_11_5.blank_pos) do
			local var_11_6 = Vector2(unpack(iter_11_3))

			arg_11_0:AddPlaceHolder(var_11_6)
		end
	end

	if var_11_5.obstacle_pos and var_11_5.obstacle_pos ~= "" then
		for iter_11_4, iter_11_5 in ipairs(var_11_5.obstacle_pos) do
			local var_11_7 = Vector2(unpack(iter_11_5))

			arg_11_0:AddObstacle(var_11_7)
		end
	end
end

function var_0_0.Reset(arg_12_0)
	manager.audio:StopAll()

	arg_12_0.workerIdx = nil
	arg_12_0.lastSelect = nil
	arg_12_0.itemGenDistribution = nil

	for iter_12_0, iter_12_1 in pairs(arg_12_0.items) do
		Dorm.DormEntityManager.Instance:RemoveEntity(iter_12_1)
	end

	arg_12_0.items = nil
	arg_12_0.chuansongdai = nil

	LianLianKan.AI[DormEnum.CharacterType.RestaurantNormalCustomer].Clear()
	LianLianKan.AI[DormEnum.CharacterType.RestaurantCook].Clear()
	Dorm.storage:ClearData(var_0_0.ItemEidNameSpace(DormEnum.ItemType.Pan))

	for iter_12_2, iter_12_3 in ipairs(arg_12_0.entityManagers) do
		iter_12_3:Clear()
	end

	arg_12_0.listener:RemoveAll()

	arg_12_0.preparedSortInfo = nil
end

function var_0_0.Start(arg_13_0)
	arg_13_0:GenItemOnStart(arg_13_0.level)
end

function var_0_0.ResetCurLevel(arg_14_0)
	manager.audio:StopAll()

	arg_14_0.lastSelect = nil

	local var_14_0 = arg_14_0.level

	arg_14_0.previewEntityManager:Clear()
	arg_14_0.itemEntityManager:Clear()

	arg_14_0.workerIdx = {}

	arg_14_0:GenWorkerEntity(var_14_0)
	arg_14_0:GenCustomerEntity(var_14_0)
end

function var_0_0.RegisterEvents(arg_15_0)
	arg_15_0.listener:Register(DORM_CLICK_ENTITY, handler(arg_15_0, arg_15_0.OnClickEntity))
	arg_15_0.listener:Register(LIANLIANKAN_PREVIEW_APPEAR, handler(arg_15_0, arg_15_0.OnPreviewItemCreate))
	arg_15_0.listener:Register(LIANLIANKAN_AUTO_MATCH, handler(arg_15_0, arg_15_0.AutoMatch))
	arg_15_0.listener:Register(LIANLIANKAN_BUFF_IGNORE_CONNECTION, handler(arg_15_0, arg_15_0.OnBuffIgnoreConnection))
	arg_15_0.listener:Register(LIANLIANKAN_SHUFFLE, handler(arg_15_0, arg_15_0.Shuffle))
	arg_15_0.listener:Register(LIANLIANKAN_GAME_START, handler(arg_15_0, arg_15_0.Start))
	arg_15_0.listener:Register(LIANLIANKAN_GAME_RESET, handler(arg_15_0, arg_15_0.ResetCurLevel))
	arg_15_0.listener:Register(LIANLIANKAN_PREVIEW_REMOVE_ALL, handler(arg_15_0, arg_15_0.ClearItemQueue))
	arg_15_0:RegForwardAIEvent(ON_DORM_CHARACTER_WAIT_CMD)
	arg_15_0:RegForwardAIEvent(ON_DORM_CHARACTER_INTERACT)
	arg_15_0:RegForwardAIEvent(LIANLIANKAN_USE_ITEM)
	arg_15_0:RegForwardAIEvent(LIANLIANKAN_ITEM_OVERFLOW)
	arg_15_0:RegForwardAIEvent(LIANLIANKAN_CUSTOMER_EAT, handler(arg_15_0, arg_15_0.GenFoodForCustomer))
	arg_15_0:RegForwardAIEvent(LIANLIANKAN_FREEZE, handler(arg_15_0, arg_15_0.Freeze))
end

function var_0_0.PlaySoundEffect(arg_16_0, arg_16_1)
	manager.audio:PlayEffect(var_0_2, arg_16_1)
end

local function var_0_12(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0

	if arg_17_3 then
		var_17_0 = arg_17_0.gridMap:Put(arg_17_3.x, arg_17_3.y, arg_17_2)
		arg_17_2.gridCoord = arg_17_3
	else
		var_17_0 = arg_17_0.gridMap:RndPut(arg_17_2)

		local var_17_1, var_17_2 = arg_17_0.gridMap:ToCoord(var_17_0)

		arg_17_2.gridCoord = Vector2(var_17_1, var_17_2)
	end

	if var_17_0 then
		arg_17_2.idx = var_17_0

		return (arg_17_2.isPlaceholder and arg_17_0.placeholderEntityManager or arg_17_0.itemEntityManager):Update(var_17_0, arg_17_1, arg_17_2), var_17_0
	end
end

function var_0_0.AddPlaceHolder(arg_18_0, arg_18_1)
	local var_18_0 = {
		model = var_0_5
	}
	local var_18_1, var_18_2 = var_0_12(arg_18_0, var_18_0, {
		itemID = "placeholder",
		passThroughConnect = true,
		isPlaceholder = true
	}, arg_18_1)

	Dorm.DormEntityManager.PutEntityLookToDir(var_18_1, arg_18_0:GridCoordToPos(Vector2(arg_18_0.gridMap:ToCoord(var_18_2))), Vector3.forward)
end

function var_0_0.AddObstacle(arg_19_0, arg_19_1)
	local var_19_0 = {
		model = var_0_4
	}
	local var_19_1, var_19_2 = var_0_12(arg_19_0, var_19_0, {
		itemID = "obstacle",
		passThroughConnect = false,
		isPlaceholder = true
	}, arg_19_1)

	Dorm.DormEntityManager.PutEntityLookToDir(var_19_1, arg_19_0:GridCoordToPos(Vector2(arg_19_0.gridMap:ToCoord(var_19_2))), Vector3.forward)
end

local function var_0_13(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = {
		Vector2.left,
		Vector2.up,
		Vector2.right,
		Vector2.down
	}
	local var_20_1 = {
		{
			arg_20_1
		}
	}

	while next(var_20_1) do
		local var_20_2 = table.remove(var_20_1)
		local var_20_3 = var_20_2[2]
		local var_20_4 = var_20_2[3] or 0

		for iter_20_0, iter_20_1 in pairs(var_20_0) do
			local var_20_5 = var_20_3 and var_20_3 ~= iter_20_1 and var_20_3 + iter_20_1 ~= Vector2.zero

			if not var_20_5 or not (var_20_4 < arg_20_2) then
				local var_20_6 = var_20_2[1] + iter_20_1

				if arg_20_0:IsGridInMap(var_20_6.x, var_20_6.y) then
					local var_20_7 = arg_20_0:Get(var_20_6.x, var_20_6.y)

					if arg_20_3(var_20_7) then
						return var_20_6
					elseif var_20_7.passThroughConnect then
						table.insert(var_20_1, {
							var_20_6,
							iter_20_1,
							var_20_5 and var_20_4 + 1 or var_20_4
						})
					end
				end
			end
		end
	end
end

local var_0_14 = {
	pooled = true,
	model = var_0_6
}
local var_0_15 = {
	pooled = true,
	ignoreCreateVfx = true,
	model = var_0_6
}

function var_0_0.Add2Item(arg_21_0, arg_21_1)
	local var_21_0 = {
		itemID = arg_21_1
	}
	local var_21_1 = var_0_12(arg_21_0, var_0_14, var_21_0)
	local var_21_2
	local var_21_3 = var_0_12(arg_21_0, var_0_14, {
		itemID = arg_21_1
	}, var_21_2)

	return var_21_1, var_21_3
end

function var_0_0.OnPreviewItemCreate(arg_22_0)
	if arg_22_0.previewEntityManager.managedEntityNum >= arg_22_0.previewItemQueueCap then
		arg_22_0:FlushPreviewItem()

		if arg_22_0:Find() == nil then
			ShowTips("LIANLIANKAN_NO_SOLUTION_SHUFFLE")
			arg_22_0:Shuffle()
		end
	end

	arg_22_0:GenPreviewItem()
end

function var_0_0.FlushPreviewItem(arg_23_0)
	while arg_23_0.gridMap:HasGridEmpty(2) and #arg_23_0.itemQueue > 0 do
		local var_23_0 = table.remove(arg_23_0.itemQueue, 1)

		arg_23_0.itemGenDistribution:Pop(var_23_0, 2)
		arg_23_0:Add2Item(var_23_0)
	end

	arg_23_0:SortItems()

	local var_23_1 = arg_23_0.itemQueue

	arg_23_0:ClearItemQueue(true)

	if #var_23_1 > 0 then
		manager.notify:Invoke(LIANLIANKAN_ITEM_OVERFLOW, var_23_1)
	end
end

local function var_0_16(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_1.x + arg_24_2.x
	local var_24_1 = arg_24_1.y + arg_24_2.y
	local var_24_2 = arg_24_1.x
	local var_24_3 = arg_24_1.y

	while arg_24_0:IsGridInMap(var_24_0, var_24_1) do
		if arg_24_0:IsGridEmpty(var_24_0, var_24_1) then
			var_24_2, var_24_3 = var_24_0, var_24_1
			var_24_0, var_24_1 = var_24_0 + arg_24_2.x, var_24_1 + arg_24_2.y
		else
			break
		end
	end

	return Vector2(var_24_2, var_24_3)
end

local var_0_17 = {
	step = 0,
	sortedGrids = {}
}

local function var_0_18(arg_25_0)
	local var_25_0 = arg_25_0.width
	local var_25_1 = arg_25_0.height
	local var_25_2
	local var_25_3 = {}

	for iter_25_0 = 0, var_25_0 - 1 do
		for iter_25_1 = 0, var_25_1 - 1 do
			table.insert(var_25_3, Vector2(iter_25_0, iter_25_1))
		end
	end

	return var_25_3
end

function var_0_0.SortItems(arg_26_0)
	local var_26_0
	local var_26_1

	if arg_26_0.preparedSortInfo == nil then
		local var_26_2 = arg_26_0.level
		local var_26_3 = ActivityLinkGameCfg[var_26_2].sort_func or 0

		if var_26_3 == 0 then
			arg_26_0.preparedSortInfo = var_0_17

			return
		end

		if var_26_3 == 1 then
			var_26_0 = Vector2(-1, 0)
		elseif var_26_3 == 2 then
			var_26_0 = Vector2(1, 0)
		elseif var_26_3 == 3 then
			var_26_0 = Vector2(0, -1)
		else
			var_26_0 = Vector2(0, 1)
		end

		var_26_1 = var_0_18(arg_26_0.gridMap)

		CommonTools.UniversalSortEx(var_26_1, {
			map = function(arg_27_0)
				return Vector2.Dot(arg_27_0, var_26_0)
			end
		})

		arg_26_0.preparedSortInfo = {
			step = var_26_0,
			sortedGrids = var_26_1
		}
	else
		var_26_0 = arg_26_0.preparedSortInfo.step or Vector2.right
		var_26_1 = arg_26_0.preparedSortInfo.sortedGrids or {}
	end

	for iter_26_0, iter_26_1 in pairs(var_26_1) do
		local var_26_4 = arg_26_0:QueryEntityID(iter_26_1.x, iter_26_1.y)

		if var_26_4 then
			local var_26_5 = DormUtils.GetEntityData(var_26_4)
			local var_26_6 = var_0_16(arg_26_0.gridMap, var_26_5.gridCoord, var_26_0)

			arg_26_0:SwapItemToPos(var_26_5, var_26_6)
		end
	end
end

function var_0_0.PrepareNextGenQueue(arg_28_0)
	arg_28_0.itemQueue = arg_28_0.itemGenDistribution:Peek(arg_28_0.previewItemQueueCap, 2)
end

function var_0_0.GenFoodForCustomer(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0.customerFoodEntityManager

	if var_29_0:GetEntityID(arg_29_1) == nil then
		var_29_0:Create(arg_29_1, {
			pooled = true,
			model = var_0_8,
			type = DormEnum.ItemType.Food,
			spawnAt = arg_29_1
		})
	end
end

function var_0_0.GenPreviewItem(arg_30_0)
	local var_30_0 = {
		complex = true,
		pooled = true,
		model = var_0_7
	}
	local var_30_1 = arg_30_0.previewEntityManager.managedEntityNum + 1

	arg_30_0.previewEntityManager:Update(var_30_1, var_30_0, {
		itemID = arg_30_0.itemQueue[var_30_1]
	})
end

local var_0_19 = 1

function var_0_0.GridCoordToPos(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_1.x
	local var_31_1 = arg_31_1.y
	local var_31_2 = arg_31_0.gridCoordOrigin.position
	local var_31_3 = arg_31_0.gridMap.width
	local var_31_4 = arg_31_0.gridMap.height
	local var_31_5 = var_0_19 * 0.5

	return var_31_2 - Vector3(var_31_0 - 0.5 * var_31_3, 0, var_31_1 - 0.5 * var_31_4) * var_31_5 - Vector3(var_31_5 * 0.5, 0, var_31_5 * 0.5)
end

function var_0_0.ItemEidNameSpace(arg_32_0)
	return "lianliankan.item." .. arg_32_0 .. ".eid"
end

function var_0_0.PlayItemCreateVfx(arg_33_0, arg_33_1)
	Dorm.DormEntityManager.PlayEffectDetached(arg_33_1, "root", var_0_1.itemEnter, 0.7)
end

function var_0_0.OnItemCreate(arg_34_0, arg_34_1, arg_34_2, arg_34_3, arg_34_4)
	local var_34_0 = arg_34_4.itemID
	local var_34_1 = var_0_0.ItemEidNameSpace(var_34_0)

	Dorm.storage:RecordData(var_34_1, arg_34_1, arg_34_2)
	Dorm.LuaBridge.MiniGameBridge.SetupClickTriggerForEntity(arg_34_2, var_0_19)

	local var_34_2 = ActivityLinkGameCellCfg[var_34_0]

	Dorm.LuaBridge.MiniGameBridge.SetupItemSprite(arg_34_2, var_34_2.path .. "/" .. var_34_2.album_id)
	arg_34_0:SetItemHighlight(arg_34_2, false)
	Dorm.DormEntityManager.PutEntityLookToDir(arg_34_2, arg_34_0:GridCoordToPos(arg_34_4.gridCoord), Vector3.forward)

	if not arg_34_3.ignoreCreateVfx then
		arg_34_0:PlayItemCreateVfx(arg_34_2)
	end
end

function var_0_0.OnItemRemoved(arg_35_0, arg_35_1, arg_35_2)
	Dorm.LuaBridge.MiniGameBridge.MuteClickTriggerForEntity(arg_35_2)

	local var_35_0 = DormUtils.GetEntityData(arg_35_2).itemID
	local var_35_1 = var_0_0.ItemEidNameSpace(var_35_0)

	Dorm.storage:RecordData(var_35_1, arg_35_1, nil)
	arg_35_0.gridMap:RemoveByIdx(arg_35_1)
end

function var_0_0.SetItemHighlight(arg_36_0, arg_36_1, arg_36_2)
	Dorm.DormEntityManager.SetHighlighted(arg_36_1, arg_36_2)

	if arg_36_2 then
		Dorm.DormEntityManager.GrabItemPartCMD(arg_36_1, arg_36_1, "gezi_normal", "gua_hide")
		Dorm.DormEntityManager.GrabItemPartCMD(arg_36_1, arg_36_1, "gezi_highlight", "root")
	else
		Dorm.DormEntityManager.RestoreItemPartCMD(arg_36_1, "gezi_normal")
		Dorm.DormEntityManager.RestoreItemPartCMD(arg_36_1, "gezi_highlight")
	end
end

function var_0_0.SwapItemToPos(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = arg_37_1.itemID
	local var_37_1 = arg_37_1.gridCoord

	if var_37_1 == arg_37_2 then
		return
	end

	local var_37_2

	if not arg_37_0.gridMap:IsGridEmpty(arg_37_2.x, arg_37_2.y) then
		local var_37_3 = arg_37_0.gridMap:Get(arg_37_2.x, arg_37_2.y)

		var_37_2 = var_37_3.itemID

		if var_37_0 == var_37_2 then
			return
		end

		arg_37_0.itemEntityManager:Remove(var_37_3.idx)
	end

	arg_37_0.itemEntityManager:Remove(arg_37_1.idx)

	local var_37_4 = var_0_12(arg_37_0, var_0_15, {
		itemID = var_37_0
	}, arg_37_2)
	local var_37_5

	if var_37_2 then
		var_37_5 = var_0_12(arg_37_0, var_0_15, {
			itemID = var_37_2
		}, var_37_1)
	end

	return var_37_4, var_37_5
end

local var_0_20 = {
	FREEZE_CELL = 1020,
	SHUFFLE_CELL = 1019
}

local function var_0_21(arg_38_0)
	local var_38_0 = {}

	for iter_38_0, iter_38_1 in pairs(arg_38_0.itemGenDistribution.weights) do
		table.insert(var_38_0, iter_38_0)
	end

	var_0_11(var_38_0)

	local var_38_1 = var_38_0

	for iter_38_2, iter_38_3 in pairs(var_0_20) do
		table.insert(var_38_1, iter_38_3)
	end

	return var_38_1
end

local var_0_22 = 2

function var_0_0.OnSpecialItemConnectProcessEffect(arg_39_0, arg_39_1)
	if arg_39_1 == var_0_20.SHUFFLE_CELL then
		manager.audio:PlayEffect("minigame_activity_5_0", "minigame_activity_5_0_connect_refresh")
		arg_39_0:Shuffle(3)
	elseif arg_39_1 == var_0_20.FREEZE_CELL then
		local var_39_0 = ActivityLinkGameGoodsCfg[var_0_22].extra_param[1]

		arg_39_0:Freeze(var_39_0)
	end
end

function var_0_0.Find(arg_40_0)
	for iter_40_0, iter_40_1 in ipairs(var_0_21(arg_40_0)) do
		local var_40_0 = {}

		for iter_40_2, iter_40_3 in Dorm.storage:ForeachData(arg_40_0.ItemEidNameSpace(iter_40_1), pairs) do
			table.insert(var_40_0, iter_40_3)
		end

		for iter_40_4 = 1, #var_40_0 - 1 do
			for iter_40_5 = iter_40_4 + 1, #var_40_0 do
				local var_40_1 = var_40_0[iter_40_4]
				local var_40_2 = var_40_0[iter_40_5]
				local var_40_3 = DormUtils.GetEntityData(var_40_1)
				local var_40_4 = DormUtils.GetEntityData(var_40_2)
				local var_40_5 = var_40_3.gridCoord
				local var_40_6 = var_40_4.gridCoord
				local var_40_7 = arg_40_0:TestConnectivity(var_40_5, var_40_6)

				if var_40_7 then
					return var_40_7, var_40_5, var_40_6
				end
			end
		end
	end

	return nil
end

function var_0_0.ClearSelect(arg_41_0)
	if arg_41_0.lastSelect and Dorm.DormEntityManager.IsValidEntityID(arg_41_0.lastSelect) then
		arg_41_0:SetItemHighlight(arg_41_0.lastSelect, false)
	end

	arg_41_0.lastSelect = nil
end

function var_0_0.Shuffle(arg_42_0, arg_42_1)
	arg_42_0:ClearSelect()

	local var_42_0 = {}

	for iter_42_0, iter_42_1 in pairs(arg_42_0.itemEntityManager.managed) do
		local var_42_1 = DormUtils.GetEntityData(iter_42_1)
		local var_42_2 = (var_42_0[var_42_1.itemID] or 0) + 1

		var_42_0[var_42_1.itemID] = var_42_2
	end

	for iter_42_2, iter_42_3 in pairs(var_42_0) do
		-- block empty
	end

	arg_42_0.itemEntityManager:Clear()

	while next(var_42_0) do
		for iter_42_4, iter_42_5 in pairs(var_42_0) do
			arg_42_0:Add2Item(iter_42_4)

			if iter_42_5 > 2 then
				var_42_0[iter_42_4] = iter_42_5 - 2
			else
				var_42_0[iter_42_4] = nil
			end
		end
	end

	arg_42_0:SortItems()
	arg_42_0:EnsureSolution(arg_42_1)
end

function var_0_0.QueryEntityID(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = arg_43_0.gridMap:ToIdx(arg_43_1, arg_43_2)

	return arg_43_0.itemEntityManager:GetEntityID(var_43_0)
end

function var_0_0.AutoMatch(arg_44_0, arg_44_1)
	for iter_44_0 = 1, arg_44_1 do
		if arg_44_0.itemEntityManager.managedEntityNum == 0 then
			return
		end

		local var_44_0, var_44_1, var_44_2 = arg_44_0:Find()

		if var_44_0 then
			local var_44_3 = arg_44_0.gridMap:Get(var_44_1.x, var_44_1.y)
			local var_44_4 = arg_44_0.gridMap:Get(var_44_2.x, var_44_2.y)
			local var_44_5 = arg_44_0:QueryEntityID(var_44_1.x, var_44_1.y)
			local var_44_6 = arg_44_0:QueryEntityID(var_44_2.x, var_44_2.y)

			arg_44_0:OnConnectItemSuccess(var_44_0, var_44_5, var_44_6, var_44_3, var_44_4)
		end
	end
end

function var_0_0.Freeze(arg_45_0, arg_45_1)
	DormLinkGameData:PauseMaterialGenerate(arg_45_1)
end

function var_0_0.OnBuffIgnoreConnection(arg_46_0, arg_46_1)
	manager.audio:PlayEffect("minigame_activity_5_0", "minigame_activity_5_0_connect_except")
	DormLinkGameData:BuffIgnoreConnectCheck(arg_46_1)
end

local var_0_23 = {
	ignoreConnectivity = true
}

function var_0_0.TestConnectivity(arg_47_0, arg_47_1, arg_47_2)
	if DormLinkGameData:GetGameBuffIgnoreConnectCheck() then
		return var_0_23
	end

	return LianLianKanUtil.TestConnectivity(arg_47_0.gridMap, arg_47_1.x, arg_47_1.y, arg_47_2.x, arg_47_2.y, arg_47_0.turn)
end

function var_0_0.OnClickEntity(arg_48_0, arg_48_1)
	if arg_48_0.lastSelect == nil or not Dorm.DormEntityManager.IsValidEntityID(arg_48_0.lastSelect) then
		arg_48_0:SetItemHighlight(arg_48_1, true)

		arg_48_0.lastSelect = arg_48_1

		arg_48_0:PlaySoundEffect(var_0_3.Select)
	elseif arg_48_1 == arg_48_0.lastSelect then
		arg_48_0:SetItemHighlight(arg_48_1, false)

		arg_48_0.lastSelect = nil

		arg_48_0:PlaySoundEffect(var_0_3.CancelSelect)
	else
		local var_48_0 = DormUtils.GetEntityData(arg_48_0.lastSelect)
		local var_48_1 = DormUtils.GetEntityData(arg_48_1)
		local var_48_2 = var_48_0.itemID
		local var_48_3 = var_48_1.itemID
		local var_48_4

		if var_48_2 == var_48_3 then
			local var_48_5 = var_48_0.gridCoord
			local var_48_6 = var_48_1.gridCoord

			var_48_4 = arg_48_0:TestConnectivity(var_48_5, var_48_6)
		end

		if var_48_4 then
			arg_48_0:OnConnectItemSuccess(var_48_4, arg_48_0.lastSelect, arg_48_1, var_48_0, var_48_1)
		else
			Dorm.DormEntityManager.PlayEffect(arg_48_0.lastSelect, "root", var_0_1.itemNotMatch, 0.6)
			Dorm.DormEntityManager.PlayEffect(arg_48_1, "root", var_0_1.itemNotMatch, 0.6)
			arg_48_0:SetItemHighlight(arg_48_0.lastSelect, false)
			arg_48_0:PlaySoundEffect(var_0_3.ItemNotMatch)
		end

		arg_48_0.lastSelect = nil
	end
end

local var_0_24 = Vector3(0, 0.25, 0)

function var_0_0.ShowConnectLine(arg_49_0, arg_49_1, arg_49_2, arg_49_3)
	if arg_49_1.ignoreConnectivity then
		return
	else
		local var_49_0 = {}

		table.insert(var_49_0, arg_49_0:GridCoordToPos(arg_49_2) + var_0_24)

		for iter_49_0, iter_49_1 in ipairs(arg_49_1) do
			table.insert(var_49_0, arg_49_0:GridCoordToPos(iter_49_1) + var_0_24)
		end

		table.insert(var_49_0, arg_49_0:GridCoordToPos(arg_49_3) + var_0_24)
		Dorm.LuaBridge.MiniGameBridge.ShowConnectLine(var_49_0, 0.3)
	end
end

function var_0_0.OnConnectItemSuccess(arg_50_0, arg_50_1, arg_50_2, arg_50_3, arg_50_4, arg_50_5)
	local var_50_0 = arg_50_4.gridCoord
	local var_50_1 = arg_50_5.gridCoord

	arg_50_0:ShowConnectLine(arg_50_1, var_50_0, var_50_1)

	local var_50_2 = arg_50_4.itemID

	arg_50_0.itemGenDistribution:Return(var_50_2, 2)
	manager.notify:Invoke(LIANLIANKAN_ITEM_MATCH, var_50_2)
	Dorm.DormEntityManager.PlayEffectDetached(arg_50_2, "gua_fx", var_0_1.itemRemove, 0.5)
	Dorm.DormEntityManager.PlayEffectDetached(arg_50_3, "gua_fx", var_0_1.itemRemove, 0.5)
	arg_50_0:PlaySoundEffect(var_0_3.ItemMatch)
	arg_50_0.itemEntityManager:Remove(arg_50_4.idx)
	arg_50_0.itemEntityManager:Remove(arg_50_5.idx)
	arg_50_0:OnSpecialItemConnectProcessEffect(var_50_2)

	if arg_50_0.itemEntityManager.managedEntityNum == 0 then
		manager.notify:Invoke(LIANLIANKAN_GAME_CLEAR)
	elseif arg_50_0:Find() == nil then
		ShowTips("LIANLIANKAN_NO_SOLUTION_SHUFFLE")
		arg_50_0:Shuffle()
	else
		arg_50_0:SortItems()
	end
end

function var_0_0.ClearItemQueue(arg_51_0, arg_51_1)
	if arg_51_1 then
		arg_51_0:PrepareNextGenQueue()
	end

	if arg_51_0.previewEntityManager.managedEntityNum > 0 then
		Dorm.DormEntityManager.PlayEffectDetached(arg_51_0.chuansongdai, "gua_flush_fx", var_0_1.previewItemRemove, 1)
		arg_51_0:PlaySoundEffect(var_0_3.ItemPreviewClear)
	end

	arg_51_0.previewEntityManager:Clear()
end

local var_0_25 = {
	DormEnum.CharacterType.RestaurantCook,
	DormEnum.CharacterType.RestaurantCook,
	DormEnum.CharacterType.RestaurantWaiter
}

function var_0_0.GenItemOnStart(arg_52_0, arg_52_1)
	arg_52_0.itemGenDistribution = arg_52_0:PrepareGenDistribution(arg_52_1)

	arg_52_0:ClearItemQueue(true)
	arg_52_0.itemEntityManager:Clear()

	while arg_52_0.gridMap:HasGridEmpty(2) do
		local var_52_0 = arg_52_0.itemGenDistribution:Take(2)

		arg_52_0:Add2Item(var_52_0)
	end
end

local function var_0_26(arg_53_0)
	return nullable(BackHomeHeroSkinCfg, arg_53_0, "model") or nullable(BackHomeNpcCfg, arg_53_0, "model") or string.format("%d_tpose", arg_53_0)
end

function var_0_0.GenWorkerEntity(arg_54_0, arg_54_1)
	local var_54_0 = ActivityLinkGameCfg[arg_54_1]

	for iter_54_0, iter_54_1 in ipairs(var_0_25) do
		local var_54_1 = var_54_0.hero_id[iter_54_0]
		local var_54_2 = {
			complex = true,
			model = "CharDorm/" .. var_0_26(var_54_1),
			type = iter_54_1,
			spawnAt = arg_54_0.workerIdx[iter_54_1] or 1
		}
		local var_54_3 = {
			cfgID = var_54_1,
			heroID = var_54_1,
			skinID = var_54_1,
			style = nullable(BackHomeHeroSkinCfg, var_54_1, "style") or nullable(BackHomeNpcCfg, var_54_1, "style")
		}
		local var_54_4 = arg_54_0.workerEntityManager:Update(iter_54_0, var_54_2, var_54_3)
		local var_54_5 = LianLianKan.AI[iter_54_1]

		if var_54_5 then
			var_54_5.SetEntity(var_54_4, iter_54_0)
		end

		arg_54_0.workerIdx[iter_54_1] = var_54_2.spawnAt + 1
	end
end

function var_0_0.GenCustomerEntity(arg_55_0, arg_55_1)
	local var_55_0 = ActivityLinkGameCfg[arg_55_1]

	for iter_55_0, iter_55_1 in ipairs(var_55_0.customer_id) do
		local var_55_1 = DormEnum.CharacterType.RestaurantNormalCustomer
		local var_55_2 = arg_55_0.customerEntityManager:Update(iter_55_0, {
			complex = true,
			model = "CharDorm/" .. var_0_26(iter_55_1),
			type = var_55_1,
			spawnAt = iter_55_0
		}, {
			cfgID = iter_55_1
		})

		LianLianKan.AI[var_55_1].SetEntity(var_55_2, iter_55_0)
	end
end

function var_0_0.PrepareGenDistribution(arg_56_0, arg_56_1)
	local var_56_0 = ActivityLinkGameCfg[arg_56_1]
	local var_56_1 = arg_56_0.gridMap.width * arg_56_0.gridMap.height

	return LianLianKanItemGen.New(var_56_1, var_56_0.food_weight)
end

function var_0_0.ForwardToAI(arg_57_0, ...)
	for iter_57_0, iter_57_1 in pairs(LianLianKan.AI) do
		local var_57_0 = nullable(iter_57_1, "events", arg_57_0)

		if var_57_0 then
			var_57_0(...)
		end
	end
end

local function var_0_27(arg_58_0, arg_58_1)
	arg_58_1 = arg_58_1 or 1

	local var_58_0 = {}
	local var_58_1 = {}
	local var_58_2 = var_0_21(arg_58_0)

	for iter_58_0, iter_58_1 in ipairs(var_58_2) do
		local var_58_3 = {}

		for iter_58_2, iter_58_3 in Dorm.storage:ForeachData(arg_58_0.ItemEidNameSpace(iter_58_1), pairs) do
			table.insert(var_58_3, iter_58_3)
		end

		var_58_1[iter_58_1] = var_58_3
	end

	while arg_58_1 > 0 and #var_58_2 > 0 do
		local var_58_4 = table.remove(var_58_2, 1)
		local var_58_5 = var_58_1[var_58_4]

		if #var_58_5 >= 2 then
			arg_58_1 = arg_58_1 - 1

			local var_58_6 = table.remove(var_58_5)
			local var_58_7 = table.remove(var_58_5)

			table.insert(var_58_0, {
				eid1 = var_58_6,
				eid2 = var_58_7
			})

			if #var_58_5 >= 2 then
				table.insert(var_58_2, var_58_4)
			end
		end
	end

	return var_58_0
end

local function var_0_28(arg_59_0)
	return arg_59_0 == nil
end

local function var_0_29(arg_60_0)
	if var_0_28(arg_60_0) then
		return true
	elseif not arg_60_0.isPlaceholder then
		return true
	end

	return false
end

local function var_0_30(arg_61_0, arg_61_1)
	for iter_61_0, iter_61_1 in ipairs(arg_61_0) do
		local var_61_0 = iter_61_1.eid1
		local var_61_1 = iter_61_1.eid2

		if var_61_0 == arg_61_1 then
			return true
		elseif var_61_1 == arg_61_1 then
			return true
		end
	end

	return false
end

function var_0_0.EnsureSolution(arg_62_0, arg_62_1)
	local var_62_0 = var_0_27(arg_62_0, arg_62_1)
	local var_62_1 = {
		Color.New(1, 0, 0, 1),
		Color.New(1, 1, 0, 1),
		Color.New(0, 1, 0, 1),
		Color.New(0, 1, 1, 1),
		Color.New(0, 0, 1, 1),
		Color.New(1, 0, 1, 1)
	}

	for iter_62_0, iter_62_1 in ipairs(var_62_0) do
		local var_62_2 = iter_62_1.eid1
		local var_62_3 = iter_62_1.eid2
		local var_62_4 = DormUtils.GetEntityData(var_62_2)
		local var_62_5 = DormUtils.GetEntityData(var_62_3)
		local var_62_6 = var_0_13(arg_62_0.gridMap, var_62_4.gridCoord, arg_62_0.turn, function(arg_63_0)
			if var_0_28(arg_63_0) then
				return true
			elseif arg_63_0.isPlaceholder then
				return false
			else
				local var_63_0 = arg_63_0.gridCoord
				local var_63_1 = arg_62_0:QueryEntityID(var_63_0.x, var_63_0.y)

				if var_0_30(var_62_0, var_63_1) then
					return false
				else
					return true
				end
			end

			return false
		end)

		if var_62_6 then
			LuaForUtil.DebugDrawLine(arg_62_0:GridCoordToPos(var_62_6), arg_62_0:GridCoordToPos(var_62_4.gridCoord), var_62_1[iter_62_0 % #var_62_1 + 1], 5, false)

			iter_62_1.eid2 = arg_62_0:SwapItemToPos(var_62_5, var_62_6)
		end
	end
end

return var_0_0
