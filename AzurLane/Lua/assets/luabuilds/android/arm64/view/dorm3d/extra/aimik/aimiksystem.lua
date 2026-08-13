class = var_0_10000

local var_0_0 = "AimIKSystem"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.dorm3d.Extra.BaseExtraSystem"))

var_0_1.GET_TIP_SHOW_INFO = "AimIKSystem.GetTipShowInfo"
var_0_1.ON_BEGIN_DRAG = "AimIKSystem.OnBeginDrag"
var_0_1.ON_DRAG = "AimIKSystem.OnDrag"
var_0_1.ON_END_DRAG = "AimIKSystem.OnEndDrag"
var_0_1.ENTER_TIMELINE_AIMIK_STATUS = "AimIKSystem.EnterTimelineAimIKStatus"
var_0_1.EXIT_TIMELINE_AIMIK_STATUS = "AimIKSystem.ExitTimelineAimIKStatus"

function var_0_1.OnInit(arg_1_0)
	arg_1_0.inStatus = false
	arg_1_0.inExitProcessing = false
	arg_1_0.exitProcessToken = 0

	return
end

function var_0_1.RegisterEvents(arg_2_0)
	arg_2_0:Bind(var_0_1.GET_TIP_SHOW_INFO, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_2_0

		return var_2.GetTipShowInfo(var_3_0, arg_3_1)
	end)
	arg_2_0:Bind(var_0_1.ON_BEGIN_DRAG, function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_2_0

		var_3.OnBeginDrag(var_4_0, arg_4_1, arg_4_2)

		return
	end)
	arg_2_0:Bind(var_0_1.ON_DRAG, function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = arg_2_0

		var_3.OnDrag(var_5_0, arg_5_1, arg_5_2)

		return
	end)
	arg_2_0:Bind(var_0_1.ON_END_DRAG, function(arg_6_0, arg_6_1, arg_6_2)
		local var_6_0 = arg_2_0

		var_3.OnEndDrag(var_6_0, arg_6_1, arg_6_2)

		return
	end)
	arg_2_0:Bind(var_0_1.ENTER_TIMELINE_AIMIK_STATUS, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_2_0

		var_2.EnterTimelineAimIKStatus(var_7_0, arg_7_1)

		return
	end)
	arg_2_0:Bind(var_0_1.EXIT_TIMELINE_AIMIK_STATUS, function()
		local var_8_0 = arg_2_0

		var_0.ExitTimelineAimIKStatus(var_8_0)

		return
	end)

	return
end

function var_0_1.OnHandleNotification(arg_9_0, arg_9_1, arg_9_2)
	Dorm3dRoomTemplateScene = var_1_10003

	if arg_9_1 == var_1_10003.TIMELINE_END then
		if not arg_9_0.inStatus and not arg_9_0.inExitProcessing then
			return
		end

		arg_9_0:ForceExitTimelineAimIKStatus()
	end

	return
end

function var_0_1.GetInterests()
	local var_10_0 = {}

	Dorm3dRoomTemplateScene = var_1_10001
	var_10_0[1] = var_1_10001.TIMELINE_END

	return var_10_0
end

function var_0_1.OnDispose(arg_11_0)
	arg_11_0:InvalidateExitProcess()
	arg_11_0:StopWeightLerp()

	if arg_11_0.triggerAction and arg_11_0.dragComp then
		local var_11_0 = arg_11_0.dragComp

		var_1.UnregisterOnTargetReachBoundary(var_11_0, arg_11_0.triggerAction)

		arg_11_0.triggerAction = nil
	end

	return
end

function var_0_1.EnterTimelineAimIKStatus(arg_12_0, arg_12_1)
	warning = var_1_10002

	var_1_10002("enteraimikstatus")

	if arg_12_0.inStatus then
		warning = var_2

		var_2("重复进入TimelineAimIK状态")

		return
	end

	arg_12_0.inStatus = true
	pg = var_2
	arg_12_0.config = var_2.dorm3d_aim_ik[arg_12_1]
	assert = var_2

	local var_12_0 = arg_12_0.config
	local var_12_1 = "AimIK config is nil for id: "

	tostring = var_1_10006

	var_2(var_12_0, var_12_1 .. var_1_10006(arg_12_1))

	Dorm3dHxHelper = var_2
	arg_12_0.character = var_2.GetTimelineMainCharacter()
	assert = var_2

	var_2(arg_12_0.character, "Timeline main character not found")

	local var_12_2 = arg_12_0.character

	arg_12_0.configRoot = var_2.Find(var_12_2, "AimIKLayers/" .. arg_12_0.config.layer_config)
	assert = var_2

	var_2(arg_12_0.configRoot, "AimIK config root not found in character")

	local var_12_3 = arg_12_0.configRoot

	arg_12_0.dragGo = var_2.Find(var_12_3, "plane")

	local var_12_4 = arg_12_0.dragGo
	local var_12_5 = var_2.GetComponent

	typeof = var_5
	CanvasRectDragTarget = var_1_10007
	arg_12_0.dragComp = var_12_5(var_12_4, var_5(var_1_10007))

	local var_12_6 = arg_12_0.configRoot

	arg_12_0.headAimIKGo = var_2.Find(var_12_6, "headAim")

	local var_12_7 = arg_12_0.headAimIKGo
	local var_12_8 = var_2.GetComponent

	typeof = var_5
	HeadAimIKHotfix = var_1_10007
	arg_12_0.headAimIKComp = var_12_8(var_12_7, var_5(var_1_10007))

	local var_12_9 = arg_12_0.configRoot

	arg_12_0.stickAimGo = var_2.Find(var_12_9, "stickAim")

	local var_12_10 = arg_12_0.stickAimGo
	local var_12_11 = var_2.GetComponent

	typeof = var_5
	StickAim = var_1_10007
	arg_12_0.stickAimComp = var_12_11(var_12_10, var_5(var_1_10007))
	GameObject = var_2
	arg_12_0.stickSceneGo = var_2.Find(arg_12_0.config.item_path)

	local var_12_12 = arg_12_0.stickAimComp

	var_12_12.bindTransform = arg_12_0.stickSceneGo.transform
	Camera = var_12_12
	arg_12_0.mainCamera = var_12_12.main
	arg_12_0.headAimIKComp.weight = 0

	local var_12_13 = arg_12_0.stickAimComp

	var_12_13.weight = 0
	setActive = var_12_13

	var_12_13(arg_12_0.configRoot, true)
	arg_12_0:LerpAimWeight(0, 1, arg_12_0.config.fade_in, function()
		local var_13_0 = arg_12_0
		local var_13_1 = var_0.Emit

		Dorm3dAimIKView = var_2_10003

		var_13_1(var_13_0, var_2_10003.BIND_DRAG_AREA, arg_12_0.dragComp)

		local var_13_2 = arg_12_0
		local var_13_3 = var_0.Emit

		Dorm3dAimIKView = var_3

		var_13_3(var_13_2, var_3.SHOW_OR_HIDE, true)

		local var_13_4 = arg_12_0

		System = var_2_10001
		var_13_4.triggerAction = var_2_10001.Action(function()
			local var_14_0 = arg_12_0
			local var_14_1 = var_0.Emit

			Dorm3dRoomTemplateScene = var_3_10003

			var_14_1(var_14_0, var_3_10003.TRIGGER_TIMELINE_PLAYER_EVENT, {
				intParameter = 1919810,
				floatParameter = 0,
				stringParameter = "TimelineSelect"
			})

			local var_14_2 = arg_12_0

			var_0.ExitTimelineAimIKStatus(var_14_2)

			return
		end)

		local var_13_5 = arg_12_0.dragComp

		var_0.RegisterOnTargetReachBoundary(var_13_5, arg_12_0.triggerAction)

		return
	end)

	return
end

function var_0_1.ExitTimelineAimIKStatus(arg_15_0, arg_15_1)
	warning = var_1_10002

	var_1_10002("exitaimikstatus")

	arg_15_0.inStatus = false

	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_0.Emit

	Dorm3dAimIKView = var_1_10005

	var_15_1(var_15_0, var_1_10005.SHOW_OR_HIDE, false)

	if arg_15_0.triggerAction and arg_15_0.dragComp then
		local var_15_2 = arg_15_0.dragComp

		var_2.UnregisterOnTargetReachBoundary(var_15_2, arg_15_0.triggerAction)

		arg_15_0.triggerAction = nil
	end

	if arg_15_1 then
		arg_15_0:InvalidateExitProcess()
		arg_15_0:FinishExitTimelineAimIKStatus()
	else
		arg_15_0.cachedDampTime = {
			arg_15_0.headAimIKComp.DampTime,
			arg_15_0.stickAimComp.rotateDampTime,
			arg_15_0.stickAimComp.followDampTime
		}
		math = var_2
		arg_15_0.maxDampTime = var_2.max(arg_15_0.cachedDampTime[1], arg_15_0.cachedDampTime[2], arg_15_0.cachedDampTime[3])

		local var_15_3 = arg_15_0.headAimIKComp.weight

		arg_15_0:InvalidateExitProcess()

		arg_15_0.inExitProcessing = true

		local var_15_4 = arg_15_0.exitProcessToken

		seriesAsync = var_4

		var_4({
			function(arg_16_0)
				local var_16_0 = arg_15_0

				if not var_1.IsExitProcessValid(var_16_0, var_15_4) then
					return
				end

				local var_16_1 = arg_15_0

				var_1.LerpAimWeight(var_16_1, var_15_3, var_15_3, arg_15_0.maxDampTime, function()
					local var_17_0 = arg_15_0

					if not var_0.IsExitProcessValid(var_17_0, var_15_4) then
						return
					end

					arg_16_0()

					return
				end)

				return
			end,
			function(arg_18_0)
				local var_18_0 = arg_15_0

				if not var_1.IsExitProcessValid(var_18_0, var_15_4) then
					return
				end

				local var_18_1 = arg_15_0

				var_1.SetDampTime(var_18_1, {
					0,
					0,
					0
				})

				local var_18_2

				if not arg_15_0.headAimIKComp or not arg_15_0.headAimIKComp.weight then
					var_18_2 = 1
				end

				local var_18_3 = arg_15_0

				var_2.LerpAimWeight(var_18_3, var_18_2, 0, arg_15_0.config.fade_out, function()
					local var_19_0 = arg_15_0

					if not var_0.IsExitProcessValid(var_19_0, var_15_4) then
						return
					end

					arg_18_0()

					return
				end)

				return
			end,
			function(arg_20_0)
				local var_20_0 = arg_15_0

				if not var_1.IsExitProcessValid(var_20_0, var_15_4) then
					return
				end

				local var_20_1 = arg_15_0

				var_1.FinishExitTimelineAimIKStatus(var_20_1)
				arg_20_0()

				return
			end
		}, function()
			if arg_15_0.exitProcessToken ~= var_15_4 then
				return
			end

			arg_15_0.inExitProcessing = false

			return
		end)
	end

	return
end

function var_0_1.ForceExitTimelineAimIKStatus(arg_22_0)
	if not arg_22_0.inStatus and not arg_22_0.inExitProcessing then
		return
	end

	arg_22_0:ExitTimelineAimIKStatus(true)

	return
end

function var_0_1.FinishExitTimelineAimIKStatus(arg_23_0)
	arg_23_0:StopWeightLerp()

	if arg_23_0.cachedDampTime then
		arg_23_0:SetDampTime(arg_23_0.cachedDampTime)
	end

	if arg_23_0.headAimIKComp then
		arg_23_0.headAimIKComp.weight = 0
	end

	if arg_23_0.stickAimComp then
		arg_23_0.stickAimComp.weight = 0
	end

	if arg_23_0.configRoot then
		setActive = var_1

		var_1(arg_23_0.configRoot, false)
	end

	arg_23_0.cachedDampTime = nil
	arg_23_0.maxDampTime = nil

	return
end

function var_0_1.InvalidateExitProcess(arg_24_0)
	local var_24_0

	if not arg_24_0.exitProcessToken then
		var_24_0 = 0
	end

	arg_24_0.exitProcessToken = var_24_0 + 1
	arg_24_0.inExitProcessing = false

	return
end

function var_0_1.IsExitProcessValid(arg_25_0, arg_25_1)
	local var_25_0

	if arg_25_0.inExitProcessing then
		var_25_0 = arg_25_0.exitProcessToken == arg_25_1
	end

	return var_25_0
end

function var_0_1.OnBeginDrag(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_0.dragComp

	var_3.OnPointerDown(var_26_0, arg_26_2)

	return
end

function var_0_1.OnDrag(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_0.dragComp

	var_3.OnDrag(var_27_0, arg_27_2)

	return
end

function var_0_1.OnEndDrag(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_0.dragComp

	var_3.OnPointerUp(var_28_0, arg_28_2)

	return
end

function var_0_1.GetTipShowInfo(arg_29_0, arg_29_1)
	local var_29_0 = {}

	table = var_1_10003

	var_1_10003.insert(var_29_0, {
		pos = arg_29_0:Func("GetScreenPosition", arg_29_0.stickSceneGo.transform.position, arg_29_0.mainCamera)
	})

	if arg_29_1 then
		table = var_3

		var_3.insert(arg_29_1, var_29_0)
	end

	return var_29_0
end

function var_0_1.StopWeightLerp(arg_30_0)
	if not arg_30_0.weightLerpTweenId then
		return
	end

	LeanTween = var_1

	if var_1.isTweening(arg_30_0.weightLerpTweenId) then
		LeanTween = var_1

		var_1.cancel(arg_30_0.weightLerpTweenId)
	end

	arg_30_0.weightLerpTweenId = nil

	return
end

function var_0_1.LerpAimWeight(arg_31_0, arg_31_1, arg_31_2, arg_31_3, arg_31_4)
	arg_31_0:StopWeightLerp()
	;(function(arg_32_0)
		arg_31_0.headAimIKComp.weight = arg_32_0
		arg_31_0.stickAimComp.weight = arg_32_0

		return
	end)(arg_31_1)

	LeanTween = var_6

	local var_31_0 = var_6.value

	go = var_8

	local var_31_1 = var_31_0(var_8(arg_31_0.configRoot), arg_31_1, arg_31_2, arg_31_3)
	local var_31_2 = var_6.setEase

	LeanTweenType = var_9

	local var_31_3 = var_31_2(var_31_1, var_9.easeInOutSine)
	local var_31_4 = var_6.setOnUpdate

	System = var_9

	local var_31_5 = var_31_4(var_31_3, var_9.Action_float(function(arg_33_0)
		var_0(arg_33_0)

		return
	end))
	local var_31_6 = var_6.setOnComplete

	System = var_9
	arg_31_0.weightLerpTweenId = var_31_6(var_31_5, var_9.Action(function()
		arg_31_0.weightLerpTweenId = nil

		var_0(arg_31_2)

		if arg_31_4 then
			arg_31_4()
		end

		return
	end)).uniqueId

	return
end

function var_0_1.SetDampTime(arg_35_0, arg_35_1)
	arg_35_0.headAimIKComp.DampTime = arg_35_1[1]
	arg_35_0.stickAimComp.rotateDampTime = arg_35_1[2]
	arg_35_0.stickAimComp.followDampTime = arg_35_1[3]

	return
end

return var_0_1
