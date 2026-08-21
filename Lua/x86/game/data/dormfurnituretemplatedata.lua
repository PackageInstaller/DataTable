local var_0_0 = singletonClass("DormFurnitureTemplateData")
local var_0_1
local var_0_2

function var_0_0.InitTemplateSimpleDorm(arg_1_0, arg_1_1)
	var_0_0:SetOtherCanSave(arg_1_1.share_is_open or true)
end

function var_0_0.InitDormFurnitureTemplate(arg_2_0, arg_2_1)
	var_0_2 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.template) do
		local var_2_0 = {
			id = iter_2_1.id,
			type = iter_2_1.type,
			name = iter_2_1.name,
			pos = iter_2_1.pos
		}
		local var_2_1 = {}

		if iter_2_1.furniture_pos_list then
			for iter_2_2, iter_2_3 in ipairs(iter_2_1.furniture_pos_list) do
				if iter_2_3.type and iter_2_3.type < 100 then
					DormFurnitureTools:AddFurnitureInfo(var_2_1, iter_2_3.furniture_pos, DormConst.PROTOCOL_TILE_TYPE[iter_2_3.type])
				else
					print("模板数据内存在套装家具，模板id为" .. iter_2_1.id)
				end
			end
		end

		local var_2_2 = iter_2_1.type
		local var_2_3 = RoomInfo.New()

		var_2_3.furnitureInfoS = var_2_1
		var_2_0.furnitureInfoS = var_2_3.furnitureInfoS
		var_0_2[iter_2_1.id] = DormRoomTemplate.New(var_2_0)

		local var_2_4 = {}

		for iter_2_4, iter_2_5 in ipairs(iter_2_1.furniture_pos_list) do
			if iter_2_5.type == DormConst.PROTOCOL_TILE_TYPE_INDEX.FLOOR then
				var_2_4 = iter_2_5.furniture_pos
			end
		end

		DormSpecialFurnitureTools:AddSpecialFurInfo(var_0_2[iter_2_1.id], var_2_2, var_2_4, false)
	end
end

function var_0_0.DeleteDormTemplateInfo(arg_3_0, arg_3_1)
	if var_0_2[arg_3_1] then
		var_0_2[arg_3_1]:Dispose()

		var_0_2[arg_3_1] = nil
	else
		print("不存在家具模板信息")
	end
end

function var_0_0.Dispose(arg_4_0)
	if var_0_2 then
		for iter_4_0, iter_4_1 in pairs(var_0_2) do
			iter_4_1:Dispose()
		end
	end
end

function var_0_0.SetOtherCanSave(arg_5_0, arg_5_1)
	var_0_1 = arg_5_1
end

function var_0_0.GetOtherCanSave(arg_6_0)
	return var_0_1
end

function var_0_0.PreviewDormSceneTemplate(arg_7_0, arg_7_1)
	DormHeroTools.HideAllCharacter()

	local var_7_0 = DormFurnitureTemplateData:GetDormTemplateInfo(arg_7_1)

	if var_7_0 then
		DormFurEditStateData:RestoreRoomAllFurniture(true)

		local var_7_1 = var_7_0.furnitureInfoS

		DormFurnitureTools:GenFurListInCurRoom(var_7_1, var_7_0.suitInfo)

		local var_7_2 = var_7_0.specialFur

		DormSpecialFurnitureTools:ChangeDormFloorOrWallData(var_7_2)
	end
end

function var_0_0.CancelPreviewDormSceneTemplate(arg_8_0, arg_8_1)
	local var_8_0 = DormitoryData:GetDormSceneData(arg_8_1)
	local var_8_1 = var_8_0.roomInfo.furnitureInfoS

	DormFurnitureTools:GenFurListInCurRoom(var_8_1)
	DormSpecialFurnitureTools:ChangeDormFloorOrWallData(var_8_0.specialFur)
	DormSuitTools:GenerateSuitInfoList(var_8_0.suitInfo, true)
	DormHeroTools:GenerateHeroWhenEnterScene()
end

function var_0_0.SaveDormSceneTemplate(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6)
	if arg_9_2 == DormConst.BACKHOME_TYPE.VISITPUBLICDORM then
		arg_9_2 = DormConst.BACKHOME_TYPE.PublicDorm
	end

	if arg_9_2 == DormConst.BACKHOME_TYPE.VISITPRIVATEDORM then
		arg_9_2 = DormConst.BACKHOME_TYPE.PrivateDorm
	end

	if not arg_9_4 or arg_9_4 > 1000 then
		local var_9_0 = DormData:GetCurrectSceneID()
		local var_9_1 = DormitoryData:GetDormSceneData(var_9_0)
		local var_9_2 = DormLuaBridge.GetPlacedFurnitureInfo(true)

		DormAction:SaveFurTemplate(arg_9_1, arg_9_2, arg_9_3, 0, var_9_2, arg_9_5, var_9_1.specialFur, arg_9_6)
	else
		local var_9_3 = DormitoryData:GetDormSceneData(arg_9_4)

		if var_9_3.suitInfo and next(var_9_3.suitInfo) ~= nil then
			local var_9_4 = DormLuaBridge.GetPlacedFurnitureInfo(true)

			DormAction:SaveFurTemplate(arg_9_1, arg_9_2, arg_9_3, 0, var_9_4, arg_9_5, var_9_3.specialFur, arg_9_6)
		else
			DormAction:SaveFurTemplate(arg_9_1, arg_9_2, arg_9_3, arg_9_4, nil, arg_9_5, nil, arg_9_6)
		end
	end
end

function var_0_0.SaveFurTemplateInfo(arg_10_0, arg_10_1)
	local var_10_0 = DormitoryData:GetDormMapList()
	local var_10_1
	local var_10_2 = arg_10_1.architecture_id

	if var_10_2 ~= 0 and var_10_2 < 1000 then
		var_10_1 = var_10_0[var_10_2]
	else
		var_10_1 = var_10_0[DormData:GetCurrectSceneID()]
	end

	local var_10_3 = arg_10_1.pos
	local var_10_4 = arg_10_1.type
	local var_10_5 = DormFurnitureTemplateData:GetDormTemplateInfoByPosID(var_10_3, var_10_4)

	if var_0_2[var_10_5] then
		local var_10_6 = var_0_2[var_10_5]

		var_10_6.id = arg_10_1.id
		var_10_6.type = arg_10_1.type
		var_10_6.name = arg_10_1.name
		var_10_6.posID = arg_10_1.pos
		var_10_6.furnitureInfoS = DormLuaBridge.GetPlacedFurnitureInfo(true)
		var_10_6.specialFur = deepClone(var_10_1.specialFur)
	else
		local var_10_7 = {
			id = arg_10_1.id,
			type = arg_10_1.type,
			name = arg_10_1.name,
			pos = arg_10_1.pos,
			furnitureInfoS = DormLuaBridge.GetPlacedFurnitureInfo(true),
			specialFur = deepClone(var_10_1.specialFur)
		}

		var_0_2[arg_10_1.id] = DormRoomTemplate.New(var_10_7)
	end
end

function var_0_0.ConfirmUseTemplateInRoom(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	if arg_11_3 then
		DormAction:SetFurListInMap(arg_11_2, arg_11_1, nil, arg_11_5)
	else
		DormAction:SetFurListInMap(arg_11_2, nil, arg_11_4, arg_11_5)
	end
end

function var_0_0.GetCanUseTemplateID(arg_12_0)
	local var_12_0 = DormConst.DORM_TEMPLATE_NUM_MAX + DormConst.DORM_TEMPLATE_PRIVATE_NUM_MAX

	for iter_12_0 = 1, var_12_0 do
		local var_12_1 = false

		for iter_12_1, iter_12_2 in pairs(var_0_2) do
			if iter_12_1 == iter_12_0 then
				var_12_1 = true

				break
			end
		end

		if not var_12_1 then
			return iter_12_0
		end
	end
end

function var_0_0.GetDormTemplateInfo(arg_13_0, arg_13_1)
	if var_0_2 and var_0_2[arg_13_1] then
		return var_0_2[arg_13_1]
	end
end

function var_0_0.GetDormTemplateInfoByPosID(arg_14_0, arg_14_1, arg_14_2)
	if var_0_2 then
		for iter_14_0, iter_14_1 in pairs(var_0_2) do
			if iter_14_1.posID == arg_14_1 and arg_14_2 == iter_14_1.type then
				return iter_14_0
			end
		end
	end
end

function var_0_0.CheckFurNumSuitTemplate(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = {}
	local var_15_1 = true
	local var_15_2 = DormFurnitureTemplateData:GetDormTemplateInfo(arg_15_1)

	if not var_15_2 then
		print("模板数据为空")

		return
	end

	local var_15_3, var_15_4 = var_15_2:GetDormTemplateFurNumInfo()

	for iter_15_0, iter_15_1 in pairs(var_15_4) do
		local var_15_5 = DormFurEditStateData:GetCanUseFurNumInRoom(arg_15_2, iter_15_0) + DormRoomTools:GetHasPlaceFurInfoByRoom(arg_15_2, iter_15_0)

		if var_15_5 < iter_15_1 then
			var_15_1 = false
			var_15_0[iter_15_0] = iter_15_1 - var_15_5
		end
	end

	if not var_15_1 then
		return var_15_1, var_15_0
	else
		return var_15_1, nil
	end
end

function var_0_0.ReduceTemplateLackFurInfoS(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = DormFurnitureTemplateData:GetDormTemplateInfo(arg_16_1).furnitureInfoS
	local var_16_1 = DormFurnitureTemplateData:GetDormTemplateInfo(arg_16_1)
	local var_16_2 = {}
	local var_16_3 = var_16_1.specialFur

	for iter_16_0 = 0, var_16_0.Length - 1 do
		local var_16_4 = FurnitureInfo.New()

		var_16_4.id = var_16_0[iter_16_0].id
		var_16_4.tileType = var_16_0[iter_16_0].tileType
		var_16_4.pos = var_16_0[iter_16_0].pos
		var_16_4.rotation = var_16_0[iter_16_0].rotation

		table.insert(var_16_2, var_16_4)
	end

	for iter_16_1 = #var_16_2, 1, -1 do
		local var_16_5 = var_16_2[iter_16_1].id

		if not DormSpecialFurnitureTools:JudgeFurIsSpecialType(var_16_5) and arg_16_2[var_16_5] and arg_16_2[var_16_5] > 0 then
			table.remove(var_16_2, iter_16_1)

			arg_16_2[var_16_5] = arg_16_2[var_16_5] - 1
		end
	end

	local var_16_6 = var_16_1.type
	local var_16_7 = var_16_3.wallID
	local var_16_8 = var_16_3.floorID
	local var_16_9 = var_16_3.backGroundID

	if arg_16_2[var_16_3.wallID] and arg_16_2[var_16_3.wallID] > 0 then
		var_16_7 = DormSpecialFurnitureTools:GetOriFloorOrWall(var_16_6, DormConst.WALL_TYPE_NUM)
	end

	if arg_16_2[var_16_3.floorID] and arg_16_2[var_16_3.floorID] > 0 then
		var_16_8 = DormSpecialFurnitureTools:GetOriFloorOrWall(var_16_6, DormConst.FLOOR_TYPE_NUM)
	end

	if arg_16_2[var_16_3.backGroundID] and arg_16_2[var_16_3.backGroundID] > 0 then
		var_16_9 = DormSpecialFurnitureTools:GetOriFloorOrWall(var_16_6, DormConst.BACK_GROUND_TYPE)
	end

	local var_16_10 = RoomInfo.New()

	var_16_10.furnitureInfoS = var_16_2

	local var_16_11 = {
		wallID = var_16_7,
		floorID = var_16_8,
		backGroundID = var_16_9
	}

	return var_16_10.furnitureInfoS, var_16_11
end

return var_0_0
