local var_0_0 = {
	GenerateFurnitureWhenEnterScene = function(arg_1_0)
		local var_1_0 = DormData:GetCurrectSceneID()
		local var_1_1 = DormitoryData:GetDormSceneData(var_1_0)

		DormSpecialFurnitureTools:ChangeDormFloorOrWallData(var_1_1.specialFur)

		local var_1_2 = var_1_1.suitInfo
		local var_1_3 = DormitoryData:GetDormFurListByRoomID(var_1_0)

		DormFurnitureManager.GetInstance():ClearAndGenByFurList(var_1_3, false, var_1_2)
	end,
	DestoryRandomPruralFurByID = function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		local var_2_0 = DormFurnitureManager.GetInstance():GetAllFurniture()

		for iter_2_0, iter_2_1 in ipairs(var_2_0) do
			if DormUtils.GetEntityData(iter_2_1).cfgID == arg_2_1 then
				if arg_2_3 then
					if DormLuaBridge.CheckFurnitureBelongSuit(arg_2_1) then
						DormFurnitureManager.GetInstance().FindAndRemove(iter_2_1)
						DormFurEditStateData:ReviseFurNumInEditRoom(arg_2_0.itemID, -1)

						arg_2_2 = arg_2_2 - 1
					end
				else
					DormFurnitureManager.GetInstance().FindAndRemove(iter_2_1)
					DormFurEditStateData:ReviseFurNumInEditRoom(arg_2_0.itemID, -1)

					arg_2_2 = arg_2_2 - 1
				end

				if arg_2_2 <= 0 then
					break
				end
			end
		end

		if arg_2_2 <= 0 then
			return true
		end
	end,
	GenFurListInCurRoom = function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_1 then
			DormFurnitureManager.GetInstance():ClearAndGenByFurList(arg_3_1, false, arg_3_2)
		else
			print("家具信息不存在")
		end
	end,
	AddFurnitureInfo = function(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		if arg_4_2 then
			for iter_4_0, iter_4_1 in ipairs(arg_4_2) do
				repeat
					if DormSuitData:CheckIsSuit(iter_4_1.furniture_id) then
						break
					end

					if not BackHomeFurniture[iter_4_1.furniture_id] then
						print("未在家具表中配置，家具id为" .. iter_4_1.furniture_id)

						return
					end

					if not DormSpecialFurnitureTools:JudgeFurIsSpecialType(iter_4_1.furniture_id) then
						local var_4_0 = FurnitureInfo.New()

						var_4_0.id = iter_4_1.furniture_id
						var_4_0.tileType = arg_4_3
						var_4_0.pos = Vector2.New(iter_4_1.x / DormConst.POS_PRECISION, iter_4_1.y / DormConst.POS_PRECISION)
						var_4_0.rotation = iter_4_1.rotation / DormConst.POS_PRECISION

						table.insert(arg_4_1, var_4_0)
					end
				until true
			end
		end
	end,
	ResolverFurnitureInfo = function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = DormRoomTools:GetRoomSceneType(arg_5_2)
		local var_5_1 = {}
		local var_5_2 = {}

		for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
			if iter_5_1.type < 100 then
				arg_5_0:AddFurnitureInfo(var_5_1, iter_5_1.furniture_pos, DormConst.PROTOCOL_TILE_TYPE[iter_5_1.type])
			end

			if iter_5_1.type == DormConst.PROTOCOL_TILE_TYPE_INDEX.FLOOR then
				var_5_2 = iter_5_1.furniture_pos
			end
		end

		local var_5_3 = {}

		DormSpecialFurnitureTools:AddSpecialFurInfo(var_5_3, var_5_0, var_5_2, false)

		local var_5_4 = {}

		for iter_5_2, iter_5_3 in ipairs(arg_5_1) do
			if iter_5_3.type < 100 then
				for iter_5_4, iter_5_5 in ipairs(iter_5_3.furniture_pos) do
					if DormSuitData:CheckIsSuit(iter_5_5.furniture_id) then
						var_5_4[iter_5_5.furniture_id] = {
							pos = {
								x = iter_5_5.x / DormConst.POS_PRECISION,
								y = iter_5_5.y / DormConst.POS_PRECISION,
								rotation = iter_5_5.rotation / DormConst.POS_PRECISION
							}
						}
					end
				end
			else
				var_5_4[iter_5_3.type] = {}

				local var_5_5 = {}

				DormFurnitureTools:AddFurnitureInfo(var_5_5, iter_5_3.furniture_pos, DormConst.PROTOCOL_TILE_TYPE[5])

				local var_5_6 = RoomInfo.New()

				var_5_6.furnitureInfoS = var_5_5
				var_5_4[iter_5_3.type].furList = var_5_6.furnitureInfoS
				var_5_4[iter_5_3.type].tileType = DormConst.PROTOCOL_TILE_TYPE_INDEX.FLOOR
			end
		end

		return var_5_1, var_5_3.specialFur, var_5_4
	end,
	CheckFurShowExtendLable = function(arg_6_0, arg_6_1)
		if BackHomeFurniture[arg_6_1] and BackHomeFurniture[arg_6_1].extend_info == 1 then
			return true
		end

		return false
	end,
	CheckFurCanUseRoom = function(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = BackHomeFurniture[arg_7_2]
		local var_7_1 = false

		for iter_7_0, iter_7_1 in ipairs(var_7_0.scene_id) do
			if iter_7_1 == BackHomeCfg[arg_7_1].type then
				var_7_1 = true

				break
			end
		end

		return var_7_1
	end,
	JudgeFurIsOri = function(arg_8_0, arg_8_1, arg_8_2)
		local var_8_0 = BackHomeCfg[arg_8_1].default_item

		for iter_8_0, iter_8_1 in ipairs(var_8_0) do
			if arg_8_2 == iter_8_1[1] then
				return true
			end
		end

		return false
	end,
	GetCanUseFurListByRoomID = function(arg_9_0, arg_9_1)
		local var_9_0 = {}
		local var_9_1 = BackHomeCfg[arg_9_1].type
		local var_9_2 = DormData:GetFurnitureInfoList()

		for iter_9_0, iter_9_1 in pairs(var_9_2) do
			local var_9_3 = BackHomeFurniture[iter_9_0].scene_id

			for iter_9_2, iter_9_3 in ipairs(var_9_3) do
				if iter_9_3 == var_9_1 then
					if iter_9_3 == DormConst.BACKHOME_TYPE.PrivateDorm and BackHomeFurniture[iter_9_0].is_give == DormConst.BACKHOME_FUR_GIVE_TYPE.SPECIFY then
						if DormitoryData:GetArchiveIDViaRoomID(arg_9_1)[1] == BackHomeFurniture[iter_9_0].hero_id then
							table.insert(var_9_0, iter_9_0)
						end

						break
					end

					table.insert(var_9_0, iter_9_0)

					break
				end
			end
		end

		return var_9_0
	end
}

function var_0_0.GetRoomCanPlaceFurList(arg_10_0, arg_10_1)
	local var_10_0 = {}
	local var_10_1 = var_0_0:GetCanUseFurListByRoomID(arg_10_1)

	if var_10_1 then
		for iter_10_0, iter_10_1 in ipairs(var_10_1) do
			if DormFurEditStateData:GetCanUseFurNumInRoom(arg_10_1, iter_10_1) > 0 then
				table.insert(var_10_0, iter_10_1)
			end
		end
	end

	return var_10_0
end

function var_0_0.GetRoomCanPlaceFurMaxNum(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = 0

	if not var_0_0:CheckFurCanUseRoom(arg_11_1, arg_11_2) then
		return var_11_0
	end

	local var_11_1 = DormData:GetFurnitureInfoList()

	if BackHomeCfg[arg_11_1].type == DormConst.BACKHOME_TYPE.PublicDorm then
		if DormSpecialFurnitureTools:JudgeFurIsSpecialType(arg_11_2) then
			if BackHomeFurniture[arg_11_2].is_give == 0 or BackHomeFurniture[arg_11_2].is_give == 3 then
				if var_11_1[arg_11_2].num > 0 then
					var_11_0 = 1
				end
			elseif BackHomeFurniture[arg_11_2].is_give == 1 and var_11_1[arg_11_2].give_num > 0 then
				var_11_0 = 1
			end
		elseif BackHomeFurniture[arg_11_2].is_give == 0 or BackHomeFurniture[arg_11_2].is_give == 3 then
			var_11_0 = var_11_1[arg_11_2].num
		elseif BackHomeFurniture[arg_11_2].is_give == 1 then
			var_11_0 = var_11_1[arg_11_2].give_num
		end
	elseif BackHomeCfg[arg_11_1].type == DormConst.BACKHOME_TYPE.PrivateDorm then
		local var_11_2 = DormitoryData:GetArchiveIDViaRoomID(arg_11_1)[1]
		local var_11_3 = DormData:GetHeroInfo(var_11_2)

		if DormSpecialFurnitureTools:JudgeFurIsSpecialType(arg_11_2) then
			if BackHomeFurniture[arg_11_2].is_give == 0 or BackHomeFurniture[arg_11_2].is_give == 3 then
				if var_11_1[arg_11_2].num > 0 then
					var_11_0 = 1
				end
			elseif BackHomeFurniture[arg_11_2].is_give == 1 and var_11_3:GetGiftNum(arg_11_2) > 0 then
				var_11_0 = 1
			end
		elseif BackHomeFurniture[arg_11_2].is_give == 0 or BackHomeFurniture[arg_11_2].is_give == 3 then
			var_11_0 = var_11_1[arg_11_2].num
		elseif BackHomeFurniture[arg_11_2].is_give == 1 then
			var_11_0 = var_11_3:GetGiftNum(arg_11_2)
		end
	end

	return var_11_0
end

function var_0_0.GetHasPlaceFurNumInfoInMap(arg_12_0, arg_12_1)
	local var_12_0 = 0
	local var_12_1 = {}
	local var_12_2 = DormData:GetDormSceneData(arg_12_1)

	if var_12_2.roomInfo then
		local var_12_3 = var_12_2.roomInfo.furnitureInfoS

		for iter_12_0 = 0, var_12_3.Length - 1 do
			var_12_0 = var_12_0 + 1

			if not var_12_1[var_12_3[iter_12_0].id] then
				var_12_1[var_12_3[iter_12_0].id] = 0
			end

			var_12_1[var_12_3[iter_12_0].id] = var_12_1[var_12_3[iter_12_0].id] + 1
		end
	end

	if var_12_2.suitInfo then
		for iter_12_1, iter_12_2 in pairs(var_12_2.suitInfo) do
			if iter_12_1 < DormConst.DORM_VISIT_ROOM_MIN then
				var_12_0 = var_12_0 + iter_12_2.furList.Length
			else
				var_12_0 = var_12_0 + DormSuitData:GetSuitNeedTotalFurNumList(iter_12_1)
			end
		end
	end

	return var_12_0, var_12_1
end

function var_0_0.CheckFurCanGiftInRoom(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = DormitoryData:GetArchiveIDViaRoomID(arg_13_1)

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		if DormData:GetHeroInfo(iter_13_1):GetCanGiftNum(arg_13_2) > 0 then
			return true
		end
	end

	return false
end

function var_0_0.GetHadPlaceFlagFurInRoom(arg_14_0, arg_14_1)
	local var_14_0 = {}
	local var_14_1 = DormFurnitureTools:GetCanUseFurListByRoomID(arg_14_1)

	if var_14_1 then
		for iter_14_0, iter_14_1 in ipairs(var_14_1) do
			local var_14_2 = DormFurnitureTools:GetRoomCanPlaceFurMaxNum(arg_14_1, iter_14_1)
			local var_14_3 = DormFurEditStateData:GetCanUseFurNumInRoom(arg_14_1, iter_14_1)
			local var_14_4 = DormRoomTools:GetHasPlaceFurInfoByRoom(arg_14_1, iter_14_1)
			local var_14_5 = DormFurEditStateData:GetCacheFurNum(iter_14_1)

			if var_14_2 - var_14_3 - var_14_4 - var_14_5 > 0 then
				table.insert(var_14_0, iter_14_1)
			elseif var_14_2 - var_14_3 - var_14_4 - var_14_5 < 0 then
				print("被占用数量计算错误")
			end
		end
	end

	return var_14_0
end

function var_0_0.GetNotPresentedFurInRoom(arg_15_0, arg_15_1)
	local var_15_0 = {}
	local var_15_1 = DormFurnitureTools:GetCanUseFurListByRoomID(arg_15_1)

	if var_15_1 then
		for iter_15_0, iter_15_1 in ipairs(var_15_1) do
			if BackHomeFurniture[iter_15_1].is_give == DormConst.BACKHOME_FUR_GIVE_TYPE.GIFT then
				local var_15_2 = DormData:GetFurNumInfo(iter_15_1)

				if BackHomeCfg[arg_15_1].type == DormConst.BACKHOME_TYPE.PublicDorm then
					if var_15_2.num > var_15_2.give_num then
						table.insert(var_15_0, iter_15_1)
					end
				elseif BackHomeCfg[arg_15_1].type == DormConst.BACKHOME_TYPE.PrivateDorm then
					local var_15_3 = DormitoryData:GetArchiveIDViaRoomID(arg_15_1)[1]
					local var_15_4 = DormData:GetHeroInfo(var_15_3)

					if var_15_2.num - var_15_2.give_num > 0 and var_15_4:GetGiftNum(iter_15_1) < BackHomeFurniture[iter_15_1].give_max then
						table.insert(var_15_0, iter_15_1)
					end
				end
			end
		end
	end

	return var_15_0
end

function var_0_0.GetIsOverLoad(arg_16_0, arg_16_1)
	local var_16_0 = DormitoryData:GetDormLevel(arg_16_1)
	local var_16_1

	if BackHomeCfg[arg_16_1].type == DormConst.BACKHOME_TYPE.PublicDorm then
		var_16_1 = GameSetting.dorm_lobby_furniture_limited.value[1]
	elseif BackHomeCfg[arg_16_1].type == DormConst.BACKHOME_TYPE.PrivateDorm then
		var_16_1 = BackHomeDormLevel[var_16_0].furniture_max
	end

	local var_16_2 = DormRoomTools:GetFurHasPlaceTotalNum(arg_16_1)
	local var_16_3 = DormFurEditStateData:GetCacheFurTotalNum()

	if var_16_1 - var_16_2 - var_16_3 - DormConst.DORM_SPECIAL_FURNITURE_NUM > 0 then
		return true
	end

	return false
end

local var_0_1

function var_0_0.InitFurEditFlag(arg_17_0)
	var_0_1 = getData("Dorm", "furEditFlag")

	if not var_0_1 or tostring(var_0_1) == "userdata: NULL" then
		var_0_1 = {
			otherHadPlaceFlag = true,
			hadPlaceFlag = true,
			canPlaceFlag = true,
			notPresentedFlag = true
		}
	end
end

function var_0_0.SaveFurEditFlag(arg_18_0)
	if var_0_1 then
		saveData("Dorm", "furEditFlag", var_0_1)
	end
end

function var_0_0.GetFurEditFlag(arg_19_0)
	return var_0_1
end

local var_0_2

function var_0_0.SetEditFurFlag(arg_20_0, arg_20_1)
	var_0_2 = arg_20_1
end

function var_0_0.GetEditFurFlag(arg_21_0)
	return var_0_2
end

function var_0_0.CheckFurTileType(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = BackHomeFurniture[arg_22_1]

	if var_22_0 then
		if var_22_0.display_type == 0 and arg_22_2 == DormConst.TILE_TYPE.FLOOR then
			return true
		end

		if var_22_0.display_type == 2 and (arg_22_2 == DormConst.TILE_TYPE.WALL_LEFT or arg_22_2 == DormConst.TILE_TYPE.WALL_RIGHT or arg_22_2 == DormConst.TILE_TYPE.WALL_BEHIND or arg_22_2 == DormConst.TILE_TYPE.WALL_FRONT) then
			return true
		end

		return false
	end

	print("不存在编号为" .. arg_22_1 .. "的家具")
end

return var_0_0
