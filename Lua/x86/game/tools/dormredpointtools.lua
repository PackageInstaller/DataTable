local var_0_0 = {
	UpdataGlobalRedPoint = function(arg_1_0)
		arg_1_0:UpdataDormGlobalRedPoint()
		arg_1_0:UpdateCanteenNotify()
		arg_1_0:UpdataSuitShopRedPoint()
		arg_1_0:UpdateDormIlluRedPoint()
		arg_1_0:RefreshDormIlluNew()
	end,
	EnterDormitorySystem = function(arg_2_0)
		arg_2_0:InitSuitRedPointData()
		arg_2_0:InitFurPlaceRedPointData()
		arg_2_0:UpdataSuitShopRedPoint()
	end,
	ExitDormitorySystem = function(arg_3_0)
		arg_3_0:SaveSuitRedRedPointData()
		arg_3_0:SaveSuitGoodRedPointData()
	end,
	UpdataDormGlobalRedPoint = function(arg_4_0)
		arg_4_0:UpdataDormRedPoint()
	end,
	FurnitureItemRedPoint = function(arg_5_0, arg_5_1)
		return string.format("%s_%s_%s", RedPointConst.DORM_SUIT_SHOP, tostring(arg_5_0), tostring(arg_5_1))
	end,
	UpdataDormRedPoint = function(arg_6_0, arg_6_1)
		local var_6_0 = DormitoryData:GetDormMapList()

		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM) or not var_6_0 then
			return
		end

		if arg_6_1 == false then
			manager.redPoint:setTip(RedPointConst.DORM_PLACEMENT, 0)

			local var_6_1 = DormData:GetHeroInfoList()
			local var_6_2 = {}

			for iter_6_0, iter_6_1 in pairs(var_6_1) do
				if DormData:GetHeroInfo(iter_6_0):GetHeroFavorability() >= GameSetting.dorm_hero_set_level.value[1] then
					table.insert(var_6_2, iter_6_0)
				end
			end

			saveData("RedPoint", RedPointConst.DORM_PLACEMENT, var_6_2)

			return
		end

		local var_6_3 = getData("RedPoint", RedPointConst.DORM_PLACEMENT)
		local var_6_4 = DormData:GetHeroInfoList()

		if not var_6_4 then
			return
		end

		local var_6_5 = false

		for iter_6_2, iter_6_3 in pairs(var_6_4) do
			if not DormRoomTools:GetDormIDViaArchive(iter_6_2) and DormData:GetHeroInfo(iter_6_2):GetHeroFavorability() >= GameSetting.dorm_hero_set_level.value[1] then
				var_6_5 = true

				if var_6_3 then
					for iter_6_4, iter_6_5 in ipairs(var_6_3) do
						if iter_6_2 == iter_6_5 then
							var_6_5 = false

							break
						end
					end
				end
			end
		end

		local var_6_6 = false

		for iter_6_6, iter_6_7 in pairs(var_6_0) do
			if BackHomeCfg[iter_6_6].type == DormConst.BACKHOME_TYPE.PrivateDorm and (not iter_6_7.archiveIDList or #iter_6_7.archiveIDList == 0) then
				var_6_6 = true
			end
		end

		if var_6_5 and var_6_6 then
			manager.redPoint:setTip(RedPointConst.DORM_PLACEMENT, 1)
		end
	end
}
local var_0_1

function var_0_0.InitFurPlaceRedPointData(arg_7_0)
	var_0_1 = {}

	for iter_7_0 = DormConst.DORM_FUR_TYPE_START, DormConst.DORM_FUR_TYPE_END do
		local var_7_0 = string.format("%s_%s", RedPointConst.DORM_FURNITURE, tostring(iter_7_0))
		local var_7_1 = getData("RedPoint", var_7_0)

		var_0_1[iter_7_0] = {}

		if var_7_1 then
			if tostring(var_7_1[1]) == "userdata: NULL" then
				for iter_7_1, iter_7_2 in pairs(var_7_1) do
					if tostring(iter_7_2) ~= "userdata: NULL" then
						var_0_1[iter_7_0][iter_7_1] = iter_7_2
					end
				end
			else
				for iter_7_3, iter_7_4 in ipairs(var_7_1) do
					if iter_7_4[2] and tostring(iter_7_4[2]) ~= "userdata: NULL" then
						var_0_1[iter_7_0][iter_7_4[1]] = iter_7_4[2]
					end
				end
			end
		end
	end
end

function var_0_0.SaveFurPlaceRedPointData(arg_8_0)
	if var_0_1 then
		for iter_8_0, iter_8_1 in pairs(var_0_1) do
			local var_8_0 = string.format("%s_%s", RedPointConst.DORM_FURNITURE, tostring(iter_8_0))
			local var_8_1 = {}

			for iter_8_2, iter_8_3 in pairs(iter_8_1) do
				local var_8_2 = {
					iter_8_2,
					iter_8_3
				}

				table.insert(var_8_1, var_8_2)
			end

			saveData("RedPoint", var_8_0, var_8_1)
		end
	end
end

function var_0_0.UpdataDormFurRedPoint(arg_9_0, arg_9_1, arg_9_2)
	if BackHomeCfg[arg_9_1].type == DormConst.BACKHOME_TYPE.VISITPUBLICDORM or BackHomeCfg[arg_9_1].type == DormConst.BACKHOME_TYPE.VISITPRIVATEDORM then
		local var_9_0 = string.format("%s_%s", RedPointConst.DORM_FURNITURE, tostring(arg_9_2))

		manager.redPoint:setTip(var_9_0, 0)

		return
	end

	local var_9_1 = DormitoryData:GetDormMapList()

	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM) then
		return
	end

	local var_9_2 = string.format("%s_%s", RedPointConst.DORM_FURNITURE, tostring(arg_9_2))
	local var_9_3 = (var_0_1[arg_9_2] or {})[arg_9_1]

	if tostring(var_9_3) == "userdata: NULL" then
		var_9_3 = {}
	end

	var_9_3 = var_9_3 or {}

	local var_9_4 = DormFurnitureTools:GetRoomCanPlaceFurList(arg_9_1)

	if BackHomeCfg[arg_9_1].type == DormConst.BACKHOME_TYPE.PublicDorm then
		for iter_9_0, iter_9_1 in ipairs(var_9_4) do
			if BackHomeFurniture[iter_9_1].type == arg_9_2 then
				local var_9_5 = DormData:GetFurNumInfo(iter_9_1).num
				local var_9_6 = 0

				for iter_9_2, iter_9_3 in ipairs(var_9_3) do
					if iter_9_3.furID == iter_9_1 then
						var_9_6 = iter_9_3.num
					end
				end

				if var_9_6 < var_9_5 then
					manager.redPoint:setTip(var_9_2, 1)

					return
				end
			end
		end
	elseif BackHomeCfg[arg_9_1].type == DormConst.BACKHOME_TYPE.PrivateDorm then
		for iter_9_4, iter_9_5 in ipairs(var_9_4) do
			if BackHomeFurniture[iter_9_5].type == arg_9_2 then
				local var_9_7 = var_9_1[arg_9_1].give_furnitures[iter_9_5] or 0
				local var_9_8 = 0

				for iter_9_6, iter_9_7 in ipairs(var_9_3) do
					if iter_9_7.furID == iter_9_5 then
						var_9_8 = iter_9_7.num
					end
				end

				if var_9_8 < var_9_7 then
					manager.redPoint:setTip(var_9_2, 1)

					return
				end
			end
		end
	end

	manager.redPoint:setTip(var_9_2, 0)
end

function var_0_0.CloseDormFurRedPoint(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = DormitoryData:GetDormMapList()

	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM) then
		return
	end

	local var_10_1 = string.format("%s_%s", RedPointConst.DORM_FURNITURE, tostring(arg_10_2))
	local var_10_2 = (var_0_1[arg_10_2] or {})[arg_10_1]

	if tostring(var_10_2) == "userdata: NULL" then
		var_10_2 = {}
	end

	var_10_2 = var_10_2 or {}

	if BackHomeCfg[arg_10_1].type == DormConst.BACKHOME_TYPE.PublicDorm then
		for iter_10_0, iter_10_1 in ipairs(arg_10_3) do
			local var_10_3 = iter_10_1.furID
			local var_10_4 = false

			for iter_10_2, iter_10_3 in ipairs(var_10_2) do
				if iter_10_3.furID == var_10_3 then
					iter_10_3.num = DormData:GetFurNumInfo(var_10_3).num
					var_10_4 = true

					break
				end
			end

			if not var_10_4 then
				local var_10_5 = DormData:GetFurNumInfo(var_10_3).num
				local var_10_6 = {
					furID = var_10_3,
					num = var_10_5
				}

				table.insert(var_10_2, var_10_6)
			end
		end
	elseif BackHomeCfg[arg_10_1].type == DormConst.BACKHOME_TYPE.PrivateDorm then
		for iter_10_4, iter_10_5 in pairs(var_10_0[arg_10_1].give_furnitures) do
			local var_10_7 = false

			for iter_10_6, iter_10_7 in ipairs(var_10_2) do
				if iter_10_7.furID == iter_10_4 then
					iter_10_7.num = iter_10_5
					var_10_7 = true

					break
				end
			end

			if not var_10_7 then
				local var_10_8 = {
					furID = iter_10_4,
					num = iter_10_5
				}

				table.insert(var_10_2, var_10_8)
			end
		end
	end

	if not var_0_1[arg_10_2] then
		var_0_1[arg_10_2] = {}
	end

	var_0_1[arg_10_2][arg_10_1] = var_10_2

	local var_10_9 = string.format("%s_%s", RedPointConst.DORM_FURNITURE, tostring(arg_10_2))

	manager.redPoint:setTip(var_10_9, 0)
	arg_10_0:SaveFurPlaceRedPointData()
end

local var_0_2

function var_0_0.InitSuitRedPointData(arg_11_0)
	var_0_2 = {}

	local var_11_0 = RedPointConst.DORM_SUIT
	local var_11_1 = getData("RedPoint", var_11_0) or {}

	if tostring(var_11_1) == "userdata: NULL" then
		var_11_1 = {}
	end

	for iter_11_0, iter_11_1 in ipairs(var_11_1) do
		var_0_2[iter_11_1] = true
	end
end

function var_0_0.SaveSuitRedRedPointData(arg_12_0)
	if var_0_2 then
		local var_12_0 = {}

		for iter_12_0, iter_12_1 in pairs(var_0_2) do
			table.insert(var_12_0, iter_12_0)
		end

		local var_12_1 = RedPointConst.DORM_SUIT

		saveData("RedPoint", var_12_1, var_12_0)
	end
end

function var_0_0.UpdataSuitRedPoint(arg_13_0)
	if BackHomeDataManager:GetCurSystem() ~= DormEnum.DormSystemType.Dormitory then
		return
	end

	if not var_0_2 then
		var_0_2 = {}
	end

	local var_13_0 = false
	local var_13_1 = DormSuitData:GetUnLockSuitList()

	for iter_13_0, iter_13_1 in ipairs(var_13_1) do
		if not var_0_2[iter_13_1] then
			local var_13_2 = true
			local var_13_3, var_13_4 = DormSuitData:CheckIsConfigSuit(iter_13_1)
			local var_13_5

			if var_13_4 == DormSuitTools.DORM_SUIT_TYPE.FULL_SET then
				local var_13_6 = BackHomeSuitCfg[iter_13_1].scene_id[1]

				if var_13_6 == DormConst.BACKHOME_TYPE.PublicDorm then
					var_13_5 = RedPointConst.DORM_FULL_PUBLIC_SUIT
				elseif var_13_6 == DormConst.BACKHOME_TYPE.PrivateDorm then
					var_13_5 = RedPointConst.DORM_FULL_PRIVATE_SUIT
				end
			elseif var_13_4 == DormSuitTools.DORM_SUIT_TYPE.PART_SET then
				var_13_5 = RedPointConst.DORM_PART_SUIT
			end

			local var_13_7 = string.format("%s_%s", var_13_5, tostring(iter_13_1))

			manager.redPoint:setTip(var_13_7, var_13_2 and 1 or 0)
		end
	end
end

function var_0_0.ClickSuitIconRedPoint(arg_14_0, arg_14_1)
	if var_0_2[arg_14_1] then
		return
	end

	local var_14_0, var_14_1 = DormSuitData:CheckIsConfigSuit(arg_14_1)
	local var_14_2

	if var_14_1 == DormSuitTools.DORM_SUIT_TYPE.FULL_SET then
		local var_14_3 = BackHomeSuitCfg[arg_14_1].scene_id[1]

		if var_14_3 == DormConst.BACKHOME_TYPE.PublicDorm then
			var_14_2 = RedPointConst.DORM_FULL_PUBLIC_SUIT
		elseif var_14_3 == DormConst.BACKHOME_TYPE.PrivateDorm then
			var_14_2 = RedPointConst.DORM_FULL_PRIVATE_SUIT
		end
	elseif var_14_1 == DormSuitTools.DORM_SUIT_TYPE.PART_SET then
		var_14_2 = RedPointConst.DORM_PART_SUIT
	end

	local var_14_4 = string.format("%s_%s", var_14_2, tostring(arg_14_1))

	manager.redPoint:setTip(var_14_4, 0)

	var_0_2[arg_14_1] = true

	arg_14_0:SaveSuitRedRedPointData()
end

local var_0_3

function var_0_0.UpdataSuitShopRedPoint(arg_15_0)
	arg_15_0:GetSuitShopCache()

	local var_15_0 = DormTools:GetAllDormShopIDList()

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		var_0_0:UpdataSingleDormShopRedPoint(iter_15_1)
	end
end

function var_0_0.GetSuitShopCache(arg_16_0)
	if not var_0_3 then
		local var_16_0 = RedPointConst.DORM_SUIT_SHOP
		local var_16_1 = getData("RedPoint", var_16_0) or {}

		var_0_3 = {}

		for iter_16_0, iter_16_1 in ipairs(var_16_1) do
			var_0_3[iter_16_1.id] = {}

			for iter_16_2, iter_16_3 in ipairs(iter_16_1.goodList) do
				var_0_3[iter_16_1.id][iter_16_3] = true
			end
		end
	end
end

function var_0_0.SaveSuitGoodRedPointData(arg_17_0, arg_17_1)
	local var_17_0 = RedPointConst.DORM_SUIT_SHOP

	if var_0_3 then
		local var_17_1 = {}

		for iter_17_0, iter_17_1 in pairs(var_0_3) do
			local var_17_2 = {
				id = iter_17_0
			}
			local var_17_3 = {}

			for iter_17_2, iter_17_3 in pairs(iter_17_1) do
				table.insert(var_17_3, iter_17_2)
			end

			var_17_2.goodList = var_17_3

			table.insert(var_17_1, var_17_2)
		end

		saveData("RedPoint", var_17_0, var_17_1)
	end

	if not arg_17_1 then
		var_0_3 = nil
	end
end

function var_0_0.UpdataSingleDormShopRedPoint(arg_18_0, arg_18_1)
	arg_18_0:GetSuitShopCache()

	local var_18_0 = var_0_3[arg_18_1] or {}
	local var_18_1 = DormSuitTools:GetFurSuitGoodListByShopID(arg_18_1)

	for iter_18_0, iter_18_1 in ipairs(var_18_1) do
		if not var_18_0[iter_18_1] and ShopTools.IsGoodCanBuyInShop(arg_18_1, iter_18_1) and not ShopTools.CheckSoldOut(iter_18_1) then
			local var_18_2 = var_0_0.FurnitureItemRedPoint(arg_18_1, iter_18_1)

			manager.redPoint:setTip(var_18_2, 1)
		end
	end
end

function var_0_0.CloseSingleSuitGoodRedPoint(arg_19_0, arg_19_1, arg_19_2)
	arg_19_0:GetSuitShopCache()

	local var_19_0 = var_0_0.FurnitureItemRedPoint(arg_19_1, arg_19_2)

	if manager.redPoint:getTipBoolean(var_19_0) then
		local var_19_1 = var_0_3[arg_19_1] or {}

		manager.redPoint:setTip(var_19_0, 0)

		var_19_1[arg_19_2] = true
		var_0_3[arg_19_1] = var_19_1

		arg_19_0:SaveSuitGoodRedPointData(true)
	end
end

function var_0_0.CloseAllSuitGoodRedPoint(arg_20_0, arg_20_1)
	arg_20_0:GetSuitShopCache()

	local var_20_0 = ShopTools.GetShopRedPointKey(arg_20_1)

	if manager.redPoint:getTipBoolean(var_20_0) then
		local var_20_1 = DormSuitTools:GetFurSuitGoodListByShopID(arg_20_1)
		local var_20_2 = var_0_3[arg_20_1] or {}

		for iter_20_0, iter_20_1 in ipairs(var_20_1) do
			local var_20_3 = var_0_0.FurnitureItemRedPoint(arg_20_1, iter_20_1)

			if manager.redPoint:getTipBoolean(var_20_3) then
				manager.redPoint:setTip(var_20_3, 0)

				var_20_2[iter_20_1] = true
			end
		end

		var_0_3[arg_20_1] = var_20_2

		arg_20_0:SaveSuitGoodRedPointData(true)
	end
end

var_0_0.RedPointType = {
	Session = 1,
	LocalMachine = 2,
	Normal = 0
}

function var_0_0.SkipNotify(arg_21_0, arg_21_1)
	return RedPointData:GetSessionCacheRedPoint(arg_21_1) == RedPointData.HasNotified or RedPointData:GetJsonCacheRedPoint(arg_21_1) == RedPointData.HasNotified
end

function var_0_0.Notify(arg_22_0, arg_22_1, arg_22_2)
	arg_22_2 = (arg_22_2 == false or arg_22_0:SkipNotify(arg_22_1)) and 0 or 1

	if arg_22_2 ~= manager.redPoint:getTipBoolean(arg_22_1) then
		manager.redPoint:setTip(arg_22_1, arg_22_2)
	end
end

function var_0_0.ConsumeNotification(arg_23_0, arg_23_1, arg_23_2)
	manager.redPoint:setTip(arg_23_1, 0)

	if arg_23_2 == var_0_0.RedPointType.Session and RedPointData:GetSessionCacheRedPoint(arg_23_1) ~= 0 then
		RedPointData:SetSessionCacheRedPoint(arg_23_1)
	elseif arg_23_2 == var_0_0.RedPointType.LocalMachine and RedPointData:GetJsonCacheRedPoint(arg_23_1) ~= 0 then
		RedPointData:SetJsonCacheRedPoint(arg_23_1)
	end
end

function var_0_0.CheckCanteenOpen(arg_24_0)
	local var_24_0 = CanteenTools:CheckSignFoodNumCanOpen()
	local var_24_1 = true

	for iter_24_0, iter_24_1 in ipairs(DormConst.DORM_RESTAURANT_SET_JOB_TYPE) do
		if not CanteenHeroTools:HasJobAssignedToHero(iter_24_1) then
			var_24_1 = false

			break
		end
	end

	return var_24_0 and var_24_1
end

function var_0_0.CheckUnLockEntrustRedPoint(arg_25_0)
	local var_25_0 = CanteenEntrustData:GetEntrustList()

	if var_25_0 then
		for iter_25_0, iter_25_1 in pairs(var_25_0) do
			local var_25_1 = false

			if iter_25_1.id < 0 then
				local var_25_2 = GameSetting.dorm_canteen_task_unlock.value[iter_25_0][2]
				local var_25_3
				local var_25_4
				local var_25_5

				if var_25_2 ~= 0 then
					local var_25_6, var_25_7

					var_25_3, var_25_6, var_25_7 = IsConditionAchieved(var_25_2)
				else
					var_25_3 = true
				end

				var_25_1 = var_25_3
			end

			arg_25_0:Notify(string.format("%s_%s", RedPointConst.CANTEEN_UNLOCK_ENTRUST, iter_25_0), var_25_1)
		end
	end
end

function var_0_0.CheckUnLockFoodRedPoint(arg_26_0)
	for iter_26_0, iter_26_1 in ipairs(BackHomeCanteenFoodCfg.all) do
		local var_26_0 = false

		if BackHomeCanteenFoodCfg[iter_26_1].unlock > 0 and CanteenTools:CheckFoodUnLock(iter_26_1) then
			var_26_0 = true
		end

		local var_26_1 = tostring(BackHomeCanteenFoodCfg[iter_26_1].cook_type)

		arg_26_0:Notify(string.format("%s_%s_%s", RedPointConst.CANTEEN_UNLOCK_FOOD, var_26_1, iter_26_1), var_26_0)
	end
end

function var_0_0.CheckCanLevelUpFurRedPoint(arg_27_0)
	for iter_27_0, iter_27_1 in pairs(DormEnum.FurnitureMainType) do
		arg_27_0:Notify(string.format("%s_%s", RedPointConst.CANTEEN_UPGRADE_AVAILABLE, tostring(iter_27_1)), CanteenTools:CheckAllFurCanLevelUp(iter_27_1))
	end
end

function var_0_0.UpdateCanteenNotify(arg_28_0)
	if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM) then
		local var_28_0 = arg_28_0:CheckCanteenOpen()

		arg_28_0:Notify(RedPointConst.CANTEEN_BUSINESS_STOPPED, not var_28_0)

		local var_28_1 = CanteenEntrustData.NoAnyEntrustDispatched()
		local var_28_2 = false
		local var_28_3 = (getData("DormTaskRedpoint", "lastClickTime") or 0) < manager.time:GetTodayFreshTime() and true or false

		arg_28_0:Notify(RedPointConst.CANTEEN_DISPATCH_NONE, var_28_1 and var_28_3)

		local var_28_4 = CanteenEntrustData.AnyEntrustFinished()

		arg_28_0:Notify(RedPointConst.CANTEEN_DISPATCH_FINISHED, var_28_4)
		arg_28_0:Notify(RedPointConst.CANTEEN_JOB_AVAILABLE, CanteenTools:AnyJobAvailable())

		local var_28_5 = CanteenEntrustData.EntrustFinishList()

		for iter_28_0 = 1, 4 do
			if table.indexof(var_28_5, iter_28_0) then
				arg_28_0:Notify(string.format("%s_%s", RedPointConst.CANTEEN_DISPATCH_FINISHED, iter_28_0), true)
			else
				arg_28_0:Notify(string.format("%s_%s", RedPointConst.CANTEEN_DISPATCH_FINISHED, iter_28_0), false)
			end
		end

		arg_28_0:CheckUnLockEntrustRedPoint()
		arg_28_0:CheckUnLockFoodRedPoint()
		arg_28_0:CheckCanLevelUpFurRedPoint()
		arg_28_0:CheckAutoAwardNumRedPoint()
	end
end

function var_0_0.CheckAutoAwardNumRedPoint(arg_29_0)
	local var_29_0 = CanteenData:GetAutoAwardNum() or 0
	local var_29_1 = DormSkillData:GetInComeStorageMax()

	if var_29_0 == var_29_1 and var_29_1 > 0 then
		arg_29_0:Notify(RedPointConst.CANTEEN_MAX, true)
	else
		arg_29_0:Notify(RedPointConst.CANTEEN_MAX, false)
	end
end

function var_0_0.UpdateDormIlluRedPoint(arg_30_0, arg_30_1)
	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM) then
		return
	end

	local var_30_0 = TaskTools:GetFinishTaskIds(TaskConst.TASK_TYPE.DORM_ILLU)
	local var_30_1 = {}

	for iter_30_0 = 1, #var_30_0 do
		if arg_30_1 == nil or AssignmentCfg[var_30_0[iter_30_0]].condition == arg_30_1 then
			table.insert(var_30_1, var_30_0[iter_30_0])
		end
	end

	local var_30_2 = 0
	local var_30_3 = arg_30_1 == DormIlluConst.TaskCondition.hero and 1 or arg_30_1 == DormIlluConst.TaskCondition.dance and 2 or 3

	if #var_30_1 > 0 then
		manager.redPoint:setTip(RedPointConst.DORM_ILLU_REWARD .. "_" .. tostring(var_30_3), 1)
	else
		manager.redPoint:setTip(RedPointConst.DORM_ILLU_REWARD .. "_" .. tostring(var_30_3), 0)
	end
end

function var_0_0.SetIlluHeroNewTagRed(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM) then
		return
	end

	local var_31_0 = getData("dormIllu", arg_31_1) or 0

	if var_31_0 then
		local var_31_1 = false

		if not arg_31_3 then
			var_31_1 = true
			var_31_0 = 0

			manager.redPoint:setTip(arg_31_2, 0, RedPointStyle.NORMAL)
		else
			var_31_1 = true
			var_31_0 = 1

			manager.redPoint:setTip(arg_31_2, 1, RedPointStyle.NORMAL)
		end

		if var_31_1 then
			saveData("dormIllu", arg_31_1, var_31_0)
		end
	end

	arg_31_0:RefreshDormIlluNew()
end

function var_0_0.SetIlluNewTagRed(arg_32_0, arg_32_1, arg_32_2, arg_32_3, arg_32_4)
	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM) then
		return
	end

	local var_32_0 = getData("dormIllu", arg_32_1) or {}

	if var_32_0 then
		local var_32_1 = 0

		for iter_32_0, iter_32_1 in ipairs(var_32_0) do
			if iter_32_1 == arg_32_4 then
				var_32_1 = iter_32_0

				break
			end
		end

		local var_32_2 = false

		if var_32_1 > 0 then
			if not arg_32_3 then
				var_32_2 = true

				table.remove(var_32_0, var_32_1)
				manager.redPoint:setTip(arg_32_2 .. arg_32_4, 0, RedPointStyle.NORMAL)
			end
		elseif arg_32_3 then
			var_32_2 = true

			table.insert(var_32_0, arg_32_4)
			manager.redPoint:setTip(arg_32_2 .. arg_32_4, 1, RedPointStyle.NORMAL)
		end

		if var_32_2 then
			saveData("dormIllu", arg_32_1, var_32_0)
		end
	end

	arg_32_0:RefreshDormIlluNew()
end

function var_0_0.SetDanceRed(arg_33_0)
	local var_33_0 = {}

	for iter_33_0, iter_33_1 in ipairs(IdolDanceDIYActionCfg.all) do
		if IdolTraineeData:DanceDIYActionAvailable(iter_33_1) then
			table.insert(var_33_0, iter_33_1)
		end
	end

	saveData("dormIllu", "danceNew", var_33_0)
	arg_33_0:RefreshDormIlluNew()
end

function var_0_0.RefreshDormIlluNew(arg_34_0)
	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM) then
		return
	end

	local var_34_0 = getData("dormIllu", "heroNew") or 0

	if var_34_0 and var_34_0 == 1 then
		manager.redPoint:setTip(RedPointConst.DORM_ILLU_HERO, 1, RedPointStyle.NORMAL)
	else
		manager.redPoint:setTip(RedPointConst.DORM_ILLU_HERO, 0, RedPointStyle.NORMAL)
	end

	for iter_34_0, iter_34_1 in ipairs(BackHomeFurnitureThemeCfg.all) do
		local var_34_1 = RedPointConst.DORM_ILLU_FUR_THEME .. iter_34_1

		manager.redPoint:setTip(var_34_1, 0, RedPointStyle.NORMAL)
	end

	local var_34_2 = getData("dormIllu", "furNew") or {}

	for iter_34_2, iter_34_3 in pairs(var_34_2) do
		local var_34_3 = RedPointConst.DORM_ILLU_FUR_THEME .. iter_34_3

		manager.redPoint:setTip(var_34_3, 1, RedPointStyle.NORMAL)
	end

	arg_34_0:RefreshIlluDanceNew()
end

function var_0_0.RefreshIlluDanceNew(arg_35_0)
	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM) then
		return
	end

	local var_35_0 = getData("dormIllu", "danceNew")

	if var_35_0 == nil then
		local var_35_1 = {}
		local var_35_2 = IdolDanceDIYActionCfg.all

		for iter_35_0, iter_35_1 in ipairs(var_35_2) do
			if IdolTraineeData:DanceDIYActionAvailable(iter_35_1) then
				table.insert(var_35_1, iter_35_1)
			end
		end

		saveData("dormIllu", "danceNew", var_35_1)

		var_35_0 = getData("dormIllu", "danceNew")
	end

	local var_35_3 = false

	for iter_35_2, iter_35_3 in pairs(IdolDanceDIYActionCfg.all) do
		if IdolTraineeData:DanceDIYActionAvailable(iter_35_3) then
			local var_35_4 = false

			for iter_35_4, iter_35_5 in pairs(var_35_0) do
				if iter_35_5 == iter_35_3 then
					var_35_4 = true

					break
				end
			end

			if not var_35_4 then
				var_35_3 = true

				break
			end
		end
	end

	if var_35_3 then
		manager.redPoint:setTip(RedPointConst.DORM_ILLU_DANCE, 1, RedPointStyle.NORMAL)
	else
		manager.redPoint:setTip(RedPointConst.DORM_ILLU_DANCE, 0, RedPointStyle.NORMAL)
	end
end

return var_0_0
