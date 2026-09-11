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
local var_0_6 = "Dorm/Dormitory/HZ07_item_preview"
local var_0_7 = "Dorm/Food/120"

local function var_0_8(arg_1_0)
	return arg_1_0.model
end

local function var_0_9(arg_2_0)
	if arg_2_0.type ~= nil then
		local var_2_0 = Dorm.storage:GetData("lianliankan.pos." .. arg_2_0.type, "#") or 0

		if var_2_0 ~= 0 then
			local var_2_2 = Dorm.storage:GetData("lianliankan.pos." .. arg_2_0.type, ((arg_2_0.spawnAt or 1) - 1) % var_2_0 + 1)

			var_2_2 = var_2_2 or Dorm.storage:PickData("lianliankan.pos." .. arg_2_0.type)

			return nullable(var_2_2, "transform")
		end
	end
end

local function var_0_10(arg_3_0)
	for iter_3_0 = #arg_3_0, 2, -1 do
		local var_3_0 = math.random(iter_3_0)

		arg_3_0[iter_3_0], arg_3_0[var_3_0] = arg_3_0[var_3_0], arg_3_0[iter_3_0]
	end
end

function var_0_0:Ctor()
	self.workerIdx = {}
	self.previewItemQueueCap = 10
	self.entityManagers = {}

	local var_4_0 = EntityManager.CreateModel.New(var_0_8, var_0_9)

	self.placeholderEntityManager = EntityManager.New(var_4_0)
	self.itemEntityManager = EntityManager.New(var_4_0)
	self.customerFoodEntityManager = EntityManager.New(var_4_0)
	self.previewEntityManager = EntityManager.New((EntityManager.CreateModel.New(var_0_8, var_0_9, 0.4)))
	self.customerEntityManager = EntityManager.New(var_4_0)
	self.workerEntityManager = EntityManager.New(var_4_0)

	table.insert(self.entityManagers, self.placeholderEntityManager)
	table.insert(self.entityManagers, self.itemEntityManager)
	table.insert(self.entityManagers, self.customerFoodEntityManager)
	table.insert(self.entityManagers, self.previewEntityManager)
	table.insert(self.entityManagers, self.customerEntityManager)
	table.insert(self.entityManagers, self.workerEntityManager)

	self.itemEntityManager.OnCreate = handler(self, self.OnItemCreate)
	self.itemEntityManager.OnRemove = handler(self, self.OnItemRemoved)

	function self.customerFoodEntityManager.OnCreate(arg_5_0)
		DormCharacterActionManager.taskRunner:NewTask():WaitForSec(5):Then(function()
			self.customerFoodEntityManager:Remove(arg_5_0)
		end):Start()
	end

	function self.previewEntityManager.OnCreate(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
		Dorm.DormEntityManager.SetEntitySpeed(arg_7_1, 0.5)
		DormUtils.MoveByPath(arg_7_1, Dorm.storage:GetData("lianliankan.path.preview", arg_7_0), true)
		Dorm.LuaBridge.MiniGameBridge.SetupItemSprite(arg_7_1, ActivityLinkGameCellCfg[arg_7_3.itemID].path .. "/" .. ActivityLinkGameCellCfg[arg_7_3.itemID].album_id)
	end

	function self.customerEntityManager.OnCreate(arg_8_0, arg_8_1)
		Dorm.DormEntityManager.ChangeEntityAnimeScheme(arg_8_1, "sit")
	end

	self.listener = EventListener.New()
	self.turn = 2
end

var_0_0.ItemQueueNamespace = "lianliankan.itemQueue"

function var_0_0:RegForwardAIEvent(arg_9_1, arg_9_2)
	self.listener:Register(arg_9_1, function(...)
		self.ForwardToAI(arg_9_1, ...)

		if arg_9_2 then
			arg_9_2(...)
		end
	end)
end

function var_0_0:Init(arg_11_1)
	self.level = arg_11_1
	self.gridMap = GridMap.New(8, 7)

	self:RegisterEvents()

	self.preparedSortInfo = nil
	self.gridCoordOrigin = Dorm.storage:PickData("lianliankan.pos.origin").transform
	self.items = {}

	for iter_11_0, iter_11_1 in Dorm.storage:ForeachData("lianliankan.pos.Pan", pairs) do
		local var_11_0 = Dorm.DormEntityManager.Instance:MakeModelEntity(iter_11_1.transform)

		table.insert(self.items, var_11_0)
		Dorm.storage:RecordData(var_0_0.ItemEidNameSpace(DormEnum.ItemType.Pan), iter_11_0, var_11_0)
	end

	local var_11_1 = Dorm.DormEntityManager.Instance:MakeModelEntity(Dorm.storage:PickData("lianliankan.pos.chuansongdai").transform)

	table.insert(self.items, var_11_1)

	self.chuansongdai = var_11_1

	self.previewEntityManager:MapToDormStorageData(self.ItemQueueNamespace, nil)
	self.customerEntityManager:MapToDormStorageData(DormUtils.EIdNamespace(DormEnum.CharacterType.RestaurantNormalCustomer), nil)

	self.workerIdx = {}

	self:GenWorkerEntity(arg_11_1)
	self:GenCustomerEntity(arg_11_1)
	self.placeholderEntityManager:Clear()

	if ActivityLinkGameCfg[arg_11_1].blank_pos and ActivityLinkGameCfg[arg_11_1].blank_pos ~= "" then
		for iter_11_2, iter_11_3 in ipairs(ActivityLinkGameCfg[arg_11_1].blank_pos) do
			self:AddPlaceHolder((Vector2(unpack(iter_11_3))))
		end
	end

	if ActivityLinkGameCfg[arg_11_1].obstacle_pos and ActivityLinkGameCfg[arg_11_1].obstacle_pos ~= "" then
		for iter_11_4, iter_11_5 in ipairs(ActivityLinkGameCfg[arg_11_1].obstacle_pos) do
			self:AddObstacle((Vector2(unpack(iter_11_5))))
		end
	end
end

function var_0_0:Reset()
	manager.audio:StopAll()

	self.workerIdx = nil
	self.lastSelect = nil
	self.itemGenDistribution = nil

	for iter_12_0, iter_12_1 in pairs(self.items) do
		Dorm.DormEntityManager.Instance:RemoveEntity(iter_12_1)
	end

	self.items = nil
	self.chuansongdai = nil

	LianLianKan.AI[DormEnum.CharacterType.RestaurantNormalCustomer].Clear()
	LianLianKan.AI[DormEnum.CharacterType.RestaurantCook].Clear()
	Dorm.storage:ClearData(var_0_0.ItemEidNameSpace(DormEnum.ItemType.Pan))

	for iter_12_2, iter_12_3 in ipairs(self.entityManagers) do
		iter_12_3:Clear()
	end

	self.listener:RemoveAll()

	self.preparedSortInfo = nil
end

function var_0_0:Start()
	self:GenItemOnStart(self.level)
end

function var_0_0:ResetCurLevel()
	manager.audio:StopAll()

	self.lastSelect = nil

	self.previewEntityManager:Clear()
	self.itemEntityManager:Clear()

	self.workerIdx = {}

	self:GenWorkerEntity(self.level)
	self:GenCustomerEntity(self.level)
end

function var_0_0:RegisterEvents()
	self.listener:Register(DORM_CLICK_ENTITY, handler(self, self.OnClickEntity))
	self.listener:Register(LIANLIANKAN_PREVIEW_APPEAR, handler(self, self.OnPreviewItemCreate))
	self.listener:Register(LIANLIANKAN_AUTO_MATCH, handler(self, self.AutoMatch))
	self.listener:Register(LIANLIANKAN_BUFF_IGNORE_CONNECTION, handler(self, self.OnBuffIgnoreConnection))
	self.listener:Register(LIANLIANKAN_SHUFFLE, handler(self, self.Shuffle))
	self.listener:Register(LIANLIANKAN_GAME_START, handler(self, self.Start))
	self.listener:Register(LIANLIANKAN_GAME_RESET, handler(self, self.ResetCurLevel))
	self.listener:Register(LIANLIANKAN_PREVIEW_REMOVE_ALL, handler(self, self.ClearItemQueue))
	self:RegForwardAIEvent(ON_DORM_CHARACTER_WAIT_CMD)
	self:RegForwardAIEvent(ON_DORM_CHARACTER_INTERACT)
	self:RegForwardAIEvent(LIANLIANKAN_USE_ITEM)
	self:RegForwardAIEvent(LIANLIANKAN_ITEM_OVERFLOW)
	self:RegForwardAIEvent(LIANLIANKAN_CUSTOMER_EAT, handler(self, self.GenFoodForCustomer))
	self:RegForwardAIEvent(LIANLIANKAN_FREEZE, handler(self, self.Freeze))
end

function var_0_0.PlaySoundEffect(arg_16_0, arg_16_1)
	manager.audio:PlayEffect(var_0_2, arg_16_1)
end

local function var_0_11(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
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

		return ((arg_17_2.isPlaceholder or nil) and (arg_17_0.placeholderEntityManager or arg_17_0.itemEntityManager)):Update(var_17_0, arg_17_1, arg_17_2), var_17_0
	end
end

function var_0_0:AddPlaceHolder(arg_18_1)
	local var_18_0, var_18_1 = var_0_11(self, {
		model = var_0_5
	}, {
		itemID = "placeholder",
		passThroughConnect = true,
		isPlaceholder = true
	}, arg_18_1)

	Dorm.DormEntityManager.PutEntityLookToDir(var_18_0, self:GridCoordToPos(Vector2(self.gridMap:ToCoord(var_18_1))), Vector3.forward)
end

function var_0_0:AddObstacle(arg_19_1)
	local var_19_0, var_19_1 = var_0_11(self, {
		model = var_0_4
	}, {
		itemID = "obstacle",
		passThroughConnect = false,
		isPlaceholder = true
	}, arg_19_1)

	Dorm.DormEntityManager.PutEntityLookToDir(var_19_0, self:GridCoordToPos(Vector2(self.gridMap:ToCoord(var_19_1))), Vector3.forward)
end

local function var_0_12(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
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
		local var_20_3 = var_20_2[3] or 0

		for iter_20_0, iter_20_1 in pairs(var_20_0) do
			if not (var_20_2[2] and var_20_2[2] ~= iter_20_1 and var_20_2[2] + iter_20_1 ~= Vector2.zero) or var_20_3 >= arg_20_2 then
				local var_20_4 = var_20_2[1] + iter_20_1

				if arg_20_0:IsGridInMap((var_20_2[1] + iter_20_1).x, (var_20_2[1] + iter_20_1).y) then
					local var_20_5 = arg_20_0:Get(var_20_4.x, var_20_4.y)

					if arg_20_3(var_20_5) then
						return var_20_4
					elseif var_20_5.passThroughConnect then
						local var_20_6 = {
							var_20_4,
							iter_20_1
						}

						if var_20_2[2] and var_20_2[2] ~= iter_20_1 and var_20_2[2] + iter_20_1 ~= Vector2.zero then
							var_20_6[3] = var_20_3 + 1 or var_20_3
						end

						table.insert(var_20_1, var_20_6)
					end
				end
			end
		end
	end
end

local var_0_13 = {
	pooled = true,
	model = "Dorm/Dormitory/HZ07_lianliankan_gezi"
}
local var_0_14 = {
	pooled = true,
	ignoreCreateVfx = true,
	model = "Dorm/Dormitory/HZ07_lianliankan_gezi"
}

function var_0_0.Add2Item(arg_21_0, arg_21_1)
	return var_0_11(arg_21_0, var_0_13, {
		itemID = arg_21_1
	}), (var_0_11(arg_21_0, var_0_13, {
		itemID = arg_21_1
	}, nil))
end

function var_0_0:OnPreviewItemCreate()
	if self.previewEntityManager.managedEntityNum >= self.previewItemQueueCap then
		self:FlushPreviewItem()

		if self:Find() == nil then
			ShowTips("LIANLIANKAN_NO_SOLUTION_SHUFFLE")
			self:Shuffle()
		end
	end

	self:GenPreviewItem()
end

function var_0_0:FlushPreviewItem()
	while self.gridMap:HasGridEmpty(2) and #self.itemQueue > 0 do
		local var_23_0 = table.remove(self.itemQueue, 1)

		self.itemGenDistribution:Pop(var_23_0, 2)
		self:Add2Item(var_23_0)
	end

	self:SortItems()
	self:ClearItemQueue(true)

	if #self.itemQueue > 0 then
		manager.notify:Invoke(LIANLIANKAN_ITEM_OVERFLOW, self.itemQueue)
	end
end

local function var_0_15(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_1.x
	local var_24_1 = arg_24_1.y

	while arg_24_0:IsGridInMap(arg_24_1.x + arg_24_2.x, arg_24_1.y + arg_24_2.y) do
		local var_24_2, var_24_3

		if arg_24_0:IsGridEmpty(arg_24_1.x + arg_24_2.x, arg_24_1.y + arg_24_2.y) then
			var_24_1 = arg_24_1.y + arg_24_2.y
			var_24_0 = arg_24_1.x + arg_24_2.x
			var_24_2 = arg_24_1.y + arg_24_2.y + arg_24_2.y
			var_24_3 = arg_24_1.x + arg_24_2.x + arg_24_2.x
		else
			break
		end
	end

	return Vector2(var_24_0, var_24_1)
end

local var_0_16 = {
	step = 0,
	sortedGrids = {}
}

local function var_0_17(arg_25_0)
	local var_25_1 = {}

	for iter_25_0 = 0, arg_25_0.width - 1 do
		for iter_25_1 = 0, arg_25_0.height - 1 do
			table.insert(var_25_1, Vector2(iter_25_0, iter_25_1))
		end
	end

	return var_25_1
end

function var_0_0:SortItems()
	local var_26_0
	local var_26_1

	if self.preparedSortInfo == nil then
		local var_26_2 = ActivityLinkGameCfg[self.level].sort_func or 0

		if var_26_2 == 0 then
			self.preparedSortInfo = var_0_16

			return
		end

		var_26_0 = var_26_2 == 1 and Vector2(-1, 0) or var_26_2 == 2 and Vector2(1, 0) or var_26_2 == 3 and Vector2(0, -1) or Vector2(0, 1)
		var_26_1 = var_0_17(self.gridMap)

		CommonTools.UniversalSortEx(var_26_1, {
			map = function(arg_27_0)
				return Vector2.Dot(arg_27_0, var_26_0)
			end
		})

		self.preparedSortInfo = {
			step = var_26_0,
			sortedGrids = var_26_1
		}
	else
		var_26_0 = self.preparedSortInfo.step or Vector2.right
		var_26_1 = self.preparedSortInfo.sortedGrids or {}
	end

	for iter_26_0, iter_26_1 in pairs(var_26_1) do
		local var_26_3 = self:QueryEntityID(iter_26_1.x, iter_26_1.y)

		if var_26_3 then
			local var_26_4 = DormUtils.GetEntityData(var_26_3)

			self:SwapItemToPos(var_26_4, (var_0_15(self.gridMap, var_26_4.gridCoord, var_26_0)))
		end
	end
end

function var_0_0:PrepareNextGenQueue()
	self.itemQueue = self.itemGenDistribution:Peek(self.previewItemQueueCap, 2)
end

function var_0_0:GenFoodForCustomer(arg_29_1)
	if self.customerFoodEntityManager:GetEntityID(arg_29_1) == nil then
		self.customerFoodEntityManager:Create(arg_29_1, {
			pooled = true,
			model = var_0_7,
			type = DormEnum.ItemType.Food,
			spawnAt = arg_29_1
		})
	end
end

function var_0_0:GenPreviewItem()
	self.previewEntityManager:Update(self.previewEntityManager.managedEntityNum + 1, {
		complex = true,
		pooled = true,
		model = var_0_6
	}, {
		itemID = self.itemQueue[self.previewEntityManager.managedEntityNum + 1]
	})
end

local var_0_18 = 1

function var_0_0:GridCoordToPos(arg_31_1)
	return self.gridCoordOrigin.position - Vector3(arg_31_1.x - 0.5 * self.gridMap.width, 0, arg_31_1.y - 0.5 * self.gridMap.height) * (var_0_18 * 0.5) - Vector3(var_0_18 * 0.5 * 0.5, 0, var_0_18 * 0.5 * 0.5)
end

function var_0_0.ItemEidNameSpace(arg_32_0)
	return "lianliankan.item." .. arg_32_0 .. ".eid"
end

function var_0_0.PlayItemCreateVfx(arg_33_0, arg_33_1)
	Dorm.DormEntityManager.PlayEffectDetached(arg_33_1, "root", var_0_1.itemEnter, 0.7)
end

function var_0_0:OnItemCreate(arg_34_1, arg_34_2, arg_34_3, arg_34_4)
	Dorm.storage:RecordData(var_0_0.ItemEidNameSpace(arg_34_4.itemID), arg_34_1, arg_34_2)
	Dorm.LuaBridge.MiniGameBridge.SetupClickTriggerForEntity(arg_34_2, var_0_18)
	Dorm.LuaBridge.MiniGameBridge.SetupItemSprite(arg_34_2, ActivityLinkGameCellCfg[arg_34_4.itemID].path .. "/" .. ActivityLinkGameCellCfg[arg_34_4.itemID].album_id)
	self:SetItemHighlight(arg_34_2, false)
	Dorm.DormEntityManager.PutEntityLookToDir(arg_34_2, self:GridCoordToPos(arg_34_4.gridCoord), Vector3.forward)

	if not arg_34_3.ignoreCreateVfx then
		self:PlayItemCreateVfx(arg_34_2)
	end
end

function var_0_0:OnItemRemoved(arg_35_1, arg_35_2)
	Dorm.LuaBridge.MiniGameBridge.MuteClickTriggerForEntity(arg_35_2)
	Dorm.storage:RecordData(var_0_0.ItemEidNameSpace(DormUtils.GetEntityData(arg_35_2).itemID), arg_35_1, nil)
	self.gridMap:RemoveByIdx(arg_35_1)
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

function var_0_0:SwapItemToPos(arg_37_1, arg_37_2)
	if arg_37_1.gridCoord == arg_37_2 then
		return
	end

	local var_37_0

	if not self.gridMap:IsGridEmpty(arg_37_2.x, arg_37_2.y) then
		local var_37_1 = self.gridMap:Get(arg_37_2.x, arg_37_2.y)

		var_37_0 = var_37_1.itemID

		if arg_37_1.itemID == var_37_1.itemID then
			return
		end

		self.itemEntityManager:Remove(var_37_1.idx)
	end

	self.itemEntityManager:Remove(arg_37_1.idx)

	return var_0_11(self, var_0_14, {
		itemID = arg_37_1.itemID
	}, arg_37_2), (var_37_0 or nil) and var_0_11(self, var_0_14, {
		itemID = var_37_0
	}, arg_37_1.gridCoord)
end

local var_0_19 = {
	FREEZE_CELL = 1020,
	SHUFFLE_CELL = 1019
}

local function var_0_20(arg_38_0)
	local var_38_0 = {}

	for iter_38_0, iter_38_1 in pairs(arg_38_0.itemGenDistribution.weights) do
		table.insert(var_38_0, iter_38_0)
	end

	var_0_10(var_38_0)

	for iter_38_2, iter_38_3 in pairs(var_0_19) do
		table.insert(var_38_0, iter_38_3)
	end

	return var_38_0
end

local var_0_21 = 2

function var_0_0:OnSpecialItemConnectProcessEffect(arg_39_1)
	if arg_39_1 == var_0_19.SHUFFLE_CELL then
		manager.audio:PlayEffect("minigame_activity_5_0", "minigame_activity_5_0_connect_refresh")
		self:Shuffle(3)
	elseif arg_39_1 == var_0_19.FREEZE_CELL then
		self:Freeze(ActivityLinkGameGoodsCfg[var_0_21].extra_param[1])
	end
end

function var_0_0:Find()
	for iter_40_0, iter_40_1 in ipairs(var_0_20(self)) do
		local var_40_0 = {}

		for iter_40_2, iter_40_3 in Dorm.storage:ForeachData(self.ItemEidNameSpace(iter_40_1), pairs) do
			table.insert(var_40_0, iter_40_3)
		end

		for iter_40_4 = 1, #var_40_0 - 1 do
			for iter_40_5 = iter_40_4 + 1, #var_40_0 do
				local var_40_1 = DormUtils.GetEntityData(var_40_0[iter_40_4]).gridCoord
				local var_40_2 = DormUtils.GetEntityData(var_40_0[iter_40_5]).gridCoord
				local var_40_3 = self:TestConnectivity(var_40_1, var_40_2)

				if var_40_3 then
					return var_40_3, var_40_1, var_40_2
				end
			end
		end
	end

	return nil
end

function var_0_0:ClearSelect()
	if self.lastSelect and Dorm.DormEntityManager.IsValidEntityID(self.lastSelect) then
		self:SetItemHighlight(self.lastSelect, false)
	end

	self.lastSelect = nil
end

function var_0_0:Shuffle(arg_42_1)
	self:ClearSelect()

	local var_42_0 = {}

	for iter_42_0, iter_42_1 in pairs(self.itemEntityManager.managed) do
		local var_42_1 = DormUtils.GetEntityData(iter_42_1)

		var_42_0[var_42_1.itemID] = (var_42_0[var_42_1.itemID] or 0) + 1
	end

	for iter_42_2, iter_42_3 in pairs(var_42_0) do
		-- block empty
	end

	self.itemEntityManager:Clear()

	while next(var_42_0) do
		for iter_42_4, iter_42_5 in pairs(var_42_0) do
			self:Add2Item(iter_42_4)

			var_42_0[iter_42_4] = iter_42_5 > 2 and iter_42_5 - 2 or nil
		end
	end

	self:SortItems()
	self:EnsureSolution(arg_42_1)
end

function var_0_0:QueryEntityID(arg_43_1, arg_43_2)
	return self.itemEntityManager:GetEntityID((self.gridMap:ToIdx(arg_43_1, arg_43_2)))
end

function var_0_0:AutoMatch(arg_44_1)
	for iter_44_0 = 1, arg_44_1 do
		if self.itemEntityManager.managedEntityNum == 0 then
			return
		end

		local var_44_0, var_44_1, var_44_2 = self:Find()

		if var_44_0 then
			self:OnConnectItemSuccess(var_44_0, self:QueryEntityID(var_44_1.x, var_44_1.y), self:QueryEntityID(var_44_2.x, var_44_2.y), self.gridMap:Get(var_44_1.x, var_44_1.y), (self.gridMap:Get(var_44_2.x, var_44_2.y)))
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

local var_0_22 = {
	ignoreConnectivity = true
}

function var_0_0:TestConnectivity(arg_47_1, arg_47_2)
	if DormLinkGameData:GetGameBuffIgnoreConnectCheck() then
		return var_0_22
	end

	return LianLianKanUtil.TestConnectivity(self.gridMap, arg_47_1.x, arg_47_1.y, arg_47_2.x, arg_47_2.y, self.turn)
end

function var_0_0:OnClickEntity(arg_48_1)
	if self.lastSelect == nil or not Dorm.DormEntityManager.IsValidEntityID(self.lastSelect) then
		self:SetItemHighlight(arg_48_1, true)

		self.lastSelect = arg_48_1

		self:PlaySoundEffect(var_0_3.Select)
	elseif arg_48_1 == self.lastSelect then
		self:SetItemHighlight(arg_48_1, false)

		self.lastSelect = nil

		self:PlaySoundEffect(var_0_3.CancelSelect)
	else
		local var_48_0 = DormUtils.GetEntityData(self.lastSelect)
		local var_48_1 = DormUtils.GetEntityData(arg_48_1)
		local var_48_2

		if var_48_0.itemID == var_48_1.itemID then
			var_48_2 = self:TestConnectivity(var_48_0.gridCoord, var_48_1.gridCoord)
		end

		if var_48_2 then
			self:OnConnectItemSuccess(var_48_2, self.lastSelect, arg_48_1, var_48_0, var_48_1)
		else
			Dorm.DormEntityManager.PlayEffect(self.lastSelect, "root", var_0_1.itemNotMatch, 0.6)
			Dorm.DormEntityManager.PlayEffect(arg_48_1, "root", var_0_1.itemNotMatch, 0.6)
			self:SetItemHighlight(self.lastSelect, false)
			self:PlaySoundEffect(var_0_3.ItemNotMatch)
		end

		self.lastSelect = nil
	end
end

local var_0_23 = Vector3(0, 0.25, 0)

function var_0_0:ShowConnectLine(arg_49_1, arg_49_2, arg_49_3)
	if arg_49_1.ignoreConnectivity then
		return
	else
		local var_49_0 = {}

		table.insert(var_49_0, self:GridCoordToPos(arg_49_2) + var_0_23)

		for iter_49_0, iter_49_1 in ipairs(arg_49_1) do
			table.insert(var_49_0, self:GridCoordToPos(iter_49_1) + var_0_23)
		end

		table.insert(var_49_0, self:GridCoordToPos(arg_49_3) + var_0_23)
		Dorm.LuaBridge.MiniGameBridge.ShowConnectLine(var_49_0, 0.3)
	end
end

function var_0_0:OnConnectItemSuccess(arg_50_1, arg_50_2, arg_50_3, arg_50_4, arg_50_5)
	self:ShowConnectLine(arg_50_1, arg_50_4.gridCoord, arg_50_5.gridCoord)
	self.itemGenDistribution:Return(arg_50_4.itemID, 2)
	manager.notify:Invoke(LIANLIANKAN_ITEM_MATCH, arg_50_4.itemID)
	Dorm.DormEntityManager.PlayEffectDetached(arg_50_2, "gua_fx", var_0_1.itemRemove, 0.5)
	Dorm.DormEntityManager.PlayEffectDetached(arg_50_3, "gua_fx", var_0_1.itemRemove, 0.5)
	self:PlaySoundEffect(var_0_3.ItemMatch)
	self.itemEntityManager:Remove(arg_50_4.idx)
	self.itemEntityManager:Remove(arg_50_5.idx)
	self:OnSpecialItemConnectProcessEffect(arg_50_4.itemID)

	if self.itemEntityManager.managedEntityNum == 0 then
		manager.notify:Invoke(LIANLIANKAN_GAME_CLEAR)
	elseif self:Find() == nil then
		ShowTips("LIANLIANKAN_NO_SOLUTION_SHUFFLE")
		self:Shuffle()
	else
		self:SortItems()
	end
end

function var_0_0:ClearItemQueue(arg_51_1)
	if arg_51_1 then
		self:PrepareNextGenQueue()
	end

	if self.previewEntityManager.managedEntityNum > 0 then
		Dorm.DormEntityManager.PlayEffectDetached(self.chuansongdai, "gua_flush_fx", var_0_1.previewItemRemove, 1)
		self:PlaySoundEffect(var_0_3.ItemPreviewClear)
	end

	self.previewEntityManager:Clear()
end

local var_0_24 = {
	DormEnum.CharacterType.RestaurantCook,
	DormEnum.CharacterType.RestaurantCook,
	DormEnum.CharacterType.RestaurantWaiter
}

function var_0_0:GenItemOnStart(arg_52_1)
	self.itemGenDistribution = self:PrepareGenDistribution(arg_52_1)

	self:ClearItemQueue(true)
	self.itemEntityManager:Clear()

	while self.gridMap:HasGridEmpty(2) do
		self:Add2Item((self.itemGenDistribution:Take(2)))
	end
end

local function var_0_25(arg_53_0)
	return nullable(BackHomeHeroSkinCfg, arg_53_0, "model") or nullable(BackHomeNpcCfg, arg_53_0, "model") or string.format("%d_tpose", arg_53_0)
end

function var_0_0:GenWorkerEntity(arg_54_1)
	for iter_54_0, iter_54_1 in ipairs(var_0_24) do
		local var_54_0 = {
			complex = true,
			model = "CharDorm/" .. var_0_25(ActivityLinkGameCfg[arg_54_1].hero_id[iter_54_0]),
			type = iter_54_1
		}

		var_54_0.spawnAt = self.workerIdx[iter_54_1] or 1

		local var_54_1 = {
			cfgID = ActivityLinkGameCfg[arg_54_1].hero_id[iter_54_0],
			heroID = ActivityLinkGameCfg[arg_54_1].hero_id[iter_54_0],
			skinID = ActivityLinkGameCfg[arg_54_1].hero_id[iter_54_0]
		}

		var_54_1.style = nullable(BackHomeHeroSkinCfg, ActivityLinkGameCfg[arg_54_1].hero_id[iter_54_0], "style") or nullable(BackHomeNpcCfg, ActivityLinkGameCfg[arg_54_1].hero_id[iter_54_0], "style")

		if LianLianKan.AI[iter_54_1] then
			LianLianKan.AI[iter_54_1].SetEntity(self.workerEntityManager:Update(iter_54_0, var_54_0, var_54_1), iter_54_0)
		end

		self.workerIdx[iter_54_1] = var_54_0.spawnAt + 1
	end
end

function var_0_0:GenCustomerEntity(arg_55_1)
	for iter_55_0, iter_55_1 in ipairs(ActivityLinkGameCfg[arg_55_1].customer_id) do
		LianLianKan.AI[DormEnum.CharacterType.RestaurantNormalCustomer].SetEntity(self.customerEntityManager:Update(iter_55_0, {
			complex = true,
			model = "CharDorm/" .. var_0_25(iter_55_1),
			type = DormEnum.CharacterType.RestaurantNormalCustomer,
			spawnAt = iter_55_0
		}, {
			cfgID = iter_55_1
		}), iter_55_0)
	end
end

function var_0_0:PrepareGenDistribution(arg_56_1)
	return LianLianKanItemGen.New(self.gridMap.width * self.gridMap.height, ActivityLinkGameCfg[arg_56_1].food_weight)
end

function var_0_0.ForwardToAI(arg_57_0, ...)
	for iter_57_0, iter_57_1 in pairs(LianLianKan.AI) do
		local var_57_0 = nullable(iter_57_1, "events", arg_57_0)

		if var_57_0 then
			var_57_0(...)
		end
	end
end

local function var_0_26(arg_58_0, arg_58_1)
	arg_58_1 = arg_58_1 or 1

	local var_58_0 = {}
	local var_58_1 = {}
	local var_58_2 = var_0_20(arg_58_0)

	for iter_58_0, iter_58_1 in ipairs(var_58_2) do
		local var_58_3 = {}

		for iter_58_2, iter_58_3 in Dorm.storage:ForeachData(arg_58_0.ItemEidNameSpace(iter_58_1), pairs) do
			table.insert(var_58_3, iter_58_3)
		end

		var_58_1[iter_58_1] = var_58_3
	end

	while arg_58_1 > 0 and #var_58_2 > 0 do
		local var_58_4 = table.remove(var_58_2, 1)

		if #var_58_1[var_58_4] >= 2 then
			arg_58_1 = arg_58_1 - 1

			table.insert(var_58_0, {
				eid1 = table.remove(var_58_1[var_58_4]),
				eid2 = table.remove(var_58_1[var_58_4])
			})

			if #var_58_1[var_58_4] >= 2 then
				table.insert(var_58_2, var_58_4)
			end
		end
	end

	return var_58_0
end

local function var_0_27(arg_59_0)
	return arg_59_0 == nil
end

local function var_0_29(arg_61_0, arg_61_1)
	for iter_61_0, iter_61_1 in ipairs(arg_61_0) do
		if iter_61_1.eid1 == arg_61_1 then
			return true
		elseif iter_61_1.eid2 == arg_61_1 then
			return true
		end
	end

	return false
end

function var_0_0:EnsureSolution(arg_62_1)
	local var_62_0 = var_0_26(self, arg_62_1)
	local var_62_1 = {
		Color.New(1, 0, 0, 1),
		Color.New(1, 1, 0, 1),
		Color.New(0, 1, 0, 1),
		Color.New(0, 1, 1, 1),
		Color.New(0, 0, 1, 1),
		Color.New(1, 0, 1, 1)
	}

	for iter_62_0, iter_62_1 in ipairs(var_62_0) do
		local var_62_2 = DormUtils.GetEntityData(iter_62_1.eid1)
		local var_62_3 = DormUtils.GetEntityData(iter_62_1.eid2)
		local var_62_4 = var_0_12(self.gridMap, var_62_2.gridCoord, self.turn, function(arg_63_0)
			if var_0_27(arg_63_0) then
				return true
			elseif arg_63_0.isPlaceholder then
				return false
			elseif var_0_29(var_62_0, (self:QueryEntityID(arg_63_0.gridCoord.x, arg_63_0.gridCoord.y))) then
				return false
			else
				return true
			end

			return false
		end)

		if var_62_4 then
			LuaForUtil.DebugDrawLine(self:GridCoordToPos(var_62_4), self:GridCoordToPos(var_62_2.gridCoord), var_62_1[iter_62_0 % #var_62_1 + 1], 5, false)

			iter_62_1.eid2 = self:SwapItemToPos(var_62_3, var_62_4)
		end
	end
end

return var_0_0
