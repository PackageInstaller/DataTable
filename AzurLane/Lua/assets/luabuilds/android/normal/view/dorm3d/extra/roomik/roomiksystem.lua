class = var_0_10000

local var_0_0 = "RoomIKSystem"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.dorm3d.Extra.BaseExtraSystem"))

var_0_1.SET_IK_CONFIG = "RoomIKSystem.SET_IK_CONFIG"
var_0_1.SET_IK_STATE = "RoomIKSystem.SET_IK_STATE"
var_0_1.ON_BEGIN_DRAG_CHARACTER_BODY = "RoomIKSystem.ON_BEGIN_DRAG_CHARACTER_BODY"
var_0_1.ON_DRAG_CHARACTER_BODY = "RoomIKSystem.ON_DRAG_CHARACTER_BODY"
var_0_1.ON_RELEASE_CHARACTER_BODY = "RoomIKSystem.ON_RELEASE_CHARACTER_BODY"
var_0_1.ON_IK_STATUS_CHANGED = "RoomIKSystem.ON_IK_STATUS_CHANGED"
var_0_1.ON_IK_LAYER_ACTION = "RoomIKSystem.ON_IK_LAYER_ACTION"
var_0_1.SET_IK_TIMELINE_STATUS = "RoomIKSystem.SET_IK_TIMELINE_STATUS"
var_0_1.EXIT_IK_TIMELINE_STATUS = "RoomIKSystem.EXIT_IK_TIMELINE_STATUS"
var_0_1.CYCLE_IK_CAMERA_GROUP = "RoomIKSystem.CYCLE_IK_CAMERA_GROUP"
var_0_1.SET_IK_SPECIAL_CALL = "RoomIKSystem.SET_IK_SPECIAL_CALL"
var_0_1.CONSUME_IK_SPECIAL_CALL = "RoomIKSystem.CONSUME_IK_SPECIAL_CALL"
var_0_1.GET_IK_BLOCK = "RoomIKSystem.GET_IK_BLOCK"
var_0_1.SET_IK_BLOCK = "RoomIKSystem.SET_IK_BLOCK"
var_0_1.RESET_IK_TIP_TIMER = "RoomIKSystem.RESET_IK_TIP_TIMER"
var_0_1.SET_IK_SWITCH_SKIN_ID = "RoomIKSystem.SET_IK_SWITCH_SKIN_ID"
var_0_1.SWITCH_IK_SKIN = "RoomIKSystem.SWITCH_IK_SKIN"
var_0_1.IK_STATUS_DELTA = 0.5
var_0_1.IK_TIP_WAIT_TIME = 5
var_0_1.IK_STATUS = {
	RELEASE = 3,
	BEGIN = 1,
	TRIGGER = 4,
	DRAG = 2
}

function var_0_1.OnInit(arg_1_0)
	arg_1_0:RegisterIKFunc()

	return
end

function var_0_1.RegisterEvents(arg_2_0)
	arg_2_0:Bind(var_0_1.SET_IK_CONFIG, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = arg_2_0

		var_3.SwitchIKConfig(var_3_0, arg_3_1, arg_3_2)

		return
	end)
	arg_2_0:Bind(var_0_1.SET_IK_STATE, function(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		local var_4_0 = arg_2_0

		var_4.SetIKState(var_4_0, arg_4_1, arg_4_2, arg_4_3)

		return
	end)
	arg_2_0:Bind(var_0_1.ON_BEGIN_DRAG_CHARACTER_BODY, function(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
		local var_5_0 = arg_2_0

		var_4.OnBeginDragCharacterBody(var_5_0, arg_5_1, arg_5_2, arg_5_3)

		return
	end)
	arg_2_0:Bind(var_0_1.ON_DRAG_CHARACTER_BODY, function(arg_6_0, arg_6_1, arg_6_2)
		local var_6_0 = arg_2_0

		var_3.OnDragCharacterBody(var_6_0, arg_6_1, arg_6_2)

		return
	end)
	arg_2_0:Bind(var_0_1.ON_RELEASE_CHARACTER_BODY, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_2_0

		var_2.OnReleaseCharacterBody(var_7_0, arg_7_1)

		return
	end)
	arg_2_0:Bind(var_0_1.SET_IK_TIMELINE_STATUS, function(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
		local var_8_0 = arg_2_0

		var_6.SetIKTimelineStatus(var_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)

		return
	end)
	arg_2_0:Bind(var_0_1.EXIT_IK_TIMELINE_STATUS, function(arg_9_0, arg_9_1, arg_9_2)
		local var_9_0 = arg_2_0

		var_3.ExitIKTimelineStatus(var_9_0, arg_9_1, arg_9_2)

		return
	end)
	arg_2_0:Bind(var_0_1.CYCLE_IK_CAMERA_GROUP, function()
		local var_10_0 = arg_2_0

		var_0.CycleIKCameraGroup(var_10_0)

		return
	end)
	arg_2_0:Bind(var_0_1.SET_IK_SPECIAL_CALL, function(arg_11_0, arg_11_1)
		arg_2_0.ikSpecialCall = arg_11_1

		return
	end)
	arg_2_0:Bind(var_0_1.CONSUME_IK_SPECIAL_CALL, function(arg_12_0, arg_12_1)
		local var_12_0 = arg_2_0
		local var_12_1 = var_2.ConsumeIKSpecialCall(var_12_0)

		if arg_12_1 then
			arg_12_1.consumed = var_12_1
		end

		return
	end)
	arg_2_0:Bind(var_0_1.GET_IK_BLOCK, function(arg_13_0, arg_13_1)
		if arg_13_1 then
			arg_13_1.blockIK = arg_2_0.blockIK
		end

		return
	end)
	arg_2_0:Bind(var_0_1.SET_IK_BLOCK, function(arg_14_0, arg_14_1)
		arg_2_0.blockIK = arg_14_1

		return
	end)
	arg_2_0:Bind(var_0_1.RESET_IK_TIP_TIMER, function()
		local var_15_0 = arg_2_0

		var_0.ResetIKTipTimer(var_15_0)

		return
	end)
	arg_2_0:Bind(var_0_1.SET_IK_SWITCH_SKIN_ID, function(arg_16_0, arg_16_1)
		local var_16_0 = arg_2_0

		var_2.SetIKSwitchSkinId(var_16_0, arg_16_1)

		return
	end)
	arg_2_0:Bind(var_0_1.SWITCH_IK_SKIN, function(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
		local var_17_0 = arg_2_0

		var_4.SwitchIKSkin(var_17_0, arg_17_1, arg_17_2, arg_17_3)

		return
	end)

	return
end

function var_0_1.OnUpdate(arg_18_0)
	arg_18_0:UpdateIKTarget()

	return
end

function var_0_1.OnDispose(arg_19_0)
	pg = var_1_10001

	local var_19_0 = var_1_10001.IKMgr.GetInstance()

	var_1.ReleaseDrag(var_19_0)

	pg = var_1

	local var_19_1 = var_1.IKMgr.GetInstance()

	var_1.UnregisterEnv(var_19_1)

	return
end

function var_0_1.SwitchIKConfig(arg_20_0, arg_20_1, arg_20_2)
	warning = var_1_10003

	var_1_10003("switchIkstatus", arg_20_2)

	pg = var_1_10003

	local var_20_0 = var_1_10003.dorm3d_ik_status[arg_20_2]

	local function var_20_1()
		if var_20_0.skin_id ~= arg_20_1.skinId then
			pg = var_0

			local var_21_0 = var_0.dorm3d_ik_status.get_id_list_by_base[var_20_0.base]

			_ = var_1

			local var_21_1 = var_1.detect(var_21_0, function(arg_22_0)
				pg = var_3_10001

				return var_3_10001.dorm3d_ik_status[arg_22_0].skin_id == arg_20_1.skinId
			end)

			assert = var_2

			local var_21_2 = var_21_1

			string = var_2_10004

			var_2(var_21_2, var_2_10004.format("Missing Status Config By Skin: %s original Status: %s", arg_20_1.skinId, arg_20_2))

			pg = var_2
			var_20_0 = var_2.dorm3d_ik_status[var_21_1]
		end

		return
	end

	type = var_5

	if var_5(var_20_0.skin_id) == "table" then
		table = var_5

		if not var_5.contains(var_20_0.skin_id, arg_20_1.skinId) then
			var_20_1()
		end
	else
		var_20_1()
	end

	arg_20_1.ikConfig = var_20_0

	return
end

function var_0_1.SetIKState(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	arg_23_3 = arg_23_3 or {}

	local var_23_0 = arg_23_0:GetCurrentLadyEnv()
	local var_23_1 = {}

	if arg_23_1 then
		table = var_1_10006

		var_1_10006.insert(var_23_1, function(arg_24_0)
			local var_24_0 = arg_23_0

			var_1.Func(var_24_0, "SetBlackboardValue", var_23_0, "inIK", true)

			local var_24_1 = arg_23_0
			local var_24_2 = var_1.Emit

			Dorm3dRoomTemplateScene = var_3

			var_24_2(var_24_1, var_3.SHOW_BLOCK)

			local var_24_3 = var_23_0.ikConfig.camera_group
			local var_24_4 = arg_23_0
			local var_24_5 = var_2.Emit

			Dorm3dIKView = var_4

			local var_24_6 = var_4.SET_CAMERA_BUTTON_ACTIVE

			pg = var_5

			var_24_5(var_24_4, var_24_6, #var_5.dorm3d_ik_status.get_id_list_by_camera_group[var_24_3] > 1)

			local var_24_7 = arg_23_0
			local var_24_8 = var_2.Emit

			Dorm3dIKView = var_24_6

			var_24_8(var_24_7, var_24_6.SET_CONTROL_ACTIVE, true)
			arg_24_0()

			return
		end)

		if arg_23_0:Get("uiState") ~= "ik" then
			table = var_1_10006

			var_1_10006.insert(var_23_1, function(arg_25_0)
				local var_25_0 = arg_23_0

				var_1.Func(var_25_0, "SetUI", arg_25_0, "ik")

				return
			end)
		end

		table = var_1_10006

		var_1_10006.insert(var_23_1, function(arg_26_0)
			Shader = var_2_10001

			var_2_10001.SetGlobalFloat("_ScreenClipOff", 0)

			local var_26_0 = arg_23_0

			var_1.SetIKStatus(var_26_0, var_23_0, var_23_0.ikConfig, arg_26_0, arg_23_3)

			return
		end)

		table = var_1_10006

		var_1_10006.insert(var_23_1, function(arg_27_0)
			local var_27_0 = arg_23_0
			local var_27_1 = var_1.Emit

			Dorm3dRoomTemplateScene = var_2_10003

			var_27_1(var_27_0, var_2_10003.HIDE_BLOCK)
			arg_27_0()

			return
		end)
	else
		assert = var_1_10006

		var_1_10006(arg_23_0:Get("uiState") == "ik")

		table = var_1_10006

		var_1_10006.insert(var_23_1, function(arg_28_0)
			local var_28_0 = arg_23_0
			local var_28_1 = var_1.Emit

			Dorm3dIKView = var_2_10003

			var_28_1(var_28_0, var_2_10003.SET_CONTROL_ACTIVE, false)

			local var_28_2 = arg_23_0
			local var_28_3 = var_1.Emit

			Dorm3dRoomTemplateScene = var_3

			var_28_3(var_28_2, var_3.SHOW_BLOCK)

			Shader = var_28_3

			var_28_3.SetGlobalFloat("_ScreenClipOff", 1)
			arg_28_0()

			return
		end)

		table = var_1_10006

		var_1_10006.insert(var_23_1, function(arg_29_0)
			local var_29_0 = arg_23_0

			var_1.ExitIKStatus(var_29_0, var_23_0, var_23_0.ikConfig, arg_29_0, arg_23_3)

			local var_29_1 = arg_23_0

			var_1.Func(var_29_1, "ResetSceneItemAnimators")

			return
		end)

		table = var_1_10006

		var_1_10006.insert(var_23_1, function(arg_30_0)
			local var_30_0 = arg_23_0

			var_1.Func(var_30_0, "SetUI", arg_30_0, "back")

			return
		end)

		table = var_1_10006

		var_1_10006.insert(var_23_1, function(arg_31_0)
			local var_31_0 = arg_23_0

			var_1.Func(var_31_0, "SetBlackboardValue", var_23_0, "inIK", false)

			local var_31_1 = arg_23_0
			local var_31_2 = var_1.Emit

			Dorm3dRoomTemplateScene = var_3

			var_31_2(var_31_1, var_3.HIDE_BLOCK)
			arg_31_0()

			return
		end)
	end

	seriesAsync = var_1_10006

	var_1_10006(var_23_1, arg_23_2)

	return
end

function var_0_1.OnBeginDragCharacterBody(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	if arg_32_0.blockIK then
		return
	end

	if arg_32_1.ikHandler then
		return
	end

	pg = var_4

	local var_32_0 = var_4.IKMgr.GetInstance()

	var_4.OnDragBegin(var_32_0, arg_32_2, arg_32_3)

	return
end

function var_0_1.OnDragCharacterBody(arg_33_0, arg_33_1, arg_33_2)
	if not arg_33_1.ikHandler then
		return
	end

	pg = var_3

	local var_33_0 = var_3.IKMgr.GetInstance()

	var_3.HandleBodyDrag(var_33_0, arg_33_2)

	return
end

function var_0_1.OnReleaseCharacterBody(arg_34_0, arg_34_1)
	pg = var_1_10002

	local var_34_0 = var_1_10002.IKMgr.GetInstance()

	var_2.ReleaseDrag(var_34_0)

	return
end

function var_0_1.RegisterIKFunc(arg_35_0)
	pg = var_1_10001

	local var_35_0 = var_1_10001.IKMgr.GetInstance()

	var_1.RegisterOnIKLayerActive(var_35_0, function(arg_36_0)
		arg_35_0.blockIK = true

		local var_36_0 = arg_35_0
		local var_36_1 = var_1.GetCurrentLadyEnv(var_36_0)

		var_36_1.ikHandler = arg_36_0
		_ = var_36_0

		local var_36_2 = var_36_0.detect(var_36_1.readyIKLayers, function(arg_37_0)
			local var_37_0 = arg_37_0:GetControllerPath()
			local var_37_1 = arg_36_0.ikData

			return var_37_0 == var_2.GetControllerPath(var_37_1)
		end)
		local var_36_3 = arg_35_0

		var_3.EnableIKLayer(var_36_3, var_36_2)

		local var_36_4 = arg_35_0

		Time = var_36_3
		var_36_4.ikNextCheckStamp = var_36_3.time + var_0_1.IK_STATUS_DELTA

		local var_36_5 = arg_35_0

		var_3.Emit(var_36_5, var_0_1.ON_IK_STATUS_CHANGED, var_36_2:GetConfigID(), var_0_1.IK_STATUS.BEGIN)

		return
	end)

	pg = var_1

	local var_35_1 = var_1.IKMgr.GetInstance()

	var_1.RegisterOnIKLayerDrag(var_35_1, function(arg_38_0)
		local var_38_0 = arg_35_0

		var_1.GetCurrentLadyEnv(var_38_0).ikHandler = arg_38_0

		local var_38_1 = arg_35_0

		var_2.ResetIKTipTimer(var_38_1)

		return
	end)

	pg = var_1

	local var_35_2 = var_1.IKMgr.GetInstance()

	var_1.RegisterOnIKLayerDeactive(var_35_2, function(arg_39_0, arg_39_1)
		local var_39_0 = arg_35_0
		local var_39_1 = var_2.GetCurrentLadyEnv(var_39_0)

		_ = var_39_0

		local var_39_2 = var_39_0.detect(var_39_1.readyIKLayers, function(arg_40_0)
			local var_40_0 = arg_40_0:GetControllerPath()
			local var_40_1 = arg_39_0.ikData

			return var_40_0 == var_2.GetControllerPath(var_40_1)
		end)
		local var_39_3 = arg_35_0

		var_4.DeactiveIKLayer(var_39_3, var_39_2)

		var_39_1.ikHandler = nil
		arg_35_0.blockIK = arg_39_1

		local var_39_4 = arg_35_0

		var_4.Emit(var_39_4, var_0_1.ON_IK_STATUS_CHANGED, var_39_2:GetConfigID(), var_0_1.IK_STATUS.RELEASE)

		return
	end)

	pg = var_1

	local var_35_3 = var_1.IKMgr.GetInstance()

	var_1.RegisterOnIKLayerAction(var_35_3, function(arg_41_0)
		local var_41_0 = arg_35_0
		local var_41_1 = var_1.GetCurrentLadyEnv(var_41_0)
		local var_41_2 = arg_35_0

		var_41_2.blockIK = nil
		_ = var_41_2

		local var_41_3 = var_41_2.detect(var_41_1.readyIKLayers, function(arg_42_0)
			local var_42_0 = arg_42_0:GetControllerPath()
			local var_42_1 = arg_41_0.ikData

			return var_42_0 == var_2.GetControllerPath(var_42_1)
		end)
		local var_41_4 = arg_35_0

		var_3.OnTriggerIK(var_41_4, var_41_3)

		local var_41_5 = arg_35_0

		var_3.Emit(var_41_5, var_0_1.ON_IK_STATUS_CHANGED, var_41_3:GetConfigID(), var_0_1.IK_STATUS.TRIGGER)

		return
	end)

	return
end

function var_0_1.SetIKStatus(arg_43_0, arg_43_1, arg_43_2, arg_43_3, arg_43_4)
	warning = var_1_10005

	local var_43_0 = "Set IKStatus "
	local var_43_1

	if not arg_43_2.id then
		var_43_1 = "NIL"
	end

	var_1_10005(var_43_0 .. var_43_1)

	arg_43_0.enableIKTip = true

	arg_43_0:ResetIKTipTimer()

	setActive = var_5

	var_5(arg_43_1.ladyCollider, false)

	_ = var_5

	var_5.each(arg_43_1.ladyTouchColliders, function(arg_44_0)
		setActive = var_2_10001

		var_2_10001(arg_44_0, true)

		return
	end)

	arg_43_0.blockIK = nil

	local var_43_2 = arg_43_0
	local var_43_3 = arg_43_0.Emit

	RoomTouchSystem = var_7

	var_43_3(var_43_2, var_7.CANCEL_TOUCH_PRESS)

	arg_43_1.currentIkStatus = arg_43_2.id
	arg_43_1.ikActionDict = {}
	arg_43_1.readyIKLayers = {}
	arg_43_1.iKTouchDatas = arg_43_2.touch_data

	local var_43_4 = arg_43_0
	local var_43_5 = arg_43_0.Emit

	RoomTouchSystem = var_7

	var_43_5(var_43_4, var_7.VALIDATE_TOUCH_CONFIGS, arg_43_1.iKTouchDatas, arg_43_2.id)

	local var_43_6 = {
		Colliders = arg_43_1.ladyColliders
	}
	local var_43_7 = arg_43_0

	var_43_6.CameraRaycaster = arg_43_0.Get(var_43_7, "sceneRaycaster")
	arg_43_1.IKSettings = var_43_6
	table = var_43_6

	local var_43_8 = var_43_6.shallowCopy(arg_43_2.ik_id)
	local var_43_9 = {}

	_ = var_43_7

	var_43_7.each(arg_43_1.iKTouchDatas, function(arg_45_0)
		if arg_45_0[3][1] == 7 then
			pg = var_2

			local var_45_0 = var_2.dorm3d_ik_touch_move[var_1[2]].target_ik

			_ = var_2_10004

			if not var_2_10004.detect(var_43_8, function(arg_46_0)
				return arg_46_0[1] == var_45_0
			end) then
				var_43_9[var_45_0] = {
					back_time = var_2.back_time
				}

				local var_45_1 = {
					var_45_0,
					0,
					{}
				}

				if var_2.trigger_dialogue > 0 then
					var_45_1[3] = {
						4,
						0,
						var_2.trigger_dialogue
					}
				end

				table = var_5

				var_5.insert(var_43_8, var_45_1)
			end
		end

		return
	end)

	_ = var_7

	local var_43_10 = var_7.map(var_43_8, function(arg_47_0)
		Dorm3dIK = var_2_10001

		local var_47_0 = var_2_10001.New({
			configId = arg_47_0[1]
		})
		local var_47_1

		var_47_1, switch = arg_47_0[3][1], var_2_10004

		local var_47_2 = {
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
		}

		local function var_47_3(arg_54_0)
			type = var_3_10001

			return var_3_10001(arg_54_0) == "number" and arg_54_0 or 0
		end

		unpack = var_2_10008

		local var_47_4 = var_2_10004(var_47_1, var_47_2, var_47_3, var_2_10008(var_2, 2))

		table = var_47_1

		var_47_1.insert(arg_43_1.readyIKLayers, var_47_0)

		arg_43_1.ikActionDict[var_47_0:GetControllerPath()] = var_2

		local var_47_5 = var_47_0:GetRevertTime()
		local var_47_6 = var_43_9[var_47_0:GetConfigID()]

		tobool = var_7

		if var_7(var_47_6) then
			var_47_4 = var_47_6.back_time
			var_47_5 = var_47_6.back_time
			var_47_0.ignoreDrag = true
		end

		local var_47_7 = var_47_0:GetSubTargets()
		local var_47_8 = var_47_0:GetPlaneRotations()
		local var_47_9 = var_47_0
		local var_47_10 = var_47_0.GetPlaneScales(var_47_9)

		_ = var_47_9

		local var_47_11 = var_47_9.map

		_ = var_2_10012

		local var_47_12 = var_47_11(var_2_10012.range(#var_47_7), function(arg_55_0)
			return {
				name = var_47_7[arg_55_0][1],
				planeRot = var_47_8[arg_55_0],
				planeScale = var_47_10[arg_55_0]
			}
		end)

		Dorm3dIKController = var_12

		return var_12.New({
			triggerName = var_47_0:getConfig("trigger_param")[2],
			controllerName = var_47_0:GetControllerPath(),
			subTargets = var_47_12,
			actionType = var_47_0:GetActionTriggerParams()[1],
			controlRect = var_47_0:GetRect(),
			actionRect = var_47_0:GetTriggerRect(),
			backTime = var_47_5,
			actionRevertTime = var_47_4,
			ignoreDrag = var_7
		})
	end)

	pg = var_8

	local var_43_11 = var_8.IKMgr.GetInstance()

	var_8.RegisterEnv(var_43_11, arg_43_1.ladyIKRoot, arg_43_1.ladyBoneMaps)
	arg_43_0:RegisterIKFunc()

	pg = var_8

	local var_43_12 = var_8.IKMgr.GetInstance()

	var_8.SetIKStatus(var_43_12, var_43_10)

	local var_43_13 = {}

	_ = var_43_12

	var_43_12.each(arg_43_1.iKTouchDatas, function(arg_56_0)
		local var_56_0 = arg_56_0[1]

		pg = var_2_10002

		if #var_2_10002.dorm3d_ik_touch[var_56_0].scene_item == 0 then
			return
		end

		if var_43_13[var_2.scene_item] then
			return
		end

		var_43_13[var_2.scene_item] = true

		local var_56_1 = arg_43_0

		if not var_3.GetSceneItem(var_56_1, var_2.scene_item) then
			warning = var_56_1
			string = var_5

			var_56_1(var_5.format("dorm3d_ik_touch:%d without scene_item:%s", var_56_0, var_2.scene_item))

			return
		end

		IsNil = var_56_1
		GetComponent = var_5

		local var_56_2 = var_3

		typeof = var_2_10007
		UnityEngine = var_2_10008

		if var_56_1(var_5(var_56_2, var_2_10007(var_2_10008.Collider))) then
			go = var_4

			local var_56_3 = var_4(var_3)
			local var_56_4 = var_4.AddComponent

			typeof = var_56_2
			UnityEngine = var_7

			var_56_4(var_56_3, var_56_2(var_7.BoxCollider))
		end

		return
	end)

	arg_43_0:Get("camBrain").enabled = false

	local var_43_14 = arg_43_0
	local var_43_15 = arg_43_0.Get(var_43_14, "cameras")

	Dorm3dRoomTemplateScene = var_43_14

	if var_43_15[var_43_14.CAMERA.IK_WATCH] then
		setActive = var_9

		local var_43_16 = arg_43_0
		local var_43_17 = arg_43_0.Get(var_43_16, "cameras")

		Dorm3dRoomTemplateScene = var_43_16

		var_9(var_43_17[var_43_16.CAMERA.IK_WATCH], false)

		local var_43_18 = arg_43_0
		local var_43_19 = arg_43_0.Get(var_43_18, "cameras")

		Dorm3dRoomTemplateScene = var_43_18
		var_43_19[var_43_18.CAMERA.IK_WATCH] = nil
	end

	local var_43_20 = arg_43_0:Get("cameraRoot")
	local var_43_21 = var_9.Find(var_43_20, arg_43_2.ik_camera)

	assert = var_43_20

	var_43_20(var_43_21, "Missing IKCamera")

	local var_43_22 = arg_43_0
	local var_43_23 = arg_43_0.Get(var_43_22, "cameras")

	Dorm3dRoomTemplateScene = var_43_22
	var_43_23[var_43_22.CAMERA.IK_WATCH] = var_43_21

	local var_43_24 = arg_43_0
	local var_43_25 = arg_43_0.Func
	local var_43_26 = "ActiveCamera"
	local var_43_27 = arg_43_0
	local var_43_28 = arg_43_0.Get(var_43_27, "cameras")

	Dorm3dRoomTemplateScene = var_43_27

	var_43_25(var_43_24, var_43_26, var_43_28[var_43_27.CAMERA.IK_WATCH])

	arg_43_0:Get("camBrain").enabled = true

	local var_43_29 = var_43_21
	local var_43_30 = var_43_21.GetComponent

	typeof = var_12
	Cinemachine = var_13

	if var_43_30(var_43_29, var_12(var_13.CinemachineFreeLook)) then
		arg_43_0:Func("RegisterOrbits", var_10)
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

	local var_43_31 = arg_43_0
	local var_43_32 = arg_43_0.Emit

	Dorm3dIKView = var_13

	var_43_32(var_43_31, var_13.UPDATE_TEXT_TIPS, arg_43_1.readyIKLayers)

	onNextTick = var_43_32

	var_43_32(function()
		local var_57_0 = arg_43_0
		local var_57_1 = var_0.Get(var_57_0, "furnitures")
		local var_57_2 = var_0.Find(var_57_1, arg_43_2.character_position)

		arg_43_1.lady.position = var_57_2:Find("StayPoint").position

		local var_57_3 = arg_43_1.lady

		var_57_3.rotation = var_57_2:Find("StayPoint").rotation
		existCall = var_57_3

		var_57_3(arg_43_3)

		return
	end)

	return
end

function var_0_1.ExitIKStatus(arg_58_0, arg_58_1, arg_58_2, arg_58_3, arg_58_4)
	arg_58_0.enableIKTip = false

	local var_58_1

	if arg_58_0.ikSwitchSkinId then
		local var_58_0 = arg_58_0:Get("apartment")

		var_58_1 = var_58_1.GetConfigID(var_58_0)

		arg_58_1:SwitchCharacterSkin(var_58_1, arg_58_0.ikSwitchSkinId)

		arg_58_0.ikSwitchSkinId = nil
	end

	setActive = var_58_1

	var_58_1(arg_58_1.ladyCollider, true)

	_ = var_58_1

	var_58_1.each(arg_58_1.ladyTouchColliders, function(arg_59_0)
		setActive = var_2_10001

		var_2_10001(arg_59_0, false)

		return
	end)

	arg_58_0.blockIK = nil
	pg = var_5

	local var_58_2 = var_5.IKMgr.GetInstance()

	var_5.UnregisterEnv(var_58_2)

	arg_58_1.ikHandler = nil

	local var_58_3 = arg_58_0
	local var_58_4 = arg_58_0.Emit

	Dorm3dIKView = var_7

	var_58_4(var_58_3, var_7.SET_TIPS_ACTIVE, false)

	local var_58_5 = arg_58_0
	local var_58_6 = arg_58_0.Emit

	RoomTouchSystem = var_7

	var_58_6(var_58_5, var_7.CANCEL_TOUCH_PRESS)

	arg_58_1.currentIkStatus = nil
	arg_58_1.ikActionDict = nil
	arg_58_1.readyIKLayers = nil
	arg_58_1.iKTouchDatas = nil

	arg_58_0:Func("RevertCameraOrbit")

	setActive = var_5

	local var_58_7 = arg_58_0
	local var_58_8 = arg_58_0.Get(var_58_7, "cameras")

	Dorm3dRoomTemplateScene = var_58_7

	var_5(var_58_8[var_58_7.CAMERA.IK_WATCH], false)

	local var_58_9 = arg_58_0
	local var_58_10 = arg_58_0.Get(var_58_9, "cameras")

	Dorm3dRoomTemplateScene = var_58_9
	var_58_10[var_58_9.CAMERA.IK_WATCH] = nil

	arg_58_1:EnableCloth(false)
	arg_58_0:ResetHeadAimIK(arg_58_1)
	arg_58_0:Func("SwitchAnim", arg_58_1, arg_58_2.character_action)
	arg_58_0:Func("ResetSceneItemAnimators")

	if not arg_58_4.ignoreResetExtraItem then
		arg_58_0:Func("ResetCharacterExtraItem", arg_58_1)
		arg_58_0:Func("ResetTempHideSceneItems", arg_58_1)
	end

	onNextTick = var_5

	var_5(function()
		if arg_58_2.character_position then
			arg_58_1.ladyActiveZone = arg_58_2.character_position
		else
			arg_58_1.ladyActiveZone = arg_58_1.ladyBaseZone
		end

		local var_60_0 = arg_58_0

		var_0.Func(var_60_0, "ChangeCharacterPosition", arg_58_1)

		local var_60_1 = arg_58_0

		var_0.Func(var_60_1, "TriggerLadyDistance")

		local var_60_2 = arg_58_0

		var_0.Func(var_60_2, "CheckInSector")

		existCall = var_0

		var_0(arg_58_3)

		return
	end)

	return
end

function var_0_1.SetIKTimelineStatus(arg_61_0, arg_61_1, arg_61_2, arg_61_3, arg_61_4, arg_61_5)
	warning = var_1_10006

	var_1_10006("Set IKStatus " .. (arg_61_3 or "NIL"))
	arg_61_1:SetCurrentIkTimelineStatus(arg_61_3)

	arg_61_0.enableIKTip = true

	local var_61_0 = arg_61_0
	local var_61_1 = arg_61_0.Emit

	Dorm3dIKView = var_8

	var_61_1(var_61_0, var_8.SET_CONTROL_ACTIVE, true)
	arg_61_0:ResetIKTipTimer()

	arg_61_0.blockIK = nil
	pg = var_6

	local var_61_2 = var_6.dorm3d_ik_timeline_status[arg_61_3]

	arg_61_1.readyIKLayers = {}
	arg_61_1.iKTouchDatas = {}

	local var_61_3 = {}

	GetOrAddComponent = var_8

	local var_61_4 = arg_61_4

	typeof = var_1_10010
	UnityEngine = var_1_10011
	var_61_3.CameraRaycaster = var_8(var_61_4, var_1_10010(var_1_10011.EventSystems.PhysicsRaycaster))
	arg_61_1.IKSettings = var_61_3
	assert = var_61_3

	var_61_3(arg_61_1.IKSettings.CameraRaycaster)

	local var_61_5 = {}

	table = var_8

	local var_61_6 = var_8.IpairsCArray
	local var_61_7 = arg_61_2
	local var_61_8 = arg_61_2.GetComponentsInChildren

	typeof = var_11
	UnityEngine = var_1_10012

	var_61_6(var_61_8(var_61_7, var_11(var_1_10012.Collider), true), function(arg_62_0, arg_62_1)
		if arg_62_1.name == "SafeCollider" then
			setActive = var_2

			var_2(arg_62_1, false)

			return
		end

		local var_62_0 = arg_62_1:GetType()
		local var_62_1 = var_2.Equals

		typeof = var_2_10004
		UnityEngine = var_2_10005

		if var_62_1(var_62_0, var_2_10004(var_2_10005.MeshCollider)) then
			return
		end

		tf = var_2

		if var_2(arg_62_1).name then
			string = var_4

			local var_62_2

			if not var_4.find(var_3, "Collider") then
				var_62_2 = -1
			end

			if var_62_2 <= 0 then
				errorMsg = var_5

				var_5("Wrong Name to lady Collider : " .. var_3)

				return
			end

			string = var_5

			if var_5.sub(var_3, 1, var_62_2 - 1) == "Body" or var_5 == "Safe" then
				setActive = var_6

				var_6(var_2, false)

				return
			end

			DormConst = var_6

			if var_6.BONE_TO_TOUCH[var_5] == nil then
				return
			end

			local var_62_3 = var_61_5

			var_62_3[var_5] = var_2
			setActive = var_62_3

			var_62_3(var_2, true)

			return
		end
	end)

	arg_61_1.IKSettings.Colliders = var_61_5
	arg_61_1.ikTimelineMode = true
	_ = var_8

	local var_61_9 = var_8.map(var_61_2.ik_id, function(arg_63_0)
		Dorm3dIK = var_2_10001

		local var_63_0 = var_2_10001.New({
			configId = arg_63_0
		})

		table = var_2

		var_2.insert(arg_61_1.readyIKLayers, var_63_0)

		local var_63_1 = var_63_0:GetSubTargets()
		local var_63_2 = var_63_0:GetPlaneRotations()
		local var_63_3 = var_63_0
		local var_63_4 = var_63_0.GetPlaneScales(var_63_3)

		_ = var_63_3

		local var_63_5 = var_63_3.map

		_ = var_2_10006

		local var_63_6 = var_63_5(var_2_10006.range(#var_63_1), function(arg_64_0)
			return {
				name = var_63_1[arg_64_0][1],
				planeRot = var_63_2[arg_64_0],
				planeScale = var_63_4[arg_64_0]
			}
		end)

		Dorm3dIKController = var_6

		return var_6.New({
			ignoreDrag = false,
			triggerName = var_63_0:getConfig("trigger_param")[2],
			controllerName = var_63_0:GetControllerPath(),
			subTargets = var_63_6,
			actionType = var_63_0:GetActionTriggerParams()[1],
			controlRect = var_63_0:GetRect(),
			actionRect = var_63_0:GetTriggerRect(),
			backTime = var_63_0:GetRevertTime(),
			actionRevertTime = var_63_0:GetActionRevertTime(),
			timelineActionEvent = var_63_0:GetTimelineAction()
		})
	end)
	local var_61_10 = arg_61_2.transform
	local var_61_11 = var_9.Find(var_61_10, "IKLayers")
	local var_61_12 = {}
	local var_61_13 = {}

	table = var_12

	local var_61_14 = var_12.Foreach

	DormConst = var_1_10013

	var_61_14(var_1_10013.boneMap, function(arg_65_0, arg_65_1)
		var_61_13[arg_65_1] = arg_65_0

		return
	end)

	local var_61_15 = arg_61_2.transform
	local var_61_16 = var_12.GetComponentsInChildren

	typeof = var_14
	Transform = var_1_10015

	local var_61_17 = var_61_16(var_61_15, var_14(var_1_10015), true)

	table = var_61_15

	var_61_15.IpairsCArray(var_61_17, function(arg_66_0, arg_66_1)
		if var_61_13[arg_66_1.name] then
			var_61_12[var_61_13[arg_66_1.name]] = arg_66_1
		end

		return
	end)

	pg = var_13

	local var_61_18 = var_13.IKMgr.GetInstance()

	var_13.RegisterEnv(var_61_18, var_61_11, var_61_12)
	arg_61_0:RegisterIKFunc()

	pg = var_13

	local var_61_19 = var_13.IKMgr.GetInstance()

	var_13.SetIKStatus(var_61_19, var_61_9)

	local var_61_20 = arg_61_0
	local var_61_21 = arg_61_0.Emit

	Dorm3dIKView = var_15

	var_61_21(var_61_20, var_15.UPDATE_TEXT_TIPS, arg_61_1.readyIKLayers)

	existCall = var_61_21

	var_61_21(arg_61_5)

	return
end

function var_0_1.ExitIKTimelineStatus(arg_67_0, arg_67_1, arg_67_2)
	arg_67_1:SetCurrentIkTimelineStatus(nil)

	arg_67_0.enableIKTip = false

	local var_67_0 = arg_67_0
	local var_67_1 = arg_67_0.Emit

	Dorm3dIKView = var_5

	var_67_1(var_67_0, var_5.SET_CONTROL_ACTIVE, false)

	arg_67_0.blockIK = nil
	pg = var_3

	local var_67_2 = var_3.IKMgr.GetInstance()

	var_3.UnregisterEnv(var_67_2)

	arg_67_1.ikHandler = nil
	arg_67_1.ikTimelineMode = nil
	arg_67_1.readyIKLayers = nil
	arg_67_1.iKTouchDatas = nil
	arg_67_1.IKSettings = nil

	local var_67_3 = arg_67_0
	local var_67_4 = arg_67_0.Emit

	Dorm3dIKView = var_5

	var_67_4(var_67_3, var_5.SET_TIPS_ACTIVE, false)

	existCall = var_67_4

	var_67_4(arg_67_2)

	return
end

function var_0_1.EnableIKLayer(arg_68_0, arg_68_1)
	local var_68_0 = arg_68_0:GetCurrentLadyEnv()

	if #arg_68_1:GetHeadTrackPath() > 0 then
		arg_68_0:SettingHeadAimIK(var_68_0, {
			2,
			arg_68_1:GetHeadTrackPath()
		}, true)
	end

	if #arg_68_1:GetTriggerFaceAnim() > 0 then
		arg_68_0:Func("PlayFaceAnim", var_68_0, var_3)
	end

	if not arg_68_1.ignoreDrag then
		local var_68_1 = arg_68_0
		local var_68_2 = arg_68_0.Emit

		Dorm3dIKView = var_1_10006

		var_68_2(var_68_1, var_1_10006.PLAY_HAND_BEGIN)
	end

	if not var_68_0.ikTimelineMode then
		pg = var_4

		local var_68_3 = var_4.m02
		local var_68_4 = var_4.sendNotification

		GAME = var_1_10006

		local var_68_5 = var_1_10006.APARTMENT_TRACK

		Dorm3dTrackCommand = var_1_10007

		local var_68_6 = var_1_10007.BuildDataTouch
		local var_68_7 = arg_68_0:Get("apartment").configId
		local var_68_8 = arg_68_0:Get("apartment").level
		local var_68_9 = var_68_0.ikConfig.character_action
		local var_68_10 = arg_68_1:GetTriggerParams()[2]
		local var_68_11 = arg_68_0:GetRoom()

		var_68_4(var_68_3, var_68_5, var_68_6(var_68_7, var_68_8, var_68_9, var_68_10, var_12.GetConfigID(var_68_11)))
	end

	return
end

function var_0_1.DeactiveIKLayer(arg_69_0, arg_69_1)
	if not arg_69_0:GetCurrentLadyEnv().ikTimelineMode and #arg_69_1:GetHeadTrackPath() > 0 then
		arg_69_0:SettingHeadAimIK(var_2, var_2.ikConfig.head_track)
	end

	if not arg_69_1.ignoreDrag then
		local var_69_0 = arg_69_0
		local var_69_1 = arg_69_0.Emit

		Dorm3dIKView = var_1_10005

		var_69_1(var_69_0, var_1_10005.PLAY_HAND_END)
	end

	return
end

function var_0_1.ResetIKTipTimer(arg_70_0)
	if not arg_70_0.enableIKTip then
		return
	end

	Time = var_1
	arg_70_0.nextTipIKTime = var_1.time + var_0_1.IK_TIP_WAIT_TIME

	return
end

function var_0_1.EnableCurrentHeadIK(arg_71_0, arg_71_1)
	local var_71_0 = arg_71_0:GetCurrentLadyEnv()

	arg_71_0:EnableHeadIK(var_71_0, arg_71_1)

	return
end

function var_0_1.EnableHeadIK(arg_72_0, arg_72_1, arg_72_2)
	arg_72_1.ladyHeadIKComp.enableIk = arg_72_2

	return
end

function var_0_1.SettingHeadAimIK(arg_73_0, arg_73_1, arg_73_2, arg_73_3)
	local var_73_0

	if arg_73_2[1] == 0 then
		arg_73_0:EnableHeadIK(arg_73_1, false)

		return
	elseif arg_73_2[1] == 1 then
		arg_73_0:EnableHeadIK(arg_73_1, true)

		local var_73_1 = arg_73_0:Get("mainCameraTF")

		var_73_0 = var_5.Find(var_73_1, "AimTarget")
	elseif arg_73_2[1] == 2 then
		arg_73_0:EnableHeadIK(arg_73_1, true)

		table = var_5

		local var_73_2 = var_5.IpairsCArray
		local var_73_3 = arg_73_1.lady
		local var_73_4 = var_6.GetComponentsInChildren

		typeof = var_8
		Transform = var_1_10009

		var_73_2(var_73_4(var_73_3, var_8(var_1_10009), true), function(arg_74_0, arg_74_1)
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

function var_0_1.ResetHeadAimIK(arg_75_0, arg_75_1)
	arg_75_0:EnableHeadIK(arg_75_1, true)

	local var_75_0 = arg_75_1.ladyHeadIKComp
	local var_75_1 = arg_75_0:Get("mainCameraTF")

	var_75_0.AimTarget = var_3.Find(var_75_1, "AimTarget")
	arg_75_1.ladyHeadIKComp.HeadWeight = arg_75_1.ladyHeadIKData.HeadWeight
	arg_75_1.ladyHeadIKComp.BodyWeight = arg_75_1.ladyHeadIKData.BodyWeight

	return
end

function var_0_1.OnTriggerIK(arg_76_0, arg_76_1)
	if arg_76_0:GetCurrentLadyEnv().ikTimelineMode then
		arg_76_0:ExitIKTimelineStatus(var_2)

		if arg_76_1:GetTimelineAction() then
			local var_76_0 = arg_76_0:Get("nowTimelinePlayer")

			var_4.TriggerEvent(var_76_0, var_3)
		end

		return
	end

	if not var_2.ikConfig then
		return
	end

	local var_76_1 = arg_76_1:GetControllerPath()

	if not var_2.ikActionDict[var_76_1] then
		return
	end

	arg_76_0.blockIK = true

	arg_76_0:Emit(var_0_1.ON_IK_LAYER_ACTION, var_2, arg_76_1:GetConfigID(), var_4, function()
		local var_77_0 = arg_76_0

		var_0.ResetIKTipTimer(var_77_0)

		arg_76_0.blockIK = nil

		return
	end)

	return
end

function var_0_1.UpdateIKTarget(arg_78_0)
	if not arg_78_0:Get("apartment") then
		return
	end

	if not arg_78_0:GetCurrentLadyEnv() then
		return
	end

	if var_2.ikHandler then
		if not var_2.readyIKLayers then
			return
		end

		local var_78_0 = var_2.ikHandler.screenPosition

		pg = var_1_10004

		local var_78_1 = var_1_10004.UIMgr.GetInstance().uiCamera
		local var_78_2 = var_4.Find(var_78_1, "Canvas").rect

		Vector2 = var_6

		local var_78_3 = var_78_0 - var_6.New(var_78_2.width, var_78_2.height) * 0.5
		local var_78_4 = arg_78_0
		local var_78_5 = arg_78_0.Emit

		Dorm3dIKView = var_1_10009

		var_78_5(var_78_4, var_1_10009.SET_HAND_POSITION, var_78_3)

		Time = var_78_5

		if var_78_5.time > arg_78_0.ikNextCheckStamp then
			arg_78_0.ikNextCheckStamp = arg_78_0.ikNextCheckStamp + var_0_1.IK_STATUS_DELTA
			_ = var_7

			local var_78_6 = var_7.detect(var_2.readyIKLayers, function(arg_79_0)
				local var_79_0 = arg_79_0:GetControllerPath()
				local var_79_1 = var_0.ikHandler.ikData

				return var_79_0 == var_2.GetControllerPath(var_79_1)
			end)

			arg_78_0:Emit(var_0_1.ON_IK_STATUS_CHANGED, var_78_6:GetConfigID(), var_0_1.IK_STATUS.DRAG)
		end
	end

	if arg_78_0.enableIKTip then
		if not var_2.readyIKLayers or not var_2.IKSettings then
			return
		end

		arg_78_0:UpdateIKTips(var_2)
	end

	return
end

function var_0_1.UpdateIKTips(arg_80_0, arg_80_1)
	if not arg_80_0.nextTipIKTime then
		return
	end

	if not arg_80_0.blockIK then
		Time = var_2

		local var_80_0

		if not (var_2.time > arg_80_0.nextTipIKTime) then
			var_80_0 = false
		else
			var_80_0 = true
		end

		local var_80_1 = arg_80_0
		local var_80_2 = arg_80_0.Emit

		Dorm3dIKView = var_1_10005

		var_80_2(var_80_1, var_1_10005.UPDATE_TIPS, var_80_0, arg_80_1)

		return
	end
end

function var_0_1.CycleIKCameraGroup(arg_81_0)
	local var_81_0 = arg_81_0
	local var_81_1 = arg_81_0.GetCurrentLadyEnv(var_81_0)

	assert = var_81_0

	var_81_0(arg_81_0:Func("GetBlackboardValue", var_81_1, "inIK"))

	seriesAsync = var_81_0

	var_81_0({
		function(arg_82_0)
			pg = var_2_10001

			local var_82_0 = var_2_10001.IKMgr.GetInstance()

			var_1.ResetActiveIKs(var_82_0)

			local var_82_1 = var_81_1.ikConfig.camera_group

			pg = var_2_10003

			local var_82_2 = var_2_10003.dorm3d_ik_status.get_id_list_by_camera_group[var_82_1]

			table = var_2_10004

			local var_82_3 = var_82_2[var_2_10004.indexof(var_82_2, var_1.id) % #var_82_2 + 1]
			local var_82_4 = arg_81_0

			var_6.SwitchIKConfig(var_82_4, var_81_1, var_82_3)

			local var_82_5 = arg_81_0

			var_6.SetIKState(var_82_5, true)

			return
		end
	})

	return
end

function var_0_1.SetIKSwitchSkinId(arg_83_0, arg_83_1)
	arg_83_0.ikSwitchSkinId = arg_83_1

	return
end

function var_0_1.SwitchIKSkin(arg_84_0, arg_84_1, arg_84_2, arg_84_3)
	seriesAsync = var_1_10004

	var_1_10004({
		function(arg_85_0)
			local var_85_0 = arg_84_0

			var_1.SetIKState(var_85_0, false, arg_85_0)

			return
		end,
		function(arg_86_0)
			local var_86_0 = arg_84_1

			var_1.SwitchCharacterSkin(var_86_0, arg_84_2, arg_84_3)

			local var_86_1 = arg_84_0

			var_1.SwitchIKConfig(var_86_1, arg_84_1, arg_84_1.ikConfig.id)

			local var_86_2 = arg_84_0

			var_1.SetIKState(var_86_2, true, arg_86_0)

			return
		end
	})

	return
end

function var_0_1.ConsumeIKSpecialCall(arg_87_0)
	if not arg_87_0.ikSpecialCall then
		return false
	end

	local var_87_0 = arg_87_0.ikSpecialCall

	arg_87_0.ikSpecialCall = nil
	existCall = var_2

	var_2(var_87_0)

	return true
end

return var_0_1
