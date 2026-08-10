local var_0_0 = class("ChallengeRogueTreasureData")

function var_0_0.ExportMethod(arg_1_0)
	return {
		"TreasureInitData",
		"TreasureGetList",
		"TreasureListUpdate",
		"TreasureClear",
		"TreasureGetListByCampList",
		"GetTreasureIDListByTempAndCampList",
		"GetAllCampTreasureIDListByTemp",
		"GetCampUltimateByCamp",
		"GetAllCampTreasureIDByCamp"
	}
end

function var_0_0.Init(arg_2_0)
	arg_2_0.treasureList_ = {}
	arg_2_0.allTreasureIDList_ = {}
	arg_2_0.allCampIDList_ = {}
end

function var_0_0.TreasureInitData(arg_3_0, arg_3_1)
	arg_3_0:TreasureClear()

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		arg_3_0:TreasureListUpdate(ChallengeRogueTeamConst.ITEM_OPERATE.ADD, iter_3_1)
	end
end

function var_0_0.TreasureUpdate(arg_4_0, arg_4_1, arg_4_2)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0.treasureList_) do
		if iter_4_1.id == arg_4_1 then
			arg_4_0.treasureList_[iter_4_0].rare = arg_4_2

			return
		end
	end

	table.insert(arg_4_0.treasureList_, {
		id = arg_4_1,
		rare = arg_4_2
	})
end

function var_0_0.TreasureRemove(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.treasureList_) do
		if iter_5_1.id == arg_5_1 then
			table.remove(arg_5_0.treasureList_, iter_5_0)

			break
		end
	end
end

function var_0_0.TreasureListUpdate(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_2.id
	local var_6_1 = arg_6_2.rare

	if arg_6_1 == ChallengeRogueTeamConst.ITEM_OPERATE.ADD then
		arg_6_0:TreasureUpdate(var_6_0, var_6_1)
	elseif arg_6_1 == ChallengeRogueTeamConst.ITEM_OPERATE.DELETE then
		arg_6_0:TreasureRemove(var_6_0)
	end
end

function var_0_0.TreasureClear(arg_7_0)
	for iter_7_0 = #arg_7_0.treasureList_, 1, -1 do
		arg_7_0.treasureList_[iter_7_0] = nil
	end
end

function var_0_0.TreasureGetList(arg_8_0)
	return arg_8_0.treasureList_
end

function var_0_0.TreasureGetListByCampList(arg_9_0, arg_9_1)
	if arg_9_1[1] == 0 then
		return arg_9_0:TreasureGetList()
	end

	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.treasureList_) do
		if #arg_9_1 == 1 then
			if table.indexof(RogueTeamItemCfg[iter_9_1.id].camp, arg_9_1[1]) then
				table.insert(var_9_0, iter_9_1)
			end
		elseif #arg_9_1 > 1 then
			local var_9_1 = true

			for iter_9_2, iter_9_3 in ipairs(arg_9_1) do
				if not table.indexof(RogueTeamItemCfg[iter_9_1.id].camp, iter_9_3) then
					var_9_1 = false
				end
			end

			if var_9_1 then
				table.insert(var_9_0, iter_9_1)
			end
		end
	end

	return var_9_0
end

function var_0_0.GetTreasureIDListByTempAndCampList(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = {}
	local var_10_1 = RogueTeamItemCfg.get_id_list_by_type[ChallengeRogueTeamConst.ITEM_TYPE.TREASURE]

	for iter_10_0, iter_10_1 in ipairs(var_10_1) do
		local var_10_2 = RogueTeamItemCfg[iter_10_1]

		if var_10_2.item_temp == arg_10_1 and var_10_2.camp and not table.isEmpty(var_10_2.camp) then
			for iter_10_2, iter_10_3 in ipairs(arg_10_2) do
				if not table.indexof(var_10_0, iter_10_1) then
					table.insert(var_10_0, iter_10_1)
				end
			end
		end
	end

	return var_10_0
end

function var_0_0.GetAllCampTreasureIDListByTemp(arg_11_0, arg_11_1)
	if not arg_11_0.allTreasureIDList_ then
		arg_11_0.allTreasureIDList_ = {}
	end

	if not arg_11_0.allCampIDList_ then
		arg_11_0.allCampIDList_ = {}
	end

	if arg_11_0.allTreasureIDList_[arg_11_1] and arg_11_0.allCampIDList_[arg_11_1] then
		return deepClone(arg_11_0.allTreasureIDList_[arg_11_1]), deepClone(arg_11_0.allCampIDList_[arg_11_1])
	end

	local var_11_0 = {}
	local var_11_1 = {}
	local var_11_2 = RogueTeamItemCfg.get_id_list_by_type[ChallengeRogueTeamConst.ITEM_TYPE.TREASURE]

	for iter_11_0, iter_11_1 in ipairs(var_11_2) do
		local var_11_3 = RogueTeamItemCfg[iter_11_1]

		if var_11_3.item_temp == arg_11_1 then
			table.insert(var_11_0, iter_11_1)

			if var_11_3.camp and not table.isEmpty(var_11_3.camp) then
				for iter_11_2, iter_11_3 in ipairs(var_11_3.camp) do
					if not table.indexof(var_11_1, iter_11_3) then
						table.insert(var_11_1, iter_11_3)
					end
				end
			end
		end
	end

	table.sort(var_11_1, function(arg_12_0, arg_12_1)
		return arg_12_0 < arg_12_1
	end)

	arg_11_0.allCampIDList_[arg_11_1] = var_11_1
	arg_11_0.allTreasureIDList_[arg_11_1] = var_11_0

	return var_11_0, var_11_1
end

function var_0_0.GetCampUltimateByCamp(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = RogueTeamItemCfg.get_id_list_by_item_temp[arg_13_1] or {}

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		if RogueTeamItemCfg[iter_13_1].type == ChallengeRogueTeamConst.ITEM_TYPE.SUIT_SKILL and RogueTeamItemCfg[iter_13_1].camp and RogueTeamItemCfg[iter_13_1].camp[1] == arg_13_2 then
			return iter_13_1
		end
	end
end

function var_0_0.GetAllCampTreasureIDByCamp(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = {}
	local var_14_1 = arg_14_0:GetAllCampTreasureIDListByTemp(arg_14_1)

	for iter_14_0, iter_14_1 in ipairs(var_14_1) do
		local var_14_2 = RogueTeamItemCfg[iter_14_1]

		if var_14_2.camp and not table.isEmpty(var_14_2.camp) then
			for iter_14_2, iter_14_3 in ipairs(var_14_2.camp) do
				if iter_14_3 == arg_14_2 and var_14_2.type == ChallengeRogueTeamConst.ITEM_TYPE.TREASURE and not table.indexof(var_14_0, iter_14_1) then
					table.insert(var_14_0, iter_14_1)
				end
			end
		end
	end

	return var_14_0
end

return var_0_0
