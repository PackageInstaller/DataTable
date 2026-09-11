local var_0_0 = singletonClass("DormFurEditStateData")
local var_0_1
local var_0_2
local var_0_3
local var_0_4

function var_0_0.EnterEditState(arg_1_0)
	var_0_1 = {}
	var_0_4 = {}
	var_0_3 = {}

	DormFurnitureManager.GetInstance():BeginEdit()
end

function var_0_0.ExitEditState(arg_2_0)
	var_0_1 = nil
	var_0_4 = nil
	var_0_3 = nil
	var_0_2 = nil

	DormFurnitureManager.GetInstance():EndEdit()
end

function var_0_0.GetHadPlaceFurInfoList(arg_3_0)
	local var_3_0 = DormLuaBridge.GetAllPlaceFurSuitInfo()
	local var_3_1 = {}

	for iter_3_0 = 0, var_3_0.Length - 1 do
		if var_3_0[iter_3_0].id > 1000 then
			var_3_1[var_3_0[iter_3_0].id] = {
				pos = {
					x = var_3_0[iter_3_0].pos.x,
					y = var_3_0[iter_3_0].pos.y,
					rotation = var_3_0[iter_3_0].rotation
				}
			}
		else
			var_3_1[var_3_0[iter_3_0].id] = {
				oriSuitID = var_3_0[iter_3_0].oriSuitID
			}
			var_3_1[var_3_0[iter_3_0].id].furList = DormLuaBridge.GetCustomSuitFurInfo(var_3_0[iter_3_0].id)

			if var_3_1[var_3_0[iter_3_0].id].furList[0] then
				var_3_1[var_3_0[iter_3_0].id].tileType = var_3_1[var_3_0[iter_3_0].id].furList[1].tileType
			end
		end
	end

	return DormLuaBridge.GetPlacedFurnitureInfo(), DormFurEditStateData:GetCurPlaceSpecialFurInfo(), var_3_1
end

function var_0_0:GetHadPlaceFurNumInRoom(arg_4_1)
	local var_4_0 = {}
	local var_4_1 = DormFurnitureTools:GetCanUseFurListByRoomID(arg_4_1)

	if var_4_1 then
		for iter_4_0, iter_4_1 in ipairs(var_4_1) do
			if DormRoomTools:GetHasPlaceFurInfoByRoom(arg_4_1, iter_4_1) + self:GetCacheFurNum(iter_4_1) > 0 then
				table.insert(var_4_0, iter_4_1)
			end
		end
	end

	return var_4_0
end

function var_0_0:GetCanUseFurNumInRoom(arg_5_1, arg_5_2)
	if not DormFurnitureTools:CheckFurCanUseRoom(arg_5_1, arg_5_2) then
		return 0
	else
		local var_5_0 = self:GetCacheFurNum(arg_5_2)
		local var_5_1 = DormData:GetFurNumInfo(arg_5_2)

		if BackHomeFurniture[arg_5_2].is_give == DormConst.BACKHOME_FUR_GIVE_TYPE.NO_GIFT then
			if not DormSpecialFurnitureTools:JudgeFurIsSpecialType(arg_5_2) then
				return var_5_1.num - var_5_1.hasPlaceNum - var_5_0
			else
				if DormRoomTools:GetHasPlaceFurInfoByRoom(arg_5_1, arg_5_2) + var_5_0 >= 1 then
					return 0
				end

				if var_5_1.num - var_5_1.hasPlaceNum - var_5_0 > 0 then
					return 1
				else
					return 0
				end
			end
		elseif BackHomeFurniture[arg_5_2].is_give == DormConst.BACKHOME_FUR_GIVE_TYPE.SPECIFY then
			if BackHomeCfg[arg_5_1].type == DormConst.BACKHOME_TYPE.PublicDorm then
				return var_5_1.num - var_5_1.hasPlaceNum - var_5_0
			elseif BackHomeCfg[arg_5_1].type == DormConst.BACKHOME_TYPE.PrivateDorm and DormitoryData:GetArchiveIDViaRoomID(arg_5_1)[1] == BackHomeFurniture[arg_5_2].hero_id then
				return var_5_1.num - var_5_1.hasPlaceNum - var_5_0
			end

			return 0
		elseif BackHomeFurniture[arg_5_2].is_give == DormConst.BACKHOME_FUR_GIVE_TYPE.GIFT then
			if BackHomeCfg[arg_5_1].type == DormConst.BACKHOME_TYPE.PublicDorm then
				if not DormSpecialFurnitureTools:JudgeFurIsSpecialType(arg_5_2) then
					return var_5_1.give_num - var_5_1.hasPlaceNum - var_5_0
				else
					if DormRoomTools:GetHasPlaceFurInfoByRoom(arg_5_1, arg_5_2) + var_5_0 >= 1 then
						return 0
					end

					if var_5_1.give_num - var_5_1.hasPlaceNum - var_5_0 > 0 then
						return 1
					else
						return 0
					end
				end
			elseif BackHomeCfg[arg_5_1].type == DormConst.BACKHOME_TYPE.PrivateDorm then
				local var_5_2 = DormData:GetHeroInfo(DormitoryData:GetArchiveIDViaRoomID(arg_5_1)[1])

				if var_5_2 then
					local var_5_3 = var_5_2:GetGiftNum(arg_5_2) - DormRoomTools:GetHasPlaceFurInfoByRoom(arg_5_1, arg_5_2) - var_5_0

					if var_5_3 < 0 then
						print("可摆放家具计算错误")

						return 0
					end

					return math.min(var_5_1.give_num - var_5_1.hasPlaceNum - var_5_0, var_5_3)
				end
			end
		end

		print("未找到的类型")

		return 0
	end
end

function var_0_0.GetCacheFurTotalNum(arg_6_0)
	local var_6_0 = 0

	if var_0_1 then
		for iter_6_0, iter_6_1 in pairs(var_0_1) do
			if not DormSpecialFurnitureTools:JudgeFurIsSpecialType(iter_6_0) then
				var_6_0 = var_6_0 + iter_6_1
			end
		end
	end

	return var_6_0
end

function var_0_0.GetCacheFurNumInfo(arg_7_0)
	if var_0_1 then
		return var_0_1
	end
end

function var_0_0:SetCacheFurNumInfo(arg_8_1, arg_8_2)
	var_0_1 = arg_8_1
	var_0_4 = arg_8_2

	for iter_8_0, iter_8_1 in pairs(arg_8_1) do
		if DormSpecialFurnitureTools:JudgeFurIsSpecialType(iter_8_0) and iter_8_1 > 0 then
			local var_8_0 = {}

			if BackHomeFurniture[iter_8_0].type == DormConst.FLOOR_TYPE_NUM then
				var_8_0.floorID = iter_8_0
			elseif BackHomeFurniture[iter_8_0].type == DormConst.WALL_TYPE_NUM then
				var_8_0.wallID = iter_8_0
			elseif BackHomeFurniture[iter_8_0].type == DormConst.BACK_GROUND_TYPE then
				var_8_0.backGroundID = iter_8_0
			end

			self:CacheWallAndFloorInfo(var_8_0)
		end
	end
end

function var_0_0.GetCacheFurNum(arg_9_0, arg_9_1)
	if var_0_1 then
		return var_0_1[arg_9_1] or 0
	end

	return 0
end

function var_0_0.GetCacheWallAndFloorInfo(arg_10_0, arg_10_1)
	if var_0_4 then
		if arg_10_1 == DormConst.FLOOR_TYPE_NUM then
			return var_0_4.floorID
		elseif arg_10_1 == DormConst.WALL_TYPE_NUM then
			return var_0_4.wallID
		elseif arg_10_1 == DormConst.BACK_GROUND_TYPE then
			return var_0_4.backGroundID
		end
	end
end

function var_0_0:SyncRoomFurniture(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	local var_11_0 = DormitoryData:GetDormMapList()
	local var_11_1 = arg_11_1.architecture_id

	if not var_11_0[arg_11_1.architecture_id] then
		print("没有场景数据,场景id为" .. var_11_1)

		return
	end

	if not var_11_0[var_11_1].roomInfo then
		return
	end

	var_11_0[var_11_1].roomInfo.furnitureInfoS = arg_11_2

	if not arg_11_3 then
		for iter_11_0, iter_11_1 in ipairs(arg_11_1.furniture_layout.furniture_pos_list) do
			if DormConst.PROTOCOL_TILE_TYPE[iter_11_1.type] == DormConst.TILE_TYPE.FLOOR then
				self:SyncRoomSpecialFur(iter_11_1.furniture_pos)

				break
			end
		end
	else
		self:SyncRoomSpecialFur(arg_11_3)
	end

	var_11_0[var_11_1].suitInfo = arg_11_4 or {}

	DormRoomTools:RefreshSingleRoomPlaceFurNum(var_11_1)
	DormData:UpdateAllPlaceFurNumList()
end

function var_0_0.GetCurPlaceSpecialFurInfo(arg_12_0)
	local var_12_0 = DormData:GetCurrectSceneID()
	local var_12_1 = {}
	local var_12_2 = DormitoryData:GetDormMapList()

	var_12_1.floorID = var_0_4 and var_0_4.floorID and var_0_4.floorID or var_12_2[var_12_0].specialFur.floorID
	var_12_1.wallID = var_0_4 and var_0_4.wallID and var_0_4.wallID or var_12_2[var_12_0].specialFur.wallID
	var_12_1.backGroundID = var_0_4 and var_0_4.backGroundID and var_0_4.backGroundID or var_12_2[var_12_0].specialFur.backGroundID

	return var_12_1
end

function var_0_0.SyncRoomSpecialFur(arg_13_0, arg_13_1)
	local var_13_0 = DormData:GetCurrectSceneID()
	local var_13_1 = DormitoryData:GetDormMapList()

	if var_13_1[var_13_0] then
		for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
			if DormSpecialFurnitureTools:JudgeFurIsSpecialType(iter_13_1.furniture_id) then
				if BackHomeFurniture[iter_13_1.furniture_id].type == DormConst.FLOOR_TYPE_NUM then
					var_13_1[var_13_0].specialFur.floorID = iter_13_1.furniture_id
				elseif BackHomeFurniture[iter_13_1.furniture_id].type == DormConst.WALL_TYPE_NUM then
					var_13_1[var_13_0].specialFur.wallID = iter_13_1.furniture_id
				elseif BackHomeFurniture[iter_13_1.furniture_id].type == DormConst.BACK_GROUND_TYPE then
					var_13_1[var_13_0].specialFur.backGroundID = iter_13_1.furniture_id
				end
			end
		end
	end
end

function var_0_0:ReviseFurNumInEditRoom(arg_14_1, arg_14_2)
	var_0_1 = var_0_1 or {}
	var_0_1[arg_14_1] = var_0_1[arg_14_1] or 0
	var_0_1[arg_14_1] = var_0_1[arg_14_1] + arg_14_2

	if DormSpecialFurnitureTools:JudgeFurIsSpecialType(arg_14_1) and arg_14_2 > 0 then
		local var_14_0 = {}

		if BackHomeFurniture[arg_14_1].type == DormConst.FLOOR_TYPE_NUM then
			var_14_0.floorID = arg_14_1
		elseif BackHomeFurniture[arg_14_1].type == DormConst.WALL_TYPE_NUM then
			var_14_0.wallID = arg_14_1
		elseif BackHomeFurniture[arg_14_1].type == DormConst.BACK_GROUND_TYPE then
			var_14_0.backGroundID = arg_14_1
		end

		self:CacheWallAndFloorInfo(var_14_0)
	end
end

function var_0_0.ClearFurNumInEditRoom(arg_15_0)
	var_0_1 = nil
end

function var_0_0:RestoreRoomAllFurniture(arg_16_1)
	var_0_1 = {}

	local var_16_0 = DormitoryData:GetDormMapList()[DormData:GetCurrectSceneID()].roomInfo.furnitureInfoS

	for iter_16_0 = 0, var_16_0.Length - 1 do
		var_0_1[var_16_0[iter_16_0].id] = var_0_1[var_16_0[iter_16_0].id] or 0
		var_0_1[var_16_0[iter_16_0].id] = var_0_1[var_16_0[iter_16_0].id] - 1
	end

	self:RestoreSpecialFur(arg_16_1)
	self:RestoreFurSuitCacheInfo()

	return var_0_1
end

function var_0_0:RestoreSpecialFur(arg_17_1)
	var_0_4 = nil

	local var_17_0 = DormData:GetCurrectSceneID()
	local var_17_1 = DormSpecialFurnitureTools:GetOriFloorOrWall(BackHomeCfg[var_17_0].type, DormConst.WALL_TYPE_NUM)
	local var_17_2 = DormSpecialFurnitureTools:GetOriFloorOrWall(BackHomeCfg[var_17_0].type, DormConst.FLOOR_TYPE_NUM)
	local var_17_3 = DormSpecialFurnitureTools:GetOriFloorOrWall(BackHomeCfg[var_17_0].type, DormConst.BACK_GROUND_TYPE)
	local var_17_4 = DormitoryData:GetDormSceneData(var_17_0).specialFur

	if not arg_17_1 then
		DormSpecialFurnitureTools:ChangeDormFloorOrWallData({
			wallID = var_17_1,
			floorID = var_17_2,
			backGroundID = var_17_3
		})
	end

	if var_17_1 ~= var_17_4.wallID then
		self:ReviseFurNumInEditRoom(var_17_4.wallID, -1)
		self:ReviseFurNumInEditRoom(var_17_1, 1)
	end

	if var_17_2 ~= var_17_4.floorID then
		self:ReviseFurNumInEditRoom(var_17_4.floorID, -1)
		self:ReviseFurNumInEditRoom(var_17_2, 1)
	end

	if var_17_3 ~= var_17_4.backGroundID then
		self:ReviseFurNumInEditRoom(var_17_4.backGroundID, -1)
		self:ReviseFurNumInEditRoom(var_17_3, 1)
	end
end

function var_0_0.CacheWallAndFloorInfo(arg_18_0, arg_18_1)
	var_0_4 = var_0_4 or {}

	if arg_18_1.floorID then
		var_0_4.floorID = arg_18_1.floorID
	end

	if arg_18_1.wallID then
		var_0_4.wallID = arg_18_1.wallID
	end

	if arg_18_1.backGroundID then
		var_0_4.backGroundID = arg_18_1.backGroundID
	end
end

function var_0_0.ReveseFurSuitNumInEidtRoom(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_1 > 1000 then
		var_0_3 = var_0_3 or {}
		var_0_3[arg_19_1] = var_0_3[arg_19_1] or 0
		var_0_3[arg_19_1] = var_0_3[arg_19_1] + arg_19_2

		if BackHomeSuitCfg[arg_19_1] then
			for iter_19_0, iter_19_1 in ipairs(BackHomeSuitCfg[arg_19_1].suit_num) do
				var_0_0:ReviseFurNumInEditRoom(iter_19_1[1], iter_19_1[2] * arg_19_2)
			end
		end
	end
end

function var_0_0.RestoreFurSuitCacheInfo(arg_20_0)
	var_0_3 = {}

	local var_20_0 = DormitoryData:GetDormMapList()[DormData:GetCurrectSceneID()].suitInfo

	if var_20_0 then
		for iter_20_0, iter_20_1 in pairs(var_20_0) do
			local var_20_1, var_20_2 = DormSuitData:CheckIsSuit(iter_20_0)

			if var_20_2 == DormSuitTools.DORM_SUIT_TYPE.CUSTOM_SET then
				for iter_20_2 = 0, iter_20_1.furList.Length - 1 do
					var_0_1[iter_20_1.furList[iter_20_2].id] = var_0_1[iter_20_1.furList[iter_20_2].id] or 0
					var_0_1[iter_20_1.furList[iter_20_2].id] = var_0_1[iter_20_1.furList[iter_20_2].id] - 1
				end
			else
				for iter_20_3, iter_20_4 in ipairs(BackHomeSuitCfg[iter_20_0].suit_num) do
					var_0_1[iter_20_4[1]] = var_0_1[iter_20_4[1]] or 0
					var_0_1[iter_20_4[1]] = var_0_1[iter_20_4[1]] - iter_20_4[2]
				end
			end
		end
	end
end

function var_0_0.GetRealSpecialFurInfo(arg_21_0)
	local var_21_0 = DormitoryData:GetDormSceneData((DormData:GetCurrectSceneID())).specialFur
	local var_21_1 = {}

	var_21_1.floorID = var_0_4.floorID or var_21_0.floorID
	var_21_1.wallID = var_0_4.wallID or var_21_0.wallID
	var_21_1.backGroundID = var_0_4.backGroundID or var_21_0.backGroundID

	return var_21_1
end

return var_0_0
