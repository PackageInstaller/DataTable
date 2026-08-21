local var_0_0 = singletonClass("BloodCardData")
local var_0_1
local var_0_2
local var_0_3
local var_0_4
local var_0_5
local var_0_6
local var_0_7
local var_0_8
local var_0_9
local var_0_10
local var_0_11
local var_0_12
local var_0_13

function var_0_0.Init(arg_1_0)
	var_0_1 = 0
	var_0_2 = {}
	var_0_3 = {}
	var_0_13 = {}
	unlockCardMap = {}
	var_0_4 = {}
	var_0_9 = {}
	var_0_10 = {}
	var_0_5 = false
	var_0_6 = 1
	var_0_7 = 101
	var_0_8 = 0
	var_0_11 = {}
	var_0_12 = 1
end

function var_0_0.InitFromServer(arg_2_0, arg_2_1)
	var_0_1 = arg_2_1.activity_id

	for iter_2_0, iter_2_1 in ipairs(cleanProtoTable(arg_2_1.card_id_list)) do
		if not unlockCardMap[iter_2_1] then
			unlockCardMap[iter_2_1] = 1
		else
			unlockCardMap[iter_2_1] = unlockCardMap[iter_2_1] + 1
		end

		if not table.indexof(var_0_2, iter_2_1) then
			table.insert(var_0_2, iter_2_1)
		end
	end

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.card_group_list) do
		local var_2_0 = {
			index = iter_2_3.index,
			cardIDList = cleanProtoTable(iter_2_3.card_id_list),
			name = iter_2_3.name
		}

		table.sort(var_2_0.cardIDList, function(arg_3_0, arg_3_1)
			return arg_3_0 < arg_3_1
		end)

		var_0_3[var_2_0.index] = var_2_0.cardIDList
		var_0_13[var_2_0.index] = var_2_0.name
	end

	for iter_2_4, iter_2_5 in ipairs(cleanProtoTable(arg_2_1.stage_list)) do
		if iter_2_5.is_clear then
			table.insert(var_0_4, iter_2_5.stage_id)
		end
	end

	var_0_6 = arg_2_1.current_group_index
end

function var_0_0.SetPassStage(arg_4_0, arg_4_1)
	if arg_4_1 == nil or arg_4_1 == 0 then
		return 0
	end

	if not table.indexof(var_0_4, arg_4_1) then
		table.insert(var_0_4, arg_4_1)
	end
end

function var_0_0.IsFinishGuide(arg_5_0)
	return true
end

function var_0_0.GetStageHasPass(arg_6_0, arg_6_1)
	return table.indexof(var_0_4, arg_6_1) ~= false
end

function var_0_0.GetStageHasUnlock(arg_7_0, arg_7_1)
	return BloodCardGameStageCfg[arg_7_1].pre_id == 0 or arg_7_0:GetStageHasPass(BloodCardGameStageCfg[arg_7_1].pre_id)
end

function var_0_0.GetNpcUnlock(arg_8_0, arg_8_1, arg_8_2)
	return ActivityData:GetActivityIsOpen(arg_8_2) and arg_8_0:GetStageHasUnlock(BloodCardGameNPCCfg[arg_8_1].stage_list[1])
end

function var_0_0.GetMainActivityID(arg_9_0)
	return var_0_1
end

function var_0_0.SetIsMultiGame(arg_10_0, arg_10_1)
	var_0_5 = arg_10_1
end

function var_0_0.GetIsMultiGame(arg_11_0)
	return var_0_5
end

function var_0_0.GetCardGroupList(arg_12_0)
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in ipairs(var_0_3) do
		if not table.isEmpty(iter_12_1) then
			table.insert(var_12_0, iter_12_1)
		end
	end

	return var_12_0
end

function var_0_0.GetCardGroupNameList(arg_13_0)
	return var_0_13
end

function var_0_0.GetCardGroupName(arg_14_0, arg_14_1, arg_14_2)
	if not arg_14_2 and var_0_13[arg_14_1] == "" then
		return GetTips("ACTIVITY_BLOOD_CARD_GAME_DEFAULT_NAME")
	end

	return var_0_13[arg_14_1] or ""
end

function var_0_0.GetTaskActivityID(arg_15_0, arg_15_1)
	if arg_15_1 then
		local var_15_0 = ActivityCfg[arg_15_1]

		if var_15_0 then
			return var_15_0.sub_activity_list[#var_15_0.sub_activity_list]
		end
	end

	return 0
end

function var_0_0.SetSelectStageID(arg_16_0, arg_16_1)
	var_0_7 = arg_16_1
end

function var_0_0.GetSelectStageID(arg_17_0)
	return var_0_7
end

function var_0_0.GetCardGroup(arg_18_0, arg_18_1)
	local var_18_0 = {}

	if not table.isEmpty(var_0_3[arg_18_1]) then
		for iter_18_0, iter_18_1 in ipairs(var_0_3[arg_18_1]) do
			table.insert(var_18_0, iter_18_1)
		end
	end

	return var_18_0
end

function var_0_0.SetSelectNpc(arg_19_0, arg_19_1)
	var_0_12 = arg_19_1
end

function var_0_0.GetSelectNpc(arg_20_0)
	return var_0_12
end

function var_0_0.GetUnPassNpc(arg_21_0)
	for iter_21_0, iter_21_1 in ipairs(BloodCardGameStageCfg.all) do
		local var_21_0 = arg_21_0:GetStageHasUnlock(iter_21_1)
		local var_21_1 = arg_21_0:GetStageHasPass(iter_21_1)

		if var_21_0 and not var_21_1 then
			for iter_21_2, iter_21_3 in ipairs(BloodCardGameNPCCfg.all) do
				local var_21_2 = BloodCardGameNPCCfg[iter_21_3]

				if table.indexof(var_21_2.stage_list, iter_21_1) then
					return iter_21_3
				end
			end
		end
	end

	return nil
end

function var_0_0.GetNpcIsUnlock(arg_22_0, arg_22_1)
	local var_22_0 = BloodCardGameNPCCfg[arg_22_1]

	for iter_22_0, iter_22_1 in ipairs(var_22_0.stage_list) do
		if arg_22_0:GetStageHasUnlock(iter_22_1) then
			return true
		end
	end

	return false
end

function var_0_0.GetUnlockCardIDList(arg_23_0)
	return var_0_2
end

function var_0_0.GetAllCardIDSortList(arg_24_0)
	local var_24_0 = {}
	local var_24_1 = BloodCardGameCardCfg.all

	for iter_24_0, iter_24_1 in ipairs(var_24_1) do
		table.insert(var_24_0, iter_24_1)
	end

	table.sort(var_24_0, function(arg_25_0, arg_25_1)
		local var_25_0 = table.indexof(var_0_2, arg_25_0) and 1 or 999
		local var_25_1 = table.indexof(var_0_2, arg_25_1) and 1 or 999

		if var_25_0 ~= var_25_1 then
			return var_25_0 < var_25_1
		end

		return arg_25_0 < arg_25_1
	end)

	return var_24_0
end

function var_0_0.UpdateCardGroup(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	var_0_3[arg_26_1] = arg_26_2
	var_0_13[arg_26_1] = arg_26_3
end

function var_0_0.UnlockCard(arg_27_0, arg_27_1)
	if not unlockCardMap[arg_27_1] then
		unlockCardMap[arg_27_1] = 0
	end

	unlockCardMap[arg_27_1] = unlockCardMap[arg_27_1] + 1

	if not table.indexof(var_0_2, arg_27_1) then
		table.insert(var_0_2, arg_27_1)
		table.insert(var_0_11, arg_27_1)
	end
end

function var_0_0.GetCacheUnlockCard(arg_28_0)
	return var_0_11
end

function var_0_0.ClearCacheUnlockCard(arg_29_0)
	var_0_11 = {}
end

function var_0_0.GetCardOwnNum(arg_30_0, arg_30_1)
	if unlockCardMap[arg_30_1] then
		return BloodCardGameCardCfg[arg_30_1].limit
	else
		return 0
	end
end

function var_0_0.GetUsingCardIndex(arg_31_0)
	return var_0_6
end

function var_0_0.SetUsingCardIndex(arg_32_0, arg_32_1)
	var_0_6 = arg_32_1
end

function var_0_0.GetHasCardGroupNum(arg_33_0)
	local var_33_0 = 0

	for iter_33_0, iter_33_1 in pairs(var_0_3) do
		if #iter_33_1 > 0 then
			var_33_0 = var_33_0 + 1
		end
	end

	return var_33_0
end

function var_0_0.GetGroupOwnCardNum(arg_34_0, arg_34_1)
	local var_34_0 = 0

	for iter_34_0, iter_34_1 in pairs(arg_34_1) do
		if unlockCardMap[iter_34_1] then
			var_34_0 = var_34_0 + 1
		end
	end

	return var_34_0
end

function var_0_0.SetRecommendCardSetID(arg_35_0, arg_35_1)
	var_0_8 = arg_35_1
end

function var_0_0.GetRecommendCardSetID(arg_36_0, arg_36_1)
	return var_0_8
end

function var_0_0.GetCacheParams(arg_37_0)
	return var_0_10
end

function var_0_0.SetCacheParams(arg_38_0, arg_38_1)
	var_0_10 = arg_38_1
end

return var_0_0
