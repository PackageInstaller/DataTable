local var_0_0 = singletonClass("DormSuitData")
local var_0_1
local var_0_2
local var_0_3

function var_0_0.InitDormSuitList(arg_1_0, arg_1_1)
	var_0_0:RefreshUnLockSuitList(arg_1_1.backhome_suit_id_list, true)
end

function var_0_0.DisposeDormSuitData(arg_2_0)
	var_0_1 = nil
end

function var_0_0.EnterDormSystem(arg_3_0)
	var_0_3 = getData("BackHome", "suitHelp")

	if not var_0_3 then
		var_0_3 = false
	end
end

function var_0_0.ExitDormSystem(arg_4_0)
	saveData("BackHome", "suitHelp", var_0_3)

	var_0_3 = nil
end

function var_0_0.GenerateSingleSuitData(arg_5_0, arg_5_1)
	if not var_0_1 then
		var_0_1 = {}
	end

	var_0_1[arg_5_1.suitID] = {
		furList = arg_5_1.furList,
		specialFur = arg_5_1.specialFur,
		tileType = arg_5_1.tileType,
		suitType = arg_5_1.suitType,
		suit_num = arg_5_1.suitNum
	}
end

function var_0_0.RefreshUnLockSuitList(arg_6_0, arg_6_1, arg_6_2)
	if not var_0_2 or arg_6_2 then
		var_0_2 = {}
	end

	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		table.insert(var_0_2, iter_6_1)
	end

	DormRedPointTools:UpdataSuitRedPoint()
end

function var_0_0.GetSuitFurInfo(arg_7_0, arg_7_1)
	if var_0_1 and var_0_1[arg_7_1] then
		return var_0_1[arg_7_1]
	end

	local var_7_0 = BackHomeSuitCfg[arg_7_1].type

	if var_7_0 == DormSuitTools.DORM_SUIT_TYPE.FULL_SET or var_7_0 == DormSuitTools.DORM_SUIT_TYPE.PART_SET then
		local var_7_1, var_7_2 = DormSuitTools:GetDeSerializeDormSuitDataInScene(arg_7_1)
		local var_7_3 = {
			suitID = arg_7_1,
			furList = var_7_1,
			specialFur = var_7_2,
			suitType = var_7_0,
			tileType = BackHomeSuitCfg[arg_7_1].display_type,
			suitNum = BackHomeSuitCfg[arg_7_1].suit_num
		}

		var_0_0:GenerateSingleSuitData(var_7_3)
	end

	return var_0_1[arg_7_1]
end

function var_0_0.GetSuitInfoListByType(arg_8_0, arg_8_1)
	local var_8_0 = {}

	if var_0_1 then
		for iter_8_0, iter_8_1 in pairs(var_0_1) do
			if iter_8_1.suitType == arg_8_1 then
				table.insert(var_8_0, iter_8_0)
			end
		end
	end

	return var_8_0
end

function var_0_0.GetSuitNeedTotalFurNumList(arg_9_0, arg_9_1)
	local var_9_0 = 0
	local var_9_1 = var_0_0:GetSuitFurInfo(arg_9_1)

	for iter_9_0, iter_9_1 in ipairs(var_9_1.suit_num) do
		var_9_0 = var_9_0 + var_0_0:GetFurNeedNumBySuitID(arg_9_1, iter_9_1[1])
	end

	return var_9_0
end

function var_0_0.GetTotalCanUseFurNumBySuitInRoom(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0, var_10_1 = DormSuitData:CheckIsSuit(arg_10_1)
	local var_10_2 = 0

	if var_10_0 then
		local var_10_3 = var_0_0:GetSuitFurInfo(arg_10_1)

		for iter_10_0, iter_10_1 in ipairs(var_10_3.suit_num) do
			var_10_2 = var_10_2 + var_0_0:GetFurCanUseNumBySuitIDAndRoomID(arg_10_1, iter_10_1[1], arg_10_2)
		end
	end

	return var_10_2
end

function var_0_0.CheckSuitCanUseInRoom(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = BackHomeSuitCfg[arg_11_1].suit_num

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		local var_11_1 = iter_11_1[1]

		if not DormSpecialFurnitureTools:JudgeIsOriSpecialFur(var_11_1) and iter_11_1[2] > DormFurEditStateData:GetCanUseFurNumInRoom(arg_11_2, var_11_1) then
			return false
		end
	end

	return true
end

function var_0_0.GetFurNeedNumBySuitID(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = var_0_0:GetSuitFurInfo(arg_12_1)
	local var_12_1 = 0

	for iter_12_0, iter_12_1 in ipairs(var_12_0.suit_num) do
		if iter_12_1[1] == arg_12_2 then
			var_12_1 = iter_12_1[2]

			break
		end
	end

	return var_12_1
end

function var_0_0.GetFurCanUseNumBySuitIDAndRoomID(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0, var_13_1 = var_0_0:CheckIsSuit(arg_13_1)
	local var_13_2 = BackHomeFurniture[arg_13_2].is_give
	local var_13_3 = 0
	local var_13_4 = DormFurEditStateData:GetCanUseFurNumInRoom(arg_13_3, arg_13_2)
	local var_13_5 = DormRoomTools:GetHasPlaceFurInfoByRoom(arg_13_3, arg_13_2)
	local var_13_6 = DormFurEditStateData:GetCacheFurNum(arg_13_2)
	local var_13_7 = var_0_0:GetFurNeedNumBySuitID(arg_13_1, arg_13_2)

	if var_13_1 == DormSuitTools.DORM_SUIT_TYPE.FULL_SET then
		var_13_3 = var_13_5 + var_13_6 + var_13_4
	elseif var_13_1 == DormSuitTools.DORM_SUIT_TYPE.PART_SET then
		var_13_3 = var_13_4
	end

	return math.min(var_13_7, var_13_3)
end

function var_0_0.GetNeedUseFurNumInfoBySuitID(arg_14_0, arg_14_1)
	local var_14_0 = BackHomeSuitCfg[arg_14_1]

	if var_14_0 then
		return var_14_0.suit_num
	end
end

function var_0_0.GetSuitHelpFlag(arg_15_0)
	return var_0_3
end

function var_0_0.SetSuitHelpFlag(arg_16_0, arg_16_1)
	var_0_3 = arg_16_1

	saveData("BackHome", "suitHelp", var_0_3)
end

function var_0_0.CheckUnlockSuit(arg_17_0, arg_17_1)
	if var_0_2 then
		for iter_17_0, iter_17_1 in ipairs(var_0_2) do
			if iter_17_1 == arg_17_1 then
				return true
			end
		end
	end

	return false
end

function var_0_0.GetUnLockSuitList(arg_18_0)
	return var_0_2
end

function var_0_0.GetUnLockSuitListByType(arg_19_0, arg_19_1)
	local var_19_0 = {}

	if var_0_2 then
		for iter_19_0, iter_19_1 in ipairs(var_0_2) do
			if BackHomeSuitCfg[iter_19_1].type == arg_19_1 then
				table.insert(var_19_0)
			end
		end
	end

	return var_19_0
end

function var_0_0.GetSuitIDListByType(arg_20_0, arg_20_1)
	local var_20_0 = BackHomeSuitCfg.all
	local var_20_1 = {}

	for iter_20_0, iter_20_1 in ipairs(var_20_0) do
		if BackHomeSuitCfg[iter_20_1].type == arg_20_1 then
			table.insert(var_20_1, iter_20_1)
		end
	end

	return var_20_1
end

function var_0_0.CheckCanUseSuitInRoom(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = var_0_0:CheckUnlockSuit(arg_21_2)
	local var_21_1 = BackHomeCfg[arg_21_1].type
	local var_21_2 = false

	if BackHomeSuitCfg[arg_21_2] then
		for iter_21_0, iter_21_1 in ipairs(BackHomeSuitCfg[arg_21_2].scene_id) do
			if var_21_1 == iter_21_1 then
				var_21_2 = true

				break
			end
		end
	else
		var_21_2 = true
	end

	return var_21_0 and var_21_2
end

function var_0_0.GetCanUseFurSuitIDList(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = {}

	for iter_22_0, iter_22_1 in ipairs(BackHomeSuitCfg.all) do
		if arg_22_2 == BackHomeSuitCfg[iter_22_1].type and var_0_0:CheckCanUseSuitInRoom(arg_22_1, iter_22_1) and var_0_0:CheckUnlockSuit(iter_22_1) then
			table.insert(var_22_0, iter_22_1)
		end
	end

	return var_22_0
end

function var_0_0.CheckIsSuit(arg_23_0, arg_23_1)
	local var_23_0 = BackHomeSuitCfg[arg_23_1]

	if var_23_0 then
		local var_23_1 = var_23_0.type

		return true, var_23_1
	elseif arg_23_1 < 1000 then
		return true, DormSuitTools.DORM_SUIT_TYPE.CUSTOM_SET
	end
end

function var_0_0.CheckIsConfigSuit(arg_24_0, arg_24_1)
	local var_24_0 = BackHomeSuitCfg[arg_24_1]

	if var_24_0 then
		local var_24_1 = var_24_0.type

		return true, var_24_1
	end
end

function var_0_0.GetSuitCanUseFurInfo(arg_25_0, arg_25_1)
	local var_25_0 = {}
	local var_25_1 = DormSuitTools:GetDeSerializeDormSuitData(arg_25_1)

	for iter_25_0, iter_25_1 in ipairs(var_25_1.numList) do
		var_25_0[iter_25_1[1]] = iter_25_1[2]
	end

	return var_25_0
end

local var_0_4
local var_0_5 = DormSuitTools.DORM_SUIT_TYPE.FULL_SET

function var_0_0.SetSuitType(arg_26_0, arg_26_1)
	var_0_5 = arg_26_1
end

function var_0_0.GetSuitType(arg_27_0)
	return var_0_5
end

function var_0_0.SetSuitSerializeData(arg_28_0, arg_28_1)
	var_0_4 = {}
	var_0_4.name = arg_28_1
	var_0_4.suitType = var_0_5
end

function var_0_0.GetSuitSerializeData(arg_29_0)
	return var_0_4
end

return var_0_0
