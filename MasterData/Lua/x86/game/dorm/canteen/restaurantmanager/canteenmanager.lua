local var_0_0 = singletonClass("RestaurantManager")

function var_0_0:Ctor()
	self.characterManager = CanteenCharacterManager.GetInstance()
	self.dormItemManager = CanteenItemManager.GetInstance()
	self.listener = EventListener.New()

	self:ResetAllData()
end

function var_0_0.PosNamespace(arg_2_0)
	return "restaurant.pos." .. arg_2_0
end

function var_0_0.StartAutoRestaurant()
	Dorm.restaurant:Reset()
	Dorm.storage:Reset()
	Dorm.restaurant:Init(DormEnum.RestaurantMode.RestaurantAuto)
	Dorm.restaurant:StartGenCustomer(DormEnum.RestaurantMode.RestaurantAuto)
end

function var_0_0.StartManualRestaurant()
	Dorm.restaurant:Reset()
	Dorm.storage:Reset()
	Dorm.restaurant:Init(DormEnum.RestaurantMode.RestaurantManual)
	Dorm.restaurant:StartGenCustomer(DormEnum.RestaurantMode.RestaurantManual)
	CookAI.GetInstance():Dispose()
end

function var_0_0:RegisterEvent()
	for iter_5_0, iter_5_1 in pairs({
		[DORM_RESTAURANT_START_AUTO] = var_0_0.StartAutoRestaurant,
		[DORM_RESTAURANT_START_MANUAL] = var_0_0.StartManualRestaurant,
		[DORM_RESTAURANT_NEW_ITEM] = function(arg_6_0, arg_6_1)
			if arg_6_0 == DormEnum.ItemType.DinningTable then
				CanteenAIFunction:GetEntityData(arg_6_1).available = false
			end
		end,
		[DORM_CLICK_ENTITY] = var_0_0.OnClickEntity
	}) do
		self.listener:Register(iter_5_0, iter_5_1)
	end
end

function var_0_0:RemoveEvent()
	self.listener:RemoveAll()
end

function var_0_0:ResetAllData(arg_8_1)
	self.businessInfo = {}
	self.businessInfo[self.businessModeField] = arg_8_1
	self.businessInfo[self.orderFoodListField] = {}

	Dorm.storage:MapToData(DormEnum.Namespace.RestaurantBusiness, self.businessInfo)
	DormUtils.MapSceneItemTagInfo()
end

function var_0_0:Init(arg_9_1)
	self:ResetAllData(arg_9_1)
	self.dormItemManager:Init()
	CookAI.GetInstance():Init()
	CashierAI.GetInstance():Init()
	NormalCustomerAI.GetInstance():Init()
	WaiterAI.GetInstance():Init()
	self.characterManager:Init()
	DormCharacterActionManager:Init()
	DormCharacterActionExecute.GetInstance():Init()
end

function var_0_0:Reset()
	CookAI.GetInstance():Dispose()
	CashierAI.GetInstance():Dispose()
	NormalCustomerAI.GetInstance():Dispose()
	WaiterAI.GetInstance():Dispose()
	DormCharacterActionManager:Reset()
	DormCharacterActionExecute.GetInstance():Reset()
	manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_stop", "")
	self.characterManager:Reset()
	self.dormItemManager:Reset()
	self:ResetAllData()
end

var_0_0.businessModeField = "businessMode"
var_0_0.orderFoodListField = "orderFoodList"

local function var_0_1()
	local var_11_0 = 0

	for iter_11_0, iter_11_1 in Dorm.storage:ForeachData(CanteenItemManager.ItemEIdNamespace(DormEnum.ItemType.DinningTable), pairs) do
		local var_11_1 = CanteenAIFunction:GetEntityData(iter_11_1)

		if var_11_1.level and var_11_1.level > 0 then
			var_11_0 = var_11_0 + 1
		end
	end

	return var_11_0
end

local function var_0_2(arg_12_0)
	local var_12_0 = arg_12_0:QueryTime() / arg_12_0.duration * 100
	local var_12_1 = {
		0,
		0
	}

	for iter_12_0, iter_12_1 in ipairs(GameDisplayCfg.canteen_customer_limited.value) do
		if var_12_0 < iter_12_1[1] then
			break
		end

		var_12_1 = iter_12_1
	end

	return math.min(var_0_1(), var_12_1[2])
end

function var_0_0:StartGenCustomer(arg_13_1)
	if arg_13_1 == DormEnum.RestaurantMode.RestaurantManual then
		local var_13_0 = self:StartManualBusinessTimer()

		self.characterManager:StartGenCustomerTask(function()
			return var_0_2(var_13_0)
		end)
	else
		self.characterManager:StartGenCustomerTask(function()
			return var_0_1()
		end)
	end
end

function var_0_0:StartManualBusinessTimer()
	local var_16_0 = DormCharacterActionManager.taskRunner
	local var_16_1 = DormCharacterActionManager.taskRunner:NewTimer(function()
		self.characterManager:StopGenCustomerTask()
		var_16_0:NewTask():WaitUntil(function()
			return self.characterManager:GetCharacterCount(DormEnum.CharacterType.RestaurantNormalCustomer) == 0
		end):Then(function()
			CanteenData:SetCanteenState(DormEnum.RestaurantMode.RestaurantAuto)
		end):Start()
	end, GameSetting.dorm_operate_time.value[1], false, false)

	var_16_1:Start()

	self.businessInfo.timer = var_16_1

	return var_16_1
end

function var_0_0.FinishManualRestaurant(arg_20_0)
	return
end

function var_0_0.GetCurPopularity(arg_21_0)
	return CanteenData:GetPopularityNum()
end

function var_0_0:OnChooseFood(arg_22_1)
	self:ClearData("restaurant.foodList")

	for iter_22_0, iter_22_1 in ipairs((CanteenFoodData:GetChooseFoodList())) do
		self:RecordData("restaurant.foodList", iter_22_0, iter_22_1)
	end
end

var_0_0.InteractPointMap = "restaurant.interactPointMap"

function var_0_0.PointToGridKey(arg_23_0)
	return Dorm.DormEntityManager.GetGridIndex(arg_23_0)
end

function var_0_0.RecordInteractPointInfo(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = var_0_0.PointToGridKey(arg_24_0)
	local var_24_1 = Dorm.storage:GetData(var_0_0.InteractPointMap, var_24_0) or {}

	var_24_1[arg_24_1] = arg_24_2 or ""

	Dorm.storage:RecordData(var_0_0.InteractPointMap, var_24_0, var_24_1)
end

function var_0_0.RemoveInteractPointInfo(arg_25_0)
	for iter_25_0, iter_25_1 in Dorm.storage:ForeachData(var_0_0.InteractPointMap, pairs) do
		for iter_25_2, iter_25_3 in pairs(iter_25_1) do
			if iter_25_2 == arg_25_0 then
				iter_25_1[iter_25_2] = nil
			end
		end
	end
end

function var_0_0.GetItemInteractPointsOnGrid(arg_26_0)
	return Dorm.storage:GetData(var_0_0.InteractPointMap, var_0_0.PointToGridKey(arg_26_0)) or {}
end

function var_0_0:GetCustomerGroupCount()
	return self.businessInfo.customerGroup or 0
end

function var_0_0:OnCustomerCome()
	self.businessInfo.customerGroup = self:GetCustomerGroupCount() + 1
end

function var_0_0:OnCustomerLeave(arg_29_1)
	local var_29_0 = self:GetCustomerGroupCount() - 1

	self.businessInfo.customerGroup = var_29_0

	var_0_0.ReleaseDinningTableFromCustomer(arg_29_1)

	if var_29_0 == 0 and CanteenAIFunction:GetCurCanteenMode() == DormEnum.RestaurantMode.RestaurantManual and not CanteenCharacterManager.CheckFoodEnoughGenCustomer() then
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("CANTEEN_MANNUALLY_FOOD_EMPTY"),
			OkCallback = function()
				CanteenData:SetCanteenState(DormEnum.RestaurantMode.RestaurantAuto)
			end
		})
	end
end

function var_0_0.ReleaseDinningTableFromCustomer(arg_31_0)
	CanteenAIFunction:GetEntityData(CanteenAIFunction:GetEntityData(arg_31_0).tableEid).booked = nil
end

function var_0_0.ArrangeDinningTableForCustomer()
	local var_32_0 = {}

	for iter_32_0, iter_32_1 in Dorm.storage:ForeachData(CanteenItemManager.ItemEIdNamespace(DormEnum.ItemType.DinningTable), pairs) do
		local var_32_1 = CanteenAIFunction:GetEntityData(iter_32_1)

		if var_32_1.level and var_32_1.level > 0 and not var_32_1.booked then
			table.insert(var_32_0, iter_32_1)
		end
	end

	return var_32_0[math.random(1, #var_32_0)]
end

local function var_0_3(arg_33_0, arg_33_1)
	arg_33_1 = arg_33_1 or {}

	local var_33_0 = CanteenAIFunction:GetEntityData(arg_33_0)

	if var_33_0.foodList then
		for iter_33_0, iter_33_1 in pairs(var_33_0.foodList) do
			arg_33_1[CanteenAIFunction:GetEntityData(iter_33_1).cfgID] = true
		end
	end

	return arg_33_1
end

local function var_0_4(arg_34_0, arg_34_1)
	arg_34_1 = arg_34_1 or {}

	local var_34_0 = CanteenAIFunction:GetEntityData(arg_34_0)

	if var_34_0.pick then
		arg_34_1[CanteenAIFunction:GetEntityData(var_34_0.pick).cfgID] = true
	end

	return arg_34_1
end

function var_0_0.CalcCanOrderFoodList()
	local var_35_0 = {}

	for iter_35_0, iter_35_1 in ipairs(CanteenFoodData:GetCanOrderFoodList()) do
		var_35_0[iter_35_1] = true
	end

	if CanteenAIFunction:GetCurCanteenMode() == DormEnum.RestaurantMode.RestaurantManual then
		for iter_35_2, iter_35_3 in Dorm.storage:ForeachData(CanteenItemManager.ItemEIdNamespace(DormEnum.ItemType.PassTable), pairs) do
			var_35_0 = var_0_3(iter_35_3, var_35_0)
		end

		for iter_35_4, iter_35_5 in Dorm.storage:ForeachData(CanteenCharacterManager.EIdNamespace(DormEnum.CharacterType.RestaurantCook), pairs) do
			var_35_0 = var_0_4(iter_35_5, var_35_0)
		end
	end

	return var_35_0
end

function var_0_0.GetRestaurantOrderList()
	return Dorm.storage:GetData(DormEnum.Namespace.RestaurantBusiness, var_0_0.orderFoodListField)
end

function var_0_0.AddOrder(arg_37_0)
	arg_37_0.status = DormEnum.FoodState.Wait

	table.insert(var_0_0.GetRestaurantOrderList(), arg_37_0)
	manager.notify:Invoke(CANTEEN_ORDER_FOOD_LIST_CHANGE)

	return arg_37_0
end

local function var_0_5(arg_38_0)
	return arg_38_0.status == DormEnum.FoodState.TimeOut or arg_38_0.status == DormEnum.FoodState.HasServer or arg_38_0.status == DormEnum.FoodState.Canceled
end

function var_0_0.RefreshOrder()
	local var_39_0 = var_0_0.GetRestaurantOrderList()

	for iter_39_0 = #var_39_0, 1, -1 do
		if var_0_5(var_39_0[iter_39_0]) then
			table.remove(var_39_0, iter_39_0)
		end
	end
end

function var_0_0.OnClickEntity(arg_40_0)
	local var_40_0 = CanteenAIFunction:GetEntityData(arg_40_0)

	if DormEnum.ItemType[CanteenAIFunction:GetEntityType(arg_40_0)] and var_40_0.groupID then
		manager.notify:Invoke(CANTEEN_FUR_LEVEL, var_40_0.groupID)
	end
end

function var_0_0.SetGroupItemLocked(arg_41_0, arg_41_1)
	return
end

return var_0_0
