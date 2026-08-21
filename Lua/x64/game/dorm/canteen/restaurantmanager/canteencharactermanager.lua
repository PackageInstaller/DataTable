local var_0_0 = singletonClass("CanteenCharacterManager")

local function var_0_1(arg_1_0)
	return function(arg_2_0)
		local var_2_0

		if arg_2_0.skinOverride then
			var_2_0 = arg_2_0.skinOverride
		else
			var_2_0 = nullable(arg_1_0, nullable(arg_2_0, "skinID"), "model")
		end

		return "CharDorm/" .. var_2_0
	end
end

local var_0_2 = var_0_1(BackHomeHeroSkinCfg)
local var_0_3 = var_0_1(BackHomeNpcCfg)
local var_0_4 = var_0_1(BackHomeCustomerCfg)

local function var_0_5(arg_3_0)
	local var_3_0 = CanteenManager.PosNamespace(arg_3_0.jobID)
	local var_3_1 = arg_3_0.jobCharaIndex or 1
	local var_3_2 = Dorm.storage:GetData(var_3_0, var_3_1) or Dorm.storage:PickData(var_3_0)

	return nullable(var_3_2, "transform")
end

local var_0_6 = 1.25
local var_0_7 = {
	[DormEnum.CharacterType.RestaurantCook] = DORM_RESTAURANT_NEW_COOK,
	[DormEnum.CharacterType.RestaurantWaiter] = DORM_RESTAURANT_NEW_WAITER,
	[DormEnum.CharacterType.RestaurantCashier] = DORM_RESTAURANT_NEW_CASHIER,
	[DormEnum.CharacterType.RestaurantNormalCustomer] = DORM_RESTAURANT_NEW_CUSTOMER
}

function var_0_0.Ctor(arg_4_0)
	local var_4_0 = EntityManager.CreateModel.New(function(arg_5_0)
		if arg_5_0.isNpc then
			return var_0_3(arg_5_0)
		else
			return var_0_2(arg_5_0)
		end
	end, var_0_5)
	local var_4_1 = EntityManager.CreateModel.New(var_0_4, var_0_5)

	arg_4_0.workingCharaManagers = {}

	for iter_4_0, iter_4_1 in pairs(DormEnum.CharacterType) do
		local var_4_2 = var_4_0

		if iter_4_0 == DormEnum.CharacterType.RestaurantNormalCustomer then
			var_4_2 = var_4_1
		end

		local var_4_3 = EntityManager.New(var_4_2)

		function var_4_3.OnCreate(arg_6_0, arg_6_1, arg_6_2)
			Dorm.DormEntityManager.StartFadeInCMD(arg_6_1, var_0_6, function()
				if iter_4_0 ~= DormEnum.CharacterType.RestaurantNormalCustomer then
					DormUtils.ShowCharaSpecialVfx(arg_6_1, Dorm.charaVfxActiveType)
				end
			end)
			arg_4_0:RecordEntityInfo(arg_6_1, arg_6_2)
			manager.notify:Invoke(var_0_7[iter_4_0], arg_6_1)
		end

		function var_4_3.OnRemove(arg_8_0, arg_8_1)
			arg_4_0:RemoveEntityInfo(arg_8_1)
			manager.notify:Invoke(DORM_CHARACTER_DISPOSE, arg_8_1, iter_4_0)
		end

		arg_4_0.workingCharaManagers[iter_4_0] = var_4_3
	end

	arg_4_0.listener = EventListener.New()
	arg_4_0.nextCustomerIdx = 1
end

function var_0_0.RegisterEvents(arg_9_0)
	local var_9_0 = {
		[DORM_RESTAURANT_START_INIT] = handler(arg_9_0, arg_9_0.Init),
		[DORM_RESTAURANT_UPDATE_CHARACTER_BY_TYPE] = handler(arg_9_0, arg_9_0.UpdateJobCharacter)
	}

	for iter_9_0, iter_9_1 in pairs(var_9_0) do
		arg_9_0.listener:Register(iter_9_0, iter_9_1)
	end
end

function var_0_0.RemoveEvents(arg_10_0)
	arg_10_0.listener:RemoveAll()
end

function var_0_0.CheckFoodEnoughGenCustomer()
	local var_11_0 = 0

	for iter_11_0, iter_11_1 in pairs(CanteenManager.CalcCanOrderFoodList()) do
		var_11_0 = var_11_0 + 1
	end

	local var_11_1

	if CanteenAIFunction:GetCurCanteenMode() == DormEnum.RestaurantMode.RestaurantManual then
		var_11_1 = DormConst.ORDER_FOOD_NUM
	else
		var_11_1 = DormConst.ORDER_FOOD_AUTO_NUM
	end

	return var_11_1 <= var_11_0
end

local function var_0_8(arg_12_0)
	return arg_12_0 > CanteenManager.GetInstance():GetCustomerGroupCount() and var_0_0.CheckFoodEnoughGenCustomer()
end

local var_0_9

local function var_0_10()
	local var_13_0 = CanteenManager.GetInstance():GetCurPopularity()

	if var_0_9 == nil then
		local var_13_1 = {}
		local var_13_2 = GameSetting.dorm_canteen_customer_time.value
		local var_13_3

		for iter_13_0 = #var_13_2, 1, -1 do
			local var_13_4 = var_13_2[iter_13_0][1]

			table.insert(var_13_1, {
				l = var_13_4,
				r = var_13_3,
				cd = var_13_2[iter_13_0][2]
			})

			var_13_3 = var_13_4
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

function var_0_0.StartGenCustomerTask(arg_14_0, arg_14_1)
	if arg_14_0.genCustomerTask then
		arg_14_0:StopGenCustomerTask()
	end

	local var_14_0 = DormCharacterActionManager.taskRunner

	arg_14_0.genCustomerTask = var_14_0:NewTask():WaitUntil(function(arg_15_0)
		local var_15_0 = arg_15_0.timer
		local var_15_1 = not var_15_0 or not var_15_0:IsRunning()
		local var_15_2 = arg_14_1()

		if CanteenTools:AutoModeReadyForBusiness() and var_15_1 and var_0_8(var_15_2) then
			arg_15_0.timer = var_14_0:NewTimer(nil, var_0_10(), false, false)

			arg_15_0.timer:Start()
			arg_14_0:GenCustomer()
		end

		return false
	end, {})

	arg_14_0.genCustomerTask:Start()
end

function var_0_0.StopGenCustomerTask(arg_16_0)
	if arg_16_0.genCustomerTask then
		arg_16_0.genCustomerTask:Abort()

		arg_16_0.genCustomerTask = nil
	end
end

local function var_0_11()
	local var_17_0 = {}
	local var_17_1 = {}

	for iter_17_0, iter_17_1 in pairs(BackHomeCustomerCfg.all) do
		local var_17_2 = BackHomeCustomerCfg[iter_17_1]

		if next(var_17_2.food_list) then
			for iter_17_2, iter_17_3 in pairs(var_17_2.food_list) do
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
		local var_18_2 = BackHomeCustomerCfg[iter_18_1].weight

		var_18_0 = var_18_0 + var_18_2
		var_18_1[iter_18_1] = var_18_2
	end

	local var_18_3 = math.random(1, var_18_0)
	local var_18_4

	for iter_18_2, iter_18_3 in pairs(var_18_1) do
		if var_18_3 > 0 then
			var_18_3 = var_18_3 - iter_18_3
			var_18_4 = iter_18_2
		else
			break
		end
	end

	return var_18_4
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

function var_0_0.GenCustomer(arg_20_0)
	local var_20_0 = DormEnum.CharacterType.RestaurantNormalCustomer
	local var_20_1 = CanteenManager.ArrangeDinningTableForCustomer()
	local var_20_2 = CanteenAIFunction:GetEntityData(var_20_1)
	local var_20_3 = var_20_2.group
	local var_20_4 = CanteenItemManager.GetItemsInItemGroup(DormEnum.ItemType.DinningChair, var_20_3)
	local var_20_5 = var_0_13(1, #var_20_4)
	local var_20_6 = #var_20_5
	local var_20_7 = math.random(1, var_20_6)
	local var_20_8 = {}

	for iter_20_0 = 1, var_20_6 do
		local var_20_9 = math.random(1, #var_20_4)

		var_20_4[var_20_9], var_20_4[#var_20_4] = var_20_4[#var_20_4], var_20_4[var_20_9]

		local var_20_10 = table.remove(var_20_4)
		local var_20_11 = var_20_5[iter_20_0]
		local var_20_12 = {
			cfgID = var_20_11,
			tableEid = var_20_1,
			chairEid = var_20_10,
			pay = iter_20_0 == var_20_7
		}
		local var_20_13 = {
			complex = true,
			jobID = var_20_0,
			jobCharaIndex = iter_20_0
		}
		local var_20_14 = CanteenData:GetCanteenVisitor()

		if #var_20_14 > 0 then
			local var_20_15 = var_20_14[math.random(1, #var_20_14)]

			CanteenData:SetVisitedHero(var_20_15)

			local var_20_16 = nullable(BackHomeHeroSkinCfg, var_20_15)

			var_20_13.skinOverride = nullable(var_20_16, "model")
			var_20_12.heroID = nullable(var_20_16, "hero_id")
			var_20_12.skinID = var_20_15
			var_20_12.isVisitor = true
		else
			var_20_13.skinOverride = nullable(BackHomeCustomerCfg, var_20_11, "model")
		end

		local var_20_17 = arg_20_0:GenerateCharacterEntity(var_20_0, arg_20_0.nextCustomerIdx, var_20_13, var_20_12)

		table.insert(var_20_8, var_20_17)

		arg_20_0.nextCustomerIdx = arg_20_0.nextCustomerIdx + 1

		if CanteenData:GetCanteenState() == DormEnum.RestaurantMode.RestaurantManual then
			CanteenManualData:RecordManualGenCustomerNum(1)
		end
	end

	for iter_20_1, iter_20_2 in ipairs(var_20_8) do
		arg_20_0.GetEntityData(iter_20_2).peer = var_20_8
	end

	var_20_2.booked = var_20_8

	CanteenManager.GetInstance():OnCustomerCome()
end

local var_0_14 = DormEnum.RestaurantJobToClientMap

var_0_0.EIdNamespace = DormUtils.EIdNamespace
var_0_0.IdxNamespace = DormUtils.IdxNamespace

function var_0_0.Init(arg_21_0)
	arg_21_0:RegisterEvents()

	for iter_21_0, iter_21_1 in pairs(arg_21_0.workingCharaManagers) do
		iter_21_1:Clear()
		iter_21_1:MapToDormStorageData(var_0_0.EIdNamespace(iter_21_0), var_0_0.IdxNamespace(iter_21_0))
	end

	arg_21_0:GenerateJobCharacter(var_0_14)
end

function var_0_0.UpdateJobCharacter(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.workingCharaManagers[arg_22_1]

	if var_22_0 then
		var_22_0:Clear()
		arg_22_0:GenerateJobCharacter({
			arg_22_1
		})
	end
end

function var_0_0.GenerateJobCharacter(arg_23_0, arg_23_1)
	local var_23_0 = CanteenHeroTools:GetCanteenJobList()

	for iter_23_0, iter_23_1 in pairs(arg_23_1) do
		local var_23_1 = var_23_0[DormEnum.RestaurantJobToServerMap[iter_23_1]]
		local var_23_2 = var_23_1.heroID
		local var_23_3 = var_23_1.skinID

		if var_23_3 then
			local var_23_4 = nullable(BackHomeNpcCfg, var_23_2)
			local var_23_5 = {
				complex = true,
				isNpc = var_23_4,
				skinID = var_23_3,
				jobID = iter_23_1
			}
			local var_23_6 = {
				cfgID = var_23_3,
				skinID = var_23_3,
				heroID = var_23_2
			}
			local var_23_7

			if var_23_4 then
				var_23_7 = BackHomeNpcCfg[var_23_2].speed
			else
				var_23_6.skinVariant = DormCharacterManager.GetLocalSavedCharaSkinVariant(var_23_3)
				var_23_5.skinOverride = DormCharacterManager.GetSkinOverride(var_23_3, var_23_6.skinVariant)
				var_23_7 = BackHomeHeroCfg[var_23_2].speed
			end

			local var_23_8 = arg_23_0:GenerateCharacterEntity(iter_23_1, 1, var_23_5, var_23_6)

			Dorm.DormEntityManager.SetEntitySpeed(var_23_8, var_23_7)
		end
	end
end

function var_0_0.GenerateCharacterEntity(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	local var_24_0 = arg_24_0.workingCharaManagers[arg_24_1]

	arg_24_4 = arg_24_4 or {}

	local var_24_1 = var_24_0:Create(arg_24_2, arg_24_3, arg_24_4)
	local var_24_2 = true

	arg_24_4.eid = var_24_1

	return var_24_1, var_24_2
end

function var_0_0.RecordEntityInfo(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = Dorm.storage
	local var_25_1 = DormEnum.Namespace.EntityType

	var_25_0:RecordData(var_25_1, arg_25_1, nullable(arg_25_2, "jobID"))
end

function var_0_0.RemoveEntityInfo(arg_26_0, arg_26_1)
	local var_26_0 = Dorm.storage
	local var_26_1 = DormEnum.Namespace.EntityType

	var_26_0:RecordData(var_26_1, arg_26_1, nil)
end

function var_0_0.Reset(arg_27_0)
	arg_27_0:RemoveEvents()
	arg_27_0:StopGenCustomerTask()

	for iter_27_0, iter_27_1 in pairs(arg_27_0.workingCharaManagers) do
		iter_27_1:Clear()
	end
end

function var_0_0.GetCharacterCount(arg_28_0, arg_28_1)
	return arg_28_0.workingCharaManagers[arg_28_1]:EntityNum()
end

function var_0_0.FindAndRemoveEntity(arg_29_0)
	local var_29_0 = var_0_0.GetInstance()

	EntityManager.FindAndRemoveEntity(var_29_0.workingCharaManagers, arg_29_0)
end

function var_0_0.GetEntityData(arg_30_0)
	return Dorm.storage:GetData(DormEnum.Namespace.EntityData, arg_30_0)
end

return var_0_0
