local var_0_0 = {
	GetFoodSprite = function(arg_1_0)
		return getSpriteWithoutAtlas(DormConst.CANTEEN_FOOD_PATH .. BackHomeCanteenFoodCfg[arg_1_0].icon)
	end,
	GetCanteenSkillSprite = function(arg_2_0)
		local var_2_0 = BackHomeHeroSkillCfg[arg_2_0].icon

		return getSpriteViaConfig("DormHeroSkill", var_2_0)
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
		local var_4_1 = var_4_0.atlasName
		local var_4_2 = var_4_0.spriteName

		return getSprite(var_4_1, var_4_2)
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
	local var_6_0 = CanteenHeroTools:GetCanteenJobList()

	for iter_6_0, iter_6_1 in pairs(var_6_0) do
		if not iter_6_1.heroID then
			return false
		end

		local var_6_1 = iter_6_1.heroID

		if not DormNpcTools:CheckIDIsNpc(var_6_1) then
			local var_6_2 = DormData:GetHeroFatigue(var_6_1)
			local var_6_3 = GameSetting.dorm_canteen_work_fatigue.value[1] / 100

			if var_6_2 < var_6_3 - var_6_3 % 0.1 then
				return false
			end
		end
	end

	return true
end

function var_0_0.CheckFoodUnLock(arg_7_0, arg_7_1)
	local var_7_0 = BackHomeCanteenFoodCfg[arg_7_1].unlock

	if var_7_0 ~= 0 then
		return BackHomeTools:CheckBackHomeConditionAccord(var_7_0)
	end

	return true
end

function var_0_0.GetFoodUnLockLevel(arg_8_0, arg_8_1)
	local var_8_0 = BackHomeCanteenFoodCfg[arg_8_1].unlock

	if var_8_0 ~= 0 then
		return ConditionCfg[var_8_0].params[2]
	else
		return 0
	end
end

function var_0_0.CheckFurCanLevelUp(arg_9_0, arg_9_1)
	local var_9_0 = BackHomeCanteenFurnitureIDCfg[arg_9_1].type_id
	local var_9_1 = CanteenData:GetFurnitureLevel(arg_9_1)
	local var_9_2 = BackHomeCanteenFurnitureCfg[var_9_0].condition[var_9_1 + 1]

	if not var_9_2 then
		return false
	end

	for iter_9_0, iter_9_1 in ipairs(var_9_2) do
		if ConditionCfg[iter_9_1] and not BackHomeTools:CheckBackHomeConditionAccord(iter_9_1) then
			return false
		end
	end

	local var_9_3 = BackHomeCanteenFurnitureCfg[var_9_0].cost_material[var_9_1 + 1]

	if not var_9_3 then
		return true
	end

	for iter_9_2, iter_9_3 in ipairs(var_9_3) do
		if ItemTools.getItemNum(iter_9_3[1]) < iter_9_3[2] then
			return false
		end
	end

	return true
end

function var_0_0.CheckAllFurCanLevelUp(arg_10_0, arg_10_1)
	local var_10_0 = BackHomeCanteenFurnitureIDCfg.all

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		local var_10_1 = BackHomeCanteenFurnitureIDCfg[iter_10_1].type_id

		if BackHomeCanteenFurnitureCfg[var_10_1].type == arg_10_1 and arg_10_0:CheckFurCanLevelUp(iter_10_1) then
			return true
		end
	end

	return false
end

function var_0_0.GetCookCfgName(arg_11_0, arg_11_1)
	local var_11_0 = CanteenConst.COOK_TYPE_NAME[arg_11_1]
	local var_11_1 = GetTips(var_11_0)

	if string.isNullOrEmpty(var_11_1) then
		print("未获取到厨具名字")
	end

	return var_11_1
end

function var_0_0.GetCookCfgNameByEid(arg_12_0, arg_12_1)
	if BackHomeCanteenFurnitureIDCfg[arg_12_1] then
		local var_12_0 = BackHomeCanteenFurnitureIDCfg[arg_12_1].type_id
		local var_12_1 = BackHomeCanteenFurnitureCfg[var_12_0].name

		if var_12_1 then
			return var_12_1
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
	local var_14_0 = DormEnum.FoodType[arg_14_1]

	if type(var_14_0) == "string" then
		return var_14_0
	elseif type(var_14_0) == "number" then
		return GetTips(var_14_0)
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
	local var_17_0 = CanteenHeroTools:GetCanteenJobList()

	for iter_17_0, iter_17_1 in pairs(var_17_0) do
		if iter_17_1.heroID == nil then
			return true
		end
	end

	return false
end

function var_0_0.AutoModeReadyForBusiness(arg_18_0)
	return arg_18_0:CheckSignFoodNumCanOpen() and arg_18_0:CheckCanteenJobCanOpen()
end

function var_0_0.SwitchCanteenBgm(arg_19_0, arg_19_1)
	if arg_19_1 == DormEnum.RestaurantMode.Start then
		local var_19_0 = MusicReference[1]

		manager.audio:PlayBGM(var_19_0.cuesheet, var_19_0.cueName, var_19_0.awbName)

		local var_19_1 = MusicReference[3]

		manager.audio:PlayBGM(var_19_1.cuesheet, var_19_1.cueName, var_19_1.awbName)
	elseif arg_19_1 == DormEnum.RestaurantMode.RestaurantAuto or arg_19_1 == DormEnum.RestaurantMode.Close then
		local var_19_2 = MusicReference[3]

		manager.audio:PlayBGM(var_19_2.cuesheet, var_19_2.cueName, var_19_2.awbName)
	elseif arg_19_1 == DormEnum.RestaurantMode.RestaurantManual then
		local var_19_3 = MusicReference[2]

		manager.audio:PlayBGM(var_19_3.cuesheet, var_19_3.cueName, var_19_3.awbName)
	end
end

function var_0_0.GetIndexByTaskDuring(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = BackHomeCanteenTaskCfg[arg_20_1]

	if var_20_0 then
		for iter_20_0, iter_20_1 in ipairs(var_20_0.time) do
			if arg_20_2 == iter_20_1[1] then
				return iter_20_0
			end
		end
	end
end

function var_0_0.ShowTipsGetCookCfgName(arg_21_0, arg_21_1)
	local var_21_0 = CanteenConst.COOK_TYPE_NAME[arg_21_1]

	if var_21_0 then
		return GetTips(var_21_0)
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

	local var_22_0 = DormData:GetHeroArchiveID(arg_22_0)

	if nullable(arg_22_1, var_22_0) then
		return false
	end

	return true
end

local function var_0_2(arg_23_0, arg_23_1)
	if GameSetting.dorm_canteen_work_fatigue.value[1] / 100 > DormData:GetHeroFatigue(arg_23_0) then
		return false
	end

	local var_23_0 = DormData:GetHeroTemplateInfo(arg_23_0)

	if CanteenEntrustData:CheckHasChooseEntrustCharacter(arg_23_0) or var_23_0.jobType then
		return false
	end

	if BackHomeTools.CheckHeroIsLockForAnyFeatureByHeroID(arg_23_0) then
		return false
	end

	local var_23_1 = DormData:GetHeroArchiveID(arg_23_0)

	if nullable(arg_23_1, var_23_1) then
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
			local var_25_1 = DormData:GetHeroArchiveID(iter_25_1)
			local var_25_2 = DormData:GetHeroFatigue(iter_25_1)
			local var_25_3 = DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.EntrustTotalFatigueReduce, iter_25_1)

			var_25_0.filter[var_25_1] = true

			table.insert(var_25_0.result, iter_25_1)

			var_25_0.need = var_25_0.need + var_25_2

			table.insert(var_25_0.reduce, var_25_3)
		end
	end

	return var_25_0
end

local function var_0_5(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4, arg_26_5)
	arg_26_5 = arg_26_5 or var_0_4(nil)

	if arg_26_4 > 0 then
		for iter_26_0, iter_26_1 in ipairs(arg_26_1) do
			local var_26_0 = arg_26_0[iter_26_1]

			for iter_26_2, iter_26_3 in ipairs(var_26_0) do
				local var_26_1 = DormData:GetHeroArchiveID(iter_26_3)

				if var_0_3(var_26_1, arg_26_5.filter) then
					local var_26_2 = DormData:GetHeroFatigue(iter_26_3)
					local var_26_3 = DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.EntrustTotalFatigueReduce, iter_26_3)

					table.insert(arg_26_5.result, iter_26_3)
					table.insert(arg_26_5.reduce, var_26_3)

					arg_26_5.need = arg_26_5.need + var_26_2
					arg_26_5.filter[var_26_1] = true

					local var_26_4 = 0

					for iter_26_4, iter_26_5 in ipairs(arg_26_5.reduce) do
						var_26_4 = math.min(100, var_26_4 + iter_26_5)
					end

					local var_26_5 = arg_26_2 - math.floor(arg_26_2 * var_26_3 / 100)

					if var_0_5(arg_26_0, arg_26_1, var_26_5, arg_26_3, arg_26_4 - 1, arg_26_5) then
						return true, arg_26_5.result
					end

					arg_26_5.need = arg_26_5.need - var_26_2
					arg_26_5.filter[var_26_1] = nil

					table.remove(arg_26_5.reduce)
					table.remove(arg_26_5.result)
				end
			end
		end
	end

	return arg_26_2 <= arg_26_5.need and arg_26_3 <= #arg_26_5.result, arg_26_5.result
end

function var_0_0.AnyAvailableEntrustHero()
	local var_27_0 = DormHeroTools:GetUnLockBackHomeHeroIDList()

	for iter_27_0, iter_27_1 in ipairs(var_27_0) do
		if var_0_2(iter_27_1) then
			return true
		end
	end

	return false
end

function var_0_0.AutoSelectEntrustHero(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = {}
	local var_28_1 = {}
	local var_28_2 = DormHeroTools:GetUnLockBackHomeHeroIDList()
	local var_28_3 = arg_28_0.id
	local var_28_4 = arg_28_0.tags

	for iter_28_0, iter_28_1 in ipairs(var_28_2) do
		if var_0_2(iter_28_1, arg_28_2) then
			local var_28_5 = CanteenEntrustData:CalHeroMatchNum(iter_28_1, var_28_4)
			local var_28_6 = DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.EntrustExternSucceedAdd, iter_28_1) / BackHomeCanteenTaskCfg[var_28_3].tag_success
			local var_28_7 = math.min(var_28_5 + var_28_6, DormConst.DORM_HERO_TAG_MAX)
			local var_28_8 = var_28_0[var_28_7]

			if var_28_8 == nil then
				var_28_8 = {}
				var_28_0[var_28_7] = var_28_8

				table.insert(var_28_1, var_28_7)
			end

			table.insert(var_28_8, iter_28_1)
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

	local var_28_9 = BackHomeCanteenTaskCfg[var_28_3].need
	local var_28_10 = var_28_9[1]
	local var_28_11, var_28_12 = var_28_9[2], BackHomeCanteenTaskCfg[var_28_3].cost

	if arg_28_1 then
		var_28_11 = var_28_11 - #arg_28_1
	end

	local var_28_13, var_28_14 = var_0_5(var_28_0, var_28_1, var_28_12, var_28_10, var_28_11, var_0_4(arg_28_1))

	if var_28_13 then
		return var_28_14
	end
end

function var_0_0.GetAvailableJobHeroList()
	return DormHeroTools:GetFilteredUnlockBackHomeHeroIDList(var_0_1)
end

return var_0_0
