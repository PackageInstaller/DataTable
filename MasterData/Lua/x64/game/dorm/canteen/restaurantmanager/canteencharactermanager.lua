local var_0_0 = singletonClass("CanteenCharacterManager")

local function var_0_1(arg_1_0)
	return function(arg_2_0)
		return "CharDorm/" .. (arg_2_0.skinOverride and arg_2_0.skinOverride or nullable(arg_1_0, nullable(arg_2_0, "skinID"), "model"))
	end
end

local var_0_2 = var_0_1(BackHomeHeroSkinCfg)
local var_0_3 = var_0_1(BackHomeNpcCfg)
local var_0_4 = var_0_1(BackHomeCustomerCfg)

local function var_0_5(arg_3_0)
	local var_3_0 = CanteenManager.PosNamespace(arg_3_0.jobID)

	return nullable(Dorm.storage:GetData(var_3_0, arg_3_0.jobCharaIndex or 1) or Dorm.storage:PickData(var_3_0), "transform")
end

local var_0_6 = 1.25
local var_0_7 = {
	[DormEnum.CharacterType.RestaurantCook] = DORM_RESTAURANT_NEW_COOK,
	[DormEnum.CharacterType.RestaurantWaiter] = DORM_RESTAURANT_NEW_WAITER,
	[DormEnum.CharacterType.RestaurantCashier] = DORM_RESTAURANT_NEW_CASHIER,
	[DormEnum.CharacterType.RestaurantNormalCustomer] = DORM_RESTAURANT_NEW_CUSTOMER
}

function var_0_0:Ctor()
	local var_4_0 = EntityManager.CreateModel.New(function(arg_5_0)
		if arg_5_0.isNpc then
			return var_0_3(arg_5_0)
		else
			return var_0_2(arg_5_0)
		end
	end, var_0_5)
	local var_4_1 = EntityManager.CreateModel.New(var_0_4, var_0_5)

	self.workingCharaManagers = {}

	for iter_4_0, iter_4_1 in pairs(DormEnum.CharacterType) do
		local var_4_3 = EntityManager.New((iter_4_0 == DormEnum.CharacterType.RestaurantNormalCustomer or nil) and var_4_1)

		function var_4_3.OnCreate(arg_6_0, arg_6_1, arg_6_2)
			Dorm.DormEntityManager.StartFadeInCMD(arg_6_1, var_0_6, function()
				if iter_4_0 ~= DormEnum.CharacterType.RestaurantNormalCustomer then
					DormUtils.ShowCharaSpecialVfx(arg_6_1, Dorm.charaVfxActiveType)
				end
			end)
			self:RecordEntityInfo(arg_6_1, arg_6_2)
			manager.notify:Invoke(var_0_7[iter_4_0], arg_6_1)
		end

		function var_4_3.OnRemove(arg_8_0, arg_8_1)
			self:RemoveEntityInfo(arg_8_1)
			manager.notify:Invoke(DORM_CHARACTER_DISPOSE, arg_8_1, iter_4_0)
		end

		self.workingCharaManagers[iter_4_0] = var_4_3
	end

	self.listener = EventListener.New()
	self.nextCustomerIdx = 1
end

function var_0_0:RegisterEvents()
	for iter_9_0, iter_9_1 in pairs({
		[DORM_RESTAURANT_START_INIT] = handler(self, self.Init),
		[DORM_RESTAURANT_UPDATE_CHARACTER_BY_TYPE] = handler(self, self.UpdateJobCharacter)
	}) do
		self.listener:Register(iter_9_0, iter_9_1)
	end
end

function var_0_0:RemoveEvents()
	self.listener:RemoveAll()
end

function var_0_0.CheckFoodEnoughGenCustomer()
	local var_11_0 = 0

	for iter_11_0, iter_11_1 in pairs(CanteenManager.CalcCanOrderFoodList()) do
		var_11_0 = var_11_0 + 1
	end

	return (CanteenAIFunction:GetCurCanteenMode() == DormEnum.RestaurantMode.RestaurantManual and DormConst.ORDER_FOOD_NUM or DormConst.ORDER_FOOD_AUTO_NUM) <= var_11_0
end

local function var_0_8(arg_12_0)
	return arg_12_0 > CanteenManager.GetInstance():GetCustomerGroupCount() and var_0_0.CheckFoodEnoughGenCustomer()
end

local var_0_9

local function var_0_10()
	local var_13_0 = CanteenManager.GetInstance():GetCurPopularity()

	if var_0_9 == nil then
		local var_13_1 = {}

		for iter_13_0 = #GameSetting.dorm_canteen_customer_time.value, 1, -1 do
			table.insert(var_13_1, {
				l = GameSetting.dorm_canteen_customer_time.value[iter_13_0][1],
				r = nil,
				cd = GameSetting.dorm_canteen_customer_time.value[iter_13_0][2]
			})
		end

		var_0_9 = var_13_1
	end

	for iter_13_1, iter_13_2 in ipairs(var_0_9) do
		if var_13_0 >= iter_13_2.l and (iter_13_2.r == nil or var_13_0 < iter_13_2.r) then
			return iter_13_2.cd
		end
	end

	error(string.format("人气值%d不在有效区间内，无法找到对应的客人生成间隔时间信息"))
end

function var_0_0:StartGenCustomerTask(arg_14_1)
	if self.genCustomerTask then
		self:StopGenCustomerTask()
	end

	local var_14_0 = DormCharacterActionManager.taskRunner

	self.genCustomerTask = DormCharacterActionManager.taskRunner:NewTask():WaitUntil(function(arg_15_0)
		if CanteenTools:AutoModeReadyForBusiness() and (not arg_15_0.timer or not arg_15_0.timer:IsRunning()) and var_0_8((arg_14_1())) then
			arg_15_0.timer = var_14_0:NewTimer(nil, var_0_10(), false, false)

			arg_15_0.timer:Start()
			self:GenCustomer()
		end

		return false
	end, {})

	self.genCustomerTask:Start()
end

function var_0_0:StopGenCustomerTask()
	if self.genCustomerTask then
		self.genCustomerTask:Abort()

		self.genCustomerTask = nil
	end
end

local function var_0_11()
	local var_17_0 = {}
	local var_17_1 = {}

	for iter_17_0, iter_17_1 in pairs(BackHomeCustomerCfg.all) do
		if next(BackHomeCustomerCfg[iter_17_1].food_list) then
			for iter_17_2, iter_17_3 in pairs(BackHomeCustomerCfg[iter_17_1].food_list) do
				var_17_0[iter_17_3] = var_17_0[iter_17_3] or {}

				table.insert(var_17_0[iter_17_3], iter_17_1)
			end
		else
			table.insert(var_17_1, iter_17_1)
		end
	end

	return var_17_0, var_17_1
end

local function var_0_12(arg_18_0)
	local var_18_0 = 0
	local var_18_1 = {}

	for iter_18_0, iter_18_1 in pairs(arg_18_0) do
		var_18_0 = var_18_0 + BackHomeCustomerCfg[iter_18_1].weight
		var_18_1[iter_18_1] = BackHomeCustomerCfg[iter_18_1].weight
	end

	local var_18_2 = math.random(1, var_18_0)
	local var_18_3

	for iter_18_2, iter_18_3 in pairs(var_18_1) do
		if var_18_2 > 0 then
			var_18_2 = var_18_2 - iter_18_3
			var_18_3 = iter_18_2
		else
			break
		end
	end

	return var_18_3
end

local function var_0_13(arg_19_0, arg_19_1)
	local var_19_0 = CanteenManager.CalcCanOrderFoodList()
	local var_19_1 = {}
	local var_19_2, var_19_3 = var_0_11()

	while arg_19_1 > #var_19_1 do
		if arg_19_0 <= #var_19_1 and next(var_19_0) == nil and math.random() >= 0.5 then
			break
		end

		local var_19_4
		local var_19_5 = {}

		for iter_19_0, iter_19_1 in pairs(var_19_0) do
			table.insert(var_19_5, iter_19_0)
		end

		if next(var_19_5) then
			var_19_4 = var_19_2[var_19_5[math.random(#var_19_5)]]

			if var_19_4 == nil or next(var_19_4) == nil or #var_19_1 == arg_19_1 - 1 and #var_19_5 > 1 then
				var_19_4 = var_19_3
				var_19_0 = {}
			end
		else
			var_19_4 = BackHomeCustomerCfg.all
		end

		local var_19_6 = var_0_12(var_19_4)

		table.insert(var_19_1, var_19_6)

		for iter_19_2, iter_19_3 in pairs(BackHomeCustomerCfg[var_19_6].food_list) do
			var_19_0[iter_19_3] = nil
		end
	end

	return var_19_1
end

function var_0_0:GenCustomer()
	local var_20_0 = DormEnum.CharacterType.RestaurantNormalCustomer
	local var_20_1 = CanteenManager.ArrangeDinningTableForCustomer()
	local var_20_2 = CanteenAIFunction:GetEntityData(var_20_1)
	local var_20_3 = CanteenItemManager.GetItemsInItemGroup(DormEnum.ItemType.DinningChair, var_20_2.group)
	local var_20_4 = var_0_13(1, #var_20_3)
	local var_20_5 = math.random(1, #var_20_4)
	local var_20_6 = {}

	for iter_20_0 = 1, #var_20_4 do
		local var_20_7 = math.random(1, #var_20_3)

		var_20_3[#var_20_3] = var_20_3[var_20_7]
		var_20_3[var_20_7] = var_20_3[#var_20_3]

		local var_20_8 = var_20_4[iter_20_0]
		local var_20_9 = {
			cfgID = var_20_4[iter_20_0],
			tableEid = var_20_1,
			chairEid = table.remove(var_20_3),
			pay = iter_20_0 == var_20_5
		}
		local var_20_10 = {
			complex = true,
			jobID = var_20_0,
			jobCharaIndex = iter_20_0
		}
		local var_20_11 = CanteenData:GetCanteenVisitor()

		if #var_20_11 > 0 then
			local var_20_12 = var_20_11[math.random(1, #var_20_11)]

			CanteenData:SetVisitedHero(var_20_12)

			local var_20_13 = nullable(BackHomeHeroSkinCfg, var_20_12)

			var_20_10.skinOverride = nullable(var_20_13, "model")
			var_20_9.heroID = nullable(var_20_13, "hero_id")
			var_20_9.skinID = var_20_12
			var_20_9.isVisitor = true
		else
			var_20_10.skinOverride = nullable(BackHomeCustomerCfg, var_20_8, "model")
		end

		table.insert(var_20_6, (self:GenerateCharacterEntity(var_20_0, self.nextCustomerIdx, var_20_10, var_20_9)))

		self.nextCustomerIdx = self.nextCustomerIdx + 1

		if CanteenData:GetCanteenState() == DormEnum.RestaurantMode.RestaurantManual then
			CanteenManualData:RecordManualGenCustomerNum(1)
		end
	end

	for iter_20_1, iter_20_2 in ipairs(var_20_6) do
		self.GetEntityData(iter_20_2).peer = var_20_6
	end

	var_20_2.booked = var_20_6

	CanteenManager.GetInstance():OnCustomerCome()
end

local var_0_14 = DormEnum.RestaurantJobToClientMap

var_0_0.EIdNamespace = DormUtils.EIdNamespace
var_0_0.IdxNamespace = DormUtils.IdxNamespace

function var_0_0:Init()
	self:RegisterEvents()

	for iter_21_0, iter_21_1 in pairs(self.workingCharaManagers) do
		iter_21_1:Clear()
		iter_21_1:MapToDormStorageData(var_0_0.EIdNamespace(iter_21_0), var_0_0.IdxNamespace(iter_21_0))
	end

	self:GenerateJobCharacter(var_0_14)
end

function var_0_0:UpdateJobCharacter(arg_22_1)
	if self.workingCharaManagers[arg_22_1] then
		self.workingCharaManagers[arg_22_1]:Clear()
		self:GenerateJobCharacter({
			arg_22_1
		})
	end
end

function var_0_0:GenerateJobCharacter(arg_23_1)
	local var_23_0 = CanteenHeroTools:GetCanteenJobList()

	for iter_23_0, iter_23_1 in pairs(arg_23_1) do
		if var_23_0[DormEnum.RestaurantJobToServerMap[iter_23_1]].skinID then
			local var_23_1 = nullable(BackHomeNpcCfg, var_23_0[DormEnum.RestaurantJobToServerMap[iter_23_1]].heroID)
			local var_23_2 = {
				complex = true,
				isNpc = var_23_1,
				skinID = var_23_0[DormEnum.RestaurantJobToServerMap[iter_23_1]].skinID,
				jobID = iter_23_1
			}
			local var_23_3 = {
				cfgID = var_23_0[DormEnum.RestaurantJobToServerMap[iter_23_1]].skinID,
				skinID = var_23_0[DormEnum.RestaurantJobToServerMap[iter_23_1]].skinID,
				heroID = var_23_0[DormEnum.RestaurantJobToServerMap[iter_23_1]].heroID
			}
			local var_23_4

			if var_23_1 then
				var_23_4 = BackHomeNpcCfg[var_23_0[DormEnum.RestaurantJobToServerMap[iter_23_1]].heroID].speed
			else
				var_23_3.skinVariant = DormCharacterManager.GetLocalSavedCharaSkinVariant(var_23_0[DormEnum.RestaurantJobToServerMap[iter_23_1]].skinID)
				var_23_2.skinOverride = DormCharacterManager.GetSkinOverride(var_23_0[DormEnum.RestaurantJobToServerMap[iter_23_1]].skinID, var_23_3.skinVariant)
				var_23_4 = BackHomeHeroCfg[var_23_0[DormEnum.RestaurantJobToServerMap[iter_23_1]].heroID].speed
			end

			Dorm.DormEntityManager.SetEntitySpeed(self:GenerateCharacterEntity(iter_23_1, 1, var_23_2, var_23_3), var_23_4)
		end
	end
end

function var_0_0:GenerateCharacterEntity(arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	arg_24_4 = arg_24_4 or {}

	local var_24_0 = self.workingCharaManagers[arg_24_1]:Create(arg_24_2, arg_24_3, arg_24_4)

	arg_24_4.eid = var_24_0

	return var_24_0, true
end

function var_0_0.RecordEntityInfo(arg_25_0, arg_25_1, arg_25_2)
	Dorm.storage:RecordData(DormEnum.Namespace.EntityType, arg_25_1, nullable(arg_25_2, "jobID"))
end

function var_0_0.RemoveEntityInfo(arg_26_0, arg_26_1)
	Dorm.storage:RecordData(DormEnum.Namespace.EntityType, arg_26_1, nil)
end

function var_0_0:Reset()
	self:RemoveEvents()
	self:StopGenCustomerTask()

	for iter_27_0, iter_27_1 in pairs(self.workingCharaManagers) do
		iter_27_1:Clear()
	end
end

function var_0_0:GetCharacterCount(arg_28_1)
	return self.workingCharaManagers[arg_28_1]:EntityNum()
end

function var_0_0.FindAndRemoveEntity(arg_29_0)
	EntityManager.FindAndRemoveEntity(var_0_0.GetInstance().workingCharaManagers, arg_29_0)
end

function var_0_0.GetEntityData(arg_30_0)
	return Dorm.storage:GetData(DormEnum.Namespace.EntityData, arg_30_0)
end

return var_0_0
