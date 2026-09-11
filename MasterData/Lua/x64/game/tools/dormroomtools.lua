local var_0_0 = {}
local var_0_1

local function var_0_2(arg_1_0)
	if BackHomeFurniture[arg_1_0].is_occupy and BackHomeFurniture[arg_1_0].is_occupy == 1 then
		if not DormSpecialFurnitureTools:JudgeFurIsSpecialType(arg_1_0) then
			if BackHomeFurniture[arg_1_0].display_type == 0 then
				return BackHomeFurniture[arg_1_0].title[1] * BackHomeFurniture[arg_1_0].title[2]
			elseif BackHomeFurniture[arg_1_0].display_type == 2 then
				return BackHomeFurniture[arg_1_0].title[1] * BackHomeFurniture[arg_1_0].title[3]
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
		give_furnitures = {}
	}

	var_3_0.likeNum = arg_3_1.liked_num or 0

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

	DormSpecialFurnitureTools:AddSpecialFurInfo(var_3_2, DormRoomTools:GetRoomSceneType(arg_3_1.id), {}, true)

	local var_3_5 = var_3_2.specialFur

	if not arg_3_3 and arg_3_1.layout then
		if arg_3_1.layout.temp_id == 0 then
			var_3_4, var_3_5, var_3_3 = DormFurnitureTools:ResolverFurnitureInfo(arg_3_1.layout.furniture_pos_list, arg_3_1.id)
		else
			local var_3_6 = DormFurnitureTemplateData:GetDormTemplateInfo(arg_3_1.layout.temp_id)

			if var_3_6 then
				var_3_4 = var_3_6.furnitureInfoS
				var_3_5 = var_3_6.specialFur
			end
		end
	end

	var_3_0.roomInfo.furnitureInfoS = var_3_4
	var_3_0.suitInfo = var_3_3
	var_3_0.specialFur = var_3_5
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
	local var_6_0 = DormData:GetFurNumInfo(arg_6_2)
	local var_6_1 = 0

	if BackHomeCfg[arg_6_1].type == DormConst.BACKHOME_TYPE.PrivateDorm then
		var_6_1 = DormData:GetHeroInfo(DormitoryData:GetArchiveIDViaRoomID(arg_6_1)[1]):GetCanGiftNum(arg_6_2)
	elseif BackHomeCfg[arg_6_1].type == DormConst.BACKHOME_TYPE.PublicDorm then
		var_6_1 = math.min(var_6_0.num, DormRoomTools:GetUnlockRoomNum() * BackHomeFurniture[arg_6_2].give_max) - var_6_0.give_num
	end

	return var_6_1
end

function var_0_0.RefreshDormExp(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = 0
	local var_7_1 = DormitoryData:GetDormMapList()

	if var_7_1[arg_7_1].give_furnitures then
		if BackHomeCfg[arg_7_1].type == DormConst.BACKHOME_TYPE.PrivateDorm then
			for iter_7_0, iter_7_1 in pairs(var_7_1[arg_7_1].give_furnitures) do
				var_7_0 = BackHomeFurniture[iter_7_0] and BackHomeFurniture[iter_7_0].dorm_exp * iter_7_1 + var_7_0 or var_7_0
			end
		end

		for iter_7_2, iter_7_3 in pairs((DormData:GetFurnitureInfoList())) do
			if BackHomeFurniture[iter_7_2].is_give == DormConst.BACKHOME_FUR_GIVE_TYPE.SPECIFY and var_7_1[arg_7_1].archiveIDList[1] == BackHomeFurniture[iter_7_2].hero_id then
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
	if arg_9_1 - (DormConst.DORM_POS_ID_OFFSET + 1) < DormConst.DORM_FIRST_FLOOR_ROOM_NUM and arg_9_2 - (DormConst.DORM_POS_ID_OFFSET + 1) < DormConst.DORM_FIRST_FLOOR_ROOM_NUM then
		return true
	end

	if arg_9_1 - (DormConst.DORM_POS_ID_OFFSET + 1) >= DormConst.DORM_FIRST_FLOOR_ROOM_NUM and arg_9_2 - (DormConst.DORM_POS_ID_OFFSET + 1) >= DormConst.DORM_FIRST_FLOOR_ROOM_NUM and math.floor((arg_9_1 - (DormConst.DORM_POS_ID_OFFSET + 1 + DormConst.DORM_FIRST_FLOOR_ROOM_NUM)) / DormConst.DORM_FLOOR_ROOM_NUM) == math.floor((arg_9_2 - (DormConst.DORM_POS_ID_OFFSET + 1 + DormConst.DORM_FIRST_FLOOR_ROOM_NUM)) / DormConst.DORM_FLOOR_ROOM_NUM) then
		return true
	end
end

function var_0_0.GetFurHasPlaceTotalNum(arg_10_0, arg_10_1)
	local var_10_0 = 0

	if var_0_1[arg_10_1] then
		for iter_10_0, iter_10_1 in pairs(var_0_1[arg_10_1]) do
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
		return BackHomeFurniture[arg_13_2].give_max - DormData:GetHeroInfo(DormData:GetDormSceneData(arg_13_1).archiveIDList[1]):GetGiftNum(arg_13_2)
	elseif BackHomeCfg[arg_13_1].type == DormConst.BACKHOME_TYPE.PublicDorm then
		return 10000
	end
end

function var_0_0.GetDormLevelAward(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = {}

	for iter_14_0 = arg_14_2 + 1, arg_14_3 do
		for iter_14_1, iter_14_2 in ipairs(BackHomeHeroCfg[DormData:GetHeroInfo(arg_14_1):GetCanUseHeroList()[1]].level_reward[iter_14_0]) do
			if BackHomeDormLevelRewardCfg[iter_14_2].type == 3 then
				table.insert(var_14_0, BackHomeDormLevelRewardCfg[iter_14_2].reward)
			end
		end
	end

	getReward((mergeReward((formatRewardCfgList(var_14_0)))))
end

function var_0_0.GetPrivateDormRoomState(arg_15_0, arg_15_1)
	if not arg_15_1 then
		return DormEnum.DormRoomUseState.Lock
	end

	if BackHomeCfg[arg_15_1].type ~= DormConst.BACKHOME_TYPE.PrivateDorm then
		return
	end

	if #DormitoryData:GetDormMapList()[arg_15_1].archiveIDList > 0 then
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

	if BackHomeCfg[arg_17_1].type == DormConst.BACKHOME_TYPE.VISITPUBLICDORM then
		var_17_0 = DormConst.BACKHOME_TYPE.PublicDorm
	end

	if var_17_0 == DormConst.BACKHOME_TYPE.VISITPRIVATEDORM then
		var_17_0 = DormConst.BACKHOME_TYPE.PrivateDorm
	end

	return var_17_0
end

function var_0_0.RefreshSingleRoomPlaceFurNum(arg_18_0, arg_18_1)
	local var_18_0 = DormitoryData:GetDormMapList()

	var_0_1 = var_0_1 or {}
	var_0_1[arg_18_1] = {}

	local var_18_1 = {}

	for iter_18_0 = 0, var_18_0[arg_18_1].roomInfo.furnitureInfoS.Length - 1 do
		var_18_1[var_18_0[arg_18_1].roomInfo.furnitureInfoS[iter_18_0].id] = var_18_1[var_18_0[arg_18_1].roomInfo.furnitureInfoS[iter_18_0].id] or 0
		var_18_1[var_18_0[arg_18_1].roomInfo.furnitureInfoS[iter_18_0].id] = var_18_1[var_18_0[arg_18_1].roomInfo.furnitureInfoS[iter_18_0].id] + 1
	end

	for iter_18_1, iter_18_2 in pairs(var_18_0[arg_18_1].specialFur) do
		var_18_1[iter_18_2] = 1
	end

	for iter_18_3, iter_18_4 in pairs(var_18_0[arg_18_1].suitInfo) do
		if iter_18_3 < DormConst.DORM_VISIT_ROOM_MIN then
			for iter_18_5 = 0, iter_18_4.furList.Length - 1 do
				var_18_1[iter_18_4.furList[iter_18_5].id] = var_18_1[iter_18_4.furList[iter_18_5].id] or 0
				var_18_1[iter_18_4.furList[iter_18_5].id] = var_18_1[iter_18_4.furList[iter_18_5].id] + 1
			end
		else
			for iter_18_6, iter_18_7 in ipairs((DormSuitData:GetNeedUseFurNumInfoBySuitID(iter_18_3))) do
				var_18_1[iter_18_7[1]] = var_18_1[iter_18_7[1]] or 0
				var_18_1[iter_18_7[1]] = var_18_1[iter_18_7[1]] + iter_18_7[2]
			end
		end
	end

	var_0_1[arg_18_1] = var_18_1
end

return var_0_0
