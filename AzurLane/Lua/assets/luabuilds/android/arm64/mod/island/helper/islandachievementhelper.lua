class = var_0_10000

local var_0_0 = var_0_10000("IslandAchievementHelper")

function var_0_0.GetRuntimeData(arg_1_0, arg_1_1)
	getProxy = var_1_10002
	IslandProxy = var_1_10004

	local var_1_0 = var_1_10002(var_1_10004)
	local var_1_1 = var_2.GetIsland(var_1_0)
	local var_1_2 = var_2.GetCharacterAgency(var_1_1)

	switch = var_1_0

	local var_1_3 = arg_1_0
	local var_1_4 = {}

	IslandAchievementType = var_1_10008
	var_1_4[var_1_10008.ISLAND_LV] = function()
		local var_2_0 = var_0

		return var_0.GetLevel(var_2_0)
	end
	IslandAchievementType = var_8
	var_1_4[var_8.FINISH_MAIN_TASK] = function()
		local var_3_0 = var_0
		local var_3_1 = var_0.GetTaskAgency(var_3_0)

		return var_0.IsFinishTask(var_3_1, arg_1_1) and 1 or 0
	end
	IslandAchievementType = var_8
	var_1_4[var_8.SHIP_LV] = function()
		underscore = var_2_10000

		local var_4_0 = var_2_10000.reduce
		local var_4_1 = var_1_2

		return var_4_0(var_2.GetShips(var_4_1), 0, function(arg_5_0, arg_5_1)
			return arg_5_0 + (arg_5_1:GetLevel() >= arg_1_1 and 1 or 0)
		end)
	end
	IslandAchievementType = var_8
	var_1_4[var_8.SHIP_SKILL_LV] = function()
		underscore = var_2_10000

		local var_6_0 = var_2_10000.reduce
		local var_6_1 = var_1_2

		return var_6_0(var_2.GetShips(var_6_1), 0, function(arg_7_0, arg_7_1)
			local var_7_0 = arg_7_1:GetSkill()

			return arg_7_0 + (var_2.IsUnlock(var_7_0) and var_2:GetLevel() >= arg_1_1 and 1 or 0)
		end)
	end
	IslandAchievementType = var_8
	var_1_4[var_8.SHIP_ATTR_LV_1] = function()
		underscore = var_2_10000

		local var_8_0 = var_2_10000.reduce
		local var_8_1 = var_1_2

		return var_8_0(var_2.GetShips(var_8_1), 0, function(arg_9_0, arg_9_1)
			return arg_9_0 + (arg_9_1:GetAttrGradeCnt(arg_1_1) >= 1 and 1 or 0)
		end)
	end
	IslandAchievementType = var_8
	var_1_4[var_8.SHIP_ATTR_LV_2] = function()
		underscore = var_2_10000

		local var_10_0 = var_2_10000.reduce
		local var_10_1 = var_1_2

		return var_10_0(var_2.GetShips(var_10_1), 0, function(arg_11_0, arg_11_1)
			return arg_11_0 + (arg_11_1:GetAttrGradeCnt(arg_1_1) >= 2 and 1 or 0)
		end)
	end
	IslandAchievementType = var_8
	var_1_4[var_8.SHIP_ATTR_LV_3] = function()
		underscore = var_2_10000

		local var_12_0 = var_2_10000.reduce
		local var_12_1 = var_1_2

		return var_12_0(var_2.GetShips(var_12_1), 0, function(arg_13_0, arg_13_1)
			return arg_13_0 + (arg_13_1:GetAttrGradeCnt(arg_1_1) >= 3 and 1 or 0)
		end)
	end
	IslandAchievementType = var_8
	var_1_4[var_8.SHIP_ATTR_LV_4] = function()
		underscore = var_2_10000

		local var_14_0 = var_2_10000.reduce
		local var_14_1 = var_1_2

		return var_14_0(var_2.GetShips(var_14_1), 0, function(arg_15_0, arg_15_1)
			return arg_15_0 + (arg_15_1:GetAttrGradeCnt(arg_1_1) >= 4 and 1 or 0)
		end)
	end
	IslandAchievementType = var_8
	var_1_4[var_8.SHIP_ATTR_LV_5] = function()
		underscore = var_2_10000

		local var_16_0 = var_2_10000.reduce
		local var_16_1 = var_1_2

		return var_16_0(var_2.GetShips(var_16_1), 0, function(arg_17_0, arg_17_1)
			return arg_17_0 + (arg_17_1:GetAttrGradeCnt(arg_1_1) >= 5 and 1 or 0)
		end)
	end
	IslandAchievementType = var_8
	var_1_4[var_8.SHIP_ATTR_LV_6] = function()
		underscore = var_2_10000

		local var_18_0 = var_2_10000.reduce
		local var_18_1 = var_1_2

		return var_18_0(var_2.GetShips(var_18_1), 0, function(arg_19_0, arg_19_1)
			return arg_19_0 + (arg_19_1:GetAttrGradeCnt(arg_1_1) >= 6 and 1 or 0)
		end)
	end
	IslandAchievementType = var_8
	var_1_4[var_8.SHIP_SKIN] = function()
		local var_20_0 = var_1_2

		return var_0.GetAllSkinCnt(var_20_0)
	end
	IslandAchievementType = var_8
	var_1_4[var_8.SHIP_DRESS_TYPE] = function()
		local var_21_0 = var_1_2

		return var_0.GetDiffDressCntByType(var_21_0, arg_1_1)
	end
	IslandAchievementType = var_8
	var_1_4[var_8.COMMANDER_DRESS_TYPE] = function()
		local var_22_0 = var_0
		local var_22_1 = var_0.GetDressUpAgency(var_22_0)

		return #var_0.GetHasDressByType(var_22_1, arg_1_1)
	end
	IslandAchievementType = var_8
	var_1_4[var_8.SEASON_RANK] = function()
		local var_23_0 = var_0
		local var_23_1 = var_0.GetSeasonAgency(var_23_0)

		return var_0.GetHighestRank(var_23_1) <= arg_1_1 and 1 or 0
	end
	IslandAchievementType = var_8
	var_1_4[var_8.SEASON_NUM] = function()
		local var_24_0 = var_0
		local var_24_1 = var_0.GetSeasonAgency(var_24_0)

		return var_0.GetSeasonNum(var_24_1)
	end
	IslandAchievementType = var_8
	var_1_4[var_8.FINISH_TECH] = function()
		local var_25_0 = var_0
		local var_25_1 = var_0.GetTechnologyAgency(var_25_0)

		return var_0.GetAllTypeFinishCnt(var_25_1)
	end
	IslandAchievementType = var_8
	var_1_4[var_8.FINISH_TYPE_TECH] = function()
		local var_26_0 = var_0
		local var_26_1 = var_0.GetTechnologyAgency(var_26_0)

		return var_0.GetFinishCntByType(var_26_1, arg_1_1)
	end
	IslandAchievementType = var_8
	var_1_4[var_8.RESTAURANT_SALES] = function()
		local var_27_0 = var_0
		local var_27_1 = var_0.GetManageAgency(var_27_0)
		local var_27_2

		if not var_0.GetRestaurant(var_27_1, arg_1_1) or not var_0:GetSales() then
			var_27_2 = 0
		end

		return var_27_2
	end
	IslandAchievementType = var_8
	var_1_4[var_8.FURNITURE] = function()
		if arg_1_1 == 0 then
			local var_28_0 = var_0
			local var_28_1 = var_0.GetAgoraAgency(var_28_0)
			local var_28_4

			if not #var_0.GetFurnitures(var_28_1) then
				local var_28_2 = var_0
				local var_28_3 = var_0.GetAgoraAgency(var_28_2)

				var_28_4 = #var_0.GetFurnituresByType(var_28_3, arg_1_1)
			end

			return var_28_4
		end
	end
	IslandAchievementType = var_8
	var_1_4[var_8.ACTION] = function()
		local var_29_0 = var_0
		local var_29_1 = var_0.GetActionAgency(var_29_0)

		return #var_0.GetActionList(var_29_1)
	end

	return var_1_0(var_1_3, var_1_4, function()
		assert = var_2_10000

		var_2_10000(false, "not exist runtime achv type: " .. arg_1_0)

		return
	end)
end

function var_0_0.UpdateRecord(arg_31_0, arg_31_1, arg_31_2)
	getProxy = var_1_10003
	IslandProxy = var_1_10005

	local var_31_0 = var_1_10003(var_1_10005)
	local var_31_1 = var_3.GetIsland(var_31_0)
	local var_31_2 = var_3.GetAchievementAgency(var_31_1)

	if var_3.CheckRecordExist(var_31_2, arg_31_0, arg_31_1) then
		var_3:UpdateRecord(arg_31_0, arg_31_1, arg_31_2)
	end

	return
end

function var_0_0.UpdateRecordWithAdd(arg_32_0, arg_32_1, arg_32_2)
	getProxy = var_1_10003
	IslandProxy = var_1_10005

	local var_32_0 = var_1_10003(var_1_10005)
	local var_32_1 = var_3.GetIsland(var_32_0)
	local var_32_2 = var_3.GetAchievementAgency(var_32_1)

	if var_3.CheckRecordExist(var_32_2, arg_32_0, arg_32_1) then
		var_3:UpdateRecordWithAdd(arg_32_0, arg_32_1, arg_32_2)
	end

	return
end

function var_0_0.OnShipUpgrade(arg_33_0, arg_33_1)
	IslandAchievementType = var_1_10002

	local var_33_0 = var_1_10002.SHIP_LV

	getProxy = var_1_10003
	IslandProxy = var_1_10005

	local var_33_1 = var_1_10003(var_1_10005)
	local var_33_2 = var_3.GetIsland(var_33_1)
	local var_33_3 = var_3.GetAchievementAgency(var_33_2)
	local var_33_4 = var_3.GetRecordsByType(var_33_3, var_33_0)

	pairs = var_33_2

	for iter_33_0, iter_33_1 in var_33_2(var_33_4) do
		if arg_33_0 < iter_33_0 and iter_33_0 <= arg_33_1 then
			var_3:UpdateRecord(var_33_0, iter_33_0, iter_33_1 + 1)
		end
	end

	return
end

function var_0_0.OnShipSkillUpgrade(arg_34_0)
	IslandAchievementType = var_1_10001

	local var_34_0 = var_1_10001.SHIP_SKILL_LV

	getProxy = var_1_10002
	IslandProxy = var_1_10004

	local var_34_1 = var_1_10002(var_1_10004)
	local var_34_2 = var_2.GetIsland(var_34_1)
	local var_34_3 = var_2.GetAchievementAgency(var_34_2)
	local var_34_4 = var_2.GetRecordsByType(var_34_3, var_34_0)

	pairs = var_34_2

	for iter_34_0, iter_34_1 in var_34_2(var_34_4) do
		if iter_34_0 <= arg_34_0 then
			var_2:UpdateRecord(var_34_0, iter_34_0, iter_34_1 + 1)
		end
	end

	return
end

function var_0_0.CheckAttrUpgrade(arg_35_0, arg_35_1)
	pairs = var_1_10002

	for iter_35_0, iter_35_1 in var_1_10002(arg_35_1:GetAttrs()) do
		if arg_35_1:GetAttrGrade(iter_35_0) ~= arg_35_0:GetAttrGrade(iter_35_0) then
			return true
		end
	end

	return false
end

function var_0_0.OnShipAttrUpgrade(arg_36_0, arg_36_1)
	getProxy = var_1_10002
	IslandProxy = var_1_10004

	local var_36_0 = var_1_10002(var_1_10004)
	local var_36_1 = var_2.GetIsland(var_36_0)
	local var_36_2 = var_2.GetAchievementAgency(var_36_1)

	if var_0_0.CheckAttrUpgrade(arg_36_0, arg_36_1) then
		ipairs = var_3
		IslandAchievementType = var_5

		for iter_36_0, iter_36_1 in var_3(var_5.GetAttrTypes()) do
			local var_36_3 = var_36_2:GetRecordsByType(iter_36_1)

			pairs = var_1_10009

			for iter_36_2, iter_36_3 in var_1_10009(var_36_3) do
				var_36_2:UpdateRecord(iter_36_1, iter_36_2, var_0_0.GetRuntimeData(iter_36_1, iter_36_2))
			end
		end
	end

	return
end

function var_0_0.OnSeasonReset(arg_37_0)
	IslandAchievementType = var_1_10001

	local var_37_0 = var_1_10001.SEASON_RANK

	getProxy = var_1_10002
	IslandProxy = var_1_10004

	local var_37_1 = var_1_10002(var_1_10004)
	local var_37_2 = var_2.GetIsland(var_37_1)
	local var_37_3 = var_2.GetAchievementAgency(var_37_2)
	local var_37_4 = var_2.GetRecordsByType(var_37_3, var_37_0)

	pairs = var_37_2

	for iter_37_0, iter_37_1 in var_37_2(var_37_4) do
		if arg_37_0 <= iter_37_0 then
			var_2:UpdateRecord(var_37_0, iter_37_0, 1)
		end
	end

	return
end

function var_0_0.OnFinishTechnolog(arg_38_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10003

	local var_38_0 = var_1_10001(var_1_10003)
	local var_38_1 = var_1.GetIsland(var_38_0)
	local var_38_2 = var_1.GetAchievementAgency(var_38_1)
	local var_38_3 = var_1.UpdateRecordWithAdd

	IslandAchievementType = var_1_10005

	var_38_3(var_38_2, var_1_10005.FINISH_TECH, 0, 1)

	pg = var_38_3

	local var_38_4 = var_38_3.island_technology_template[arg_38_0].tech_belong
	local var_38_5 = var_1
	local var_38_6 = var_1.UpdateRecordWithAdd

	IslandAchievementType = var_6

	var_38_6(var_38_5, var_6.FINISH_TYPE_TECH, var_38_4, 1)

	return
end

function var_0_0.OnTakePhoto(arg_39_0)
	IslandAchievementType = var_1_10001

	local var_39_0 = var_1_10001.TAKE_PHOTO

	getProxy = var_1_10002
	IslandProxy = var_1_10004

	local var_39_1 = var_1_10002(var_1_10004)
	local var_39_2 = var_2.GetIsland(var_39_1)
	local var_39_3 = var_2.GetAchievementAgency(var_39_2)

	if var_2.CheckRecordExist(var_39_3, var_39_0, arg_39_0) then
		pg = var_3

		local var_39_4 = var_3.m02
		local var_39_5 = var_3.sendNotification

		GAME = var_6

		var_39_5(var_39_4, var_6.ISLAND_UPDATE_ACHV, {
			records = {
				{
					value = 1,
					event_type = var_39_0,
					event_arg = arg_39_0
				}
			}
		})
	end

	return
end

return var_0_0
