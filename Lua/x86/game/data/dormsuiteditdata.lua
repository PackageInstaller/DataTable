local var_0_0 = singletonClass("DormSuitEditData")
local var_0_1
local var_0_2
local var_0_3
local var_0_4

function var_0_0.EnterFullSuitEditMode(arg_1_0)
	var_0_1, var_0_2, var_0_3 = DormFurEditStateData:GetHadPlaceFurInfoList()
	var_0_4 = DormFurEditStateData:RestoreRoomAllFurniture(true)

	DormFurnitureManager.GetInstance():ClearAndGenByFurList()
	DormLuaBridge.SetIsCanEditTag(false)
end

function var_0_0.ExitFullSuitEditMode(arg_2_0)
	var_0_1 = nil
	var_0_2 = nil
	var_0_3 = nil
	var_0_4 = nil

	DormLuaBridge.SetIsCanEditTag(false)
end

function var_0_0.RecoverSceneBeforeEdit(arg_3_0)
	DormFurEditStateData:SetCacheFurNumInfo(var_0_4, var_0_2)

	var_0_4 = nil

	DormFurnitureManager.GetInstance():ClearAndGenByFurList(var_0_1, true, var_0_3)
	DormSpecialFurnitureTools:ChangeDormFloorOrWallData(var_0_2)
end

function var_0_0.GetFurNumInfoInSuit(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = BackHomeSuitCfg[arg_4_1] or DormSuitData:GetSuitFurInfo(arg_4_1)
	local var_4_1
	local var_4_2

	if var_4_0 then
		local var_4_3 = var_4_0.suit_num

		for iter_4_0, iter_4_1 in ipairs(var_4_3) do
			if iter_4_1[1] == arg_4_3 then
				var_4_1 = iter_4_1[2]
			end
		end
	else
		print("未找到模板数据")
	end

	if BackHomeSuitCfg[arg_4_1] and BackHomeSuitCfg[arg_4_1].type == DormSuitTools.DORM_SUIT_TYPE.FULL_SET then
		local var_4_4 = DormRoomTools:GetHasPlaceFurInfoByRoom(arg_4_2, arg_4_3)
		local var_4_5 = DormFurEditStateData:GetCanUseFurNumInRoom(arg_4_2, arg_4_3)
		local var_4_6 = DormFurEditStateData:GetCacheFurNum(arg_4_3)

		var_4_2 = var_4_4 + var_4_5 + var_4_6
	end

	return var_4_1, var_4_2
end

function var_0_0.ResetSuitPosition(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = DormLuaBridge.GetSuitFurEidList(arg_5_1)
	local var_5_1 = DormSuitData:GetSuitFurInfo(arg_5_2)
	local var_5_2

	if var_5_1 then
		var_5_2 = var_5_1.furList
	end

	if var_5_2 then
		local var_5_3 = {}

		for iter_5_0 = 0, var_5_0.Length - 1 do
			local var_5_4 = {
				cfgID = DormUtils.GetEntityData(var_5_0[iter_5_0]).cfgID,
				eid = var_5_0[iter_5_0]
			}

			var_5_4.flag = false

			table.insert(var_5_3, var_5_4)
		end

		DormLuaBridge.SetSuitFurTrsFather(arg_5_1, false)
		DormLuaBridge.SetFurniturePosition(arg_5_1, var_5_2[0].tileType, Vector2(0, 0), 0)

		for iter_5_1 = 0, var_5_2.Length - 1 do
			for iter_5_2, iter_5_3 in pairs(var_5_3) do
				if var_5_2[iter_5_1].id == iter_5_3.cfgID and not iter_5_3.flag then
					DormLuaBridge.SetFurniturePosition(iter_5_3.eid, var_5_2[iter_5_1].tileType, var_5_2[iter_5_1].pos, var_5_2[iter_5_1].rotation)

					iter_5_3.flag = true

					break
				end
			end
		end

		DormLuaBridge.SetSuitFurTrsFather(arg_5_1, true)
		DormLuaBridge.RefreshSuitLenAndWid(arg_5_1)
		DormLuaBridge.AddFurnitureToWallDitherAlphaControl(arg_5_1)
		DormLuaBridge.BeginDragFurniture(arg_5_1)
	end
end

return var_0_0
