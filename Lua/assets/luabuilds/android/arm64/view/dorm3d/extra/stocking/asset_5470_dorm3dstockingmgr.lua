local Dorm3dStockingMgr = class("Dorm3dStockingMgr", import("view.dorm3d.Extra.BaseExtraSystem"))

Dorm3dStockingMgr.SET_STOCKING_STATUS = "Dorm3dStockingMgr.SET_STOCKING_STATUS"
Dorm3dStockingMgr.EXIT_STOCKING_STATUS = "Dorm3dStockingMgr.EXIT_STOCKING_STATUS"
Dorm3dStockingMgr.GET_TIP_SHOW_INFO = "Dorm3dStockingMgr.GET_TIP_SHOW_INFO"
Dorm3dStockingMgr.ON_BEGIN_DRAG = "Dorm3dStockingMgr.ON_BEGIN_DRAG"
Dorm3dStockingMgr.ON_DRAG = "Dorm3dStockingMgr.ON_DRAG"
Dorm3dStockingMgr.ON_END_DRAG = "Dorm3dStockingMgr.ON_END_DRAG"
Dorm3dStockingMgr.ON_EXIT_TOUCH_MODE = "Dorm3dStockingMgr.ON_EXIT_TOUCH_MODE"
Dorm3dStockingMgr.L_COLLIDERS = {
	"LeftThighCollider",
	"LeftCalfCollider",
	"LeftFootCollider"
}
Dorm3dStockingMgr.R_COLLIDERS = {
	"RightThighCollider",
	"RightCalfCollider",
	"RightFootCollider"
}
Dorm3dStockingMgr.UNLOCK_CONFIG = {
	[307071] = 1222
}

local var_0_1

function Dorm3dStockingMgr:OnInit()
	local var_1_0 = self:GetCurrentLadyEnv()

	if var_1_0 then
		for iter_1_0, iter_1_1 in pairs(var_1_0.skinIdList) do
			self:InitDormStocking(self:Get("skinDict")[iter_1_1].ladyGameObject.transform, iter_1_1)
		end
	end

	return
end

function Dorm3dStockingMgr:RegisterEvents()
	self:Bind(Dorm3dStockingMgr.SET_STOCKING_STATUS, function(arg_3_0, arg_3_1)
		self:SetStockingStatus(arg_3_1)

		return
	end)
	self:Bind(Dorm3dStockingMgr.EXIT_STOCKING_STATUS, function(arg_4_0)
		self:ExitStockingStatus()

		return
	end)
	self:Bind(Dorm3dStockingMgr.GET_TIP_SHOW_INFO, function(arg_5_0, arg_5_1)
		return self:GetTipShowInfo(arg_5_1)
	end)
	self:Bind(Dorm3dStockingMgr.ON_BEGIN_DRAG, function(arg_6_0, arg_6_1, arg_6_2)
		self:OnBeginDrag(arg_6_1, arg_6_2)

		return
	end)
	self:Bind(Dorm3dStockingMgr.ON_DRAG, function(arg_7_0, arg_7_1, arg_7_2)
		self:OnDrag(arg_7_1, arg_7_2)

		return
	end)
	self:Bind(Dorm3dStockingMgr.ON_END_DRAG, function(arg_8_0, arg_8_1, arg_8_2)
		self:OnEndDrag(arg_8_1, arg_8_2)

		return
	end)
	self:Bind(Dorm3dStockingMgr.ON_EXIT_TOUCH_MODE, function(arg_9_0)
		self:OnExitTouchMode()

		return
	end)

	return
end

function Dorm3dStockingMgr:OnHandleNotification(arg_10_1, arg_10_2)
	if arg_10_1 == GAME.APARTMENT_REPLACE_FURNITURE_DONE then
		local var_10_0 = self:GetCurrentLadyEnv()

		if not var_10_0 then
			return
		end

		for iter_10_0, iter_10_1 in pairs(var_10_0.skinIdList) do
			self:InitDormStocking(self:Get("skinDict")[iter_10_1].ladyGameObject.transform, iter_10_1)
		end
	end

	return
end

function Dorm3dStockingMgr.GetInterests()
	return {
		GAME.APARTMENT_REPLACE_FURNITURE_DONE
	}
end

function Dorm3dStockingMgr:OnBeginDrag(arg_12_1, arg_12_2)
	if self.blockingDrag then
		return
	end

	local var_12_0 = CameraMgr.instance:Raycast(self:Get("sceneRaycaster"), arg_12_2.position):ToTable()

	if #var_12_0 > 0 then
		local var_12_1 = var_12_0[1].gameObject.transform
		local var_12_2, var_12_3 = table.Find(Dorm3dStockingMgr.L_COLLIDERS, function(arg_13_0, arg_13_1)
			return var_12_1.name == arg_13_1
		end)
		local var_12_4, var_12_5 = table.Find(Dorm3dStockingMgr.R_COLLIDERS, function(arg_14_0, arg_14_1)
			return var_12_1.name == arg_14_1
		end)
		local var_12_6 = var_12_3 and 1 or var_12_5 and 2 or nil

		warning(var_12_1, var_12_3 and 1 or var_12_5 and 2 or nil)

		if not var_12_6 or var_0_1.enable_drag[var_12_6] == 0 or not self.isShow[var_12_6] then
			return
		end

		self.inDragStocking = var_12_6

		if self.inDragStocking then
			self.startStockingPos = GraphicsInterface.Instance:GetStockingPos(self.stockingTFs[self.inDragStocking].gameObject)
			self.preMin, self.preMax = self.startStockingPos, self.startStockingPos

			GraphicsInterface.Instance:StockingMouseDown(self.stockingTFs[self.inDragStocking].gameObject, arg_12_2.position, self.mainCamera)
		end
	end

	return
end

function Dorm3dStockingMgr:OnDrag(arg_15_1, arg_15_2)
	if self.blockingDrag then
		return
	end

	if self.inDragStocking then
		GraphicsInterface.Instance:StockingMouseDrag(self.stockingTFs[self.inDragStocking].gameObject, arg_15_2.position, self.mainCamera)

		local var_15_0 = GraphicsInterface.Instance:GetStockingPos(self.stockingTFs[self.inDragStocking].gameObject)

		self.preMin = math.min(self.preMin, var_15_0)
		self.preMax = math.max(self.preMax, var_15_0)

		return
	end

	self:Emit(Dorm3dRoomTemplateScene.ON_STICK_MOVE, arg_15_2.delta)

	return
end

function Dorm3dStockingMgr:OnEndDrag(arg_16_1, arg_16_2)
	if self.blockingDrag then
		return
	end

	if self.inDragStocking then
		GraphicsInterface.Instance:StockingMouseUp(self.stockingTFs[self.inDragStocking].gameObject)

		self.endStockingPos = GraphicsInterface.Instance:GetStockingPos(self.stockingTFs[self.inDragStocking].gameObject)

		self:TryTriggerEvent()
		self:CheckStockingShow()
	end

	self.inDragStocking = nil

	return
end

function Dorm3dStockingMgr:TryTriggerEvent()
	warning("TryTriggerEvent", self.inDragStocking, self.startStockingPos, self.endStockingPos, self.preMin, self.preMax)

	local var_17_0 = self.inDragStocking

	var_17_0 = self.endStockingPos > self.startStockingPos and var_17_0 * 2 - 1 or var_17_0 * 2

	for iter_17_0, iter_17_1 in ipairs(self.triggerDic[var_17_0]) do
		if iter_17_1:Check(self.endStockingPos, self.preMax, self.preMin) then
			local var_17_1, var_17_2, var_17_3 = iter_17_1:Trigger()

			self:TriggerEvent(var_17_1, var_17_2, var_17_3)

			break
		end
	end

	return
end

function Dorm3dStockingMgr:TriggerEvent(arg_18_1, arg_18_2, arg_18_3)
	warning("TriggerEvent", arg_18_1, arg_18_2, arg_18_3)

	self.blockingDrag = true

	local function var_18_0()
		self.blockingDrag = false

		if arg_18_3 then
			self:ExitStockingStatus()
		else
			self:ResetLady()
		end

		return
	end

	switch(arg_18_1, {
		function()
			self:Func("DoTalk", arg_18_2[1], var_18_0)

			return
		end
	})

	return
end

function Dorm3dStockingMgr:CheckStockingShow()
	if not self.useHideMode then
		return
	end

	if self.endStockingPos <= 0.01 then
		self.isShow[self.inDragStocking] = false

		setActive(self.stockingTFs[self.inDragStocking], false)
		setActive(self.sceneStockingTFs[self.inDragStocking], true)
	end

	return
end

function Dorm3dStockingMgr:InitStatus(arg_22_1)
	self.ladyEnv = self:GetCurrentLadyEnv()
	var_0_1 = pg.dorm3d_stocking[arg_22_1]
	self.cacheIkStatus = self.ladyEnv.currentIkStatus
	self.inDragStocking = false
	self.stockingL, self.stockingR = Dorm3dStockingMgr.GetStockingGeo(self.ladyEnv.lady, var_0_1.skin_id)
	self.stockingTFs = {
		self.stockingL,
		self.stockingR
	}
	self.mainCamera = self:Get("mainCameraTF"):GetComponent(typeof(Camera))
	self.tiptransforms = {
		self.ladyEnv.lady:Find(var_0_1.tip_show_path[1]),
		self.ladyEnv.lady:Find(var_0_1.tip_show_path[2])
	}
	self.tipDirections = {
		{
			self.ladyEnv.lady:Find(var_0_1.l_tip_bone_path[1]),
			self.ladyEnv.lady:Find(var_0_1.l_tip_bone_path[2])
		},
		{
			self.ladyEnv.lady:Find(var_0_1.r_tip_bone_path[1]),
			self.ladyEnv.lady:Find(var_0_1.r_tip_bone_path[2])
		}
	}
	self.triggerDic = {
		{},
		{},
		{},
		{}
	}

	local function var_22_0(arg_23_0, arg_23_1)
		local var_23_0 = {}
		local var_23_1 = {}

		for iter_23_0, iter_23_1 in ipairs(arg_23_1) do
			local var_23_2 = StockingTrigger.New(iter_23_1)

			if var_23_2:GetCompareType() == 0 then
				table.insert(var_23_0, var_23_2)
			else
				table.insert(var_23_1, var_23_2)
			end
		end

		StockingTrigger.Sort(var_23_0)
		StockingTrigger.Sort(var_23_1)

		self.triggerDic[arg_23_0 * 2 - 1] = var_23_0
		self.triggerDic[arg_23_0 * 2] = var_23_1

		return
	end

	for iter_22_0, iter_22_1 in ipairs({
		var_0_1.l_trigger,
		var_0_1.r_trigger
	}) do
		var_22_0(iter_22_0, iter_22_1)
	end

	self.inited = true

	return
end

function Dorm3dStockingMgr:InitHideMode()
	self.useHideMode = var_0_1.scene_stocking_path ~= "" and #var_0_1.scene_stocking_path == 2
	self.isShow = {
		isActive(self.stockingL),
		isActive(self.stockingR)
	}

	if self.useHideMode then
		self.sceneStockingTFs = {
			self:GetSceneItem(var_0_1.scene_stocking_path[1]),
			self:GetSceneItem(var_0_1.scene_stocking_path[2])
		}

		local function var_24_0(arg_25_0, arg_25_1)
			GetOrAddComponent(arg_25_1, typeof(EventTriggerListener)):AddPointClickFunc(function(arg_26_0, arg_26_1)
				self.isShow[arg_25_0] = true

				setActive(self.stockingTFs[arg_25_0], true)
				setActive(self.sceneStockingTFs[arg_25_0], false)
				GraphicsInterface.Instance:SetStockingPos(self.stockingTFs[arg_25_0].gameObject, var_0_1.wear_initial_pos[arg_25_0])

				return
			end)

			return
		end

		for iter_24_0, iter_24_1 in ipairs(self.sceneStockingTFs) do
			var_24_0(iter_24_0, iter_24_1)
			setActive(iter_24_1, not self.isShow[iter_24_0])
		end
	end

	return
end

function Dorm3dStockingMgr:ResetLady()
	local var_27_0 = self:Get("furnitures"):Find(var_0_1.character_position)

	assert(var_27_0, "找不到角色位置点 " .. var_0_1.character_position)

	local var_27_1 = var_27_0:Find("StayPoint")

	self.ladyEnv:SetPosition(var_27_1.position)
	self.ladyEnv:SetRotation(var_27_1.rotation)
	self.ladyEnv:PlaySingleAction(var_0_1.character_action)

	return
end

function Dorm3dStockingMgr:SetStockingStatus(arg_28_1)
	self:InitStatus(arg_28_1)
	self:InitHideMode()
	warning(">>>>>>>>>>> enter stocking mode <<<<<<<<<<", arg_28_1)
	seriesAsync({
		function(arg_29_0)
			self:Emit(RoomIKSystem.SET_IK_STATE, false, arg_29_0, {
				ignoreResetExtraItem = true
			})

			return
		end,
		function(arg_30_0)
			self:Func("SetUI", arg_30_0, "stocking")

			return
		end,
		function(arg_31_0)
			self:ResetLady()
			self:Func("ActiveCameraByName", var_0_1.camera)

			local var_31_0 = self:Get("cameraRoot"):Find(var_0_1.camera):GetComponent(typeof(Cinemachine.CinemachineFreeLook))

			if var_31_0 then
				self:Func("RegisterOrbits", var_31_0)
			end

			self:Func("PlayEnterSceneAnim", var_0_1.enter_scene_anim)
			self:Func("PlayEnterExtraItem", self.ladyEnv, var_0_1.enter_extra_item)
			self:Func("HideSceneItem", self.ladyEnv, var_0_1.hide_scene_item)
			setActive(self.ladyEnv.ladyCollider, false)
			_.each(self.ladyEnv.ladyTouchColliders, function(arg_32_0)
				setActive(arg_32_0, true)

				return
			end)
			arg_31_0()

			return
		end
	})

	return
end

function Dorm3dStockingMgr:ExitStockingStatus()
	seriesAsync({
		function(arg_34_0)
			self:Func("SetUI", arg_34_0, "back")

			return
		end,
		function(arg_35_0)
			warning(">>>>>>>>>>> exit stocking mode <<<<<<<<<<")

			if self.useHideMode then
				for iter_35_0, iter_35_1 in ipairs(self.sceneStockingTFs) do
					GetOrAddComponent(iter_35_1, typeof(EventTriggerListener)):RemovePointClickFunc()
				end
			end

			setActive(self.ladyEnv.ladyCollider, true)
			_.each(self.ladyEnv.ladyTouchColliders, function(arg_36_0)
				setActive(arg_36_0, false)

				return
			end)
			self:Func("ResetSceneItemAnimators")
			self:Func("ResetTempHideSceneItems", self.ladyEnv)
			self:Func("RevertCameraOrbit")
			self:Emit(RoomIKSystem.SET_IK_CONFIG, self.ladyEnv, self.cacheIkStatus)
			self:Emit(RoomIKSystem.SET_IK_STATE, true)
			arg_35_0()

			return
		end
	})

	return
end

function Dorm3dStockingMgr:OnExitTouchMode()
	if self.inited then
		self.inited = false
	end

	return
end

function Dorm3dStockingMgr:GetTipShowInfo(arg_38_1)
	local var_38_0 = {}

	for iter_38_0, iter_38_1 in ipairs(var_0_1.enable_drag) do
		if iter_38_1 == 1 then
			table.insert(var_38_0, {
				pos = self:Func("GetScreenPosition", self.tiptransforms[iter_38_0].position, self.mainCamera),
				dir = self:Func("GetScreenPosition", self.tipDirections[iter_38_0][2].position, self.mainCamera) - self:Func("GetScreenPosition", self.tipDirections[iter_38_0][1].position, self.mainCamera)
			})
		end
	end

	local var_38_1 = {}

	if self.useHideMode then
		for iter_38_2, iter_38_3 in ipairs(self.sceneStockingTFs) do
			if not self.isShow[iter_38_2] then
				table.insert(var_38_1, {
					pos = self:Func("GetScreenPosition", iter_38_3.position, self.mainCamera)
				})
			end
		end
	end

	if arg_38_1 then
		table.insert(arg_38_1, var_38_0)
		table.insert(arg_38_1, var_38_1)
	end

	return var_38_0, var_38_1
end

function Dorm3dStockingMgr:GetStockingGeo(arg_39_1)
	if pg.dorm3d_resource[arg_39_1].stocking_geo_path == "" then
		return nil, nil
	end

	return self:Find(pg.dorm3d_resource[arg_39_1].stocking_geo_path[1]), (self:Find(pg.dorm3d_resource[arg_39_1].stocking_geo_path[2]))
end

function Dorm3dStockingMgr:InitDormStocking(arg_40_1, arg_40_2)
	local var_40_0, var_40_1 = self:IsUnlockStocking(arg_40_2)

	if not var_40_0 then
		return
	end

	local var_40_2 = pg.dorm3d_resource[arg_40_2].stocking_pos
	local var_40_3, var_40_4 = Dorm3dStockingMgr.GetStockingGeo(arg_40_1, arg_40_2)

	if var_40_1 then
		setActive(var_40_3, true)
		setActive(var_40_4, true)
		GraphicsInterface.Instance:SetStockingPos(var_40_3.gameObject, var_40_2[1])
		GraphicsInterface.Instance:SetStockingPos(var_40_4.gameObject, var_40_2[2])
	else
		setActive(var_40_3, false)
		setActive(var_40_4, false)

		local var_40_5 = arg_40_1:Find("all/body_geo"):GetComponent(typeof(SkinnedMeshRenderer))

		var_40_5:SetBlendShapeWeight(0, 0)
		var_40_5:SetBlendShapeWeight(1, 0)
	end

	return
end

function Dorm3dStockingMgr:IsUnlockStocking(arg_41_1)
	if not Dorm3dStockingMgr.UNLOCK_CONFIG[arg_41_1] then
		return false, false
	end

	local var_41_1 = self:GetRoom():IsFurnitureSetIn(Dorm3dStockingMgr.UNLOCK_CONFIG[arg_41_1])
end

return Dorm3dStockingMgr
