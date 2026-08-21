local var_0_0 = class("AimIKSystem", import("view.dorm3d.Extra.BaseExtraSystem"))

var_0_0.GET_TIP_SHOW_INFO = "AimIKSystem.GetTipShowInfo"
var_0_0.ON_BEGIN_DRAG = "AimIKSystem.OnBeginDrag"
var_0_0.ON_DRAG = "AimIKSystem.OnDrag"
var_0_0.ON_END_DRAG = "AimIKSystem.OnEndDrag"
var_0_0.ENTER_TIMELINE_AIMIK_STATUS = "AimIKSystem.EnterTimelineAimIKStatus"
var_0_0.EXIT_TIMELINE_AIMIK_STATUS = "AimIKSystem.ExitTimelineAimIKStatus"

function var_0_0.OnInit(arg_1_0)
	arg_1_0.inStatus = false
	arg_1_0.inExitProcessing = false
	arg_1_0.exitProcessToken = 0

	return
end

function var_0_0.RegisterEvents(arg_2_0)
	arg_2_0:Bind(var_0_0.GET_TIP_SHOW_INFO, function(arg_3_0, arg_3_1)
		return arg_2_0:GetTipShowInfo(arg_3_1)
	end)
	arg_2_0:Bind(var_0_0.ON_BEGIN_DRAG, function(arg_4_0, arg_4_1, arg_4_2)
		arg_2_0:OnBeginDrag(arg_4_1, arg_4_2)

		return
	end)
	arg_2_0:Bind(var_0_0.ON_DRAG, function(arg_5_0, arg_5_1, arg_5_2)
		arg_2_0:OnDrag(arg_5_1, arg_5_2)

		return
	end)
	arg_2_0:Bind(var_0_0.ON_END_DRAG, function(arg_6_0, arg_6_1, arg_6_2)
		arg_2_0:OnEndDrag(arg_6_1, arg_6_2)

		return
	end)
	arg_2_0:Bind(var_0_0.ENTER_TIMELINE_AIMIK_STATUS, function(arg_7_0, arg_7_1)
		arg_2_0:EnterTimelineAimIKStatus(arg_7_1)

		return
	end)
	arg_2_0:Bind(var_0_0.EXIT_TIMELINE_AIMIK_STATUS, function()
		arg_2_0:ExitTimelineAimIKStatus()

		return
	end)

	return
end

function var_0_0.OnHandleNotification(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 == Dorm3dRoomTemplateScene.TIMELINE_END then
		if not arg_9_0.inStatus and not arg_9_0.inExitProcessing then
			return
		end

		arg_9_0:ForceExitTimelineAimIKStatus()
	end

	return
end

function var_0_0.GetInterests()
	return {
		Dorm3dRoomTemplateScene.TIMELINE_END
	}
end

function var_0_0.OnDispose(arg_11_0)
	arg_11_0:InvalidateExitProcess()
	arg_11_0:StopWeightLerp()

	if arg_11_0.triggerAction and arg_11_0.dragComp then
		arg_11_0.dragComp:UnregisterOnTargetReachBoundary(arg_11_0.triggerAction)

		arg_11_0.triggerAction = nil
	end

	return
end

function var_0_0.EnterTimelineAimIKStatus(arg_12_0, arg_12_1)
	warning("enteraimikstatus")

	if arg_12_0.inStatus then
		warning("重复进入TimelineAimIK状态")

		return
	end

	arg_12_0.inStatus = true
	arg_12_0.config = pg.dorm3d_aim_ik[arg_12_1]

	assert(arg_12_0.config, "AimIK config is nil for id: " .. tostring(arg_12_1))

	arg_12_0.character = Dorm3dHxHelper.GetTimelineMainCharacter()

	assert(arg_12_0.character, "Timeline main character not found")

	arg_12_0.configRoot = arg_12_0.character:Find("AimIKLayers/" .. arg_12_0.config.layer_config)

	assert(arg_12_0.configRoot, "AimIK config root not found in character")

	arg_12_0.dragGo = arg_12_0.configRoot:Find("plane")
	arg_12_0.dragComp = arg_12_0.dragGo:GetComponent(typeof(CanvasRectDragTarget))
	arg_12_0.headAimIKGo = arg_12_0.configRoot:Find("headAim")
	arg_12_0.headAimIKComp = arg_12_0.headAimIKGo:GetComponent(typeof(HeadAimIKHotfix))
	arg_12_0.stickAimGo = arg_12_0.configRoot:Find("stickAim")
	arg_12_0.stickAimComp = arg_12_0.stickAimGo:GetComponent(typeof(StickAim))
	arg_12_0.stickSceneGo = GameObject.Find(arg_12_0.config.item_path)
	arg_12_0.stickAimComp.bindTransform = arg_12_0.stickSceneGo.transform
	arg_12_0.mainCamera = Camera.main
	arg_12_0.headAimIKComp.weight = 0
	arg_12_0.stickAimComp.weight = 0

	setActive(arg_12_0.configRoot, true)
	arg_12_0:LerpAimWeight(0, 1, arg_12_0.config.fade_in, function()
		arg_12_0:Emit(Dorm3dAimIKView.BIND_DRAG_AREA, arg_12_0.dragComp)
		arg_12_0:Emit(Dorm3dAimIKView.SHOW_OR_HIDE, true)

		arg_12_0.triggerAction = System.Action(function()
			arg_12_0:Emit(Dorm3dRoomTemplateScene.TRIGGER_TIMELINE_PLAYER_EVENT, {
				intParameter = 1919810,
				floatParameter = 0,
				stringParameter = "TimelineSelect"
			})
			arg_12_0:ExitTimelineAimIKStatus()

			return
		end)

		arg_12_0.dragComp:RegisterOnTargetReachBoundary(arg_12_0.triggerAction)

		return
	end)

	return
end

function var_0_0.ExitTimelineAimIKStatus(arg_15_0, arg_15_1)
	warning("exitaimikstatus")

	arg_15_0.inStatus = false

	arg_15_0:Emit(Dorm3dAimIKView.SHOW_OR_HIDE, false)

	if arg_15_0.triggerAction and arg_15_0.dragComp then
		arg_15_0.dragComp:UnregisterOnTargetReachBoundary(arg_15_0.triggerAction)

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
		arg_15_0.maxDampTime = math.max(arg_15_0.cachedDampTime[1], arg_15_0.cachedDampTime[2], arg_15_0.cachedDampTime[3])

		local var_15_0 = arg_15_0.headAimIKComp.weight

		arg_15_0:InvalidateExitProcess()

		arg_15_0.inExitProcessing = true

		local var_15_1 = arg_15_0.exitProcessToken

		seriesAsync({
			function(arg_16_0)
				if not arg_15_0:IsExitProcessValid(var_15_1) then
					return
				end

				arg_15_0:LerpAimWeight(var_15_0, var_15_0, arg_15_0.maxDampTime, function()
					if not arg_15_0:IsExitProcessValid(var_15_1) then
						return
					end

					arg_16_0()

					return
				end)

				return
			end,
			function(arg_18_0)
				if not arg_15_0:IsExitProcessValid(var_15_1) then
					return
				end

				arg_15_0:SetDampTime({
					0,
					0,
					0
				})

				if arg_15_0.headAimIKComp then
					local var_18_0 = arg_15_0.headAimIKComp.weight or 1

					arg_15_0:LerpAimWeight(var_18_0, 0, arg_15_0.config.fade_out, function()
						if not arg_15_0:IsExitProcessValid(var_15_1) then
							return
						end

						arg_18_0()

						return
					end)

					return
				end
			end,
			function(arg_20_0)
				if not arg_15_0:IsExitProcessValid(var_15_1) then
					return
				end

				arg_15_0:FinishExitTimelineAimIKStatus()
				arg_20_0()

				return
			end
		}, function()
			if arg_15_0.exitProcessToken ~= var_15_1 then
				return
			end

			arg_15_0.inExitProcessing = false

			return
		end)
	end

	return
end

function var_0_0.ForceExitTimelineAimIKStatus(arg_22_0)
	if not arg_22_0.inStatus and not arg_22_0.inExitProcessing then
		return
	end

	arg_22_0:ExitTimelineAimIKStatus(true)

	return
end

function var_0_0.FinishExitTimelineAimIKStatus(arg_23_0)
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
		setActive(arg_23_0.configRoot, false)
	end

	arg_23_0.cachedDampTime = nil
	arg_23_0.maxDampTime = nil

	return
end

function var_0_0.InvalidateExitProcess(arg_24_0)
	local var_24_0 = arg_24_0.exitProcessToken or 0

	arg_24_0.exitProcessToken = var_24_0 + 1
	arg_24_0.inExitProcessing = false

	return
end

function var_0_0.IsExitProcessValid(arg_25_0, arg_25_1)
	return arg_25_0.inExitProcessing and arg_25_0.exitProcessToken == arg_25_1
end

function var_0_0.OnBeginDrag(arg_26_0, arg_26_1, arg_26_2)
	arg_26_0.dragComp:OnPointerDown(arg_26_2)

	return
end

function var_0_0.OnDrag(arg_27_0, arg_27_1, arg_27_2)
	arg_27_0.dragComp:OnDrag(arg_27_2)

	return
end

function var_0_0.OnEndDrag(arg_28_0, arg_28_1, arg_28_2)
	arg_28_0.dragComp:OnPointerUp(arg_28_2)

	return
end

function var_0_0.GetTipShowInfo(arg_29_0, arg_29_1)
	table.insert({}, {
		pos = arg_29_0:Func("GetScreenPosition", arg_29_0.stickSceneGo.transform.position, arg_29_0.mainCamera)
	})

	if arg_29_1 then
		table.insert(arg_29_1, {})
	end

	return {}
end

function var_0_0.StopWeightLerp(arg_30_0)
	if not arg_30_0.weightLerpTweenId then
		return
	end

	if LeanTween.isTweening(arg_30_0.weightLerpTweenId) then
		LeanTween.cancel(arg_30_0.weightLerpTweenId)
	end

	arg_30_0.weightLerpTweenId = nil

	return
end

function var_0_0.LerpAimWeight(arg_31_0, arg_31_1, arg_31_2, arg_31_3, arg_31_4)
	arg_31_0:StopWeightLerp()
	;(function(arg_32_0)
		arg_31_0.headAimIKComp.weight = arg_32_0
		arg_31_0.stickAimComp.weight = arg_32_0

		return
	end)(arg_31_1)

	arg_31_0.weightLerpTweenId = LeanTween.value(go(arg_31_0.configRoot), arg_31_1, arg_31_2, arg_31_3):setEase(LeanTweenType.easeInOutSine):setOnUpdate(System.Action_float(function(arg_33_0)
		var_0(arg_33_0)

		return
	end)):setOnComplete(System.Action(function()
		arg_31_0.weightLerpTweenId = nil

		var_0(arg_31_2)

		if arg_31_4 then
			arg_31_4()
		end

		return
	end)).uniqueId

	return
end

function var_0_0.SetDampTime(arg_35_0, arg_35_1)
	arg_35_0.headAimIKComp.DampTime = arg_35_1[1]
	arg_35_0.stickAimComp.rotateDampTime = arg_35_1[2]
	arg_35_0.stickAimComp.followDampTime = arg_35_1[3]

	return
end

return var_0_0
