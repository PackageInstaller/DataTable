local RoomIKSystem = class("RoomIKSystem", import("view.dorm3d.Extra.BaseExtraSystem"))

RoomIKSystem.SET_IK_CONFIG = "RoomIKSystem.SET_IK_CONFIG"
RoomIKSystem.SET_IK_STATE = "RoomIKSystem.SET_IK_STATE"
RoomIKSystem.ON_BEGIN_DRAG_CHARACTER_BODY = "RoomIKSystem.ON_BEGIN_DRAG_CHARACTER_BODY"
RoomIKSystem.ON_DRAG_CHARACTER_BODY = "RoomIKSystem.ON_DRAG_CHARACTER_BODY"
RoomIKSystem.ON_RELEASE_CHARACTER_BODY = "RoomIKSystem.ON_RELEASE_CHARACTER_BODY"
RoomIKSystem.ON_IK_STATUS_CHANGED = "RoomIKSystem.ON_IK_STATUS_CHANGED"
RoomIKSystem.ON_IK_LAYER_ACTION = "RoomIKSystem.ON_IK_LAYER_ACTION"
RoomIKSystem.SET_IK_TIMELINE_STATUS = "RoomIKSystem.SET_IK_TIMELINE_STATUS"
RoomIKSystem.EXIT_IK_TIMELINE_STATUS = "RoomIKSystem.EXIT_IK_TIMELINE_STATUS"
RoomIKSystem.CYCLE_IK_CAMERA_GROUP = "RoomIKSystem.CYCLE_IK_CAMERA_GROUP"
RoomIKSystem.SET_IK_SPECIAL_CALL = "RoomIKSystem.SET_IK_SPECIAL_CALL"
RoomIKSystem.CONSUME_IK_SPECIAL_CALL = "RoomIKSystem.CONSUME_IK_SPECIAL_CALL"
RoomIKSystem.GET_IK_BLOCK = "RoomIKSystem.GET_IK_BLOCK"
RoomIKSystem.SET_IK_BLOCK = "RoomIKSystem.SET_IK_BLOCK"
RoomIKSystem.RESET_IK_TIP_TIMER = "RoomIKSystem.RESET_IK_TIP_TIMER"
RoomIKSystem.SET_IK_SWITCH_SKIN_ID = "RoomIKSystem.SET_IK_SWITCH_SKIN_ID"
RoomIKSystem.SWITCH_IK_SKIN = "RoomIKSystem.SWITCH_IK_SKIN"
RoomIKSystem.IK_STATUS_DELTA = 0.5
RoomIKSystem.IK_TIP_WAIT_TIME = 5
RoomIKSystem.IK_STATUS = {
	RELEASE = 3,
	BEGIN = 1,
	TRIGGER = 4,
	DRAG = 2
}

function RoomIKSystem:OnInit()
	self:RegisterIKFunc()

	return
end

function RoomIKSystem:RegisterEvents()
	self:Bind(RoomIKSystem.SET_IK_CONFIG, function(arg_3_0, arg_3_1, arg_3_2)
		self:SwitchIKConfig(arg_3_1, arg_3_2)

		return
	end)
	self:Bind(RoomIKSystem.SET_IK_STATE, function(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		self:SetIKState(arg_4_1, arg_4_2, arg_4_3)

		return
	end)
	self:Bind(RoomIKSystem.ON_BEGIN_DRAG_CHARACTER_BODY, function(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
		self:OnBeginDragCharacterBody(arg_5_1, arg_5_2, arg_5_3)

		return
	end)
	self:Bind(RoomIKSystem.ON_DRAG_CHARACTER_BODY, function(arg_6_0, arg_6_1, arg_6_2)
		self:OnDragCharacterBody(arg_6_1, arg_6_2)

		return
	end)
	self:Bind(RoomIKSystem.ON_RELEASE_CHARACTER_BODY, function(arg_7_0, arg_7_1)
		self:OnReleaseCharacterBody(arg_7_1)

		return
	end)
	self:Bind(RoomIKSystem.SET_IK_TIMELINE_STATUS, function(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
		self:SetIKTimelineStatus(arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)

		return
	end)
	self:Bind(RoomIKSystem.EXIT_IK_TIMELINE_STATUS, function(arg_9_0, arg_9_1, arg_9_2)
		self:ExitIKTimelineStatus(arg_9_1, arg_9_2)

		return
	end)
	self:Bind(RoomIKSystem.CYCLE_IK_CAMERA_GROUP, function()
		self:CycleIKCameraGroup()

		return
	end)
	self:Bind(RoomIKSystem.SET_IK_SPECIAL_CALL, function(arg_11_0, arg_11_1)
		self.ikSpecialCall = arg_11_1

		return
	end)
	self:Bind(RoomIKSystem.CONSUME_IK_SPECIAL_CALL, function(arg_12_0, arg_12_1)
		if arg_12_1 then
			arg_12_1.consumed = self:ConsumeIKSpecialCall()
		end

		return
	end)
	self:Bind(RoomIKSystem.GET_IK_BLOCK, function(arg_13_0, arg_13_1)
		if arg_13_1 then
			arg_13_1.blockIK = self.blockIK
		end

		return
	end)
	self:Bind(RoomIKSystem.SET_IK_BLOCK, function(arg_14_0, arg_14_1)
		self.blockIK = arg_14_1

		return
	end)
	self:Bind(RoomIKSystem.RESET_IK_TIP_TIMER, function()
		self:ResetIKTipTimer()

		return
	end)
	self:Bind(RoomIKSystem.SET_IK_SWITCH_SKIN_ID, function(arg_16_0, arg_16_1)
		self:SetIKSwitchSkinId(arg_16_1)

		return
	end)
	self:Bind(RoomIKSystem.SWITCH_IK_SKIN, function(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
		self:SwitchIKSkin(arg_17_1, arg_17_2, arg_17_3)

		return
	end)

	return
end

function RoomIKSystem:OnUpdate()
	self:UpdateIKTarget()

	return
end

function RoomIKSystem:OnDispose()
	pg.IKMgr.GetInstance():ReleaseDrag()
	pg.IKMgr.GetInstance():UnregisterEnv()

	return
end

function RoomIKSystem:SwitchIKConfig(arg_20_1, arg_20_2)
	warning("switchIkstatus", arg_20_2)

	local var_20_0 = pg.dorm3d_ik_status[arg_20_2]

	local function var_20_1()
		if var_20_0.skin_id ~= arg_20_1.skinId then
			local var_21_0 = _.detect(pg.dorm3d_ik_status.get_id_list_by_base[var_20_0.base], function(arg_22_0)
				return pg.dorm3d_ik_status[arg_22_0].skin_id == arg_20_1.skinId
			end)

			assert(var_21_0, string.format("Missing Status Config By Skin: %s original Status: %s", arg_20_1.skinId, arg_20_2))

			var_20_0 = pg.dorm3d_ik_status[var_21_0]
		end

		return
	end

	if type(pg.dorm3d_ik_status[arg_20_2].skin_id) == "table" then
		if not table.contains(var_20_0.skin_id, arg_20_1.skinId) then
			var_20_1()
		end
	else
		var_20_1()
	end

	arg_20_1.ikConfig = var_20_0

	return
end

function RoomIKSystem:SetIKState(arg_23_1, arg_23_2, arg_23_3)
	arg_23_3 = arg_23_3 or {}

	local var_23_0 = self:GetCurrentLadyEnv()
	local var_23_1 = {}

	if arg_23_1 then
		table.insert(var_23_1, function(arg_24_0)
			self:Func("SetBlackboardValue", var_23_0, "inIK", true)
			self:Emit(Dorm3dRoomTemplateScene.SHOW_BLOCK)
			self:Emit(Dorm3dIKView.SET_CAMERA_BUTTON_ACTIVE, #pg.dorm3d_ik_status.get_id_list_by_camera_group[var_23_0.ikConfig.camera_group] > 1)
			self:Emit(Dorm3dIKView.SET_CONTROL_ACTIVE, true)
			arg_24_0()

			return
		end)

		if self:Get("uiState") ~= "ik" then
			table.insert(var_23_1, function(arg_25_0)
				self:Func("SetUI", arg_25_0, "ik")

				return
			end)
		end

		table.insert(var_23_1, function(arg_26_0)
			Shader.SetGlobalFloat("_ScreenClipOff", 0)
			self:SetIKStatus(var_23_0, var_23_0.ikConfig, arg_26_0, arg_23_3)

			return
		end)
		table.insert(var_23_1, function(arg_27_0)
			self:Emit(Dorm3dRoomTemplateScene.HIDE_BLOCK)
			arg_27_0()

			return
		end)
	else
		assert(self:Get("uiState") == "ik")
		table.insert(var_23_1, function(arg_28_0)
			self:Emit(Dorm3dIKView.SET_CONTROL_ACTIVE, false)
			self:Emit(Dorm3dRoomTemplateScene.SHOW_BLOCK)
			Shader.SetGlobalFloat("_ScreenClipOff", 1)
			arg_28_0()

			return
		end)
		table.insert(var_23_1, function(arg_29_0)
			self:ExitIKStatus(var_23_0, var_23_0.ikConfig, arg_29_0, arg_23_3)
			self:Func("ResetSceneItemAnimators")

			return
		end)
		table.insert(var_23_1, function(arg_30_0)
			self:Func("SetUI", arg_30_0, "back")

			return
		end)
		table.insert(var_23_1, function(arg_31_0)
			self:Func("SetBlackboardValue", var_23_0, "inIK", false)
			self:Emit(Dorm3dRoomTemplateScene.HIDE_BLOCK)
			arg_31_0()

			return
		end)
	end

	seriesAsync(var_23_1, arg_23_2)

	return
end

function RoomIKSystem:OnBeginDragCharacterBody(arg_32_1, arg_32_2, arg_32_3)
	if self.blockIK then
		return
	end

	if arg_32_1.ikHandler then
		return
	end

	pg.IKMgr.GetInstance():OnDragBegin(arg_32_2, arg_32_3)

	return
end

function RoomIKSystem:OnDragCharacterBody(arg_33_1, arg_33_2)
	if not arg_33_1.ikHandler then
		return
	end

	pg.IKMgr.GetInstance():HandleBodyDrag(arg_33_2)

	return
end

function RoomIKSystem:OnReleaseCharacterBody(arg_34_1)
	pg.IKMgr.GetInstance():ReleaseDrag()

	return
end

function RoomIKSystem:RegisterIKFunc()
	pg.IKMgr.GetInstance():RegisterOnIKLayerActive(function(arg_36_0)
		self.blockIK = true

		local var_36_0 = self:GetCurrentLadyEnv()

		var_36_0.ikHandler = arg_36_0

		local var_36_1 = _.detect(var_36_0.readyIKLayers, function(arg_37_0)
			return arg_37_0:GetControllerPath() == arg_36_0.ikData:GetControllerPath()
		end)

		self:EnableIKLayer(var_36_1)

		self.ikNextCheckStamp = Time.time + RoomIKSystem.IK_STATUS_DELTA

		self:Emit(RoomIKSystem.ON_IK_STATUS_CHANGED, var_36_1:GetConfigID(), RoomIKSystem.IK_STATUS.BEGIN)

		return
	end)
	pg.IKMgr.GetInstance():RegisterOnIKLayerDrag(function(arg_38_0)
		self:GetCurrentLadyEnv().ikHandler = arg_38_0

		self:ResetIKTipTimer()

		return
	end)
	pg.IKMgr.GetInstance():RegisterOnIKLayerDeactive(function(arg_39_0, arg_39_1)
		local var_39_0 = self:GetCurrentLadyEnv()
		local var_39_1 = _.detect(var_39_0.readyIKLayers, function(arg_40_0)
			return arg_40_0:GetControllerPath() == arg_39_0.ikData:GetControllerPath()
		end)

		self:DeactiveIKLayer(var_39_1)

		var_39_0.ikHandler = nil
		self.blockIK = arg_39_1

		self:Emit(RoomIKSystem.ON_IK_STATUS_CHANGED, var_39_1:GetConfigID(), RoomIKSystem.IK_STATUS.RELEASE)

		return
	end)
	pg.IKMgr.GetInstance():RegisterOnIKLayerAction(function(arg_41_0)
		self.blockIK = nil

		local var_41_0 = _.detect(self:GetCurrentLadyEnv().readyIKLayers, function(arg_42_0)
			return arg_42_0:GetControllerPath() == arg_41_0.ikData:GetControllerPath()
		end)

		self:OnTriggerIK(var_41_0)
		self:Emit(RoomIKSystem.ON_IK_STATUS_CHANGED, var_41_0:GetConfigID(), RoomIKSystem.IK_STATUS.TRIGGER)

		return
	end)

	return
end

function RoomIKSystem:SetIKStatus(arg_43_1, arg_43_2, arg_43_3, arg_43_4)
	warning("Set IKStatus " .. (arg_43_2.id or "NIL"))

	self.enableIKTip = true

	self:ResetIKTipTimer()
	setActive(arg_43_1.ladyCollider, false)
	_.each(arg_43_1.ladyTouchColliders, function(arg_44_0)
		setActive(arg_44_0, true)

		return
	end)

	self.blockIK = nil

	self:Emit(RoomTouchSystem.CANCEL_TOUCH_PRESS)

	arg_43_1.currentIkStatus = arg_43_2.id
	arg_43_1.ikActionDict = {}
	arg_43_1.readyIKLayers = {}
	arg_43_1.iKTouchDatas = arg_43_2.touch_data

	self:Emit(RoomTouchSystem.VALIDATE_TOUCH_CONFIGS, arg_43_1.iKTouchDatas, arg_43_2.id)

	arg_43_1.IKSettings = {
		Colliders = arg_43_1.ladyColliders,
		CameraRaycaster = self:Get("sceneRaycaster")
	}

	local var_43_1 = table.shallowCopy(arg_43_2.ik_id)
	local var_43_2 = {}

	_.each(arg_43_1.iKTouchDatas, function(arg_45_0)
		if arg_45_0[3][1] == 7 then
			local var_45_0 = pg.dorm3d_ik_touch_move[arg_45_0[3][2]].target_ik

			if not _.detect(var_43_1, function(arg_46_0)
				return arg_46_0[1] == var_45_0
			end) then
				var_43_2[pg.dorm3d_ik_touch_move[arg_45_0[3][2]].target_ik] = {
					back_time = pg.dorm3d_ik_touch_move[arg_45_0[3][2]].back_time
				}

				local var_45_1 = {
					pg.dorm3d_ik_touch_move[arg_45_0[3][2]].target_ik,
					0,
					{}
				}

				if pg.dorm3d_ik_touch_move[arg_45_0[3][2]].trigger_dialogue > 0 then
					var_45_1[3] = {
						4,
						0,
						pg.dorm3d_ik_touch_move[arg_45_0[3][2]].trigger_dialogue
					}
				end

				table.insert(var_43_1, var_45_1)
			end
		end

		return
	end)
	pg.IKMgr.GetInstance():RegisterEnv(arg_43_1.ladyIKRoot, arg_43_1.ladyBoneMaps)
	self:RegisterIKFunc()
	pg.IKMgr.GetInstance():SetIKStatus((_.map(var_43_1, function(arg_47_0)
		local var_47_0 = Dorm3dIK.New({
			configId = arg_47_0[1]
		})
		local var_47_1 = switch(arg_47_0[3][1], {
			function(arg_48_0, arg_48_1)
				return 0
			end,
			function()
				return 0
			end,
			function(arg_50_0, arg_50_1)
				return arg_50_0
			end,
			function(arg_51_0, arg_51_1)
				return arg_51_0
			end,
			function(arg_52_0, arg_52_1, arg_52_2, arg_52_3)
				return arg_52_0
			end,
			function(arg_53_0)
				return 0
			end
		}, function(arg_54_0)
			return type(arg_54_0) == "number" and arg_54_0 or 0
		end, unpack(arg_47_0[3], 2))

		table.insert(arg_43_1.readyIKLayers, var_47_0)

		arg_43_1.ikActionDict[var_47_0:GetControllerPath()] = arg_47_0[3]

		local var_47_2 = var_47_0:GetRevertTime()
		local var_47_3 = var_43_2[var_47_0:GetConfigID()]
		local var_47_4 = tobool(var_47_3)

		if var_47_4 then
			var_47_1 = var_47_3.back_time
			var_47_2 = var_47_3.back_time
			var_47_0.ignoreDrag = true
		end

		local var_47_5 = var_47_0:GetSubTargets()
		local var_47_6 = var_47_0:GetPlaneRotations()
		local var_47_7 = var_47_0:GetPlaneScales()

		return Dorm3dIKController.New({
			triggerName = var_47_0:getConfig("trigger_param")[2],
			controllerName = var_47_0:GetControllerPath(),
			subTargets = _.map(_.range(#var_47_5), function(arg_55_0)
				return {
					name = var_47_5[arg_55_0][1],
					planeRot = var_47_6[arg_55_0],
					planeScale = var_47_7[arg_55_0]
				}
			end),
			actionType = var_47_0:GetActionTriggerParams()[1],
			controlRect = var_47_0:GetRect(),
			actionRect = var_47_0:GetTriggerRect(),
			backTime = var_47_2,
			actionRevertTime = var_47_1,
			ignoreDrag = var_47_4
		})
	end)))

	local var_43_3 = {}

	_.each(arg_43_1.iKTouchDatas, function(arg_56_0)
		if #pg.dorm3d_ik_touch[arg_56_0[1]].scene_item == 0 then
			return
		end

		if var_43_3[pg.dorm3d_ik_touch[arg_56_0[1]].scene_item] then
			return
		end

		var_43_3[pg.dorm3d_ik_touch[arg_56_0[1]].scene_item] = true

		local var_56_0 = self:GetSceneItem(pg.dorm3d_ik_touch[arg_56_0[1]].scene_item)

		if not var_56_0 then
			warning(string.format("dorm3d_ik_touch:%d without scene_item:%s", arg_56_0[1], pg.dorm3d_ik_touch[arg_56_0[1]].scene_item))

			return
		end

		if IsNil(GetComponent(var_56_0, typeof(UnityEngine.Collider))) then
			go(var_56_0):AddComponent(typeof(UnityEngine.BoxCollider))
		end

		return
	end)

	self:Get("camBrain").enabled = false

	if self:Get("cameras")[Dorm3dRoomTemplateScene.CAMERA.IK_WATCH] then
		setActive(self:Get("cameras")[Dorm3dRoomTemplateScene.CAMERA.IK_WATCH], false)

		self:Get("cameras")[Dorm3dRoomTemplateScene.CAMERA.IK_WATCH] = nil
	end

	local var_43_4 = self:Get("cameraRoot"):Find(arg_43_2.ik_camera)

	assert(var_43_4, "Missing IKCamera")

	self:Get("cameras")[Dorm3dRoomTemplateScene.CAMERA.IK_WATCH] = var_43_4

	self:Func("ActiveCamera", self:Get("cameras")[Dorm3dRoomTemplateScene.CAMERA.IK_WATCH])

	self:Get("camBrain").enabled = true

	local var_43_5 = var_43_4:GetComponent(typeof(Cinemachine.CinemachineFreeLook))

	if var_43_5 then
		self:Func("RegisterOrbits", var_43_5)
	else
		self:Func("RevertCameraOrbit")
	end

	self:Func("SwitchAnim", arg_43_1, arg_43_2.character_action)
	self:SettingHeadAimIK(arg_43_1, arg_43_2.head_track)
	arg_43_1:EnableCloth(false)
	arg_43_1:EnableCloth(arg_43_2.use_cloth, arg_43_2.cloth_colliders)
	self:Func("PlayEnterSceneAnim", arg_43_2.enter_scene_anim)
	self:Func("PlayEnterExtraItem", arg_43_1, arg_43_2.enter_extra_item)
	self:Func("HideSceneItem", arg_43_1, arg_43_2.hide_scene_item)
	self:Emit(Dorm3dIKView.UPDATE_TEXT_TIPS, arg_43_1.readyIKLayers)
	onNextTick(function()
		local var_57_0 = self:Get("furnitures"):Find(arg_43_2.character_position)

		arg_43_1.lady.position = var_57_0:Find("StayPoint").position
		arg_43_1.lady.rotation = var_57_0:Find("StayPoint").rotation

		existCall(arg_43_3)

		return
	end)

	return
end

function RoomIKSystem:ExitIKStatus(arg_58_1, arg_58_2, arg_58_3, arg_58_4)
	self.enableIKTip = false

	if self.ikSwitchSkinId then
		arg_58_1:SwitchCharacterSkin(self:Get("apartment"):GetConfigID(), self.ikSwitchSkinId)

		self.ikSwitchSkinId = nil
	end

	setActive(arg_58_1.ladyCollider, true)
	_.each(arg_58_1.ladyTouchColliders, function(arg_59_0)
		setActive(arg_59_0, false)

		return
	end)

	self.blockIK = nil

	pg.IKMgr.GetInstance():UnregisterEnv()

	arg_58_1.ikHandler = nil

	self:Emit(Dorm3dIKView.SET_TIPS_ACTIVE, false)
	self:Emit(RoomTouchSystem.CANCEL_TOUCH_PRESS)

	arg_58_1.currentIkStatus = nil
	arg_58_1.ikActionDict = nil
	arg_58_1.readyIKLayers = nil
	arg_58_1.iKTouchDatas = nil

	self:Func("RevertCameraOrbit")
	setActive(self:Get("cameras")[Dorm3dRoomTemplateScene.CAMERA.IK_WATCH], false)

	self:Get("cameras")[Dorm3dRoomTemplateScene.CAMERA.IK_WATCH] = nil

	arg_58_1:EnableCloth(false)
	self:ResetHeadAimIK(arg_58_1)
	self:Func("SwitchAnim", arg_58_1, arg_58_2.character_action)
	self:Func("ResetSceneItemAnimators")

	if not arg_58_4.ignoreResetExtraItem then
		self:Func("ResetCharacterExtraItem", arg_58_1)
		self:Func("ResetTempHideSceneItems", arg_58_1)
	end

	onNextTick(function()
		arg_58_1.ladyActiveZone = arg_58_2.character_position and arg_58_2.character_position or arg_58_1.ladyBaseZone

		self:Func("ChangeCharacterPosition", arg_58_1)
		self:Func("TriggerLadyDistance")
		self:Func("CheckInSector")
		existCall(arg_58_3)

		return
	end)

	return
end

function RoomIKSystem:SetIKTimelineStatus(arg_61_1, arg_61_2, arg_61_3, arg_61_4, arg_61_5)
	warning("Set IKStatus " .. (arg_61_3 or "NIL"))
	arg_61_1:SetCurrentIkTimelineStatus(arg_61_3)

	self.enableIKTip = true

	self:Emit(Dorm3dIKView.SET_CONTROL_ACTIVE, true)
	self:ResetIKTipTimer()

	self.blockIK = nil
	arg_61_1.readyIKLayers = {}
	arg_61_1.iKTouchDatas = {}
	arg_61_1.IKSettings = {
		CameraRaycaster = GetOrAddComponent(arg_61_4, typeof(UnityEngine.EventSystems.PhysicsRaycaster))
	}

	assert(arg_61_1.IKSettings.CameraRaycaster)

	local var_61_0 = {}

	table.IpairsCArray(arg_61_2:GetComponentsInChildren(typeof(UnityEngine.Collider), true), function(arg_62_0, arg_62_1)
		if arg_62_1.name == "SafeCollider" then
			setActive(arg_62_1, false)

			return
		end

		if arg_62_1:GetType():Equals(typeof(UnityEngine.MeshCollider)) then
			return
		end

		local var_62_0 = tf(arg_62_1)
		local var_62_1 = var_62_0.name
		local var_62_2 = var_62_0.name and string.find(var_62_1, "Collider") or -1

		if var_62_2 <= 0 then
			errorMsg("Wrong Name to lady Collider : " .. var_62_1)

			return
		end

		local var_62_3 = string.sub(var_62_1, 1, var_62_2 - 1)

		if var_62_3 == "Body" or var_62_3 == "Safe" then
			setActive(var_62_0, false)

			return
		end

		if DormConst.BONE_TO_TOUCH[var_62_3] == nil then
			return
		end

		var_61_0[var_62_3] = var_62_0

		setActive(var_62_0, true)

		return
	end)

	arg_61_1.IKSettings.Colliders = var_61_0
	arg_61_1.ikTimelineMode = true

	local var_61_1 = {}
	local var_61_2 = {}

	table.Foreach(DormConst.boneMap, function(arg_65_0, arg_65_1)
		var_61_2[arg_65_1] = arg_65_0

		return
	end)
	table.IpairsCArray(arg_61_2.transform:GetComponentsInChildren(typeof(Transform), true), function(arg_66_0, arg_66_1)
		if var_61_2[arg_66_1.name] then
			var_61_1[var_61_2[arg_66_1.name]] = arg_66_1
		end

		return
	end)
	pg.IKMgr.GetInstance():RegisterEnv(arg_61_2.transform:Find("IKLayers"), var_61_1)
	self:RegisterIKFunc()
	pg.IKMgr.GetInstance():SetIKStatus((_.map(pg.dorm3d_ik_timeline_status[arg_61_3].ik_id, function(arg_63_0)
		local var_63_0 = Dorm3dIK.New({
			configId = arg_63_0
		})

		table.insert(arg_61_1.readyIKLayers, var_63_0)

		local var_63_1 = var_63_0:GetSubTargets()
		local var_63_2 = var_63_0:GetPlaneRotations()
		local var_63_3 = var_63_0:GetPlaneScales()

		return Dorm3dIKController.New({
			ignoreDrag = false,
			triggerName = var_63_0:getConfig("trigger_param")[2],
			controllerName = var_63_0:GetControllerPath(),
			subTargets = _.map(_.range(#var_63_1), function(arg_64_0)
				return {
					name = var_63_1[arg_64_0][1],
					planeRot = var_63_2[arg_64_0],
					planeScale = var_63_3[arg_64_0]
				}
			end),
			actionType = var_63_0:GetActionTriggerParams()[1],
			controlRect = var_63_0:GetRect(),
			actionRect = var_63_0:GetTriggerRect(),
			backTime = var_63_0:GetRevertTime(),
			actionRevertTime = var_63_0:GetActionRevertTime(),
			timelineActionEvent = var_63_0:GetTimelineAction()
		})
	end)))
	self:Emit(Dorm3dIKView.UPDATE_TEXT_TIPS, arg_61_1.readyIKLayers)
	existCall(arg_61_5)

	return
end

function RoomIKSystem:ExitIKTimelineStatus(arg_67_1, arg_67_2)
	arg_67_1:SetCurrentIkTimelineStatus(nil)

	self.enableIKTip = false

	self:Emit(Dorm3dIKView.SET_CONTROL_ACTIVE, false)

	self.blockIK = nil

	pg.IKMgr.GetInstance():UnregisterEnv()

	arg_67_1.ikHandler = nil
	arg_67_1.ikTimelineMode = nil
	arg_67_1.readyIKLayers = nil
	arg_67_1.iKTouchDatas = nil
	arg_67_1.IKSettings = nil

	self:Emit(Dorm3dIKView.SET_TIPS_ACTIVE, false)
	existCall(arg_67_2)

	return
end

function RoomIKSystem:EnableIKLayer(arg_68_1)
	local var_68_0 = self:GetCurrentLadyEnv()

	if #arg_68_1:GetHeadTrackPath() > 0 then
		self:SettingHeadAimIK(var_68_0, {
			2,
			arg_68_1:GetHeadTrackPath()
		}, true)
	end

	local var_68_1 = arg_68_1:GetTriggerFaceAnim()

	if #var_68_1 > 0 then
		self:Func("PlayFaceAnim", var_68_0, var_68_1)
	end

	if not arg_68_1.ignoreDrag then
		self:Emit(Dorm3dIKView.PLAY_HAND_BEGIN)
	end

	if not var_68_0.ikTimelineMode then
		pg.m02:sendNotification(GAME.APARTMENT_TRACK, Dorm3dTrackCommand.BuildDataTouch(self:Get("apartment").configId, self:Get("apartment").level, var_68_0.ikConfig.character_action, arg_68_1:GetTriggerParams()[2], self:GetRoom():GetConfigID()))
	end

	return
end

function RoomIKSystem:DeactiveIKLayer(arg_69_1)
	local var_69_0 = self:GetCurrentLadyEnv()

	if not var_69_0.ikTimelineMode and #arg_69_1:GetHeadTrackPath() > 0 then
		self:SettingHeadAimIK(var_69_0, var_69_0.ikConfig.head_track)
	end

	if not arg_69_1.ignoreDrag then
		self:Emit(Dorm3dIKView.PLAY_HAND_END)
	end

	return
end

function RoomIKSystem:ResetIKTipTimer()
	if not self.enableIKTip then
		return
	end

	self.nextTipIKTime = Time.time + RoomIKSystem.IK_TIP_WAIT_TIME

	return
end

function RoomIKSystem:EnableCurrentHeadIK(arg_71_1)
	self:EnableHeadIK(self:GetCurrentLadyEnv(), arg_71_1)

	return
end

function RoomIKSystem:EnableHeadIK(arg_72_1, arg_72_2)
	arg_72_1.ladyHeadIKComp.enableIk = arg_72_2

	return
end

function RoomIKSystem:SettingHeadAimIK(arg_73_1, arg_73_2, arg_73_3)
	local var_73_0

	if arg_73_2[1] == 0 then
		self:EnableHeadIK(arg_73_1, false)

		return
	elseif arg_73_2[1] == 1 then
		self:EnableHeadIK(arg_73_1, true)

		var_73_0 = self:Get("mainCameraTF"):Find("AimTarget")
	elseif arg_73_2[1] == 2 then
		self:EnableHeadIK(arg_73_1, true)
		table.IpairsCArray(arg_73_1.lady:GetComponentsInChildren(typeof(Transform), true), function(arg_74_0, arg_74_1)
			if arg_74_1.name ~= arg_73_2[2] then
				return
			end

			var_73_0 = arg_74_1

			return
		end)
	end

	arg_73_1.ladyHeadIKComp.AimTarget = var_73_0

	if not arg_73_3 and arg_73_2[3] then
		arg_73_1.ladyHeadIKComp.BodyWeight = arg_73_2[3]
	end

	if not arg_73_3 and arg_73_2[4] then
		arg_73_1.ladyHeadIKComp.HeadWeight = arg_73_2[4]
	end

	return
end

function RoomIKSystem:ResetHeadAimIK(arg_75_1)
	self:EnableHeadIK(arg_75_1, true)

	arg_75_1.ladyHeadIKComp.AimTarget = self:Get("mainCameraTF"):Find("AimTarget")
	arg_75_1.ladyHeadIKComp.HeadWeight = arg_75_1.ladyHeadIKData.HeadWeight
	arg_75_1.ladyHeadIKComp.BodyWeight = arg_75_1.ladyHeadIKData.BodyWeight

	return
end

function RoomIKSystem:OnTriggerIK(arg_76_1)
	local var_76_0 = self:GetCurrentLadyEnv()

	if var_76_0.ikTimelineMode then
		self:ExitIKTimelineStatus(var_76_0)

		local var_76_1 = arg_76_1:GetTimelineAction()

		if var_76_1 then
			self:Get("nowTimelinePlayer"):TriggerEvent(var_76_1)
		end

		return
	end

	if not var_76_0.ikConfig then
		return
	end

	local var_76_2 = var_76_0.ikActionDict[arg_76_1:GetControllerPath()]

	if not var_76_2 then
		return
	end

	self.blockIK = true

	self:Emit(RoomIKSystem.ON_IK_LAYER_ACTION, var_76_0, arg_76_1:GetConfigID(), var_76_2, function()
		self:ResetIKTipTimer()

		self.blockIK = nil

		return
	end)

	return
end

function RoomIKSystem:UpdateIKTarget()
	if not self:Get("apartment") then
		return
	end

	local var_78_0 = self:GetCurrentLadyEnv()

	if not var_78_0 then
		return
	end

	if var_78_0.ikHandler then
		local var_78_1

		if not var_78_0.readyIKLayers then
			do return end

			var_78_1 = pg.UIMgr.GetInstance().uiCamera:Find("Canvas").rect
		end

		self:Emit(Dorm3dIKView.SET_HAND_POSITION, var_78_0.ikHandler.screenPosition - Vector2.New(var_78_1.width, var_78_1.height) * 0.5)

		if Time.time > self.ikNextCheckStamp then
			self.ikNextCheckStamp = self.ikNextCheckStamp + RoomIKSystem.IK_STATUS_DELTA

			self:Emit(RoomIKSystem.ON_IK_STATUS_CHANGED, _.detect(var_78_0.readyIKLayers, function(arg_79_0)
				return arg_79_0:GetControllerPath() == var_78_0.ikHandler.ikData:GetControllerPath()
			end):GetConfigID(), RoomIKSystem.IK_STATUS.DRAG)
		end
	end

	if self.enableIKTip then
		if not var_78_0.readyIKLayers or not var_78_0.IKSettings then
			return
		end

		self:UpdateIKTips(var_78_0)
	end

	return
end

function RoomIKSystem:UpdateIKTips(arg_80_1)
	if not self.nextTipIKTime then
		return
	end

	self:Emit(Dorm3dIKView.UPDATE_TIPS, not self.blockIK and Time.time > self.nextTipIKTime, arg_80_1)

	return
end

function RoomIKSystem:CycleIKCameraGroup()
	local var_81_0 = self:GetCurrentLadyEnv()

	assert(self:Func("GetBlackboardValue", var_81_0, "inIK"))
	seriesAsync({
		function(arg_82_0)
			pg.IKMgr.GetInstance():ResetActiveIKs()
			self:SwitchIKConfig(var_81_0, pg.dorm3d_ik_status.get_id_list_by_camera_group[var_81_0.ikConfig.camera_group][table.indexof(pg.dorm3d_ik_status.get_id_list_by_camera_group[var_81_0.ikConfig.camera_group], var_81_0.ikConfig.id) % #pg.dorm3d_ik_status.get_id_list_by_camera_group[var_81_0.ikConfig.camera_group] + 1])
			self:SetIKState(true)

			return
		end
	})

	return
end

function RoomIKSystem:SetIKSwitchSkinId(arg_83_1)
	self.ikSwitchSkinId = arg_83_1

	return
end

function RoomIKSystem:SwitchIKSkin(arg_84_1, arg_84_2, arg_84_3)
	seriesAsync({
		function(arg_85_0)
			self:SetIKState(false, arg_85_0)

			return
		end,
		function(arg_86_0)
			arg_84_1:SwitchCharacterSkin(arg_84_2, arg_84_3)
			self:SwitchIKConfig(arg_84_1, arg_84_1.ikConfig.id)
			self:SetIKState(true, arg_86_0)

			return
		end
	})

	return
end

function RoomIKSystem:ConsumeIKSpecialCall()
	if not self.ikSpecialCall then
		return false
	end

	self.ikSpecialCall = nil

	existCall(self.ikSpecialCall)

	return true
end

return RoomIKSystem
