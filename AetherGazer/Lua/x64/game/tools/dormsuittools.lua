local var_0_0 = require("cjson")
local var_0_1 = {
	DORM_SUIT_STATE = {
		CAN_USE = 1,
		NOT_GET = 4,
		UNABLE = 5,
		NEED_SHOP = 3,
		NEED_GIFT = 2
	},
	DORM_SUIT_TYPE = {
		FULL_SET = 1,
		CUSTOM_SET = 3,
		PART_SET = 2
	}
}

function var_0_1.SerializeDormSuitData(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0, var_1_1 = var_0_1:FurSerializeDataFilter(arg_1_1, arg_1_2)
	local var_1_2 = arg_1_2.name
	local var_1_3 = {
		furList = var_1_0,
		numList = var_1_1
	}
	local var_1_4 = var_0_1:GetWriteHeadDormSuitSerializePath(arg_1_2.suitType)

	if var_1_4 then
		local var_1_5 = var_0_0.encode(var_1_3)
		local var_1_6 = var_1_4 .. var_1_2 .. ".json"
		local var_1_7 = io.open(var_1_6, "w")

		if var_1_7 then
			var_1_7:write(var_1_5)
			var_1_7:close()
			ShowTips("家具套装序列化成功")
		else
			ShowTips("家具套装序列化失败")
		end
	else
		ShowTips("未获取到对应类型的文件前缀，套装类型索引为" .. arg_1_2.suitType)
	end
end

function var_0_1.FurSerializeDataFilter(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0
	local var_2_1 = {}

	if arg_2_2.suitType == var_0_1.DORM_SUIT_TYPE.PART_SET then
		var_2_0 = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
			if iter_2_1.type == 5 then
				local var_2_2 = {
					type = iter_2_1.type,
					furniture_pos = {}
				}
				local var_2_3 = {}

				for iter_2_2, iter_2_3 in ipairs(iter_2_1.furniture_pos) do
					if not DormSpecialFurnitureTools:JudgeFurIsSpecialType(iter_2_3.furniture_id) and BackHomeFurniture[iter_2_3.furniture_id].sub_type == 0 then
						table.insert(var_2_3, iter_2_3)
					end
				end

				local var_2_4 = var_0_1:GetFurSuitCenter(var_2_3)

				for iter_2_4, iter_2_5 in ipairs(var_2_3) do
					iter_2_5.x = iter_2_5.x - var_2_4.x
					iter_2_5.y = iter_2_5.y - var_2_4.y

					table.insert(var_2_2.furniture_pos, iter_2_5)

					var_2_1[iter_2_5.furniture_id] = var_2_1[iter_2_5.furniture_id] or 0
					var_2_1[iter_2_5.furniture_id] = var_2_1[iter_2_5.furniture_id] + 1
				end

				table.insert(var_2_0, var_2_2)
			else
				local var_2_5 = {
					type = iter_2_1.type,
					furniture_pos = {}
				}

				table.insert(var_2_0, var_2_5)
			end
		end
	else
		var_2_0 = arg_2_1

		for iter_2_6, iter_2_7 in ipairs(arg_2_1) do
			for iter_2_8, iter_2_9 in ipairs(iter_2_7.furniture_pos) do
				var_2_1[iter_2_9.furniture_id] = var_2_1[iter_2_9.furniture_id] or 0
				var_2_1[iter_2_9.furniture_id] = var_2_1[iter_2_9.furniture_id] + 1
			end
		end
	end

	local var_2_6 = {}

	for iter_2_10, iter_2_11 in pairs(var_2_1) do
		local var_2_7 = {
			iter_2_10,
			iter_2_11
		}

		table.insert(var_2_6, var_2_7)
	end

	return var_2_0, var_2_6
end

function var_0_1.GetFurSuitCenter(arg_3_0, arg_3_1)
	local var_3_0
	local var_3_1
	local var_3_2
	local var_3_3

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		local var_3_4 = iter_3_1.rotation
		local var_3_5
		local var_3_6

		if var_3_4 / 90 % 2 == 1 then
			var_3_5 = BackHomeFurniture[iter_3_1.furniture_id].title[2] * DormConst.gridLen / 2
			var_3_6 = BackHomeFurniture[iter_3_1.furniture_id].title[1] * DormConst.gridLen / 2
		else
			var_3_5 = BackHomeFurniture[iter_3_1.furniture_id].title[1] * DormConst.gridLen / 2
			var_3_6 = BackHomeFurniture[iter_3_1.furniture_id].title[2] * DormConst.gridLen / 2
		end

		var_3_0 = var_3_0 or iter_3_1.x
		var_3_0 = math.min(var_3_0, iter_3_1.x - var_3_5)
		var_3_1 = var_3_1 or iter_3_1.x
		var_3_1 = math.max(var_3_1, iter_3_1.x + var_3_5)
		var_3_2 = var_3_2 or iter_3_1.y
		var_3_2 = math.min(var_3_2, iter_3_1.y - var_3_6)
		var_3_3 = var_3_3 or iter_3_1.y
		var_3_3 = math.max(var_3_3, iter_3_1.y + var_3_6)
	end

	if var_3_0 and var_3_1 and var_3_2 and var_3_3 then
		local var_3_7 = (var_3_1 + var_3_0) / 2
		local var_3_8 = (var_3_2 + var_3_3) / 2

		if var_3_7 % 5 ~= 0 then
			var_3_7 = math.floor(var_3_7 / 5) * 5
		end

		if var_3_8 % 5 ~= 0 then
			var_3_8 = math.floor(var_3_8 / 5) * 5
		end

		return Vector2(var_3_7, var_3_8)
	else
		print("散件套装中心数据计算错误")
	end
end

function var_0_1.GetHeadDormSuitSerializePath(arg_4_0, arg_4_1)
	local var_4_0

	if arg_4_1 == var_0_1.DORM_SUIT_TYPE.FULL_SET then
		var_4_0 = "Dorm/SuitJson/FullSet/"
	elseif arg_4_1 == var_0_1.DORM_SUIT_TYPE.PART_SET then
		var_4_0 = "Dorm/SuitJson/PartSet/"
	end

	return var_4_0
end

function var_0_1.GetWriteHeadDormSuitSerializePath(arg_5_0, arg_5_1)
	local var_5_0

	if arg_5_1 == var_0_1.DORM_SUIT_TYPE.FULL_SET then
		var_5_0 = "./Assets/ABResources/Dorm/SuitJson/FullSet/"
	elseif arg_5_1 == var_0_1.DORM_SUIT_TYPE.PART_SET then
		var_5_0 = "./Assets/ABResources/Dorm/SuitJson/PartSet/"
	end

	return var_5_0
end

function var_0_1.GetDormDormSuitSerializePath(arg_6_0, arg_6_1)
	local var_6_0 = BackHomeSuitCfg[arg_6_1].type
	local var_6_1
	local var_6_2 = var_0_1:GetHeadDormSuitSerializePath(var_6_0)

	if var_6_2 then
		var_6_1 = var_6_2 .. tostring(BackHomeSuitCfg[arg_6_1].model)
	end

	return var_6_1
end

function var_0_1.GetDeSerializeDormSuitDataInScene(arg_7_0, arg_7_1)
	local var_7_0 = var_0_1:GetDeSerializeDormSuitData(arg_7_1)
	local var_7_1 = {}
	local var_7_2 = {}
	local var_7_3 = BackHomeSuitCfg[arg_7_1]

	if var_7_0 and var_7_0.furList then
		for iter_7_0, iter_7_1 in ipairs(var_7_0.furList) do
			if iter_7_1.type then
				DormFurnitureTools:AddFurnitureInfo(var_7_1, iter_7_1.furniture_pos, DormConst.PROTOCOL_TILE_TYPE[iter_7_1.type])
			end

			if iter_7_1.type == 5 and BackHomeSuitCfg[arg_7_1].type == var_0_1.DORM_SUIT_TYPE.FULL_SET then
				local var_7_4 = BackHomeSuitCfg[arg_7_1].scene_id[1]

				DormSpecialFurnitureTools:AddSpecialFurInfo(var_7_2, var_7_4, iter_7_1.furniture_pos, false)
			end
		end
	end

	local var_7_5 = RoomInfo.New()

	var_7_5.furnitureInfoS = var_7_1

	return var_7_5.furnitureInfoS, var_7_2.specialFur
end

function var_0_1.GetDeSerializeDormSuitData(arg_8_0, arg_8_1)
	if BackHomeSuitCfg[arg_8_1] then
		local var_8_0 = var_0_1:GetDormDormSuitSerializePath(arg_8_1) .. ".json"
		local var_8_1

		if var_8_0 then
			local var_8_2 = AssetEx.LoadText(var_8_0)

			if var_8_2 then
				var_8_1 = var_0_0.decode(var_8_2)
			else
				print("未获取到json数据")
			end
		end

		if var_8_1 and var_8_1.furList then
			for iter_8_0, iter_8_1 in ipairs(var_8_1.furList) do
				if iter_8_1.type then
					for iter_8_2, iter_8_3 in ipairs(iter_8_1.furniture_pos) do
						iter_8_3.x = iter_8_3.x
						iter_8_3.y = iter_8_3.y
						iter_8_3.rotation = iter_8_3.rotation
					end
				end
			end
		end

		return var_8_1
	end
end

function var_0_1.GetDeSerializeDormSuitDataInLuaData(arg_9_0, arg_9_1)
	local var_9_0 = var_0_1:GetDeSerializeDormSuitData(arg_9_1)

	for iter_9_0, iter_9_1 in ipairs(var_9_0.furList) do
		if iter_9_1.type then
			for iter_9_2, iter_9_3 in ipairs(iter_9_1.furniture_pos) do
				iter_9_3.x = iter_9_3.x / DormConst.POS_PRECISION
				iter_9_3.y = iter_9_3.y / DormConst.POS_PRECISION
				iter_9_3.rotation = iter_9_3.rotation / DormConst.POS_PRECISION
			end
		end
	end

	return var_9_0
end

function var_0_1.GenerateSuitInfoList(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 then
		for iter_10_0, iter_10_1 in pairs(arg_10_1) do
			var_0_1:GenerateFurSuit(iter_10_0, iter_10_1.pos, arg_10_2, iter_10_1.furList)
		end
	end
end

local function var_0_2(arg_11_0, arg_11_1)
	local var_11_0 = DormFurnitureManager.GetInstance():Generate(arg_11_1.id)

	DormLuaBridge.SetFurniturePosition(var_11_0, arg_11_0, arg_11_1.pos, arg_11_1.rotation)
	DormLuaBridge.ChangeFurnitureState(var_11_0, DormFurnitureManager.FurnitureState.Placed)

	return var_11_0
end

function var_0_1.GenerateFullSetFurSuit(arg_12_0, arg_12_1)
	local var_12_0 = DormSuitData:GetSuitFurInfo(arg_12_1)

	DormFurnitureTools:GenFurListInCurRoom(var_12_0.furList)
	DormSpecialFurnitureTools:ChangeDormFloorOrWallData(var_12_0.specialFur)
end

function var_0_1.GenerateFurSuit(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	local var_13_0, var_13_1 = DormSuitData:CheckIsSuit(arg_13_1)
	local var_13_2 = arg_13_4

	if not var_13_2 and arg_13_1 > 1000 then
		var_13_2 = DormSuitData:GetSuitFurInfo(arg_13_1)
	end

	local var_13_3 = {}

	if var_13_2 == nil then
		return
	end

	arg_13_2 = arg_13_2 or {
		rotation = 0,
		x = 0,
		y = 0
	}

	local var_13_4
	local var_13_5

	if var_13_1 == var_0_1.DORM_SUIT_TYPE.PART_SET then
		var_13_4 = var_13_2.furList
		var_13_5 = var_13_2.tileType
	elseif var_13_1 == var_0_1.DORM_SUIT_TYPE.CUSTOM_SET then
		var_13_4 = var_13_2
		var_13_5 = DormConst.PROTOCOL_TILE_TYPE[5]
		arg_13_1 = 0
	end

	for iter_13_0 = 0, var_13_4.Length - 1 do
		local var_13_6 = var_13_4[iter_13_0]

		table.insert(var_13_3, var_0_2(var_13_5, var_13_6))
	end

	local var_13_7 = DormLuaBridge.GenerateSuitPrefab(arg_13_1, var_13_1 == var_0_1.DORM_SUIT_TYPE.PART_SET, var_13_5)

	for iter_13_1, iter_13_2 in pairs(var_13_3) do
		DormLuaBridge.SetFurInSuitChild(var_13_7, iter_13_2)
	end

	local var_13_8 = Vector2(arg_13_2.x or 0, arg_13_2.y or 0)

	DormLuaBridge.SetFurniturePosition(var_13_7, var_13_5, var_13_8, 0)
	DormLuaBridge.RotateFurnitureSuit(var_13_7, arg_13_2.rotation or 0)

	if arg_13_3 then
		DormLuaBridge.SetFurnitureSuitOccupy(var_13_7, arg_13_3)
	end

	DormLuaBridge.UpdateAllWallMountDitherAlphaControl()
	DormLuaBridge.UpdateAllFurnitureInteractAreaEnabled()

	return var_13_7
end

function var_0_1.DestoryFurSuitObject(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = DormLuaBridge.GetSuitFurEidList(arg_14_1)
	local var_14_1 = {}

	for iter_14_0 = 0, var_14_0.Length - 1 do
		table.insert(var_14_1, var_14_0[iter_14_0])
	end

	for iter_14_1, iter_14_2 in ipairs(var_14_1) do
		local var_14_2 = DormUtils.GetEntityData(iter_14_2)

		if arg_14_2 then
			var_14_2.noOccupy = true
		end

		local var_14_3 = var_14_2.cfgID

		if arg_14_3 and var_14_3 then
			DormFurEditStateData:ReviseFurNumInEditRoom(var_14_3, -1)
		end

		DormFurnitureManager.GetInstance().FindAndRemove(iter_14_2)
	end

	DormLuaBridge.RemoveFurniture(arg_14_1, false)
end

function var_0_1.RelieveSuit(arg_15_0, arg_15_1)
	DormLuaBridge.DisassembleFurSuit(arg_15_1)
	DormLuaBridge.ExitSuitEditMode(arg_15_1)
	manager.notify:Invoke(DORM_EXIT_SUIT_EDIT_MODE, arg_15_1)
	DormLuaBridge.RemoveFurniture(arg_15_1, false)
end

function var_0_1.GetSuitHighDefinitionIcon(arg_16_0, arg_16_1)
	local var_16_0 = BackHomeSuitCfg[arg_16_1]

	if var_16_0 then
		local var_16_1 = var_16_0.icon

		if var_16_1 then
			return getSpriteViaConfig("DormSuitPreview", var_16_1)
		end
	end
end

function var_0_1.GetFurSuitGoodListByShopID(arg_17_0, arg_17_1)
	local var_17_0 = getShopIDListByShopID(arg_17_1)
	local var_17_1 = {}

	for iter_17_0, iter_17_1 in ipairs(var_17_0) do
		local var_17_2 = getShopCfg(iter_17_1, arg_17_1)

		if DormSuitData:CheckIsConfigSuit(var_17_2.give_id) then
			table.insert(var_17_1, iter_17_1)
		end
	end

	return var_17_1
end

return var_0_1
