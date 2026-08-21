local var_0_0 = class("CrossRoadRunningData")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tpl = arg_1_1
	arg_1_0._sceneMaskTF = arg_1_2
	arg_1_0._gameVo = arg_1_3
	arg_1_0._joyData = nil

	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	arg_2_0.frontContentDis = -265
	arg_2_0.playerTF = nil
	arg_2_0._trackCarGOList = {}
	arg_2_0._roleList = {}
	arg_2_0.selectRoleId = -1
	arg_2_0.playerPosition = nil
	arg_2_0.playRound = -1
	arg_2_0.roleCrashCnt = #CrossRoadGameConst.SHIP_TPL
	arg_2_0.itemGoList = {}

	arg_2_0:InitAllRoads()
	arg_2_0:InitAllTpl()
	arg_2_0:InitItemTF()

	return
end

function var_0_0.InitAllRoads(arg_3_0)
	arg_3_0.sceneContainer = arg_3_0._sceneMaskTF:Find("sceneContainer")
	arg_3_0.backRoadTF = arg_3_0.sceneContainer:Find("scene_background/content/road")
	arg_3_0.sceneRoadTF = arg_3_0.sceneContainer:Find("scene/content/road")
	arg_3_0.frontRoadTF = arg_3_0.sceneContainer:Find("scene_front")
	arg_3_0.backRoadList = {}
	arg_3_0.sceneRoadList = {}
	arg_3_0.frontRoadList = {}

	for iter_3_0 = 1, arg_3_0.backRoadTF.childCount do
		(function(arg_4_0, arg_4_1, arg_4_2)
			local var_4_0 = arg_4_1:Find(tostring(arg_4_2))

			if var_4_0 == nil then
				var_4_0 = arg_4_1:Find("content")

				if var_4_0 == nil then
					return
				end
			end

			;({}).startTF = var_4_0:Find("startPoint")
			;({}).midTF = var_4_0:Find("midPoint")
			;({}).endTF = var_4_0:Find("endPoint")
			arg_4_0[arg_4_2] = {}

			return
		end)(arg_3_0.backRoadList, arg_3_0.backRoadTF, iter_3_0)
	end

	for iter_3_1 = 1, arg_3_0.sceneRoadTF.childCount do
		(function(arg_4_0, arg_4_1, arg_4_2)
			local var_4_0 = arg_4_1:Find(tostring(arg_4_2))

			if var_4_0 == nil then
				var_4_0 = arg_4_1:Find("content")

				if var_4_0 == nil then
					return
				end
			end

			;({}).startTF = var_4_0:Find("startPoint")
			;({}).midTF = var_4_0:Find("midPoint")
			;({}).endTF = var_4_0:Find("endPoint")
			arg_4_0[arg_4_2] = {}

			return
		end)(arg_3_0.sceneRoadList, arg_3_0.sceneRoadTF, iter_3_1)
	end

	;(function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_4_1:Find(tostring(arg_4_2))

		if var_4_0 == nil then
			var_4_0 = arg_4_1:Find("content")

			if var_4_0 == nil then
				return
			end
		end

		;({}).startTF = var_4_0:Find("startPoint")
		;({}).midTF = var_4_0:Find("midPoint")
		;({}).endTF = var_4_0:Find("endPoint")
		arg_4_0[arg_4_2] = {}

		return
	end)(arg_3_0.frontRoadList, arg_3_0.frontRoadTF, 1)

	arg_3_0.frontRoadList[1].lightTF = arg_3_0.frontRoadTF:Find("content/lightPoint")
	arg_3_0.walkLineEnd = arg_3_0.frontRoadTF:Find("content").anchoredPosition.y - CrossRoadGameConst.WALKER_LINE_UNNDER
	arg_3_0.frontContentDis = arg_3_0.frontRoadTF:Find("content").anchoredPosition.y

	return
end

function var_0_0.InitAllTpl(arg_5_0)
	arg_5_0.allShipTpl = {}
	arg_5_0.allItemTpl = {}
	arg_5_0.allCarTpl = {}

	for iter_5_0, iter_5_1 in ipairs(CrossRoadGameConst.SHIP_TPL) do
		table.insert(arg_5_0.allShipTpl, arg_5_0._tpl:Find(iter_5_1))
	end

	for iter_5_2, iter_5_3 in ipairs(CrossRoadGameConst.CAR_TPL) do
		table.insert(arg_5_0.allCarTpl, arg_5_0._tpl:Find(iter_5_3))
	end

	for iter_5_4, iter_5_5 in ipairs(CrossRoadGameConst.ITEM_TPL) do
		table.insert(arg_5_0.allItemTpl, arg_5_0._tpl:Find(iter_5_5))
	end

	arg_5_0.playerTF = arg_5_0._tpl:Find("zhihui_tpl")

	return
end

function var_0_0.InitItemTF(arg_6_0)
	arg_6_0.ItemSceneList = {}
	arg_6_0.ItemSceneTF = arg_6_0.sceneContainer:Find("scene_Item/content")

	for iter_6_0 = 1, 6 do
		table.insert(arg_6_0.ItemSceneList, arg_6_0.ItemSceneTF:Find(tostring(iter_6_0)))
	end

	arg_6_0.hongChaItemTF = arg_6_0.ItemSceneTF:Find("lightPoint")

	return
end

function var_0_0.SetJoyData(arg_7_0, arg_7_1)
	arg_7_0._joyData = arg_7_1

	return
end

function var_0_0.SetTrackCarGoList(arg_8_0, arg_8_1)
	arg_8_0._trackCarGOList = arg_8_1

	return
end

function var_0_0.SetRoleList(arg_9_0, arg_9_1)
	arg_9_0._roleList = arg_9_1

	return
end

function var_0_0.GetRoadList(arg_10_0, arg_10_1)
	if arg_10_1 == CrossRoadGameConst.BACK_ROAD_NAME then
		return arg_10_0.backRoadList
	elseif arg_10_1 == CrossRoadGameConst.SCENE_ROAD_NAME then
		return arg_10_0.sceneRoadList
	elseif arg_10_1 == CrossRoadGameConst.FRONT_ROAD_NAME then
		return arg_10_0.frontRoadList[1]
	end

	return
end

function var_0_0.GetRoadTF(arg_11_0, arg_11_1)
	if arg_11_1 == CrossRoadGameConst.BACK_ROAD_NAME then
		return arg_11_0.backRoadTF
	elseif arg_11_1 == CrossRoadGameConst.SCENE_ROAD_NAME then
		return arg_11_0.sceneRoadTF
	elseif arg_11_1 == CrossRoadGameConst.FRONT_ROAD_NAME then
		return arg_11_0.frontRoadTF
	end

	return
end

function var_0_0.GetAllShipTpl(arg_12_0)
	return arg_12_0.allShipTpl
end

function var_0_0.GetAllCarTpl(arg_13_0)
	return arg_13_0.allCarTpl
end

function var_0_0.GetAllItemTpl(arg_14_0)
	return arg_14_0.allItemTpl
end

function var_0_0.GetZhiHuiTpl(arg_15_0)
	return arg_15_0.zhihuiTpl
end

function var_0_0.GetItemListTF(arg_16_0)
	return arg_16_0.ItemSceneList
end

function var_0_0.GetHongChaTpl(arg_17_0)
	return arg_17_0.allItemTpl[1]
end

function var_0_0.GetHongChaTF(arg_18_0)
	return arg_18_0.hongChaItemTF
end

function var_0_0.GetItemScene(arg_19_0)
	return arg_19_0.ItemSceneTF
end

function var_0_0.GetJoyData(arg_20_0)
	return arg_20_0._joyData
end

function var_0_0.GetSceneWidth(arg_21_0)
	return arg_21_0.sceneContainer.rect.width
end

function var_0_0.GetTrackCarGoList(arg_22_0)
	return arg_22_0._trackCarGOList
end

function var_0_0.GetFrontRoadUnderLine(arg_23_0)
	return arg_23_0.walkLineEnd
end

function var_0_0.GetFrontRoadDistance(arg_24_0)
	return arg_24_0.frontContentDis
end

function var_0_0.GetRoleList(arg_25_0)
	return arg_25_0._roleList
end

function var_0_0.SetSelectID(arg_26_0, arg_26_1)
	arg_26_0.selectRoleId = arg_26_1

	return
end

function var_0_0.GetSelectID(arg_27_0)
	return arg_27_0.selectRoleId
end

function var_0_0.SetPlayerPosition(arg_28_0, arg_28_1)
	arg_28_0.playerPosition = arg_28_1

	return
end

function var_0_0.GetPlayerPosition(arg_29_0)
	return arg_29_0.playerPosition
end

function var_0_0.SetPlayerCrashDir(arg_30_0, arg_30_1)
	arg_30_0.playerCrashDir = arg_30_1

	return
end

function var_0_0.GetPlayerCrashDir(arg_31_0)
	return arg_31_0.playerCrashDir
end

function var_0_0.SetPlayerCarshSize(arg_32_0, arg_32_1)
	arg_32_0.playerCrashSize = arg_32_1

	return
end

function var_0_0.GetPlayerCarshSize(arg_33_0)
	return arg_33_0.playerCrashSize
end

function var_0_0.SetItemGoList(arg_34_0, arg_34_1)
	arg_34_0.itemGoList = arg_34_1

	return
end

function var_0_0.GetItemGoList(arg_35_0)
	return arg_35_0.itemGoList
end

function var_0_0.RefreshRound(arg_36_0)
	arg_36_0.playRound = arg_36_0.playRound + 1
	arg_36_0.roleCrashCnt = #CrossRoadGameConst.SHIP_TPL

	return
end

function var_0_0.GetRoundCnt(arg_37_0)
	return arg_37_0.playRound
end

function var_0_0.CrashDeadRole(arg_38_0)
	arg_38_0.roleCrashCnt = arg_38_0.roleCrashCnt - 1

	return
end

function var_0_0.CanRefreshRound(arg_39_0)
	return arg_39_0.roleCrashCnt == 0
end

function var_0_0.FindRoleFa(arg_40_0, arg_40_1)
	local var_40_0 = arg_40_1:GetFatherID()
	local var_40_1 = arg_40_1:GetID()

	if var_40_0 == var_40_1 then
		return var_40_1
	else
		local var_40_2 = arg_40_0:FindRoleFa(arg_40_0._roleList[var_40_0])

		arg_40_1:SetFatherID(var_40_2)

		return var_40_2
	end

	return
end

function var_0_0.upDateRoleFather(arg_41_0)
	for iter_41_0, iter_41_1 in ipairs(arg_41_0._roleList) do
		arg_41_0:FindRoleFa(iter_41_1)
	end

	return
end

function var_0_0.OutRoleUnion(arg_42_0, arg_42_1, arg_42_2)
	local var_42_0 = arg_42_1:GetID()
	local var_42_1 = arg_42_2:GetID()
	local var_42_2 = arg_42_0:FindRoleFa(arg_42_2)

	if var_42_0 == arg_42_0:FindRoleFa(arg_42_1) then
		arg_42_1:SetFatherID(var_42_1)
		arg_42_2:SetFatherID(var_42_1)
		arg_42_0:upDateRoleFather()
		arg_42_1:SetFatherID(var_42_0)
	else
		arg_42_2:SetFatherID(var_42_1)
		arg_42_1:SetFatherID(var_42_0)

		for iter_42_0 = var_42_1 + 1, #arg_42_0._roleList do
			if arg_42_0._roleList[iter_42_0]:GetRunState() == CrossRoadGameConst.SHIP_STATE.crash then
				-- block empty
			elseif arg_42_0:FindRoleFa(arg_42_0._roleList[iter_42_0]) == var_42_0 then
				arg_42_0._roleList[iter_42_0]:SetFatherID(var_42_1)
			else
				break
			end
		end
	end

	return
end

function var_0_0.InRoleUnion(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = arg_43_1:GetID()
	local var_43_1 = arg_43_0:FindRoleFa(arg_43_2)

	if arg_43_0:FindRoleFa(arg_43_1) == var_43_1 then
		return
	end

	arg_43_1:SetFatherID(var_43_1)

	return
end

function var_0_0.TryUpdateUnion(arg_44_0, arg_44_1)
	local var_44_0 = -1

	for iter_44_0 = arg_44_1:GetID() + 1, #arg_44_0._roleList do
		if arg_44_0._roleList[iter_44_0]:GetRunState() == CrossRoadGameConst.SHIP_STATE.crash then
			-- block empty
		elseif CrossRoadGameHelper:CheckTwoRoleIsCrash(arg_44_1, arg_44_0._roleList[iter_44_0]) then
			var_44_0 = iter_44_0
		else
			break
		end
	end

	if var_44_0 == -1 then
		return
	end

	arg_44_0:OutRoleUnion(arg_44_1, arg_44_0._roleList[var_44_0])

	return
end

function var_0_0.CheckCarCarshRole(arg_45_0, arg_45_1, arg_45_2)
	local var_45_0, var_45_1, var_45_2, var_45_3 = arg_45_1:GetCarRectPoint()
	local var_45_4, var_45_5, var_45_6, var_45_7 = arg_45_2:GetRoleRectPoint()

	return CrossRoadGameHelper:IsRectCross(var_45_0, var_45_1 - arg_45_0.frontContentDis, var_45_2, var_45_3 - arg_45_0.frontContentDis, var_45_4, var_45_5, var_45_6, var_45_7)
end

function var_0_0.CheckCarCarshPlayer(arg_46_0, arg_46_1)
	local var_46_0, var_46_1, var_46_2, var_46_3 = arg_46_1:GetCarRectPoint()

	return CrossRoadGameHelper:IsRectCross(var_46_0, var_46_1 - arg_46_0.frontContentDis, var_46_2, var_46_3 - arg_46_0.frontContentDis, arg_46_0.playerPosition.x - arg_46_0.playerTF.rect.width / 2, arg_46_0.playerPosition.y - arg_46_0.playerTF.rect.height / 2, arg_46_0.playerPosition.x + arg_46_0.playerTF.rect.width / 2, arg_46_0.playerPosition.y + arg_46_0.playerTF.rect.height / 2)
end

function var_0_0.Clear(arg_47_0)
	arg_47_0._joyData = nil
	arg_47_0._roleList = {}
	arg_47_0.selectRoleId = -1
	arg_47_0.playerPosition = nil
	arg_47_0.playerCrashDir = nil
	arg_47_0.playerCrashSize = nil
	arg_47_0.playRound = -1
	arg_47_0.roleCrashCnt = #CrossRoadGameConst.SHIP_TPL
	arg_47_0.itemGoList = {}

	return
end

return var_0_0
