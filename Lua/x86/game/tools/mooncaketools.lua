local var_0_0 = {}

function var_0_0.InitConst()
	var_0_0.materialItemIdList = {}
	var_0_0.fillingItemIdList = {}
	var_0_0.cakeItemIdList = {}
	var_0_0.giftItemIdList = {}
	var_0_0.cakeRecipeDic_ = {}
	var_0_0.cakeIdDicByCakeItemID_ = {}
	var_0_0.subActivityIdDic_ = {}
	var_0_0.mainActivityIdDic_ = {}
	var_0_0.tempVisitViewParams_ = {}
	var_0_0.tempDelegateViewParams_ = {}
	var_0_0.tempRecordViewParams_ = {}

	local var_1_0 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.MOON_CAKE]

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		local var_1_1 = {}
		local var_1_2 = ActivityCfg[iter_1_1].sub_activity_list

		for iter_1_2, iter_1_3 in ipairs(var_1_2) do
			if ActivityTools.GetActivityType(iter_1_3) == ActivityTemplateConst.MOON_CAKE_MAKE then
				var_1_1.cake_activity_id = iter_1_3
			elseif ActivityTools.GetActivityType(iter_1_3) == ActivityTemplateConst.MOON_CAKE_PARTY then
				var_1_1.party_activity_id = iter_1_3
			elseif ActivityTools.GetActivityType(iter_1_3) == ActivityTemplateConst.MOONBO then
				var_1_1.moon_bo_activity_id = iter_1_3
			end

			var_0_0.mainActivityIdDic_[iter_1_3] = iter_1_1
		end

		var_0_0.subActivityIdDic_[iter_1_1] = var_1_1
	end

	local var_1_3 = ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.MOON_FILLING_MATERIAL]
	local var_1_4 = ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.MOON_FILLING]
	local var_1_5 = ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.MOON_CAKE]
	local var_1_6 = ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.MOON_CAKE_GIFT]

	for iter_1_4, iter_1_5 in ipairs(var_1_3) do
		local var_1_7 = ItemCfg[iter_1_5].time[2][1]

		var_0_0.materialItemIdList[var_1_7] = var_0_0.materialItemIdList[var_1_7] or {}

		table.insert(var_0_0.materialItemIdList[var_1_7], iter_1_5)
	end

	for iter_1_6, iter_1_7 in ipairs(var_1_4) do
		local var_1_8 = ItemCfg[iter_1_7].time[2][1]

		var_0_0.fillingItemIdList[var_1_8] = var_0_0.fillingItemIdList[var_1_8] or {}

		table.insert(var_0_0.fillingItemIdList[var_1_8], iter_1_7)
	end

	for iter_1_8, iter_1_9 in ipairs(var_1_5) do
		local var_1_9 = ItemCfg[iter_1_9].time[2][1]

		var_0_0.cakeItemIdList[var_1_9] = var_0_0.cakeItemIdList[var_1_9] or {}

		table.insert(var_0_0.cakeItemIdList[var_1_9], iter_1_9)
	end

	for iter_1_10, iter_1_11 in ipairs(var_1_6) do
		local var_1_10 = ItemCfg[iter_1_11].time[2][1]

		var_0_0.giftItemIdList[var_1_10] = var_0_0.giftItemIdList[var_1_10] or {}

		table.insert(var_0_0.giftItemIdList[var_1_10], iter_1_11)
	end

	for iter_1_12, iter_1_13 in pairs(MoonCakeCfg.get_id_list_by_activity) do
		local var_1_11 = {}

		for iter_1_14, iter_1_15 in ipairs(iter_1_13) do
			local var_1_12 = MoonCakeCfg[iter_1_15].patties
			local var_1_13 = MoonCakeCfg[iter_1_15].mold

			var_1_11[var_1_12] = var_1_11[var_1_12] or {}
			var_1_11[var_1_12][var_1_13] = iter_1_15

			local var_1_14 = MoonCakeCfg[iter_1_15].moon_cakes

			var_0_0.cakeIdDicByCakeItemID_[var_1_14] = iter_1_15
		end

		var_0_0.cakeRecipeDic_[iter_1_12] = var_1_11
	end
end

function var_0_0.GetMainActivityID(arg_2_0)
	if not var_0_0.mainActivityIdDic_[arg_2_0] then
		-- block empty
	end

	return var_0_0.mainActivityIdDic_[arg_2_0]
end

function var_0_0.GetCakeStageActivityID(arg_3_0)
	if not var_0_0.subActivityIdDic_[arg_3_0].cake_activity_id then
		-- block empty
	end

	return var_0_0.subActivityIdDic_[arg_3_0].cake_activity_id
end

function var_0_0.GetPartyStageActivityID(arg_4_0)
	if not var_0_0.subActivityIdDic_[arg_4_0].party_activity_id then
		-- block empty
	end

	return var_0_0.subActivityIdDic_[arg_4_0].party_activity_id
end

function var_0_0.GetMoonBoStageActivityID(arg_5_0)
	if not var_0_0.subActivityIdDic_[arg_5_0].moon_bo_activity_id then
		-- block empty
	end

	return var_0_0.subActivityIdDic_[arg_5_0].moon_bo_activity_id
end

function var_0_0.GetCakeRecipeDic(arg_6_0)
	return var_0_0.cakeRecipeDic_[arg_6_0]
end

function var_0_0.GetCakeIdDicByCakeItemID()
	return var_0_0.cakeIdDicByCakeItemID_
end

function var_0_0.GetMaterialItemIdList(arg_8_0)
	return var_0_0.materialItemIdList[arg_8_0]
end

function var_0_0.GetFillingItemIdList(arg_9_0)
	return var_0_0.fillingItemIdList[arg_9_0]
end

function var_0_0.GetGiftItemIdList(arg_10_0)
	return var_0_0.giftItemIdList[arg_10_0]
end

function var_0_0.GetFillingMultiTimes(arg_11_0)
	local var_11_0 = 0
	local var_11_1 = 0
	local var_11_2 = MoonCakeFillingCfg[arg_11_0].recipe
	local var_11_3 = {}

	for iter_11_0, iter_11_1 in ipairs(var_11_2) do
		var_11_3[iter_11_0] = ItemTools.getItemNum(iter_11_1[1])
	end

	local var_11_4 = #var_11_3
	local var_11_5 = true

	while var_11_5 do
		for iter_11_2 = 1, var_11_4 do
			if var_11_3[iter_11_2] - var_11_2[iter_11_2][2] < 0 then
				var_11_5 = false

				break
			else
				var_11_3[iter_11_2] = var_11_3[iter_11_2] - var_11_2[iter_11_2][2]
			end
		end

		if var_11_5 then
			var_11_1 = var_11_1 + 1
		end
	end

	local var_11_6 = var_11_1 > 0 and 1 or 0

	return var_11_1, var_11_6
end

function var_0_0.GetSortedFilling(arg_12_0)
	local var_12_0 = deepClone(MoonCakeFillingCfg.get_id_list_by_activity[arg_12_0])
	local var_12_1 = {}

	local function var_12_2(arg_13_0, arg_13_1)
		if not var_12_1[arg_13_0] then
			var_12_1[arg_13_0] = var_0_0.GetFillingMultiTimes(arg_13_0)
		end

		if not var_12_1[arg_13_1] then
			var_12_1[arg_13_1] = var_0_0.GetFillingMultiTimes(arg_13_1)
		end

		if var_12_1[arg_13_0] == var_12_1[arg_13_1] then
			return arg_13_0 < arg_13_1
		else
			return var_12_1[arg_13_0] > var_12_1[arg_13_1]
		end
	end

	table.sort(var_12_0, var_12_2)

	return var_12_0
end

function var_0_0.CanVisitNext(arg_14_0)
	local var_14_0 = MoonCakeData:GetTempVisitIndex(arg_14_0)

	if not var_14_0 then
		return false
	end

	local var_14_1 = var_14_0.type
	local var_14_2 = var_14_0.index
	local var_14_3 = {}

	if var_14_1 == MoonCakeConst.VISIT_TYPE.ALL then
		var_14_3 = MoonCakeData:GetSortedRecommendPartyList(arg_14_0)
	elseif var_14_1 == MoonCakeConst.VISIT_TYPE.FRIEND then
		var_14_3 = MoonCakeData:GetSortedFriendPartyList(arg_14_0)
	end

	local var_14_4 = var_14_2 + 1

	if #var_14_3 > 0 and var_14_4 > #var_14_3 then
		return false
	end

	return true
end

function var_0_0.GetSortedCakeGroupList(arg_15_0)
	local var_15_0 = MoonCakeData:GetReceivedGroupDic(arg_15_0)
	local var_15_1 = MoonCakeData:GetUnlockCakeDic(arg_15_0)
	local var_15_2 = MoonCakeGroupCfg.get_id_list_by_activity[arg_15_0]
	local var_15_3 = {}
	local var_15_4 = {}
	local var_15_5 = {}

	for iter_15_0, iter_15_1 in ipairs(var_15_2) do
		if var_15_0[iter_15_1] then
			var_15_3[#var_15_3 + 1] = iter_15_1
		else
			local var_15_6 = true
			local var_15_7 = MoonCakeGroupCfg[iter_15_1].collect_condition

			for iter_15_2, iter_15_3 in ipairs(var_15_7) do
				if not var_15_1[iter_15_3] then
					var_15_5[#var_15_5 + 1] = iter_15_1
					var_15_6 = false

					break
				end
			end

			if var_15_6 then
				var_15_4[#var_15_4 + 1] = iter_15_1
			end
		end
	end

	table.insertto(var_15_4, var_15_5)
	table.insertto(var_15_4, var_15_3)

	return var_15_4
end

function var_0_0.GetCakeItemIdList(arg_16_0)
	return var_0_0.cakeItemIdList[arg_16_0] or {}
end

function var_0_0.CheckPartyPlanValid(arg_17_0, arg_17_1)
	local var_17_0 = 0
	local var_17_1 = 0
	local var_17_2 = false

	if arg_17_1 == MoonCakeConst.PARTY_TYPE.CAKE then
		local var_17_3 = var_0_0.GetMainActivityID(arg_17_0)
		local var_17_4 = var_0_0.cakeItemIdList[var_17_3]

		for iter_17_0, iter_17_1 in ipairs(var_17_4) do
			var_17_0 = var_17_0 + ItemTools.getItemNum(iter_17_1)
		end

		var_17_1 = GameSetting.activity_mid_autumn_party_consume_1.value[1]
		var_17_2 = var_17_1 <= var_17_0
	elseif arg_17_1 == MoonCakeConst.PARTY_TYPE.VISIT then
		var_17_0 = MoonCakeData:GetTodayVisitTimes(arg_17_0)
		var_17_1 = GameSetting.activity_mid_autumn_party_consume_2.value[1]
		var_17_2 = var_17_1 <= var_17_0
	end

	return var_17_2, var_17_0, var_17_1
end

function var_0_0.SetTempVisitViewType(arg_18_0, arg_18_1)
	var_0_0.tempVisitViewParams_[arg_18_0] = var_0_0.tempVisitViewParams_[arg_18_0] or {}
	var_0_0.tempVisitViewParams_[arg_18_0].type = arg_18_1
end

function var_0_0.GetTempVisitViewType(arg_19_0)
	return var_0_0.tempVisitViewParams_[arg_19_0].type
end

function var_0_0.SetTempVisitViewScrollPos(arg_20_0, arg_20_1)
	var_0_0.tempVisitViewParams_[arg_20_0] = var_0_0.tempVisitViewParams_[arg_20_0] or {}
	var_0_0.tempVisitViewParams_[arg_20_0].scrollPos = arg_20_1
end

function var_0_0.GetTempVisitViewScrollPos(arg_21_0)
	return var_0_0.tempVisitViewParams_[arg_21_0].scrollPos
end

function var_0_0.SetTempDelegateViewPageIndex(arg_22_0, arg_22_1)
	var_0_0.tempDelegateViewParams_[arg_22_0] = var_0_0.tempDelegateViewParams_[arg_22_0] or {}
	var_0_0.tempDelegateViewParams_[arg_22_0].pageIndex = arg_22_1
end

function var_0_0.GetTempDelegateViewPageIndex(arg_23_0)
	return var_0_0.tempDelegateViewParams_[arg_23_0].pageIndex
end

function var_0_0.SetTempDelegateViewScrollPos(arg_24_0, arg_24_1)
	var_0_0.tempDelegateViewParams_[arg_24_0] = var_0_0.tempDelegateViewParams_[arg_24_0] or {}
	var_0_0.tempDelegateViewParams_[arg_24_0].scrollPos = arg_24_1
end

function var_0_0.GetTempDelegateViewScrollPos(arg_25_0)
	return var_0_0.tempDelegateViewParams_[arg_25_0].scrollPos
end

function var_0_0.SetTempRecordViewType(arg_26_0, arg_26_1)
	var_0_0.tempRecordViewParams_[arg_26_0] = var_0_0.tempRecordViewParams_[arg_26_0] or {}
	var_0_0.tempRecordViewParams_[arg_26_0].type = arg_26_1
end

function var_0_0.GetTempRecordViewType(arg_27_0)
	return var_0_0.tempRecordViewParams_[arg_27_0].type
end

function var_0_0.SetTempRecordViewScrollPos(arg_28_0, arg_28_1)
	var_0_0.tempRecordViewParams_[arg_28_0] = var_0_0.tempRecordViewParams_[arg_28_0] or {}
	var_0_0.tempRecordViewParams_[arg_28_0].scrollPos = arg_28_1
end

function var_0_0.GetTempRecordViewScrollPos(arg_29_0)
	return var_0_0.tempRecordViewParams_[arg_29_0].scrollPos
end

return var_0_0
