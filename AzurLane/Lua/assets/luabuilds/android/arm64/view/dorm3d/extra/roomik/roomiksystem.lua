local var_0_0 = class("RoomIKSystem", import("view.dorm3d.Extra.BaseExtraSystem"))

var_0_0.SET_IK_CONFIG = "RoomIKSystem.SET_IK_CONFIG"
var_0_0.SET_IK_STATE = "RoomIKSystem.SET_IK_STATE"
var_0_0.ON_BEGIN_DRAG_CHARACTER_BODY = "RoomIKSystem.ON_BEGIN_DRAG_CHARACTER_BODY"
var_0_0.ON_DRAG_CHARACTER_BODY = "RoomIKSystem.ON_DRAG_CHARACTER_BODY"
var_0_0.ON_RELEASE_CHARACTER_BODY = "RoomIKSystem.ON_RELEASE_CHARACTER_BODY"
var_0_0.ON_IK_STATUS_CHANGED = "RoomIKSystem.ON_IK_STATUS_CHANGED"
var_0_0.ON_IK_LAYER_ACTION = "RoomIKSystem.ON_IK_LAYER_ACTION"
var_0_0.SET_IK_TIMELINE_STATUS = "RoomIKSystem.SET_IK_TIMELINE_STATUS"
var_0_0.EXIT_IK_TIMELINE_STATUS = "RoomIKSystem.EXIT_IK_TIMELINE_STATUS"
var_0_0.CYCLE_IK_CAMERA_GROUP = "RoomIKSystem.CYCLE_IK_CAMERA_GROUP"
var_0_0.SET_IK_SPECIAL_CALL = "RoomIKSystem.SET_IK_SPECIAL_CALL"
var_0_0.CONSUME_IK_SPECIAL_CALL = "RoomIKSystem.CONSUME_IK_SPECIAL_CALL"
var_0_0.GET_IK_BLOCK = "RoomIKSystem.GET_IK_BLOCK"
var_0_0.SET_IK_BLOCK = "RoomIKSystem.SET_IK_BLOCK"
var_0_0.RESET_IK_TIP_TIMER = "RoomIKSystem.RESET_IK_TIP_TIMER"
var_0_0.SET_IK_SWITCH_SKIN_ID = "RoomIKSystem.SET_IK_SWITCH_SKIN_ID"
var_0_0.SWITCH_IK_SKIN = "RoomIKSystem.SWITCH_IK_SKIN"
var_0_0.IK_STATUS_DELTA = 0.5
var_0_0.IK_TIP_WAIT_TIME = 5
var_0_0.IK_STATUS = {
	RELEASE = 3,
	BEGIN = 1,
	TRIGGER = 4,
	DRAG = 2
}

function var_0_0.OnInit(arg_1_0)
	arg_1_0:RegisterIKFunc()

	return
end

function var_0_0.RegisterEvents(arg_2_0)
	arg_2_0:Bind(var_0_0.SET_IK_CONFIG, function(arg_3_0, arg_3_1, arg_3_2)
		arg_2_0:SwitchIKConfig(arg_3_1, arg_3_2)

		return
	end)
	arg_2_0:Bind(var_0_0.SET_IK_STATE, function(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		arg_2_0:SetIKState(arg_4_1, arg_4_2, arg_4_3)

		return
	end)
	arg_2_0:Bind(var_0_0.ON_BEGIN_DRAG_CHARACTER_BODY, function(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
		arg_2_0:OnBeginDragCharacterBody(arg_5_1, arg_5_2, arg_5_3)

		return
	end)
	arg_2_0:Bind(var_0_0.ON_DRAG_CHARACTER_BODY, function(arg_6_0, arg_6_1, arg_6_2)
		arg_2_0:OnDragCharacterBody(arg_6_1, arg_6_2)

		return
	end)
	arg_2_0:Bind(var_0_0.ON_RELEASE_CHARACTER_BODY, function(arg_7_0, arg_7_1)
		arg_2_0:OnReleaseCharacterBody(arg_7_1)

		return
	end)
	arg_2_0:Bind(var_0_0.SET_IK_TIMELINE_STATUS, function(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
		arg_2_0:SetIKTimelineStatus(arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)

		return
	end)
	arg_2_0:Bind(var_0_0.EXIT_IK_TIMELINE_STATUS, function(arg_9_0, arg_9_1, arg_9_2)
		arg_2_0:ExitIKTimelineStatus(arg_9_1, arg_9_2)

		return
	end)
	arg_2_0:Bind(var_0_0.CYCLE_IK_CAMERA_GROUP, function()
		arg_2_0:CycleIKCameraGroup()

		return
	end)
	arg_2_0:Bind(var_0_0.SET_IK_SPECIAL_CALL, function(arg_11_0, arg_11_1)
		arg_2_0.ikSpecialCall = arg_11_1

		return
	end)
	arg_2_0:Bind(var_0_0.CONSUME_IK_SPECIAL_CALL, function(arg_12_0, arg_12_1)
		if arg_12_1 then
			arg_12_1.consumed = arg_2_0:ConsumeIKSpecialCall()
		end

		return
	end)
	arg_2_0:Bind(var_0_0.GET_IK_BLOCK, function(arg_13_0, arg_13_1)
		if arg_13_1 then
			arg_13_1.blockIK = arg_2_0.blockIK
		end

		return
	end)
	arg_2_0:Bind(var_0_0.SET_IK_BLOCK, function(arg_14_0, arg_14_1)
		arg_2_0.blockIK = arg_14_1

		return
	end)
	arg_2_0:Bind(var_0_0.RESET_IK_TIP_TIMER, function()
		arg_2_0:ResetIKTipTimer()

		return
	end)
	arg_2_0:Bind(var_0_0.SET_IK_SWITCH_SKIN_ID, function(arg_16_0, arg_16_1)
		arg_2_0:SetIKSwitchSkinId(arg_16_1)

		return
	end)
	arg_2_0:Bind(var_0_0.SWITCH_IK_SKIN, function(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
		arg_2_0:SwitchIKSkin(arg_17_1, arg_17_2, arg_17_3)

		return
	end)

	return
end

function var_0_0.OnUpdate(arg_18_0)
	arg_18_0:UpdateIKTarget()

	return
end

function var_0_0.OnDispose(arg_19_0)
	pg.IKMgr.GetInstance():ReleaseDrag()
	pg.IKMgr.GetInstance():UnregisterEnv()

	return
end

function var_0_0.SwitchIKConfig(arg_20_0, arg_20_1, arg_20_2)
	warning("switchIkstatus", arg_20_2)

	local var_20_0 = pg.dorm3d_ik_status[arg_20_2]

	if type(pg.dorm3d_ik_status[arg_20_2].skin_id) == "table" then
		if not table.contains(var_20_0.skin_id, arg_20_1.skinId) then
			(function()
				if var_20_0.skin_id ~= arg_20_1.skinId then
					local var_21_0 = _.detect(pg.dorm3d_ik_status.get_id_list_by_base[var_20_0.base], function(arg_22_0)
						return pg.dorm3d_ik_status[arg_22_0].skin_id == arg_20_1.skinId
					end)

					assert(var_21_0, string.format("Missing Status Config By Skin: %s original Status: %s", arg_20_1.skinId, arg_20_2))

					var_20_0 = pg.dorm3d_ik_status[var_21_0]
				end

				return
			end)()
		end
	else
		(function()
			if var_20_0.skin_id ~= arg_20_1.skinId then
				local var_21_0 = _.detect(pg.dorm3d_ik_status.get_id_list_by_base[var_20_0.base], function(arg_22_0)
					return pg.dorm3d_ik_status[arg_22_0].skin_id == arg_20_1.skinId
				end)

				assert(var_21_0, string.format("Missing Status Config By Skin: %s original Status: %s", arg_20_1.skinId, arg_20_2))

				var_20_0 = pg.dorm3d_ik_status[var_21_0]
			end

			return
		end)()
	end

	arg_20_1.ikConfig = var_20_0

	return
end

function var_0_0.SetIKState(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	arg_23_3 = arg_23_3 or {}

	local var_23_0 = arg_23_0:GetCurrentLadyEnv()
	local var_23_1 = {}

	if arg_23_1 then
		table.insert(var_23_1, function(arg_24_0)
			arg_23_0:Func("SetBlackboardValue", var_23_0, "inIK", true)
			arg_23_0:Emit(Dorm3dRoomTemplateScene.SHOW_BLOCK)
			arg_23_0:Emit(Dorm3dIKView.SET_CAMERA_BUTTON_ACTIVE, #pg.dorm3d_ik_status.get_id_list_by_camera_group[var_23_0.ikConfig.camera_group] > 1)
			arg_23_0:Emit(Dorm3dIKView.SET_CONTROL_ACTIVE, true)
			arg_24_0()

			return
		end)

		if arg_23_0:Get("uiState") ~= "ik" then
			table.insert(var_23_1, function(arg_25_0)
				arg_23_0:Func("SetUI", arg_25_0, "ik")

				return
			end)
		end

		table.insert(var_23_1, function(arg_26_0)
			Shader.SetGlobalFloat("_ScreenClipOff", 0)
			arg_23_0:SetIKStatus(var_23_0, var_23_0.ikConfig, arg_26_0, arg_23_3)

			return
		end)
		table.insert(var_23_1, function(arg_27_0)
			arg_23_0:Emit(Dorm3dRoomTemplateScene.HIDE_BLOCK)
			arg_27_0()

			return
		end)
	else
		assert(arg_23_0:Get("uiState") == "ik")
		table.insert(var_23_1, function(arg_28_0)
			arg_23_0:Emit(Dorm3dIKView.SET_CONTROL_ACTIVE, false)
			arg_23_0:Emit(Dorm3dRoomTemplateScene.SHOW_BLOCK)
			Shader.SetGlobalFloat("_ScreenClipOff", 1)
			arg_28_0()

			return
		end)
		table.insert(var_23_1, function(arg_29_0)
			arg_23_0:ExitIKStatus(var_23_0, var_23_0.ikConfig, arg_29_0, arg_23_3)
			arg_23_0:Func("ResetSceneItemAnimators")

			return
		end)
		table.insert(var_23_1, function(arg_30_0)
			arg_23_0:Func("SetUI", arg_30_0, "back")

			return
		end)
		table.insert(var_23_1, function(arg_31_0)
			arg_23_0:Func("SetBlackboardValue", var_23_0, "inIK", false)
			arg_23_0:Emit(Dorm3dRoomTemplateScene.HIDE_BLOCK)
			arg_31_0()

			return
		end)
	end

	seriesAsync(var_23_1, arg_23_2)

	return
end

function var_0_0.OnBeginDragCharacterBody(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	if arg_32_0.blockIK then
		return
	end

	if arg_32_1.ikHandler then
		return
	end

	pg.IKMgr.GetInstance():OnDragBegin(arg_32_2, arg_32_3)

	return
end

function var_0_0.OnDragCharacterBody(arg_33_0, arg_33_1, arg_33_2)
	if not arg_33_1.ikHandler then
		return
	end

	pg.IKMgr.GetInstance():HandleBodyDrag(arg_33_2)

	return
end

function var_0_0.OnReleaseCharacterBody(arg_34_0, arg_34_1)
	pg.IKMgr.GetInstance():ReleaseDrag()

	return
end

function var_0_0.RegisterIKFunc(arg_35_0)
	pg.IKMgr.GetInstance():RegisterOnIKLayerActive(function(arg_36_0)
		arg_35_0.blockIK = true

		local var_36_0 = arg_35_0:GetCurrentLadyEnv()

		var_36_0.ikHandler = arg_36_0

		local var_36_1 = _.detect(var_36_0.readyIKLayers, function(arg_37_0)
			return arg_37_0:GetControllerPath() == arg_36_0.ikData:GetControllerPath()
		end)

		arg_35_0:EnableIKLayer(var_36_1)

		arg_35_0.ikNextCheckStamp = Time.time + var_0_0.IK_STATUS_DELTA

		arg_35_0:Emit(var_0_0.ON_IK_STATUS_CHANGED, var_36_1:GetConfigID(), var_0_0.IK_STATUS.BEGIN)

		return
	end)
	pg.IKMgr.GetInstance():RegisterOnIKLayerDrag(function(arg_38_0)
		arg_35_0:GetCurrentLadyEnv().ikHandler = arg_38_0

		arg_35_0:ResetIKTipTimer()

		return
	end)
	pg.IKMgr.GetInstance():RegisterOnIKLayerDeactive(function(arg_39_0, arg_39_1)
		local var_39_0 = arg_35_0:GetCurrentLadyEnv()
		local var_39_1 = _.detect(var_39_0.readyIKLayers, function(arg_40_0)
			return arg_40_0:GetControllerPath() == arg_39_0.ikData:GetControllerPath()
		end)

		arg_35_0:DeactiveIKLayer(var_39_1)

		var_39_0.ikHandler = nil
		arg_35_0.blockIK = arg_39_1

		arg_35_0:Emit(var_0_0.ON_IK_STATUS_CHANGED, var_39_1:GetConfigID(), var_0_0.IK_STATUS.RELEASE)

		return
	end)
	pg.IKMgr.GetInstance():RegisterOnIKLayerAction(function(arg_41_0)
		arg_35_0.blockIK = nil

		local var_41_0 = _.detect(arg_35_0:GetCurrentLadyEnv().readyIKLayers, function(arg_42_0)
			return arg_42_0:GetControllerPath() == arg_41_0.ikData:GetControllerPath()
		end)

		arg_35_0:OnTriggerIK(var_41_0)
		arg_35_0:Emit(var_0_0.ON_IK_STATUS_CHANGED, var_41_0:GetConfigID(), var_0_0.IK_STATUS.TRIGGER)

		return
	end)

	return
end

function var_0_0.SetIKStatus(arg_43_0, arg_43_1, arg_43_2, arg_43_3, arg_43_4)
	local var_43_0 = arg_43_2.id or "NIL"

	warning("Set IKStatus " .. var_43_0)

	arg_43_0.enableIKTip = true

	arg_43_0:ResetIKTipTimer()
	setActive(arg_43_1.ladyCollider, false)
	_.each(arg_43_1.ladyTouchColliders, function(arg_44_0)
		setActive(arg_44_0, true)

		return
	end)

	arg_43_0.blockIK = nil

	arg_43_0:Emit(RoomTouchSystem.CANCEL_TOUCH_PRESS)

	arg_43_1.currentIkStatus = arg_43_2.id
	arg_43_1.ikActionDict = {}
	arg_43_1.readyIKLayers = {}
	arg_43_1.iKTouchDatas = arg_43_2.touch_data

	arg_43_0:Emit(RoomTouchSystem.VALIDATE_TOUCH_CONFIGS, arg_43_1.iKTouchDatas, arg_43_2.id)

	arg_43_1.IKSettings = {
		Colliders = arg_43_1.ladyColliders,
		CameraRaycaster = arg_43_0:Get("sceneRaycaster")
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

				if pg.dorm3d_ik_touch_move[arg_45_0[3][2]].trigger_dialogue > 0 then
					({
						pg.dorm3d_ik_touch_move[arg_45_0[3][2]].target_ik,
						0,
						{}
					})[3] = {
						4,
						0,
						pg.dorm3d_ik_touch_move[arg_45_0[3][2]].trigger_dialogue
					}
				end

				table.insert(var_43_1, {
					pg.dorm3d_ik_touch_move[arg_45_0[3][2]].target_ik,
					0,
					{}
				})
			end
		end

		return
	end)
	pg.IKMgr.GetInstance():RegisterEnv(arg_43_1.ladyIKRoot, arg_43_1.ladyBoneMaps)
	arg_43_0:RegisterIKFunc()
	pg.IKMgr.GetInstance():SetIKStatus((_.map(table.shallowCopy(arg_43_2.ik_id), function(arg_47_0)
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
		local var_47_5, var_47_6, var_47_7

		if var_47_4 then
			var_47_1 = var_47_3.back_time
			var_47_2 = var_47_3.back_time
			var_47_0.ignoreDrag = true
			var_47_5 = var_47_0:GetPlaneRotations()
			var_47_6 = var_47_0:GetPlaneScales()
			var_47_7 = {
				triggerName = var_47_0:getConfig("trigger_param")[2],
				controllerName = var_47_0:GetControllerPath()
			}
		end

		var_47_7.subTargets = _.map(_.range(#var_47_0:GetSubTargets()), function(arg_55_0)
			return {
				name = var_0[arg_55_0][1],
				planeRot = var_47_5[arg_55_0],
				planeScale = var_47_6[arg_55_0]
			}
		end)
		var_47_7.actionType = var_47_0:GetActionTriggerParams()[1]
		var_47_7.controlRect = var_47_0:GetRect()
		var_47_7.actionRect = var_47_0:GetTriggerRect()
		var_47_7.backTime = var_47_2
		var_47_7.actionRevertTime = var_47_1
		var_47_7.ignoreDrag = var_47_4

		return Dorm3dIKController.New(var_47_7)
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

		local var_56_0 = arg_43_0:GetSceneItem(pg.dorm3d_ik_touch[arg_56_0[1]].scene_item)

		if not var_56_0 then
			warning(string.format("dorm3d_ik_touch:%d without scene_item:%s", arg_56_0[1], pg.dorm3d_ik_touch[arg_56_0[1]].scene_item))

			return
		end

		if IsNil(GetComponent(var_56_0, typeof(UnityEngine.Collider))) then
			go(var_56_0):AddComponent(typeof(UnityEngine.BoxCollider))
		end

		return
	end)

	arg_43_0:Get("camBrain").enabled = false

	if arg_43_0:Get("cameras")[Dorm3dRoomTemplateScene.CAMERA.IK_WATCH] then
		setActive(arg_43_0:Get("cameras")[Dorm3dRoomTemplateScene.CAMERA.IK_WATCH], false)

		arg_43_0:Get("cameras")[Dorm3dRoomTemplateScene.CAMERA.IK_WATCH] = nil
	end

	local var_43_4 = arg_43_0:Get("cameraRoot"):Find(arg_43_2.ik_camera)

	assert(var_43_4, "Missing IKCamera")

	arg_43_0:Get("cameras")[Dorm3dRoomTemplateScene.CAMERA.IK_WATCH] = var_43_4

	arg_43_0:Func("ActiveCamera", arg_43_0:Get("cameras")[Dorm3dRoomTemplateScene.CAMERA.IK_WATCH])

	arg_43_0:Get("camBrain").enabled = true

	local var_43_5 = var_43_4:GetComponent(typeof(Cinemachine.CinemachineFreeLook))

	if var_43_5 then
		arg_43_0:Func("RegisterOrbits", var_43_5)
	else
		arg_43_0:Func("RevertCameraOrbit")
	end

	arg_43_0:Func("SwitchAnim", arg_43_1, arg_43_2.character_action)
	arg_43_0:SettingHeadAimIK(arg_43_1, arg_43_2.head_track)
	arg_43_1:EnableCloth(false)
	arg_43_1:EnableCloth(arg_43_2.use_cloth, arg_43_2.cloth_colliders)
	arg_43_0:Func("PlayEnterSceneAnim", arg_43_2.enter_scene_anim)
	arg_43_0:Func("PlayEnterExtraItem", arg_43_1, arg_43_2.enter_extra_item)
	arg_43_0:Func("HideSceneItem", arg_43_1, arg_43_2.hide_scene_item)
	arg_43_0:Emit(Dorm3dIKView.UPDATE_TEXT_TIPS, arg_43_1.readyIKLayers)
	onNextTick(function()
		local var_57_0 = arg_43_0:Get("furnitures"):Find(arg_43_2.character_position)

		arg_43_1.lady.position = var_57_0:Find("StayPoint").position
		arg_43_1.lady.rotation = var_57_0:Find("StayPoint").rotation

		existCall(arg_43_3)

		return
	end)

	return
end

function var_0_0.ExitIKStatus(arg_58_0, arg_58_1, arg_58_2, arg_58_3, arg_58_4)
	arg_58_0.enableIKTip = false

	if arg_58_0.ikSwitchSkinId then
		arg_58_1:SwitchCharacterSkin(arg_58_0:Get("apartment"):GetConfigID(), arg_58_0.ikSwitchSkinId)

		arg_58_0.ikSwitchSkinId = nil
	end

	setActive(arg_58_1.ladyCollider, true)
	_.each(arg_58_1.ladyTouchColliders, function(arg_59_0)
		setActive(arg_59_0, false)

		return
	end)

	arg_58_0.blockIK = nil

	pg.IKMgr.GetInstance():UnregisterEnv()

	arg_58_1.ikHandler = nil

	arg_58_0:Emit(Dorm3dIKView.SET_TIPS_ACTIVE, false)
	arg_58_0:Emit(RoomTouchSystem.CANCEL_TOUCH_PRESS)

	arg_58_1.currentIkStatus = nil
	arg_58_1.ikActionDict = nil
	arg_58_1.readyIKLayers = nil
	arg_58_1.iKTouchDatas = nil

	arg_58_0:Func("RevertCameraOrbit")
	setActive(arg_58_0:Get("cameras")[Dorm3dRoomTemplateScene.CAMERA.IK_WATCH], false)

	arg_58_0:Get("cameras")[Dorm3dRoomTemplateScene.CAMERA.IK_WATCH] = nil

	arg_58_1:EnableCloth(false)
	arg_58_0:ResetHeadAimIK(arg_58_1)
	arg_58_0:Func("SwitchAnim", arg_58_1, arg_58_2.character_action)
	arg_58_0:Func("ResetSceneItemAnimators")

	if not arg_58_4.ignoreResetExtraItem then
		arg_58_0:Func("ResetCharacterExtraItem", arg_58_1)
		arg_58_0:Func("ResetTempHideSceneItems", arg_58_1)
	end

	onNextTick(function()
		arg_58_1.ladyActiveZone = arg_58_2.character_position and arg_58_2.character_position or arg_58_1.ladyBaseZone

		arg_58_0:Func("ChangeCharacterPosition", arg_58_1)
		arg_58_0:Func("TriggerLadyDistance")
		arg_58_0:Func("CheckInSector")
		existCall(arg_58_3)

		return
	end)

	return
end

function var_0_0.SetIKTimelineStatus(arg_61_0, arg_61_1, arg_61_2, arg_61_3, arg_61_4, arg_61_5)
	warning("Set IKStatus " .. (arg_61_3 or "NIL"))
	arg_61_1:SetCurrentIkTimelineStatus(arg_61_3)

	arg_61_0.enableIKTip = true

	arg_61_0:Emit(Dorm3dIKView.SET_CONTROL_ACTIVE, true)
	arg_61_0:ResetIKTipTimer()

	arg_61_0.blockIK = nil
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

		local var_62_0 = arg_62_1:GetType()

		if var_62_0:Equals(typeof(UnityEngine.MeshCollider)) then
			return
		end

		local var_62_1 = tf(arg_62_1)
		local var_62_2 = var_62_1.name
		local var_62_3 = var_62_1.name and string.find(var_62_2, "Collider") or -1

		if var_62_3 <= 0 then
			errorMsg("Wrong Name to lady Collider : " .. var_62_2)

			return
		end

		local var_62_4 = string.sub(var_62_2, 1, var_62_3 - 1)

		if var_62_4 == "Body" or var_62_4 == "Safe" then
			setActive(var_62_1, false)

			return
		end

		if DormConst.BONE_TO_TOUCH[var_62_4] == nil then
			return
		end

		var_61_0[var_62_4] = var_62_1

		setActive(var_62_1, true)

		return
	end)

	arg_61_1.IKSettings.Colliders = {}
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
	pg.IKMgr.GetInstance():RegisterEnv(arg_61_2.transform:Find("IKLayers"), {})
	arg_61_0:RegisterIKFunc()
	pg.IKMgr.GetInstance():SetIKStatus((_.map(pg.dorm3d_ik_timeline_status[arg_61_3].ik_id, function(arg_63_0)
		local var_63_0 = Dorm3dIK.New({
			configId = arg_63_0
		})

		table.insert(arg_61_1.readyIKLayers, var_63_0)

		local var_63_1 = var_63_0:GetPlaneRotations()
		local var_63_2 = var_63_0:GetPlaneScales()

		return Dorm3dIKController.New({
			ignoreDrag = false,
			triggerName = var_63_0:getConfig("trigger_param")[2],
			controllerName = var_63_0:GetControllerPath(),
			subTargets = _.map(_.range(#var_63_0:GetSubTargets()), function(arg_64_0)
				return {
					name = var_0[arg_64_0][1],
					planeRot = var_63_1[arg_64_0],
					planeScale = var_63_2[arg_64_0]
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
	arg_61_0:Emit(Dorm3dIKView.UPDATE_TEXT_TIPS, arg_61_1.readyIKLayers)
	existCall(arg_61_5)

	return
end

function var_0_0.ExitIKTimelineStatus(arg_67_0, arg_67_1, arg_67_2)
	arg_67_1:SetCurrentIkTimelineStatus(nil)

	arg_67_0.enableIKTip = false

	arg_67_0:Emit(Dorm3dIKView.SET_CONTROL_ACTIVE, false)

	arg_67_0.blockIK = nil

	pg.IKMgr.GetInstance():UnregisterEnv()

	arg_67_1.ikHandler = nil
	arg_67_1.ikTimelineMode = nil
	arg_67_1.readyIKLayers = nil
	arg_67_1.iKTouchDatas = nil
	arg_67_1.IKSettings = nil

	arg_67_0:Emit(Dorm3dIKView.SET_TIPS_ACTIVE, false)
	existCall(arg_67_2)

	return
end

function var_0_0.EnableIKLayer(arg_68_0, arg_68_1)
	local var_68_0 = arg_68_0:GetCurrentLadyEnv()

	if #arg_68_1:GetHeadTrackPath() > 0 then
		arg_68_0:SettingHeadAimIK(var_68_0, {
			2,
			arg_68_1:GetHeadTrackPath()
		}, true)
	end

	local var_68_1 = arg_68_1:GetTriggerFaceAnim()

	if #var_68_1 > 0 then
		arg_68_0:Func("PlayFaceAnim", var_68_0, var_68_1)
	end

	if not arg_68_1.ignoreDrag then
		arg_68_0:Emit(Dorm3dIKView.PLAY_HAND_BEGIN)
	end

	if not var_68_0.ikTimelineMode then
		pg.m02:sendNotification(GAME.APARTMENT_TRACK, Dorm3dTrackCommand.BuildDataTouch(arg_68_0:Get("apartment").configId, arg_68_0:Get("apartment").level, var_68_0.ikConfig.character_action, arg_68_1:GetTriggerParams()[2], arg_68_0:GetRoom():GetConfigID()))
	end

	return
end

function var_0_0.DeactiveIKLayer(arg_69_0, arg_69_1)
	local var_69_0 = arg_69_0:GetCurrentLadyEnv()

	if not var_69_0.ikTimelineMode and #arg_69_1:GetHeadTrackPath() > 0 then
		arg_69_0:SettingHeadAimIK(var_69_0, var_69_0.ikConfig.head_track)
	end

	if not arg_69_1.ignoreDrag then
		arg_69_0:Emit(Dorm3dIKView.PLAY_HAND_END)
	end

	return
end

function var_0_0.ResetIKTipTimer(arg_70_0)
	if not arg_70_0.enableIKTip then
		return
	end

	arg_70_0.nextTipIKTime = Time.time + var_0_0.IK_TIP_WAIT_TIME

	return
end

function var_0_0.EnableCurrentHeadIK(arg_71_0, arg_71_1)
	arg_71_0:EnableHeadIK(arg_71_0:GetCurrentLadyEnv(), arg_71_1)

	return
end

function var_0_0.EnableHeadIK(arg_72_0, arg_72_1, arg_72_2)
	arg_72_1.ladyHeadIKComp.enableIk = arg_72_2

	return
end

function var_0_0.SettingHeadAimIK(arg_73_0, arg_73_1, arg_73_2, arg_73_3)
	local var_73_0

	if arg_73_2[1] == 0 then
		arg_73_0:EnableHeadIK(arg_73_1, false)

		return
	elseif arg_73_2[1] == 1 then
		arg_73_0:EnableHeadIK(arg_73_1, true)

		var_73_0 = arg_73_0:Get("mainCameraTF"):Find("AimTarget")
	elseif arg_73_2[1] == 2 then
		arg_73_0:EnableHeadIK(arg_73_1, true)
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

function var_0_0.ResetHeadAimIK(arg_75_0, arg_75_1)
	arg_75_0:EnableHeadIK(arg_75_1, true)

	arg_75_1.ladyHeadIKComp.AimTarget = arg_75_0:Get("mainCameraTF"):Find("AimTarget")
	arg_75_1.ladyHeadIKComp.HeadWeight = arg_75_1.ladyHeadIKData.HeadWeight
	arg_75_1.ladyHeadIKComp.BodyWeight = arg_75_1.ladyHeadIKData.BodyWeight

	return
end

function var_0_0.OnTriggerIK(arg_76_0, arg_76_1)
	local var_76_0 = arg_76_0:GetCurrentLadyEnv()

	if var_76_0.ikTimelineMode then
		arg_76_0:ExitIKTimelineStatus(var_76_0)

		local var_76_1 = arg_76_1:GetTimelineAction()

		if var_76_1 then
			arg_76_0:Get("nowTimelinePlayer"):TriggerEvent(var_76_1)
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

	arg_76_0.blockIK = true

	arg_76_0:Emit(var_0_0.ON_IK_LAYER_ACTION, var_76_0, arg_76_1:GetConfigID(), var_76_2, function()
		arg_76_0:ResetIKTipTimer()

		arg_76_0.blockIK = nil

		return
	end)

	return
end

function var_0_0.UpdateIKTarget(arg_78_0)
	if not arg_78_0:Get("apartment") then
		return
	end

	local var_78_0 = arg_78_0:GetCurrentLadyEnv()

	if not var_78_0 then
		return
	end

	if var_78_0.ikHandler then
		local var_78_1

		if not var_78_0.readyIKLayers then
			do return end

			var_78_1 = pg.UIMgr.GetInstance().uiCamera:Find("Canvas").rect
		end

		arg_78_0:Emit(Dorm3dIKView.SET_HAND_POSITION, var_78_0.ikHandler.screenPosition - Vector2.New(var_78_1.width, var_78_1.height) * 0.5)

		if Time.time > arg_78_0.ikNextCheckStamp then
			arg_78_0.ikNextCheckStamp = arg_78_0.ikNextCheckStamp + var_0_0.IK_STATUS_DELTA

			arg_78_0:Emit(var_0_0.ON_IK_STATUS_CHANGED, _.detect(var_78_0.readyIKLayers, function(arg_79_0)
				return arg_79_0:GetControllerPath() == var_78_0.ikHandler.ikData:GetControllerPath()
			end):GetConfigID(), var_0_0.IK_STATUS.DRAG)
		end
	end

	if arg_78_0.enableIKTip then
		if not var_78_0.readyIKLayers or not var_78_0.IKSettings then
			return
		end

		arg_78_0:UpdateIKTips(var_78_0)
	end

	return
end

function var_0_0.UpdateIKTips(arg_80_0, arg_80_1)
	if not arg_80_0.nextTipIKTime then
		return
	end

	arg_80_0:Emit(Dorm3dIKView.UPDATE_TIPS, not arg_80_0.blockIK and Time.time > arg_80_0.nextTipIKTime, arg_80_1)

	return
end

function var_0_0.CycleIKCameraGroup(arg_81_0)
	assert(arg_81_0:Func("GetBlackboardValue", arg_81_0:GetCurrentLadyEnv(), "inIK"))
	seriesAsync({
		function(arg_82_0)
			pg.IKMgr.GetInstance():ResetActiveIKs()
			arg_81_0:SwitchIKConfig(var_0, pg.dorm3d_ik_status.get_id_list_by_camera_group[var_0.ikConfig.camera_group][table.indexof(pg.dorm3d_ik_status.get_id_list_by_camera_group[var_0.ikConfig.camera_group], var_0.ikConfig.id) % #pg.dorm3d_ik_status.get_id_list_by_camera_group[var_0.ikConfig.camera_group] + 1])
			arg_81_0:SetIKState(true)

			return
		end
	})

	return
end

function var_0_0.SetIKSwitchSkinId(arg_83_0, arg_83_1)
	arg_83_0.ikSwitchSkinId = arg_83_1

	return
end

function var_0_0.SwitchIKSkin(arg_84_0, arg_84_1, arg_84_2, arg_84_3)
	seriesAsync({
		function(arg_85_0)
			arg_84_0:SetIKState(false, arg_85_0)

			return
		end,
		function(arg_86_0)
			arg_84_1:SwitchCharacterSkin(arg_84_2, arg_84_3)
			arg_84_0:SwitchIKConfig(arg_84_1, arg_84_1.ikConfig.id)
			arg_84_0:SetIKState(true, arg_86_0)

			return
		end
	})

	return
end

function var_0_0.ConsumeIKSpecialCall(arg_87_0)
	if not arg_87_0.ikSpecialCall then
		return false
	end

	local var_87_0 = arg_87_0.ikSpecialCall

	arg_87_0.ikSpecialCall = nil

	existCall(var_87_0)

	return true
end

return var_0_0
