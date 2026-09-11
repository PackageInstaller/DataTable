local var_0_0 = {
	GetFoodSprite = function(arg_1_0)
		return getSpriteWithoutAtlas(DormConst.CANTEEN_FOOD_PATH .. BackHomeCanteenFoodCfg[arg_1_0].icon)
	end,
	GetCanteenSkillSprite = function(arg_2_0)
		return getSpriteViaConfig("DormHeroSkill", BackHomeHeroSkillCfg[arg_2_0].icon)
	end,
	GetFilterGroupByType = function(arg_3_0, arg_3_1)
		if arg_3_0 == 1 then
			return Filter_Tags_Define["ATTACKRANGE" .. arg_3_1]
		elseif arg_3_0 == 2 then
			return Filter_Tags_Define["Race" .. arg_3_1]
		elseif arg_3_0 == 4 then
			return Filter_Tags_Define["MECHAINISM" .. arg_3_1]
		end
	end
}

function var_0_0.GetFilterIcon(arg_4_0, arg_4_1)
	if arg_4_0 == 3 then
		return HeroTools.GetSkillAttributeIcon(arg_4_1, true)
	else
		local var_4_0 = CommonFilterConst.GetFilterTagCfg(var_0_0.GetFilterGroupByType(arg_4_0, arg_4_1))

		return getSprite(var_4_0.atlasName, var_4_0.spriteName)
	end
end

function var_0_0.CheckSignFoodNumCanOpen(arg_5_0)
	local var_5_0 = CanteenFoodData:GetCanOrderFoodList()

	if var_5_0 then
		if #var_5_0 < DormConst.ORDER_FOOD_AUTO_NUM then
			return false
		else
			return true
		end
	end
end

function var_0_0.CheckCanteenJobCanOpen(arg_6_0)
	for iter_6_0, iter_6_1 in pairs((CanteenHeroTools:GetCanteenJobList())) do
		if not iter_6_1.heroID then
			return false
		end

		if not DormNpcTools:CheckIDIsNpc(iter_6_1.heroID) and DormData:GetHeroFatigue(iter_6_1.heroID) < GameSetting.dorm_canteen_work_fatigue.value[1] / 100 - GameSetting.dorm_canteen_work_fatigue.value[1] / 100 % 0.1 then
			return false
		end
	end

	return true
end

function var_0_0.CheckFoodUnLock(arg_7_0, arg_7_1)
	if BackHomeCanteenFoodCfg[arg_7_1].unlock ~= 0 then
		return BackHomeTools:CheckBackHomeConditionAccord(BackHomeCanteenFoodCfg[arg_7_1].unlock)
	end

	return true
end

function var_0_0.GetFoodUnLockLevel(arg_8_0, arg_8_1)
	if BackHomeCanteenFoodCfg[arg_8_1].unlock ~= 0 then
		return ConditionCfg[BackHomeCanteenFoodCfg[arg_8_1].unlock].params[2]
	else
		return 0
	end
end

function var_0_0.CheckFurCanLevelUp(arg_9_0, arg_9_1)
	local var_9_0 = CanteenData:GetFurnitureLevel(arg_9_1)

	if not BackHomeCanteenFurnitureCfg[BackHomeCanteenFurnitureIDCfg[arg_9_1].type_id].condition[var_9_0 + 1] then
		return false
	end

	for iter_9_0, iter_9_1 in ipairs(BackHomeCanteenFurnitureCfg[BackHomeCanteenFurnitureIDCfg[arg_9_1].type_id].condition[var_9_0 + 1]) do
		if ConditionCfg[iter_9_1] and not BackHomeTools:CheckBackHomeConditionAccord(iter_9_1) then
			return false
		end
	end

	if not BackHomeCanteenFurnitureCfg[BackHomeCanteenFurnitureIDCfg[arg_9_1].type_id].cost_material[var_9_0 + 1] then
		return true
	end

	for iter_9_2, iter_9_3 in ipairs(BackHomeCanteenFurnitureCfg[BackHomeCanteenFurnitureIDCfg[arg_9_1].type_id].cost_material[var_9_0 + 1]) do
		if ItemTools.getItemNum(iter_9_3[1]) < iter_9_3[2] then
			return false
		end
	end

	return true
end

function var_0_0:CheckAllFurCanLevelUp(arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(BackHomeCanteenFurnitureIDCfg.all) do
		if BackHomeCanteenFurnitureCfg[BackHomeCanteenFurnitureIDCfg[iter_10_1].type_id].type == arg_10_1 and self:CheckFurCanLevelUp(iter_10_1) then
			return true
		end
	end

	return false
end

function var_0_0.GetCookCfgName(arg_11_0, arg_11_1)
	local var_11_0 = GetTips(CanteenConst.COOK_TYPE_NAME[arg_11_1])

	if string.isNullOrEmpty(var_11_0) then
		print("未获取到厨具名字")
	end

	return var_11_0
end

function var_0_0.GetCookCfgNameByEid(arg_12_0, arg_12_1)
	if BackHomeCanteenFurnitureIDCfg[arg_12_1] then
		if BackHomeCanteenFurnitureCfg[BackHomeCanteenFurnitureIDCfg[arg_12_1].type_id].name then
			return BackHomeCanteenFurnitureCfg[BackHomeCanteenFurnitureIDCfg[arg_12_1].type_id].name
		else
			print("未找到家具名字")
		end
	end
end

function var_0_0.GetJobName(arg_13_0, arg_13_1)
	if arg_13_1 == 1 then
		return GetTips("DORM_CANTEEN_COOK")
	elseif arg_13_1 == 2 then
		return GetTips("DORM_CANTEEN_WAITER")
	elseif arg_13_1 == 3 then
		return GetTips("DORM_CANTEEN_CASHIER")
	end
end

function var_0_0.GetFootTypeName(arg_14_0, arg_14_1)
	if type(DormEnum.FoodType[arg_14_1]) == "string" then
		return DormEnum.FoodType[arg_14_1]
	elseif type(DormEnum.FoodType[arg_14_1]) == "number" then
		return GetTips(DormEnum.FoodType[arg_14_1])
	end
end

function var_0_0.GetFurEidByType(arg_15_0, arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(BackHomeFurniture.all) do
		if BackHomeFurniture[iter_15_1].type == arg_15_1 then
			for iter_15_2, iter_15_3 in ipairs(BackHomeCanteenFurnitureIDCfg.all) do
				if BackHomeCanteenFurnitureIDCfg[iter_15_3].type_id == iter_15_1 then
					return iter_15_3
				end
			end
		end
	end
end

function var_0_0.GetCanteenEIDByFurCfgID(arg_16_0, arg_16_1)
	for iter_16_0, iter_16_1 in ipairs(BackHomeCanteenFurnitureIDCfg.all) do
		if BackHomeCanteenFurnitureIDCfg[iter_16_1].type_id == arg_16_1 then
			return iter_16_1
		end
	end
end

function var_0_0.AnyJobAvailable(arg_17_0)
	for iter_17_0, iter_17_1 in pairs((CanteenHeroTools:GetCanteenJobList())) do
		if iter_17_1.heroID == nil then
			return true
		end
	end

	return false
end

function var_0_0:AutoModeReadyForBusiness()
	return self:CheckSignFoodNumCanOpen() and self:CheckCanteenJobCanOpen()
end

function var_0_0.SwitchCanteenBgm(arg_19_0, arg_19_1)
	if arg_19_1 == DormEnum.RestaurantMode.Start then
		manager.audio:PlayBGM(MusicReference[1].cuesheet, MusicReference[1].cueName, MusicReference[1].awbName)
		manager.audio:PlayBGM(MusicReference[3].cuesheet, MusicReference[3].cueName, MusicReference[3].awbName)
	elseif arg_19_1 ~= DormEnum.RestaurantMode.RestaurantAuto then
		if arg_19_1 == DormEnum.RestaurantMode.Close then
			manager.audio:PlayBGM(MusicReference[3].cuesheet, MusicReference[3].cueName, MusicReference[3].awbName)
		elseif arg_19_1 == DormEnum.RestaurantMode.RestaurantManual then
			manager.audio:PlayBGM(MusicReference[2].cuesheet, MusicReference[2].cueName, MusicReference[2].awbName)
		end
	end
end

function var_0_0.GetIndexByTaskDuring(arg_20_0, arg_20_1, arg_20_2)
	if BackHomeCanteenTaskCfg[arg_20_1] then
		for iter_20_0, iter_20_1 in ipairs(BackHomeCanteenTaskCfg[arg_20_1].time) do
			if arg_20_2 == iter_20_1[1] then
				return iter_20_0
			end
		end
	end
end

function var_0_0.ShowTipsGetCookCfgName(arg_21_0, arg_21_1)
	if CanteenConst.COOK_TYPE_NAME[arg_21_1] then
		return GetTips(CanteenConst.COOK_TYPE_NAME[arg_21_1])
	else
		return ""
	end
end

local function var_0_1(arg_22_0, arg_22_1)
	if CanteenEntrustData:CheckHasChooseEntrustCharacter(arg_22_0) then
		return false
	end

	if BackHomeTools.CheckHeroIsLockForAnyFeatureByHeroID(arg_22_0) then
		return false
	end

	if nullable(arg_22_1, (DormData:GetHeroArchiveID(arg_22_0))) then
		return false
	end

	return true
end

local function var_0_2(arg_23_0, arg_23_1)
	if GameSetting.dorm_canteen_work_fatigue.value[1] / 100 > DormData:GetHeroFatigue(arg_23_0) then
		return false
	end

	if CanteenEntrustData:CheckHasChooseEntrustCharacter(arg_23_0) or DormData:GetHeroTemplateInfo(arg_23_0).jobType then
		return false
	end

	if BackHomeTools.CheckHeroIsLockForAnyFeatureByHeroID(arg_23_0) then
		return false
	end

	if nullable(arg_23_1, (DormData:GetHeroArchiveID(arg_23_0))) then
		return false
	end

	return true
end

local function var_0_3(arg_24_0, arg_24_1)
	return not nullable(arg_24_1, arg_24_0)
end

local function var_0_4(arg_25_0)
	local var_25_0 = {
		need = 0,
		result = {},
		filter = {},
		reduce = {}
	}

	if arg_25_0 then
		for iter_25_0, iter_25_1 in ipairs(arg_25_0) do
			local var_25_1 = DormData:GetHeroFatigue(iter_25_1)
			local var_25_2 = DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.EntrustTotalFatigueReduce, iter_25_1)

			var_25_0.filter[DormData:GetHeroArchiveID(iter_25_1)] = true

			table.insert(var_25_0.result, iter_25_1)

			var_25_0.need = var_25_0.need + var_25_1

			table.insert(var_25_0.reduce, var_25_2)
		end
	end

	return var_25_0
end

local function var_0_5(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4, arg_26_5)
	arg_26_5 = arg_26_5 or var_0_4(nil)

	if arg_26_4 > 0 then
		for iter_26_0, iter_26_1 in ipairs(arg_26_1) do
			for iter_26_2, iter_26_3 in ipairs(arg_26_0[iter_26_1]) do
				local var_26_0 = DormData:GetHeroArchiveID(iter_26_3)

				if var_0_3(var_26_0, arg_26_5.filter) then
					local var_26_1 = DormData:GetHeroFatigue(iter_26_3)
					local var_26_2 = DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.EntrustTotalFatigueReduce, iter_26_3)

					table.insert(arg_26_5.result, iter_26_3)
					table.insert(arg_26_5.reduce, var_26_2)

					arg_26_5.need = arg_26_5.need + var_26_1
					arg_26_5.filter[var_26_0] = true

					for iter_26_4, iter_26_5 in ipairs(arg_26_5.reduce) do
						local var_26_3 = math.min(100, 0 + iter_26_5)
					end

					if var_0_5(arg_26_0, arg_26_1, arg_26_2 - math.floor(arg_26_2 * var_26_2 / 100), arg_26_3, arg_26_4 - 1, arg_26_5) then
						return true, arg_26_5.result
					end

					arg_26_5.need = arg_26_5.need - var_26_1
					arg_26_5.filter[var_26_0] = nil

					table.remove(arg_26_5.reduce)
					table.remove(arg_26_5.result)
				end
			end
		end
	end

	return arg_26_2 <= arg_26_5.need and arg_26_3 <= #arg_26_5.result, arg_26_5.result
end

function var_0_0.AnyAvailableEntrustHero()
	for iter_27_0, iter_27_1 in ipairs((DormHeroTools:GetUnLockBackHomeHeroIDList())) do
		if var_0_2(iter_27_1) then
			return true
		end
	end

	return false
end

function var_0_0:AutoSelectEntrustHero(arg_28_1, arg_28_2)
	local var_28_0 = {}
	local var_28_1 = {}

	for iter_28_0, iter_28_1 in ipairs((DormHeroTools:GetUnLockBackHomeHeroIDList())) do
		if var_0_2(iter_28_1, arg_28_2) then
			local var_28_2 = math.min(CanteenEntrustData:CalHeroMatchNum(iter_28_1, self.tags) + DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.EntrustExternSucceedAdd, iter_28_1) / BackHomeCanteenTaskCfg[self.id].tag_success, DormConst.DORM_HERO_TAG_MAX)
			local var_28_3 = var_28_0[var_28_2]

			if var_28_0[var_28_2] == nil then
				var_28_3 = {}
				var_28_0[var_28_2] = var_28_3

				table.insert(var_28_1, var_28_2)
			end

			table.insert(var_28_3, iter_28_1)
		end
	end

	for iter_28_2, iter_28_3 in pairs(var_28_0) do
		CommonTools.UniversalSortEx(iter_28_3, {
			map = function(arg_29_0)
				return DormData:GetHeroFatigue(arg_29_0)
			end
		})
	end

	table.sort(var_28_1, function(arg_30_0, arg_30_1)
		return arg_30_1 < arg_30_0
	end)

	local var_28_4 = BackHomeCanteenTaskCfg[self.id].need[2]

	if arg_28_1 then
		var_28_4 = var_28_4 - #arg_28_1
	end

	local var_28_5, var_28_6 = var_0_5(var_28_0, var_28_1, BackHomeCanteenTaskCfg[self.id].cost, BackHomeCanteenTaskCfg[self.id].need[1], var_28_4, var_0_4(arg_28_1))

	if var_28_5 then
		return var_28_6
	end
end

function var_0_0.GetAvailableJobHeroList()
	return DormHeroTools:GetFilteredUnlockBackHomeHeroIDList(var_0_1)
end

return var_0_0
