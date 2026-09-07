local CrossRoadRunningData = class("CrossRoadRunningData")

function CrossRoadRunningData:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._tpl = arg_1_1
	self._sceneMaskTF = arg_1_2
	self._gameVo = arg_1_3
	self._joyData = nil

	self:Init()

	return
end

function CrossRoadRunningData:Init()
	self.frontContentDis = -265
	self.playerTF = nil
	self._trackCarGOList = {}
	self._roleList = {}
	self.selectRoleId = -1
	self.playerPosition = nil
	self.playRound = -1
	self.roleCrashCnt = #CrossRoadGameConst.SHIP_TPL
	self.itemGoList = {}

	self:InitAllRoads()
	self:InitAllTpl()
	self:InitItemTF()

	return
end

function CrossRoadRunningData:InitAllRoads()
	local function var_3_0(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_4_1:Find(tostring(arg_4_2))

		if var_4_0 == nil then
			var_4_0 = arg_4_1:Find("content")

			local var_4_1

			if var_4_0 == nil then
				do return end

				var_4_1 = {}
			end
		end

		var_4_1.startTF = var_4_0:Find("startPoint")
		var_4_1.midTF = var_4_0:Find("midPoint")
		var_4_1.endTF = var_4_0:Find("endPoint")
		arg_4_0[arg_4_2] = var_4_1

		return
	end

	self.sceneContainer = self._sceneMaskTF:Find("sceneContainer")
	self.backRoadTF = self.sceneContainer:Find("scene_background/content/road")
	self.sceneRoadTF = self.sceneContainer:Find("scene/content/road")
	self.frontRoadTF = self.sceneContainer:Find("scene_front")
	self.backRoadList = {}
	self.sceneRoadList = {}
	self.frontRoadList = {}

	for iter_3_0 = 1, self.backRoadTF.childCount do
		var_3_0(self.backRoadList, self.backRoadTF, iter_3_0)
	end

	for iter_3_1 = 1, self.sceneRoadTF.childCount do
		var_3_0(self.sceneRoadList, self.sceneRoadTF, iter_3_1)
	end

	var_3_0(self.frontRoadList, self.frontRoadTF, 1)

	self.frontRoadList[1].lightTF = self.frontRoadTF:Find("content/lightPoint")
	self.walkLineEnd = self.frontRoadTF:Find("content").anchoredPosition.y - CrossRoadGameConst.WALKER_LINE_UNNDER
	self.frontContentDis = self.frontRoadTF:Find("content").anchoredPosition.y

	return
end

function CrossRoadRunningData:InitAllTpl()
	self.allShipTpl = {}
	self.allItemTpl = {}
	self.allCarTpl = {}

	for iter_5_0, iter_5_1 in ipairs(CrossRoadGameConst.SHIP_TPL) do
		table.insert(self.allShipTpl, self._tpl:Find(iter_5_1))
	end

	for iter_5_2, iter_5_3 in ipairs(CrossRoadGameConst.CAR_TPL) do
		table.insert(self.allCarTpl, self._tpl:Find(iter_5_3))
	end

	for iter_5_4, iter_5_5 in ipairs(CrossRoadGameConst.ITEM_TPL) do
		table.insert(self.allItemTpl, self._tpl:Find(iter_5_5))
	end

	self.playerTF = self._tpl:Find("zhihui_tpl")

	return
end

function CrossRoadRunningData:InitItemTF()
	self.ItemSceneList = {}
	self.ItemSceneTF = self.sceneContainer:Find("scene_Item/content")

	for iter_6_0 = 1, 6 do
		table.insert(self.ItemSceneList, self.ItemSceneTF:Find(tostring(iter_6_0)))
	end

	self.hongChaItemTF = self.ItemSceneTF:Find("lightPoint")

	return
end

function CrossRoadRunningData:SetJoyData(arg_7_1)
	self._joyData = arg_7_1

	return
end

function CrossRoadRunningData:SetTrackCarGoList(arg_8_1)
	self._trackCarGOList = arg_8_1

	return
end

function CrossRoadRunningData:SetRoleList(arg_9_1)
	self._roleList = arg_9_1

	return
end

function CrossRoadRunningData:GetRoadList(arg_10_1)
	if arg_10_1 == CrossRoadGameConst.BACK_ROAD_NAME then
		return self.backRoadList
	elseif arg_10_1 == CrossRoadGameConst.SCENE_ROAD_NAME then
		return self.sceneRoadList
	elseif arg_10_1 == CrossRoadGameConst.FRONT_ROAD_NAME then
		return self.frontRoadList[1]
	end

	return
end

function CrossRoadRunningData:GetRoadTF(arg_11_1)
	if arg_11_1 == CrossRoadGameConst.BACK_ROAD_NAME then
		return self.backRoadTF
	elseif arg_11_1 == CrossRoadGameConst.SCENE_ROAD_NAME then
		return self.sceneRoadTF
	elseif arg_11_1 == CrossRoadGameConst.FRONT_ROAD_NAME then
		return self.frontRoadTF
	end

	return
end

function CrossRoadRunningData:GetAllShipTpl()
	return self.allShipTpl
end

function CrossRoadRunningData:GetAllCarTpl()
	return self.allCarTpl
end

function CrossRoadRunningData:GetAllItemTpl()
	return self.allItemTpl
end

function CrossRoadRunningData:GetZhiHuiTpl()
	return self.zhihuiTpl
end

function CrossRoadRunningData:GetItemListTF()
	return self.ItemSceneList
end

function CrossRoadRunningData:GetHongChaTpl()
	return self.allItemTpl[1]
end

function CrossRoadRunningData:GetHongChaTF()
	return self.hongChaItemTF
end

function CrossRoadRunningData:GetItemScene()
	return self.ItemSceneTF
end

function CrossRoadRunningData:GetJoyData()
	return self._joyData
end

function CrossRoadRunningData:GetSceneWidth()
	return self.sceneContainer.rect.width
end

function CrossRoadRunningData:GetTrackCarGoList()
	return self._trackCarGOList
end

function CrossRoadRunningData:GetFrontRoadUnderLine()
	return self.walkLineEnd
end

function CrossRoadRunningData:GetFrontRoadDistance()
	return self.frontContentDis
end

function CrossRoadRunningData:GetRoleList()
	return self._roleList
end

function CrossRoadRunningData:SetSelectID(arg_26_1)
	self.selectRoleId = arg_26_1

	return
end

function CrossRoadRunningData:GetSelectID()
	return self.selectRoleId
end

function CrossRoadRunningData:SetPlayerPosition(arg_28_1)
	self.playerPosition = arg_28_1

	return
end

function CrossRoadRunningData:GetPlayerPosition()
	return self.playerPosition
end

function CrossRoadRunningData:SetPlayerCrashDir(arg_30_1)
	self.playerCrashDir = arg_30_1

	return
end

function CrossRoadRunningData:GetPlayerCrashDir()
	return self.playerCrashDir
end

function CrossRoadRunningData:SetPlayerCarshSize(arg_32_1)
	self.playerCrashSize = arg_32_1

	return
end

function CrossRoadRunningData:GetPlayerCarshSize()
	return self.playerCrashSize
end

function CrossRoadRunningData:SetItemGoList(arg_34_1)
	self.itemGoList = arg_34_1

	return
end

function CrossRoadRunningData:GetItemGoList()
	return self.itemGoList
end

function CrossRoadRunningData:RefreshRound()
	self.playRound = self.playRound + 1
	self.roleCrashCnt = #CrossRoadGameConst.SHIP_TPL

	return
end

function CrossRoadRunningData:GetRoundCnt()
	return self.playRound
end

function CrossRoadRunningData:CrashDeadRole()
	self.roleCrashCnt = self.roleCrashCnt - 1

	return
end

function CrossRoadRunningData:CanRefreshRound()
	return self.roleCrashCnt == 0
end

function CrossRoadRunningData:FindRoleFa(arg_40_1)
	local var_40_0 = arg_40_1:GetFatherID()
	local var_40_1 = arg_40_1:GetID()

	if var_40_0 == var_40_1 then
		return var_40_1
	else
		local var_40_2 = self:FindRoleFa(self._roleList[var_40_0])

		arg_40_1:SetFatherID(var_40_2)

		return var_40_2
	end

	return
end

function CrossRoadRunningData:upDateRoleFather()
	for iter_41_0, iter_41_1 in ipairs(self._roleList) do
		self:FindRoleFa(iter_41_1)
	end

	return
end

function CrossRoadRunningData:OutRoleUnion(arg_42_1, arg_42_2)
	local var_42_0 = arg_42_1:GetID()
	local var_42_1 = arg_42_2:GetID()
	local var_42_2 = self:FindRoleFa(arg_42_2)

	if var_42_0 == self:FindRoleFa(arg_42_1) then
		arg_42_1:SetFatherID(var_42_1)
		arg_42_2:SetFatherID(var_42_1)
		self:upDateRoleFather()
		arg_42_1:SetFatherID(var_42_0)
	else
		arg_42_2:SetFatherID(var_42_1)
		arg_42_1:SetFatherID(var_42_0)

		for iter_42_0 = var_42_1 + 1, #self._roleList do
			if self._roleList[iter_42_0]:GetRunState() == CrossRoadGameConst.SHIP_STATE.crash then
				-- block empty
			elseif self:FindRoleFa(self._roleList[iter_42_0]) == var_42_0 then
				self._roleList[iter_42_0]:SetFatherID(var_42_1)
			else
				break
			end
		end
	end

	return
end

function CrossRoadRunningData:InRoleUnion(arg_43_1, arg_43_2)
	local var_43_0 = arg_43_1:GetID()
	local var_43_1 = self:FindRoleFa(arg_43_2)

	if self:FindRoleFa(arg_43_1) == var_43_1 then
		return
	end

	arg_43_1:SetFatherID(var_43_1)

	return
end

function CrossRoadRunningData:TryUpdateUnion(arg_44_1)
	local var_44_0 = -1

	for iter_44_0 = arg_44_1:GetID() + 1, #self._roleList do
		if self._roleList[iter_44_0]:GetRunState() == CrossRoadGameConst.SHIP_STATE.crash then
			-- block empty
		elseif CrossRoadGameHelper:CheckTwoRoleIsCrash(arg_44_1, self._roleList[iter_44_0]) then
			var_44_0 = iter_44_0
		else
			break
		end
	end

	if var_44_0 == -1 then
		return
	end

	self:OutRoleUnion(arg_44_1, self._roleList[var_44_0])

	return
end

function CrossRoadRunningData:CheckCarCarshRole(arg_45_1, arg_45_2)
	local var_45_0, var_45_1, var_45_2, var_45_3 = arg_45_1:GetCarRectPoint()
	local var_45_4, var_45_5, var_45_6, var_45_7 = arg_45_2:GetRoleRectPoint()

	return CrossRoadGameHelper:IsRectCross(var_45_0, var_45_1 - self.frontContentDis, var_45_2, var_45_3 - self.frontContentDis, var_45_4, var_45_5, var_45_6, var_45_7)
end

function CrossRoadRunningData:CheckCarCarshPlayer(arg_46_1)
	local var_46_0, var_46_1, var_46_2, var_46_3 = arg_46_1:GetCarRectPoint()

	return CrossRoadGameHelper:IsRectCross(var_46_0, var_46_1 - self.frontContentDis, var_46_2, var_46_3 - self.frontContentDis, self.playerPosition.x - self.playerTF.rect.width / 2, self.playerPosition.y - self.playerTF.rect.height / 2, self.playerPosition.x + self.playerTF.rect.width / 2, self.playerPosition.y + self.playerTF.rect.height / 2)
end

function CrossRoadRunningData:Clear()
	self._joyData = nil
	self._roleList = {}
	self.selectRoleId = -1
	self.playerPosition = nil
	self.playerCrashDir = nil
	self.playerCrashSize = nil
	self.playRound = -1
	self.roleCrashCnt = #CrossRoadGameConst.SHIP_TPL
	self.itemGoList = {}

	return
end

return CrossRoadRunningData
