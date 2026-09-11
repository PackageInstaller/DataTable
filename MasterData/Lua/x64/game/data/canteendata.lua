local DormEnum = import("game.dorm.DormEnum")
local var_0_1 = singletonClass("CanteenData")
local var_0_2
local var_0_3
local var_0_4
local var_0_5
local var_0_6
local var_0_7 = DormConst.CANTEEN_ID
local var_0_8

function var_0_1.InitSimpleCanteenInfo(arg_1_0, arg_1_1)
	var_0_3 = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.canteens) do
		local var_1_0 = {}

		var_1_0.totalEar = iter_1_1.accruing_earnings or 0
		var_0_3[iter_1_1.id] = var_1_0
	end

	CanteenEntrustData:InitSimpleCanteenEntrustData(arg_1_1)
	CanteenFoodData:InitSimpleCanteenFoodData(arg_1_1)
	CanteenHeroTools:InitCanteenJobState(arg_1_1.canteens[1].careers)
	var_0_1:InitFurnitureLevel(arg_1_1.canteen_furnitures)
end

function var_0_1.InitDetailCanteenData(arg_2_0, arg_2_1)
	var_0_1:InitCanteenMapData(arg_2_1)
	CanteenEntrustData:InitDetailCanteenEntrustData(arg_2_1)
	CanteenFoodData:InitDetailCanteenFoodData(arg_2_1)
	CanteenHeroTools:InitCanteenJobState(arg_2_1.canteens[1].careers)
	var_0_1:InitPopularity(var_0_5[var_0_7])
end

function var_0_1.EnterCurSystem(arg_3_0)
	DormTools:SystemStayTime(DormConst.BACKHOME_SYSTEM_TYPE.Canteen, false)
end

function var_0_1.ExitCurSystem(arg_4_0)
	var_0_4 = nil

	DormTools:SystemStayTime(DormConst.BACKHOME_SYSTEM_TYPE.Canteen, true)
end

function var_0_1.ExitBackHomeSystem(arg_5_0)
	var_0_2 = nil

	CanteenFoodData:DisposeDetailData()
	CanteenEntrustData:DisposeDetailData()
end

function var_0_1.InitCanteenMapData(arg_6_0, arg_6_1)
	var_0_2 = {}
	var_0_3 = {}
	var_0_5 = {}
	var_0_4 = nil

	for iter_6_0, iter_6_1 in ipairs(arg_6_1.canteens) do
		local var_6_0 = {}

		var_6_0.totalEar = iter_6_1.accruing_earnings or 0
		var_6_0.earnings = iter_6_1.business.earnings or 0
		var_6_0.last_earnings_update_time = iter_6_1.business.last_earnings_update_time or manager.time:GetServerTime()
		var_6_0.last_receive_earnings_time = iter_6_1.business.last_receive_earnings_time or manager.time:GetServerTime()
		var_0_3[iter_6_1.id] = var_6_0
		var_0_2[iter_6_1.id] = {}
		var_0_2[iter_6_1.id].roomInfo = RoomInfo.New()
		var_0_2[iter_6_1.id].roomInfo.id = iter_6_1.id
		var_0_2[iter_6_1.id].roomInfo.sceneName = BackHomeCfg[iter_6_1.id].scene
		var_0_2[iter_6_1.id].roomInfo.furnitureInfoS = {}
		var_0_5[iter_6_1.id] = {}

		local var_6_1 = {}

		var_6_1.dynamicNum = iter_6_1.attractive.dynamic or 0
		var_6_1.updataTime = iter_6_1.attractive.dynamic_update_time
		var_0_5[iter_6_1.id].Popularity = var_6_1
	end
end

function var_0_1.GetCanteenSceneData(arg_7_0)
	if var_0_2[var_0_7] then
		return var_0_2[var_0_7]
	end
end

function var_0_1.GetCurEarning(arg_8_0)
	return var_0_3[var_0_7].totalEar
end

function var_0_1.InitFurnitureLevel(arg_9_0, arg_9_1)
	var_0_6 = {}

	if arg_9_1 then
		for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
			local var_9_0 = {}

			var_9_0.level = iter_9_1.level or 1
			var_9_0.cfgID = BackHomeCanteenFurnitureIDCfg[iter_9_1.uid].type_id
			var_9_0.stringEid = BackHomeCanteenFurnitureIDCfg[iter_9_1.uid].type_id
			var_9_0.unLock = BackHomeCanteenFurnitureIDCfg[iter_9_1.uid].unLock
			var_0_6[iter_9_1.uid] = var_9_0
		end
	end
end

function var_0_1.GetFurnitureLevel(arg_10_0, arg_10_1)
	if var_0_6[arg_10_1] then
		return var_0_6[arg_10_1].level
	else
		return 0
	end
end

function var_0_1.FurLevelUpCallBack(arg_11_0, arg_11_1)
	var_0_6[arg_11_1] = var_0_6[arg_11_1] or {
		level = 0
	}

	local var_11_0 = BackHomeCanteenFurnitureIDCfg[arg_11_1].type_id

	if BackHomeCanteenFurnitureCfg[BackHomeCanteenFurnitureIDCfg[arg_11_1].type_id].skill[var_0_6[arg_11_1].level] then
		for iter_11_0, iter_11_1 in ipairs(BackHomeCanteenFurnitureCfg[BackHomeCanteenFurnitureIDCfg[arg_11_1].type_id].skill[var_0_6[arg_11_1].level]) do
			if DormSkillData:CheckSkillIsRun(arg_11_1, iter_11_1, DormEnum.EntityType.Furniture) then
				DormSkillData:DisposeSkillComponent(arg_11_1, iter_11_1, DormEnum.EntityType.Furniture)
			end
		end
	end

	var_0_6[arg_11_1].level = var_0_6[arg_11_1].level + 1

	if BackHomeCanteenFurnitureCfg[var_11_0].skill[var_0_6[arg_11_1].level] then
		for iter_11_2, iter_11_3 in ipairs(BackHomeCanteenFurnitureCfg[var_11_0].skill[var_0_6[arg_11_1].level]) do
			if DormSkillData:CheckSkillIsOpen(arg_11_1, iter_11_3, DormEnum.EntityType.Furniture) then
				DormSkillData:AddSkillComponent(arg_11_1, iter_11_3, DormEnum.EntityType.Furniture)
			end
		end
	end
end

function var_0_1.GetFurInfoList(arg_12_0)
	if var_0_6 then
		return var_0_6
	else
		print("家具信息不存在")
	end
end

function var_0_1.GetCanteenState(arg_13_0)
	return var_0_4
end

function var_0_1.SetCanteenState(arg_14_0, arg_14_1)
	if arg_14_1 == var_0_4 then
		return
	end

	CanteenAction:ChangeCanteenMode(var_0_7, arg_14_1)
end

function var_0_1:ChangeCanteenStateSusscee(arg_15_1, arg_15_2)
	var_0_4 = arg_15_1

	if arg_15_1 == DormEnum.RestaurantMode.RestaurantManual then
		manager.notify:Invoke(DORM_RESTAURANT_START_MANUAL)
		JumpTools.OpenPageByJump("dormPlayerControlView")
		CanteenTools:SwitchCanteenBgm(DormEnum.RestaurantMode.RestaurantManual)
		DormLuaBridge.ChangeRoomState(true)
		CanteenManualData:EnterManualState()
		manager.notify:Invoke(DORM_REFRESH_RESTAURANT_STATUS_EVENT, var_0_4)
	else
		if arg_15_2 then
			CanteenManualData:ExitManualState()
		else
			CanteenAction:CanteenManualSettlement(var_0_7, CanteenManualData:GetManualInfo().manualSettlementList)
		end

		self:ChooseCanteenAutoState()
		CharacterBubbleManager:Dispose()
		DormLuaBridge.ChangeRoomState(false)
		CanteenTools:SwitchCanteenBgm(DormEnum.RestaurantMode.RestaurantAuto)
	end
end

function var_0_1.ChooseCanteenAutoState(arg_16_0)
	if var_0_4 == DormEnum.RestaurantMode.RestaurantManual then
		return
	end

	local var_16_0 = CanteenTools:AutoModeReadyForBusiness() and DormEnum.RestaurantMode.RestaurantAuto or DormEnum.RestaurantMode.Close

	if var_16_0 ~= var_0_4 then
		manager.notify:Invoke(DORM_RESTAURANT_START_AUTO)
	end

	var_0_4 = var_16_0

	manager.notify:Invoke(DORM_REFRESH_RESTAURANT_STATUS_EVENT, var_0_4)
end

function var_0_1:InitPopularity(arg_17_1)
	local var_17_0 = 0
	local var_17_1 = GameSetting.canteen_hot_reduce.value[1]

	if arg_17_1.Popularity.updataTime == 0 or not arg_17_1.Popularity.updataTime then
		arg_17_1.Popularity.updataTime = manager.time:GetServerTime()
	end

	local var_17_2 = manager.time:GetServerTime() - arg_17_1.Popularity.updataTime
	local var_17_3 = math.modf(var_17_2 / GameSetting.canteen_hot_reduce.value[2])

	arg_17_1.Popularity.updataTime = arg_17_1.Popularity.updataTime + var_17_3 * var_17_1

	if arg_17_1.Popularity.dynamicNum > 0 then
		var_17_0 = math.max(0, arg_17_1.Popularity.dynamicNum - var_17_3 * var_17_1)
	end

	arg_17_1.buffList = {}
	arg_17_1.hightPopularityNum = 0
	arg_17_1.dynamicNum = var_17_0
	arg_17_1.basePopualrityNum = 0
	arg_17_1.remainTime = var_17_2 % GameSetting.canteen_hot_reduce.value[2]
	arg_17_1.manualNum = 0

	if self.startHotTimer == nil then
		self.startHotTimer = Timer.New(function()
			self:UpdataDynmicPopularity()

			self.updataHotTimer = Timer.New(handler(self, self.UpdataDynmicPopularity), GameSetting.canteen_hot_reduce.value[2], -1)

			self.updataHotTimer:Start()
		end, var_0_5[var_0_7].remainTime, 1)
	end

	self.startHotTimer:Start()
end

function var_0_1.GetPopularInfo(arg_19_0)
	return var_0_5[var_0_7]
end

function var_0_1.GetPopularityNum(arg_20_0)
	if not var_0_5 then
		return DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.PopularRise) or 0
	else
		var_0_5[var_0_7].basePopualrityNum = DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.PopularRise)

		return math.max(var_0_5[var_0_7].dynamicNum + var_0_5[var_0_7].basePopualrityNum + CanteenManualData:GetManualPopNum(), 0)
	end
end

function var_0_1.UpdataDynmicPopularity(arg_21_0)
	var_0_5[var_0_7].dynamicNum = math.max(var_0_5[var_0_7].dynamicNum - GameSetting.canteen_hot_reduce.value[1], 0)
	var_0_5[var_0_7].Popularity.updataTime = manager.time:GetServerTime()

	manager.notify:Invoke(DORM_REFRESH_POPULAR_EVENT)
end

function var_0_1.RefreshAutoAwardInfo(arg_22_0, arg_22_1)
	Debug.Log("RefreshAutoAwardInfo")

	if not var_0_3 then
		var_0_3 = {}
		var_0_3[var_0_7] = {}
	end

	var_0_3[var_0_7].earnings = arg_22_1.earnings
	var_0_3[var_0_7].last_earnings_update_time = arg_22_1.last_earnings_update_time

	manager.notify:Invoke(BACKHOME_CATEEN_AWARD_UPDATE)
end

function var_0_1.GetAutoAwardNum(arg_23_0)
	if var_0_3[var_0_7].earnings then
		return var_0_3[var_0_7].earnings
	else
		return 0
	end
end

function var_0_1.ReceiveCurPenEarSuccess(arg_24_0, arg_24_1, arg_24_2)
	var_0_3[var_0_7].totalEar = var_0_3[var_0_7].totalEar + arg_24_1

	if arg_24_2 == DormEnum.RestaurantMode.RestaurantAuto then
		var_0_3[var_0_7].earnings = 0
		var_0_3[var_0_7].last_receive_earnings_time = manager.time:GetServerTime()
	end
end

function var_0_1.GetAutoNextAwardTime(arg_25_0)
	local var_25_1 = (var_0_3[var_0_7].last_receive_earnings_time and var_0_3[var_0_7].last_receive_earnings_time + GameSetting.canteen_receive_time_interval.value[1] or manager.time:GetServerTime()) - manager.time:GetServerTime()

	if var_25_1 > 0 then
		local var_25_2 = math.modf(var_25_1 / 3600)

		return var_25_2, math.floor((var_25_1 - var_25_2 * 3600) / 60), (var_25_1 - var_25_2 * 3600) % 60
	else
		return -1, -1, -1
	end
end

function var_0_1.RefreshCanteenDailyZero(arg_26_0)
	CanteenEntrustData:RefreshDailyZero()
end

function var_0_1.GetCanteenVisitor(arg_27_0)
	if not var_0_8 or var_0_8.playerId ~= USER_ID then
		var_0_8 = {
			playerId = USER_ID,
			visHero = {}
		}
	end

	local var_27_0 = {}

	for iter_27_0, iter_27_1 in ipairs(DormData:GetVisitInfo().visitUser) do
		if not var_0_8.visHero[iter_27_1.heroID] then
			table.insert(var_27_0, iter_27_1.heroID)
		end
	end

	return var_27_0
end

function var_0_1.SetVisitedHero(arg_28_0, arg_28_1)
	if not var_0_8 or var_0_8.playerId ~= USER_ID then
		var_0_8 = {
			playerId = USER_ID,
			visHero = {}
		}
	end

	var_0_8.visHero[arg_28_1] = true
end

return var_0_1
