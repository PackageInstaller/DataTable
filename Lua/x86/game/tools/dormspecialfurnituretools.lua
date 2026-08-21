local var_0_0 = {
	ChangeDormSpeicalFur = function(arg_1_0, arg_1_1)
		local var_1_0 = DormData:GetCurrectSceneID()
		local var_1_1 = DormRoomTools:GetRoomSceneType(var_1_0)
		local var_1_2 = BackHomeFurniture[arg_1_1]

		if BackHomeFurniture[arg_1_1].type == DormConst.FLOOR_TYPE_NUM then
			local var_1_3

			if var_1_2.replace and #var_1_2.replace > 0 then
				for iter_1_0 = 1, #var_1_2.scene_id do
					if var_1_1 == var_1_2.scene_id[iter_1_0] then
						var_1_3 = var_1_2.replace[iter_1_0]

						break
					end
				end
			else
				var_1_3 = BackHomeFurniture[arg_1_1].model
			end

			local var_1_4 = BackHomeFurniture[arg_1_1].extend

			if var_1_3 then
				DormLuaBridge.SetRoomThemeFloor(var_1_3, var_1_4)
			end
		elseif BackHomeFurniture[arg_1_1].type == DormConst.WALL_TYPE_NUM then
			local var_1_5 = BackHomeFurniture[arg_1_1].material
			local var_1_6 = BackHomeFurniture[arg_1_1].mesh

			DormLuaBridge.SetRoomThemeWall(var_1_5, var_1_6)
		elseif BackHomeFurniture[arg_1_1].type == DormConst.BACK_GROUND_TYPE then
			local var_1_7 = BackHomeFurniture[arg_1_1].extend
			local var_1_8 = BackHomeFurniture[arg_1_1].material

			DormLuaBridge.SetRoomThemeBG(var_1_7, var_1_8)
		end
	end,
	ChangeDormFloorOrWallData = function(arg_2_0, arg_2_1)
		if arg_2_1.wallID then
			arg_2_0:ChangeDormSpeicalFur(arg_2_1.wallID)
		end

		if arg_2_1.floorID then
			arg_2_0:ChangeDormSpeicalFur(arg_2_1.floorID)
		end

		if arg_2_1.backGroundID then
			arg_2_0:ChangeDormSpeicalFur(arg_2_1.backGroundID)
		end
	end
}

function var_0_0.AddSpecialFurInfo(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_1.specialFur = {}

	if arg_3_4 then
		arg_3_1.specialFur.floorID = var_0_0:GetOriFloorOrWall(arg_3_2, DormConst.FLOOR_TYPE_NUM)
		arg_3_1.specialFur.wallID = var_0_0:GetOriFloorOrWall(arg_3_2, DormConst.WALL_TYPE_NUM)
		arg_3_1.specialFur.backGroundID = var_0_0:GetOriFloorOrWall(arg_3_2, DormConst.BACK_GROUND_TYPE)
	else
		if arg_3_3 then
			for iter_3_0, iter_3_1 in ipairs(arg_3_3) do
				if BackHomeFurniture[iter_3_1.furniture_id] then
					if BackHomeFurniture[iter_3_1.furniture_id].type == DormConst.FLOOR_TYPE_NUM then
						arg_3_1.specialFur.floorID = iter_3_1.furniture_id
					elseif BackHomeFurniture[iter_3_1.furniture_id].type == DormConst.WALL_TYPE_NUM then
						arg_3_1.specialFur.wallID = iter_3_1.furniture_id
					elseif BackHomeFurniture[iter_3_1.furniture_id].type == DormConst.BACK_GROUND_TYPE then
						arg_3_1.specialFur.backGroundID = iter_3_1.furniture_id
					end
				end
			end
		end

		if not arg_3_1.specialFur.floorID then
			arg_3_1.specialFur.floorID = var_0_0:GetOriFloorOrWall(arg_3_2, DormConst.FLOOR_TYPE_NUM)
		end

		if not arg_3_1.specialFur.wallID then
			arg_3_1.specialFur.wallID = var_0_0:GetOriFloorOrWall(arg_3_2, DormConst.WALL_TYPE_NUM)
		end

		if not arg_3_1.specialFur.backGroundID then
			arg_3_1.specialFur.backGroundID = var_0_0:GetOriFloorOrWall(arg_3_2, DormConst.BACK_GROUND_TYPE)
		end
	end
end

function var_0_0.JudgeFurIsSpecialType(arg_4_0, arg_4_1)
	if BackHomeFurniture[arg_4_1] then
		if BackHomeFurniture[arg_4_1].type == DormConst.FLOOR_TYPE_NUM or BackHomeFurniture[arg_4_1].type == DormConst.WALL_TYPE_NUM or BackHomeFurniture[arg_4_1].type == DormConst.BACK_GROUND_TYPE then
			return true
		else
			return false
		end
	end
end

function var_0_0.JudgeIsOriSpecialFur(arg_5_0, arg_5_1)
	if DormConst.LOBBY_ORI_FLOOR_ID == arg_5_1 or DormConst.LOBBY_ORI_WALL_ID == arg_5_1 or DormConst.LOBBY_ORI_BACKHGROUND_ID == arg_5_1 or DormConst.FLOOR_ORI_ID == arg_5_1 or DormConst.WALL_ORI_ID == arg_5_1 or DormConst.BACK_GROUND_ORI_ID == arg_5_1 then
		return true
	end

	return false
end

function var_0_0.GetOriFloorOrWall(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == DormConst.BACKHOME_TYPE.PublicDorm then
		if arg_6_2 == DormConst.FLOOR_TYPE_NUM then
			return DormConst.LOBBY_ORI_FLOOR_ID
		elseif arg_6_2 == DormConst.WALL_TYPE_NUM then
			return DormConst.LOBBY_ORI_WALL_ID
		elseif arg_6_2 == DormConst.BACK_GROUND_TYPE then
			return DormConst.LOBBY_ORI_BACKHGROUND_ID
		end
	elseif arg_6_1 == DormConst.BACKHOME_TYPE.PrivateDorm then
		if arg_6_2 == DormConst.FLOOR_TYPE_NUM then
			return DormConst.FLOOR_ORI_ID
		elseif arg_6_2 == DormConst.WALL_TYPE_NUM then
			return DormConst.WALL_ORI_ID
		elseif arg_6_2 == DormConst.BACK_GROUND_TYPE then
			return DormConst.BACK_GROUND_ORI_ID
		end
	end
end

function var_0_0.GetSpecialFurIDByRoom(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = DormitoryData:GetDormMapList()

	if var_7_0[arg_7_1] then
		if arg_7_2 == DormConst.FLOOR_TYPE_NUM then
			return var_7_0[arg_7_1].specialFur.floorID
		elseif arg_7_2 == DormConst.WALL_TYPE_NUM then
			return var_7_0[arg_7_1].specialFur.wallID
		elseif arg_7_2 == DormConst.BACK_GROUND_TYPE then
			return var_7_0[arg_7_1].specialFur.backGroundID
		end
	end
end

return var_0_0
