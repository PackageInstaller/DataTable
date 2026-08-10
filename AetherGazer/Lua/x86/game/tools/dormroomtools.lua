local var_0_0 = {}
local var_0_1

local function var_0_2(arg_1_0)
	local var_1_0 = BackHomeFurniture[arg_1_0]

	if var_1_0.is_occupy and var_1_0.is_occupy == 1 then
		if not DormSpecialFurnitureTools:JudgeFurIsSpecialType(arg_1_0) then
			local var_1_1 = var_1_0.display_type

			if var_1_1 == 0 then
				return var_1_0.title[1] * var_1_0.title[2]
			elseif var_1_1 == 2 then
				return var_1_0.title[1] * var_1_0.title[3]
			end
		end
	else
		return 0
	end
end

function var_0_0.InitDormHasPlaceFurInfo(arg_2_0, arg_2_1)
	var_0_1 = {}
end

function var_0_0.InitNewSingleRoomData(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = {
		exp = 0,
		pos_id = arg_3_1.pos_id,
		archiveIDList = {},
		give_furnitures = {},
		likeNum = arg_3_1.liked_num or 0
	}

	if arg_3_1.archives_id then
		for iter_3_0, iter_3_1 in ipairs(arg_3_1.archives_id) do
			table.insert(var_3_0.archiveIDList, iter_3_1)
		end
	end

	if BackHomeCfg[arg_3_1.id].type == DormConst.BACKHOME_TYPE.PrivateDorm and #var_3_0.archiveIDList > 0 then
		DormData:GetHeroInfo(var_3_0.archiveIDList[1]):InitHeroRoomID(arg_3_1.id)
	end

	local var_3_1 = BackHomeCfg[arg_3_1.id]

	var_3_0.roomInfo = RoomInfo.New()
	var_3_0.roomInfo.id = arg_3_1.id
	var_3_0.roomInfo.sceneName = var_3_1.scene

	local var_3_2 = {}
	local var_3_3 = {}
	local var_3_4 = {}
	local var_3_5 = DormRoomTools:GetRoomSceneType(arg_3_1.id)

	DormSpecialFurnitureTools:AddSpecialFurInfo(var_3_2, var_3_5, {}, true)

	local var_3_6 = var_3_2.specialFur

	if not arg_3_3 and arg_3_1.layout then
		if arg_3_1.layout.temp_id == 0 then
			var_3_4, var_3_6, var_3_3 = DormFurnitureTools:ResolverFurnitureInfo(arg_3_1.layout.furniture_pos_list, arg_3_1.id)
		else
			local var_3_7 = DormFurnitureTemplateData:GetDormTemplateInfo(arg_3_1.layout.temp_id)

			if var_3_7 then
				var_3_4 = var_3_7.furnitureInfoS
				var_3_6 = var_3_7.specialFur
			end
		end
	end

	var_3_0.roomInfo.furnitureInfoS = var_3_4
	var_3_0.suitInfo = var_3_3
	var_3_0.specialFur = var_3_6
	var_3_0.give_furnitures = {}

	if arg_3_1.give_furnitures then
		for iter_3_2, iter_3_3 in ipairs(arg_3_1.give_furnitures) do
			if BackHomeFurniture[iter_3_3.id].is_give == 1 then
				var_3_0.give_furnitures[iter_3_3.id] = iter_3_3.num
			end
		end
	end

	arg_3_2[arg_3_1.id] = var_3_0

	DormRoomTools:RefreshSingleRoomPlaceFurNum(arg_3_1.id)
end

function var_0_0.GetDormFurOccupy(arg_4_0, arg_4_1)
	local var_4_0 = DormFurEditStateData:GetCacheFurNumInfo()
	local var_4_1 = 0

	if arg_4_1 == DormData:GetCurrectSceneID() and var_4_0 then
		for iter_4_0, iter_4_1 in pairs(var_4_0) do
			var_4_1 = var_4_1 + var_0_2(iter_4_0) * iter_4_1
		end
	end

	if var_0_1[arg_4_1] then
		for iter_4_2, iter_4_3 in pairs(var_0_1[arg_4_1]) do
			var_4_1 = var_4_1 + var_0_2(iter_4_2) * iter_4_3
		end
	end

	return var_4_1
end

function var_0_0.GetUnlockRoomNum(arg_5_0)
	local var_5_0 = 0
	local var_5_1 = DormitoryData:GetDormMapList()

	if var_5_1 then
		for iter_5_0, iter_5_1 in pairs(var_5_1) do
			if BackHomeCfg[iter_5_0].type == DormConst.BACKHOME_TYPE.PrivateDorm then
				var_5_0 = var_5_0 + 1
			end
		end
	end

	return var_5_0
end

function var_0_0.GetCanGiftNumByRoomIDAndFurID(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = BackHomeCfg[arg_6_1].type
	local var_6_1 = DormData:GetFurNumInfo(arg_6_2)
	local var_6_2 = 0

	if var_6_0 == DormConst.BACKHOME_TYPE.PrivateDorm then
		local var_6_3 = DormitoryData:GetArchiveIDViaRoomID(arg_6_1)[1]

		var_6_2 = DormData:GetHeroInfo(var_6_3):GetCanGiftNum(arg_6_2)
	elseif var_6_0 == DormConst.BACKHOME_TYPE.PublicDorm then
		local var_6_4 = DormRoomTools:GetUnlockRoomNum()

		var_6_2 = math.min(var_6_1.num, var_6_4 * BackHomeFurniture[arg_6_2].give_max) - var_6_1.give_num
	end

	return var_6_2
end

function var_0_0.RefreshDormExp(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = 0
	local var_7_1 = DormitoryData:GetDormMapList()

	if var_7_1[arg_7_1].give_furnitures then
		local var_7_2 = var_7_1[arg_7_1].give_furnitures

		if BackHomeCfg[arg_7_1].type == DormConst.BACKHOME_TYPE.PrivateDorm then
			for iter_7_0, iter_7_1 in pairs(var_7_2) do
				if BackHomeFurniture[iter_7_0] then
					var_7_0 = BackHomeFurniture[iter_7_0].dorm_exp * iter_7_1 + var_7_0
				end
			end
		end

		local var_7_3 = DormData:GetFurnitureInfoList()
		local var_7_4 = var_7_1[arg_7_1].archiveIDList[1]

		for iter_7_2, iter_7_3 in pairs(var_7_3) do
			if BackHomeFurniture[iter_7_2].is_give == DormConst.BACKHOME_FUR_GIVE_TYPE.SPECIFY and var_7_4 == BackHomeFurniture[iter_7_2].hero_id then
				var_7_0 = var_7_0 + iter_7_3.num * BackHomeFurniture[iter_7_2].dorm_exp
			end
		end
	elseif arg_7_2 and BackHomeFurniture[arg_7_2].is_give == DormConst.BACKHOME_FUR_GIVE_TYPE.SPECIFY then
		-- block empty
	end

	var_7_1[arg_7_1].exp = var_7_0
end

function var_0_0.GetHasPlaceFurInfoByRoom(arg_8_0, arg_8_1, arg_8_2)
	if var_0_1[arg_8_1] then
		return var_0_1[arg_8_1][arg_8_2] or 0
	end

	return 0
end

function var_0_0.CheckRoomPosSameLevel(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_1 - (DormConst.DORM_POS_ID_OFFSET + 1)
	local var_9_1 = arg_9_2 - (DormConst.DORM_POS_ID_OFFSET + 1)

	if var_9_0 < DormConst.DORM_FIRST_FLOOR_ROOM_NUM and var_9_1 < DormConst.DORM_FIRST_FLOOR_ROOM_NUM then
		return true
	end

	if var_9_0 >= DormConst.DORM_FIRST_FLOOR_ROOM_NUM and var_9_1 >= DormConst.DORM_FIRST_FLOOR_ROOM_NUM then
		local var_9_2 = arg_9_1 - (DormConst.DORM_POS_ID_OFFSET + 1 + DormConst.DORM_FIRST_FLOOR_ROOM_NUM)
		local var_9_3 = arg_9_2 - (DormConst.DORM_POS_ID_OFFSET + 1 + DormConst.DORM_FIRST_FLOOR_ROOM_NUM)

		if math.floor(var_9_2 / DormConst.DORM_FLOOR_ROOM_NUM) == math.floor(var_9_3 / DormConst.DORM_FLOOR_ROOM_NUM) then
			return true
		end
	end
end

function var_0_0.GetFurHasPlaceTotalNum(arg_10_0, arg_10_1)
	local var_10_0 = 0
	local var_10_1 = var_0_1[arg_10_1]

	if var_10_1 then
		for iter_10_0, iter_10_1 in pairs(var_10_1) do
			if not DormSpecialFurnitureTools:JudgeFurIsSpecialType(iter_10_0) then
				var_10_0 = var_10_0 + iter_10_1
			end
		end
	else
		print("未获取到已摆放家具数量信息")
	end

	return var_10_0
end

function var_0_0.GetDormIDViaArchive(arg_11_0, arg_11_1)
	if arg_11_1 then
		local var_11_0 = DormData:GetHeroInfo(arg_11_1)

		if var_11_0 then
			return var_11_0:GetRoomID()
		end
	end
end

function var_0_0.GetGiftNumByRoomID(arg_12_0, arg_12_1)
	local var_12_0 = 0

	if arg_12_1 then
		local var_12_1 = DormitoryData:GetDormSceneData(arg_12_1)

		if var_12_1 and var_12_1.give_furnitures then
			for iter_12_0, iter_12_1 in pairs(var_12_1.give_furnitures) do
				var_12_0 = var_12_0 + iter_12_1
			end
		end
	end

	return var_12_0
end

function var_0_0.GetCanGiftFurMaxNum(arg_13_0, arg_13_1, arg_13_2)
	if BackHomeCfg[arg_13_1].type == DormConst.BACKHOME_TYPE.PrivateDorm then
		local var_13_0 = DormData:GetDormSceneData(arg_13_1)
		local var_13_1 = DormData:GetHeroInfo(var_13_0.archiveIDList[1])

		return BackHomeFurniture[arg_13_2].give_max - var_13_1:GetGiftNum(arg_13_2)
	elseif BackHomeCfg[arg_13_1].type == DormConst.BACKHOME_TYPE.PublicDorm then
		return 10000
	end
end

function var_0_0.GetDormLevelAward(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = {}

	for iter_14_0 = arg_14_2 + 1, arg_14_3 do
		local var_14_1 = DormData:GetHeroInfo(arg_14_1):GetCanUseHeroList()[1]
		local var_14_2 = BackHomeHeroCfg[var_14_1].level_reward[iter_14_0]

		for iter_14_1, iter_14_2 in ipairs(var_14_2) do
			local var_14_3 = BackHomeDormLevelRewardCfg[iter_14_2]

			if var_14_3.type == 3 then
				table.insert(var_14_0, var_14_3.reward)
			end
		end
	end

	local var_14_4 = formatRewardCfgList(var_14_0)
	local var_14_5 = mergeReward(var_14_4)

	getReward(var_14_5)
end

function var_0_0.GetPrivateDormRoomState(arg_15_0, arg_15_1)
	local var_15_0 = DormitoryData:GetDormMapList()

	if not arg_15_1 then
		return DormEnum.DormRoomUseState.Lock
	end

	if BackHomeCfg[arg_15_1].type ~= DormConst.BACKHOME_TYPE.PrivateDorm then
		return
	end

	if #var_15_0[arg_15_1].archiveIDList > 0 then
		return DormEnum.DormRoomUseState.HadPlace
	else
		return DormEnum.DormRoomUseState.Unlock
	end
end

function var_0_0.Dispose(arg_16_0)
	var_0_1 = nil
end

function var_0_0.GetRoomSceneType(arg_17_0, arg_17_1)
	local var_17_0 = BackHomeCfg[arg_17_1].type

	if var_17_0 == DormConst.BACKHOME_TYPE.VISITPUBLICDORM then
		var_17_0 = DormConst.BACKHOME_TYPE.PublicDorm
	end

	if var_17_0 == DormConst.BACKHOME_TYPE.VISITPRIVATEDORM then
		var_17_0 = DormConst.BACKHOME_TYPE.PrivateDorm
	end

	return var_17_0
end

function var_0_0.RefreshSingleRoomPlaceFurNum(arg_18_0, arg_18_1)
	local var_18_0 = DormitoryData:GetDormMapList()

	if not var_0_1 then
		var_0_1 = {}
	end

	var_0_1[arg_18_1] = {}

	local var_18_1 = {}
	local var_18_2 = var_18_0[arg_18_1].roomInfo.furnitureInfoS

	for iter_18_0 = 0, var_18_2.Length - 1 do
		local var_18_3 = var_18_2[iter_18_0].id

		if not var_18_1[var_18_3] then
			var_18_1[var_18_3] = 0
		end

		var_18_1[var_18_3] = var_18_1[var_18_3] + 1
	end

	local var_18_4 = var_18_0[arg_18_1].specialFur

	for iter_18_1, iter_18_2 in pairs(var_18_4) do
		var_18_1[iter_18_2] = 1
	end

	for iter_18_3, iter_18_4 in pairs(var_18_0[arg_18_1].suitInfo) do
		if iter_18_3 < DormConst.DORM_VISIT_ROOM_MIN then
			for iter_18_5 = 0, iter_18_4.furList.Length - 1 do
				local var_18_5 = iter_18_4.furList[iter_18_5].id

				var_18_1[var_18_5] = var_18_1[var_18_5] or 0
				var_18_1[var_18_5] = var_18_1[var_18_5] + 1
			end
		else
			local var_18_6 = DormSuitData:GetNeedUseFurNumInfoBySuitID(iter_18_3)

			for iter_18_6, iter_18_7 in ipairs(var_18_6) do
				var_18_1[iter_18_7[1]] = var_18_1[iter_18_7[1]] or 0
				var_18_1[iter_18_7[1]] = var_18_1[iter_18_7[1]] + iter_18_7[2]
			end
		end
	end

	var_0_1[arg_18_1] = var_18_1
end

return var_0_0
