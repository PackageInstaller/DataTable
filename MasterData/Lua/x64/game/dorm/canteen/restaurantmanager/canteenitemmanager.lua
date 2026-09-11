local function var_0_0(arg_1_0)
	return Dorm.storage:GetData(DormEnum.Namespace.EntityData, arg_1_0)
end

local function var_0_1(arg_2_0)
	return arg_2_0.tag.transform
end

local function var_0_2(arg_3_0, arg_3_1)
	local var_3_0

	if CanteenItemCfg.get_id_list_by_combination[arg_3_0] then
		for iter_3_0, iter_3_1 in ipairs(CanteenItemCfg.get_id_list_by_combination[arg_3_0]) do
			if arg_3_1 >= CanteenItemCfg[iter_3_1].level then
				var_3_0 = iter_3_1
			else
				break
			end
		end
	end

	return var_3_0
end

local var_0_3 = "HZ04_placeholder"

local function var_0_4(arg_4_0)
	local var_4_1 = nullable(CanteenItemCfg, var_0_2(arg_4_0.type, arg_4_0.level or 0), "model")

	var_4_1 = var_4_1 or var_0_3

	if var_4_1 == "" then
		var_4_1 = var_0_3
	end

	return "Dorm/Restaurant/" .. var_4_1
end

local var_0_5 = CanteenManager.PosNamespace(DormEnum.Points.RestaurantFoodSpawn)

local function var_0_6()
	return Dorm.storage:RndPickData(var_0_5).transform
end

local function var_0_7(arg_6_0)
	return "Dorm/Food/" .. arg_6_0.prefab
end

local function var_0_8(arg_7_0, arg_7_1, arg_7_2)
	arg_7_2 = arg_7_2 or {}
	arg_7_2.available = true
	arg_7_2.type = DormEnum.EntityType.FoodItem

	return arg_7_2
end

local var_0_9 = singletonClass("DormItemManager")

function var_0_9:Ctor()
	self.listener = EventListener.New()
	self.staticItemEntityManager = EntityManager.New((EntityManager.AttachToModel.New(var_0_1)))
	self.itemEntityManager = EntityManager.New((EntityManager.CreateModel.New(var_0_4, var_0_1)))
	self.foodEntityManager = EntityManager.New(EntityManager.CreateModel.New(var_0_7, var_0_6, 1), var_0_8)

	local function var_8_0(arg_9_0, arg_9_1, arg_9_2)
		local var_9_0 = Dorm.storage:GetData(var_0_9.TypeNamespace, arg_9_0)

		self.RecordItemInfo(arg_9_0, arg_9_1, var_9_0)
		self.RecordInteractPoints(arg_9_0, arg_9_1, var_9_0)
	end

	self.staticItemEntityManager.OnCreate = var_8_0
	self.itemEntityManager.OnCreate = var_8_0

	function self.foodEntityManager.OnCreate(arg_10_0, arg_10_1, arg_10_2)
		Dorm.DormEntityManager.SetFadeCMD(arg_10_1, 1)
		self.RecordItemInfo(arg_10_0, arg_10_1, DormEnum.ItemType.Food)
	end

	self.staticItemEntityManager.OnRemove = self.RemoveItemInfo
	self.itemEntityManager.OnRemove = self.RemoveItemInfo

	function self.foodEntityManager.OnRemove(arg_11_0, arg_11_1, arg_11_2)
		Dorm.DormEntityManager.StartFadeOutCMD(arg_11_1, 1)
		self.RemoveItemInfo(arg_11_0, arg_11_1, arg_11_2)
	end
end

function var_0_9:Init()
	self:RegisterEvents()
	self:GenerateAllSceneItem()
	self.foodEntityManager:MapToDormStorageData(var_0_9.ItemEIdNamespace(DormEnum.ItemType.Food), var_0_9.ItemIdxNamespace(DormEnum.ItemType.Food))
end

function var_0_9:Reset()
	self.staticItemEntityManager:Clear()
	self.itemEntityManager:Clear()

	self.foodID = nil

	self.foodEntityManager:Clear(true)
	self:RemoveEvents()
end

function var_0_9:RegisterEvents()
	self.listener:Register(DORM_RESTAURANT_UPDATE_SCENE_ITEM, function()
		self:ClearAllSenenItem()
		self:GenerateAllSceneItem()
	end)
end

function var_0_9:RemoveEvents()
	self.listener:RemoveAll()
end

var_0_9.ItemEIdNamespace = DormUtils.EIdNamespace
var_0_9.ItemIdxNamespace = DormUtils.IdxNamespace
var_0_9.ItemCountNamespace = "restaurant.item.count"

function var_0_9.GetItemCount(arg_17_0)
	return Dorm.storage:GetData(var_0_9.ItemCountNamespace, arg_17_0) or 0
end

local function var_0_10(arg_18_0)
	local var_18_0 = {}

	for iter_18_0 = 0, arg_18_0.Length - 1 do
		table.insert(var_18_0, arg_18_0[iter_18_0])
	end

	return var_18_0
end

function var_0_9.RecordItemInfo(arg_19_0, arg_19_1, arg_19_2)
	Dorm.storage:RecordData(DormEnum.Namespace.EntityType, arg_19_1, arg_19_2)
	Dorm.storage:RecordData(var_0_9.ItemEIdNamespace(arg_19_2), arg_19_0, arg_19_1)
	Dorm.storage:RecordData(var_0_9.ItemIdxNamespace(arg_19_2), arg_19_1, arg_19_0)
	Dorm.storage:RecordData(var_0_9.ItemCountNamespace, arg_19_2, var_0_9.GetItemCount(arg_19_2) + 1)
end

function var_0_9.RecordInteractPoints(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0

	if arg_20_2 == DormEnum.ItemType.Food then
		do return end

		var_20_0 = Dorm.storage:GetData(var_0_9.ItemInteractPointsNamespace, arg_20_0)
	end

	if var_20_0 then
		local var_20_1 = var_0_10(var_20_0)

		Dorm.storage:GetData(DormEnum.Namespace.EntityData, arg_20_1).interactPoints = var_20_1

		for iter_20_0, iter_20_1 in ipairs(var_20_1) do
			CanteenManager.RecordInteractPointInfo(iter_20_1, arg_20_1, nil)
		end
	end
end

function var_0_9.RemoveItemInfo(arg_21_0, arg_21_1)
	local var_21_0 = Dorm.storage:GetData(DormEnum.Namespace.EntityType, arg_21_1)

	if var_21_0 == nil then
		return
	end

	Dorm.storage:RecordData(DormEnum.Namespace.EntityType, arg_21_1, nil)
	Dorm.storage:RecordData(var_0_9.ItemEIdNamespace(var_21_0), arg_21_0, nil)
	Dorm.storage:RecordData(var_0_9.ItemIdxNamespace(var_21_0), arg_21_1, nil)
	Dorm.storage:RecordData(var_0_9.ItemCountNamespace, var_21_0, var_0_9.GetItemCount(var_21_0) - 1)

	if Dorm.storage:GetData(var_0_9.ItemInteractPointsNamespace, arg_21_0) then
		CanteenManager.RemoveInteractPointInfo(arg_21_1)
	end
end

var_0_9.PosNamespace = DormTagConst.DORM_RESTAURANT_ITEM_NAMESPACE
var_0_9.StaticItemPosNamespace = DormTagConst.DORM_RESTAURANT_STATIC_ITEM_NAMESPACE
var_0_9.GroupNamespace = DormTagConst.DORM_RESTAURANT_ITEM_GROUP_NAMESPACE
var_0_9.TypeNamespace = DormTagConst.DORM_RESTAURANT_ITEM_TYPE_NAMESPACE
var_0_9.ItemInteractPointsNamespace = DormTagConst.DORM_RESTAURANT_ITEM_INTERACT_POINTS_NAMESPACE

function var_0_9.GetGroupID(arg_22_0)
	return nullable(BackHomeCanteenFurnitureIDCfg.get_id_list_by_item_tag, arg_22_0, 1)
end

function var_0_9.GetGroupFromStaticInfo(arg_23_0)
	return Dorm.sceneItemInfo[var_0_9.GroupNamespace][arg_23_0]
end

function var_0_9:GenerateSceneItem(arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = Dorm.storage:GetData(var_0_9.TypeNamespace, arg_24_1)
	local var_24_1 = Dorm.storage:GetData(var_0_9.GroupNamespace, arg_24_1)
	local var_24_2 = var_0_9.GetGroupID(var_24_1) or -1

	if var_24_0 then
		local var_24_3 = CanteenData:GetFurnitureLevel(var_24_2)
		local var_24_4 = {
			available = true,
			category = DormEnum.EntityType.Furniture,
			type = var_24_0,
			tag = arg_24_2,
			group = var_24_1,
			groupID = var_24_2,
			level = var_24_3,
			complex = nullable(CanteenItemCfg, var_0_2(var_24_0, var_24_3), "complex")
		}

		manager.notify:Invoke(DORM_RESTAURANT_NEW_ITEM, var_24_0, (((arg_24_3 or nil) and (self.staticItemEntityManager or self.itemEntityManager)):Create(arg_24_1, var_24_4, var_24_4)))
	end
end

function var_0_9:ClearAllSenenItem()
	self.staticItemEntityManager:Clear()
	self.itemEntityManager:Clear()
end

function var_0_9:GenerateAllSceneItem()
	for iter_26_0, iter_26_1 in Dorm.storage:ForeachData(var_0_9.PosNamespace, pairs) do
		self:GenerateSceneItem(iter_26_0, iter_26_1, false)
	end

	for iter_26_2, iter_26_3 in Dorm.storage:ForeachData(var_0_9.StaticItemPosNamespace, pairs) do
		self:GenerateSceneItem(iter_26_2, iter_26_3, true)
	end

	manager.notify:Invoke(DORM_ITEM_RECORD_FIN)
end

function var_0_9:GetNextFoodID()
	self.foodID = (self.foodID or 0) + 1

	return self.foodID
end

function var_0_9:GenerateFood(arg_28_1, arg_28_2)
	local var_28_0 = self.foodEntityManager:Create(self:GetNextFoodID(), {
		pooled = true,
		prefab = nullable(BackHomeCanteenFoodCfg, arg_28_1).prefab
	}, arg_28_2)

	manager.notify:Invoke(DORM_RESTAURANT_NEW_ITEM, DormEnum.ItemType.Food, var_28_0)

	return var_28_0
end

function var_0_9.FindAndRemoveEntity(arg_29_0)
	local var_29_0 = var_0_9.GetInstance()

	EntityManager.FindAndRemoveEntity({
		var_29_0.foodEntityManager,
		var_29_0.staticItemEntityManager,
		var_29_0.itemEntityManager
	}, arg_29_0)
end

function var_0_9.GetItemInteractPositions(arg_30_0)
	local var_30_0 = var_0_0(arg_30_0).interactPoints

	if var_30_0 then
		local var_30_1 = {}

		for iter_30_0, iter_30_1 in pairs(var_30_0) do
			table.insert(var_30_1, iter_30_1)
		end

		return var_30_1
	end

	return {
		Dorm.DormEntityManager.QueryPosition(arg_30_0)
	}
end

function var_0_9.GetItemsInItemGroup(arg_31_0, arg_31_1)
	local var_31_0 = {}

	for iter_31_0, iter_31_1 in Dorm.storage:ForeachData(var_0_9.ItemEIdNamespace(arg_31_0), pairs) do
		if var_0_0(iter_31_1).group == arg_31_1 then
			table.insert(var_31_0, iter_31_1)
		end
	end

	return var_31_0
end

return var_0_9
