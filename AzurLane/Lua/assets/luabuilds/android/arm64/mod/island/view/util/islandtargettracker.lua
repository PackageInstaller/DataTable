class = var_0_10000

local var_0_0 = var_0_10000("IslandTargetTracker")
local var_0_1 = {
	200,
	200
}
local var_0_2 = 25
local var_0_3 = 2
local var_0_4 = 6
local var_0_5 = 2

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._tf = arg_1_1
	arg_1_0.distanceTr = arg_1_0._tf
	setActive = var_2

	var_2(arg_1_0.distanceTr, true)

	GetOrAddComponent = var_2

	local var_1_0 = arg_1_0.distanceTr

	typeof = var_5
	CanvasGroup = var_1_10007
	arg_1_0.cg = var_2(var_1_0, var_5(var_1_10007))

	local var_1_1 = arg_1_0.cg

	var_1_1.alpha = 0
	findTF = var_1_1
	arg_1_0.arrTr = var_1_1(arg_1_0.distanceTr, "arr")

	local var_1_2 = arg_1_0.distanceTr
	local var_1_3 = var_2.Find(var_1_2, "Text")
	local var_1_4 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.distanceTxt = var_1_4(var_1_3, var_5(var_1_10007))
	Vector2 = var_2
	Screen = var_1_3

	local var_1_5 = var_1_3.width

	Screen = var_5
	arg_1_0.screenSize = var_2(var_1_5, var_5.height)
	Vector2 = var_2
	arg_1_0.screenCenter = var_2(arg_1_0.screenSize.x * 0.5, arg_1_0.screenSize.y * 0.5)
	Vector2 = var_2
	arg_1_0.radiusOfEllipse = var_2(var_0_1[1], var_0_1[2])
	Vector3 = var_2
	arg_1_0.targetPosition = var_2.zero
	arg_1_0.lerpSpeed = 25
	arg_1_0.showHudDic = {}

	return
end

function var_0_0.Tracking(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0:SetUp(arg_2_1, arg_2_2, arg_2_3)

	return
end

function var_0_0.UnTracking(arg_3_0)
	arg_3_0:Clear()

	return
end

function var_0_0.Update(arg_4_0, arg_4_1)
	if arg_4_0.cg.alpha == 0 then
		return
	end

	if arg_4_1 and not arg_4_0.isAttach then
		arg_4_0:AdjustTargetPosition(arg_4_1)
	end

	local var_4_0 = arg_4_0.distanceTr

	Vector3 = var_1_10003

	local var_4_1 = var_1_10003.Lerp
	local var_4_2 = arg_4_0.distanceTr.localPosition
	local var_4_3 = arg_4_0.targetPosition

	Time = var_1_10007
	var_4_0.localPosition = var_4_1(var_4_2, var_4_3, var_1_10007.deltaTime * arg_4_0.lerpSpeed)

	return
end

function var_0_0.GetShowTargetPosition(arg_5_0)
	local var_5_0

	if arg_5_0.cg.alpha == 0 or not arg_5_0.targetPosition then
		var_5_0 = nil
	end

	return var_5_0
end

function var_0_0.AdjustTargetPosition(arg_6_0, arg_6_1)
	math = var_1_10002

	local var_6_0 = var_1_10002.rad2Deg

	math = var_1_10003

	local var_6_1 = var_6_0 * var_1_10003.atan2(arg_6_1.x - 1, arg_6_1.y)

	math = var_3

	local var_6_2 = var_3.rad2Deg

	math = var_1_10004

	local var_6_3 = var_6_2 * var_1_10004.atan2(arg_6_0.targetPosition.x - 1, arg_6_0.targetPosition.y)

	math = var_4

	if var_4.abs(var_6_3 - var_6_1) < var_0_2 then
		local var_6_4 = arg_6_0
		local var_6_5, var_6_6 = arg_6_0.RotatePoint(var_6_4, arg_6_1.x, arg_6_1.y, var_0_2)

		Vector3 = var_6_4
		arg_6_0.targetPosition = var_6_4(var_6_5, var_6_6, 0)
	end

	return
end

function var_0_0.RotatePoint(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	math = var_1_10004

	local var_7_0 = var_1_10004.deg2Rad * arg_7_3

	math = var_1_10005

	local var_7_1 = arg_7_1 * var_1_10005.cos(var_7_0)

	math = var_1_10006

	local var_7_2 = var_7_1 - arg_7_2 * var_1_10006.sin(var_7_0)

	math = var_6

	local var_7_3 = arg_7_1 * var_6.sin(var_7_0)

	math = var_7

	return var_7_2, var_7_3 + arg_7_2 * var_7.cos(var_7_0)
end

function var_0_0.Disable(arg_8_0)
	arg_8_0.isDisable = true
	arg_8_0.cg.alpha = 0

	return
end

function var_0_0.Enable(arg_9_0)
	arg_9_0.isDisable = false

	return
end

function var_0_0.OnShowHud(arg_10_0, arg_10_1)
	arg_10_0.showHudDic[arg_10_1] = true

	return
end

function var_0_0.OnHideHud(arg_11_0, arg_11_1)
	arg_11_0.showHudDic[arg_11_1] = nil

	return
end

function var_0_0.SetUp(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	arg_12_0:ShutDown()

	arg_12_0.trackId = arg_12_3
	FrameTimer = var_4
	arg_12_0.timer = var_4.New(function()
		IsNil = var_2_10000

		if var_2_10000(arg_12_2) then
			arg_12_0.cg.alpha = 0

			return
		end

		local var_13_0 = arg_12_2.transform.position

		IslandCalcUtil = var_2_10001

		local var_13_1 = var_2_10001.IsInViewport(var_13_0)
		local var_13_2 = not arg_12_0.isDisable and (not var_13_1 or not arg_12_0.showHudDic[arg_12_0.trackId])
		local var_13_3 = arg_12_0.cg

		var_13_3.alpha = var_13_2 and 1 or 0

		if not var_13_2 then
			return
		end

		Vector3 = var_13_3

		local var_13_4 = var_13_3.Distance(var_13_0, arg_12_1.transform.position)
		local var_13_5 = arg_12_0.distanceTxt

		math = var_5
		var_13_5.text = var_5.ceil(var_13_4 > var_0_3 and var_13_4 or 0) .. "M"

		local var_13_6 = var_13_4 < var_0_4

		Vector3 = var_5

		local var_13_7 = var_5(0, 0, 0)
		local var_13_8 = 0
		local var_13_9 = false
		local var_13_12

		if var_13_6 then
			local var_13_10 = arg_12_0
			local var_13_11, var_13_13

			var_13_11, var_13_12, var_13_13 = var_8.CalcNearPosition(var_13_10, arg_12_2.transform)
			var_13_9 = var_13_13
			var_13_8 = var_13_12
			var_13_7 = var_13_11
		else
			local var_13_14 = arg_12_0
			local var_13_15, var_13_16

			var_13_15, var_13_12, var_13_16 = var_8.CalcPosition(var_13_14, arg_12_2.transform)
			var_13_9 = var_13_16
			var_13_8 = var_13_12
			var_13_7 = var_13_15
		end

		local var_13_17 = arg_12_0

		Vector3 = var_13_12
		var_13_17.targetPosition = var_13_12(var_13_7.x, var_13_7.y, 0)

		local var_13_18 = arg_12_0.arrTr

		Vector3 = var_9
		var_13_18.localEulerAngles = var_9(0, 0, var_13_8)
		arg_12_0.isAttach = var_13_9

		return
	end, 1, -1)

	local var_12_0 = arg_12_0.timer

	var_4.Start(var_12_0)

	return
end

function var_0_0.CalcPosition(arg_14_0, arg_14_1)
	IslandCameraMgr = var_1_10002

	local var_14_0 = var_1_10002.instance._mainCamera
	local var_14_1 = var_2.WorldToScreenPoint(var_14_0, arg_14_1.transform.position)
	local var_14_2 = var_2.gameObject.transform.forward
	local var_14_3 = (arg_14_1.transform.position - var_2.gameObject.transform.position).normalized

	Vector3 = var_6

	local var_14_4

	if var_6.Dot(var_14_2, var_14_3) <= 0 then
		var_14_4 = arg_14_0.screenSize.x - var_14_1.x

		local var_14_5 = arg_14_0.screenSize.y - var_14_1.y

		Vector3 = var_8
		var_14_1 = var_8(var_14_4, var_14_5, 0)
	end

	Vector2 = var_14_4

	local var_14_6 = var_14_4(var_14_1.x, var_14_1.y) - arg_14_0.screenCenter

	math = var_7

	local var_14_7 = var_7.pow(var_14_6.x / arg_14_0.radiusOfEllipse.x, 2)

	math = var_8

	local var_14_9, var_14_11

	if var_14_7 + var_8.pow(var_14_6.y / arg_14_0.radiusOfEllipse.y, 2) > 1 then
		local var_14_8 = var_14_6.y / (var_14_6.x + 1e-07)

		Mathf = var_14_9
		var_14_9 = var_14_9.Pow(arg_14_0.radiusOfEllipse.x * arg_14_0.radiusOfEllipse.y, 2)
		Mathf = var_10

		local var_14_10 = var_10.Pow(arg_14_0.radiusOfEllipse.y, 2)

		Mathf = var_14_11
		var_14_11 = var_14_11.Pow(var_14_8, 2)
		Mathf = var_1_10012

		local var_14_12 = var_14_10 + var_14_11 * var_1_10012.Pow(arg_14_0.radiusOfEllipse.x, 2)

		math = var_14_11
		var_14_11 = var_14_11.sqrt(var_14_9 / var_14_12)
		math = var_1_10012
		var_1_10012 = var_1_10012.sign(var_14_11)
		math = var_13

		if var_1_10012 ~= var_13.sign(var_14_6.x) then
			var_14_11 = -1 * var_14_11
		end

		var_1_10012 = var_14_11 * var_14_8
		Vector2 = var_13

		local var_14_13 = var_13(var_14_11, var_1_10012)

		IslandCalcUtil = var_14

		local var_14_14 = var_14.SignedAngle

		Vector2 = var_16

		local var_14_15 = var_16.up

		Vector2 = var_1_10017

		local var_14_16 = var_14_14(var_14_15, var_1_10017(var_14_6.x, var_14_6.y))

		return
	elseif var_7 < 1 then
		return arg_14_0:CalcNearPosition(arg_14_1)
	else
		local var_14_17 = var_14_6

		IslandCalcUtil = var_14_9

		local var_14_18 = var_14_9.SignedAngle

		Vector2 = var_14_11

		local var_14_19 = var_14_11.up

		Vector2 = var_1_10012

		local var_14_20 = var_14_18(var_14_19, var_1_10012(var_14_6.x, var_14_6.y))

		return
	end

	return
end

function var_0_0.CalcNearPosition(arg_15_0, arg_15_1)
	IslandCameraMgr = var_1_10002

	local var_15_0 = var_1_10002.instance._mainCamera

	Vector3 = var_1_10003

	local var_15_1 = var_1_10003(arg_15_1.transform.position.x, arg_15_1.transform.position.y + var_0_5, arg_15_1.transform.position.z)
	local var_15_2 = var_15_0:WorldToScreenPoint(var_15_1)

	Vector2 = var_5

	return var_5(var_15_2.x, var_15_2.y) - arg_15_0.screenCenter, 180, true
end

function var_0_0.ShutDown(arg_16_0)
	if arg_16_0.timer then
		local var_16_0 = arg_16_0.timer

		var_1.Stop(var_16_0)

		arg_16_0.timer = nil
	end

	arg_16_0.cg.alpha = 0
	arg_16_0.trackId = nil

	return
end

function var_0_0.Clear(arg_17_0)
	arg_17_0:ShutDown()

	return
end

function var_0_0.Dispose(arg_18_0)
	arg_18_0.showHudDic = nil

	arg_18_0:Clear()

	return
end

return var_0_0
