pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001

local var_0_1 = "CameraFixMgr"

import = var_0_10004
var_0.CameraFixMgr = var_0_10001(var_0_1, var_0_10004("view.base.BaseEventLogic"))
pg = var_0

local var_0_2 = var_0.CameraFixMgr

var_0_2.ASPECT_RATIO_UPDATE = "aspect_ratio_update"

function var_0_2.Init(arg_1_0, arg_1_1)
	arg_1_0.targetRatio = 1.7777777777777777

	arg_1_0:AddListener()
	arg_1_0:Adapt()
	arg_1_1()

	return
end

function var_0_2.AddListener(arg_2_0)
	arg_2_0:Clear()

	function arg_2_0.adaptCall(arg_3_0)
		local var_3_0 = arg_2_0

		var_1.AfterCall(var_3_0, arg_3_0)

		return
	end

	CameraMgr = var_1

	local var_2_0 = var_1.instance

	var_1.AddListener(var_2_0, arg_2_0.adaptCall)

	return
end

function var_0_2.Adapt(arg_4_0)
	CameraMgr = var_1_10001

	local var_4_0 = var_1_10001.instance

	var_1.Adapt(var_4_0)

	return
end

function var_0_2.AfterCall(arg_5_0, arg_5_1)
	arg_5_0.targetRatio = arg_5_1
	Screen = var_1_10002
	arg_5_0.currentWidth = var_1_10002.width
	Screen = var_2
	arg_5_0.currentHeight = var_2.height

	local var_5_0

	if arg_5_0.currentWidth / arg_5_0.currentHeight < arg_5_0.targetRatio then
		arg_5_0.actualWidth = arg_5_0.currentWidth
		arg_5_0.actualHeight = arg_5_0.currentWidth / arg_5_0.targetRatio
		var_5_0 = (arg_5_0.currentHeight - arg_5_0.actualHeight) * 0.5
		Vector3 = var_1_10004
		arg_5_0.leftBottomVector = var_1_10004(0, var_5_0, 0)
		Vector3 = var_1_10004
		arg_5_0.rightTopVector = var_1_10004(arg_5_0.currentWidth, arg_5_0.currentHeight - var_5_0, 0)
	else
		arg_5_0.actualWidth = arg_5_0.currentHeight * arg_5_0.targetRatio
		arg_5_0.actualHeight = arg_5_0.currentHeight
		var_5_0 = (arg_5_0.currentWidth - arg_5_0.actualWidth) * 0.5
		Vector3 = var_1_10004
		arg_5_0.leftBottomVector = var_1_10004(var_5_0, 0, 0)
		Vector3 = var_1_10004
		arg_5_0.rightTopVector = var_1_10004(arg_5_0.currentWidth - var_5_0, arg_5_0.currentHeight, 0)
	end

	NotchAdapt = var_5_0

	local var_5_1 = var_5_0.CheckNotchRatio

	ADAPT_NOTICE = var_1_10004

	if var_1_10004 < var_2 and var_5_1 < arg_5_0.targetRatio then
		arg_5_0.notchAdaptWidth = arg_5_0.currentHeight * var_5_1
		arg_5_0.notchAdaptHeight = arg_5_0.currentHeight

		local var_5_2 = (arg_5_0.currentWidth - arg_5_0.notchAdaptWidth) * 0.5

		Vector3 = var_5
		arg_5_0.notchAdaptLBVector = var_5(var_5_2, 0, 0)
		Vector3 = var_5
		arg_5_0.notchAdaptRTVector = var_5(arg_5_0.currentWidth - var_5_2, arg_5_0.currentHeight, 0)
	else
		arg_5_0.notchAdaptWidth = arg_5_0.actualWidth
		arg_5_0.notchAdaptHeight = arg_5_0.actualHeight
		arg_5_0.notchAdaptLBVector = arg_5_0.leftBottomVector
		arg_5_0.notchAdaptRTVector = arg_5_0.rightTopVector
	end

	arg_5_0:FixOverlayPadding(var_2)
	arg_5_0:emit(var_0_2.ASPECT_RATIO_UPDATE, arg_5_0.targetRatio)

	return
end

function var_0_2.GetBattleUIRatio(arg_6_0)
	return arg_6_0.targetRatio
end

function var_0_2.GetCurrentWidth(arg_7_0)
	return arg_7_0.currentWidth
end

function var_0_2.GetCurrentHeight(arg_8_0)
	return arg_8_0.currentHeight
end

function var_0_2.SetForceRatio(arg_9_0, arg_9_1)
	if not arg_9_1 then
		CameraMgr = var_1_10002

		local var_9_0 = var_1_10002.instance

		var_1_10002.SetForceRatio(var_9_0, -1)
	else
		CameraMgr = var_1_10002

		local var_9_1 = var_1_10002.instance

		var_2.SetForceRatio(var_9_1, arg_9_1)
	end

	return
end

function var_0_2.BlockCameraRatioControll(arg_10_0, arg_10_1)
	CameraMgr = var_1_10002

	local var_10_0 = var_1_10002.instance

	if arg_10_1 then
		System = var_1_10003
		var_1_10003 = var_1_10003.Array.CreateInstance
		typeof = var_1_10005
		var_1_10003 = var_1_10003(var_1_10005("System.Single"), 2)
		var_1_10003[0] = 0
		var_1_10003[1] = 100
		ReflectionHelp = var_4

		var_4.RefSetField(var_10_0:GetType(), "AspectRatioRange", var_10_0, var_1_10003)
	else
		System = var_1_10003

		local var_10_1 = var_1_10003.Array.CreateInstance

		typeof = var_1_10005

		local var_10_2 = var_10_1(var_1_10005("System.Single"), 2)

		var_10_2[0] = 1.3333333333333333
		var_10_2[1] = 2.3333333333333335
		ReflectionHelp = var_4

		var_4.RefSetField(var_10_0:GetType(), "AspectRatioRange", var_10_0, var_10_2)
	end

	arg_10_0:Adapt()

	return
end

function var_0_2.Clear(arg_11_0)
	if arg_11_0.adaptCall then
		CameraMgr = var_1

		local var_11_0 = var_1.instance

		var_1.RemoveListener(var_11_0, arg_11_0.adaptCall)

		arg_11_0.adaptCall = nil
	end

	return
end

function var_0_2.Dispose(arg_12_0)
	arg_12_0:Clear()

	return
end

local var_0_3 = 1920
local var_0_4 = 1080

local function var_0_5(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0

	if arg_13_0 then
		::label_13_0::

		IsNil = var_13_0
		var_13_0 = not var_13_0(arg_13_0)
	end

	local var_13_1 = var_0_3
	local var_13_2 = var_0_4

	if var_13_0 then
		var_13_1 = arg_13_0.referenceResolution.x
		var_13_2 = var_6.y
	end

	if var_13_1 <= 0 or var_13_2 <= 0 then
		var_13_1 = var_0_3
		var_13_2 = var_0_4
	end

	local var_13_3 = arg_13_1 / var_13_1
	local var_13_4 = arg_13_2 / var_13_2

	if var_13_0 then
		var_1_10008 = arg_13_0.screenMatchMode
		CanvasScaler = var_1_10009

		if var_1_10008 == var_1_10009.ScreenMatchMode.MatchWidthOrHeight then
			math = var_1_10008
			var_1_10008 = var_1_10008.log(var_13_3)
			math = var_1_10009
			var_1_10008 = var_1_10008 / var_1_10009.log(2)
			math = var_1_10009
			var_1_10009 = var_1_10009.log(var_13_4)
			math = var_10
			var_1_10009 = var_1_10009 / var_10.log(2)

			local var_13_5 = arg_13_0.matchWidthOrHeight

			math = var_11

			do return var_11.pow(2, var_1_10008 + (var_1_10009 - var_1_10008) * var_13_5) end

			goto label_13_1
		end
	end

	if var_13_0 then
		var_1_10008 = arg_13_0.screenMatchMode
		CanvasScaler = var_1_10009

		if var_1_10008 == var_1_10009.ScreenMatchMode.Shrink then
			math = var_1_10008

			do return var_1_10008.max(var_13_3, var_13_4) end

			goto label_13_1
		end
	end

	math = var_1_10008

	do return var_1_10008.min(var_13_3, var_13_4) end

	::label_13_1::

	return
end

function var_0_2.FixOverlayPadding(arg_14_0, arg_14_1)
	if arg_14_0.paddingCanvas then
		IsNil = var_2

		if var_2(arg_14_0.paddingCanvas) then
			GameObject = var_2

			if var_2.Find("/OverlayCamera/Adpter") then
				IsNil = var_1_10003

				if var_1_10003(var_2) then
					return
				end

				rtf = var_1_10003
				arg_14_0.paddingCanvas = var_1_10003(var_2)

				local var_14_0 = var_2
				local var_14_1 = var_2.GetComponent

				typeof = var_1_10006
				CanvasScaler = var_1_10008
				arg_14_0.paddingCanvasScaler = var_14_1(var_14_0, var_1_10006(var_1_10008))

				local var_14_2 = arg_14_0.paddingCanvas

				arg_14_0.paddingTop = var_3.Find(var_14_2, "top")

				local var_14_3 = arg_14_0.paddingCanvas

				arg_14_0.paddingBottom = var_3.Find(var_14_3, "bottom")

				local var_14_4 = arg_14_0.paddingCanvas

				arg_14_0.paddingLeft = var_3.Find(var_14_4, "left")

				local var_14_5 = arg_14_0.paddingCanvas

				arg_14_0.paddingRight = var_3.Find(var_14_5, "right")
				IsNil = var_2

				if not var_2(arg_14_0.paddingTop) then
					IsNil = var_2

					if not var_2(arg_14_0.paddingBottom) then
						IsNil = var_2

						if not var_2(arg_14_0.paddingLeft) then
							IsNil = var_2

							if var_2(arg_14_0.paddingRight) then
								return
							end

							if var_0_5(arg_14_0.paddingCanvasScaler, arg_14_0.currentWidth, arg_14_0.currentHeight) <= 0 then
								return
							end

							local var_14_6 = arg_14_0.currentWidth / var_2
							local var_14_7 = arg_14_0.currentHeight / var_2
							local var_14_8
							local var_14_9

							if arg_14_1 < arg_14_0.targetRatio then
								var_14_8 = var_14_6
								var_14_9 = var_14_6 / arg_14_0.targetRatio
							else
								var_14_9 = var_14_7
								var_14_8 = var_14_7 * arg_14_0.targetRatio
							end

							math = var_7

							local var_14_10 = var_7.max((var_14_6 - var_14_8) * 0.5, 0)

							math = var_1_10008

							local var_14_11 = var_1_10008.max((var_14_7 - var_14_9) * 0.5, 0)
							local var_14_12 = arg_14_0.paddingLeft

							Vector2 = var_10
							var_14_12.sizeDelta = var_10(var_14_10, arg_14_0.paddingLeft.sizeDelta.y)

							local var_14_13 = arg_14_0.paddingRight

							Vector2 = var_10
							var_14_13.sizeDelta = var_10(var_14_10, arg_14_0.paddingRight.sizeDelta.y)

							local var_14_14 = arg_14_0.paddingTop

							Vector2 = var_10
							var_14_14.sizeDelta = var_10(arg_14_0.paddingTop.sizeDelta.x, var_14_11)

							local var_14_15 = arg_14_0.paddingBottom

							Vector2 = var_10
							var_14_15.sizeDelta = var_10(arg_14_0.paddingBottom.sizeDelta.x, var_14_11)

							return
						end
					end
				end
			end
		end
	end
end

return
