local var_0_0 = class("IslandTargetTracker")
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

	setActive(arg_1_0.distanceTr, true)

	arg_1_0.cg = GetOrAddComponent(arg_1_0.distanceTr, typeof(CanvasGroup))
	arg_1_0.cg.alpha = 0
	arg_1_0.arrTr = findTF(arg_1_0.distanceTr, "arr")
	arg_1_0.distanceTxt = arg_1_0.distanceTr:Find("Text"):GetComponent(typeof(Text))
	arg_1_0.screenSize = Vector2(Screen.width, Screen.height)
	arg_1_0.screenCenter = Vector2(arg_1_0.screenSize.x * 0.5, arg_1_0.screenSize.y * 0.5)
	arg_1_0.radiusOfEllipse = Vector2(var_0_1[1], var_0_1[2])
	arg_1_0.targetPosition = Vector3.zero
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

	arg_4_0.distanceTr.localPosition = Vector3.Lerp(arg_4_0.distanceTr.localPosition, arg_4_0.targetPosition, Time.deltaTime * arg_4_0.lerpSpeed)

	return
end

function var_0_0.GetShowTargetPosition(arg_5_0)
	if arg_5_0.cg.alpha ~= 0 then
		return arg_5_0.targetPosition or nil
	end
end

function var_0_0.AdjustTargetPosition(arg_6_0, arg_6_1)
	if math.abs(math.rad2Deg * math.atan2(arg_6_0.targetPosition.x - 1, arg_6_0.targetPosition.y) - math.rad2Deg * math.atan2(arg_6_1.x - 1, arg_6_1.y)) < var_0_2 then
		local var_6_0, var_6_1 = arg_6_0:RotatePoint(arg_6_1.x, arg_6_1.y, var_0_2)

		arg_6_0.targetPosition = Vector3(var_6_0, var_6_1, 0)
	end

	return
end

function var_0_0.RotatePoint(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	return arg_7_1 * math.cos(math.deg2Rad * arg_7_3) - arg_7_2 * math.sin(math.deg2Rad * arg_7_3), arg_7_1 * math.sin(math.deg2Rad * arg_7_3) + arg_7_2 * math.cos(math.deg2Rad * arg_7_3)
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
	arg_12_0.timer = FrameTimer.New(function()
		if IsNil(arg_12_2) then
			arg_12_0.cg.alpha = 0

			return
		end

		local var_13_0 = arg_12_2.transform.position
		local var_13_1 = IslandCalcUtil.IsInViewport(arg_12_2.transform.position)
		local var_13_2 = not arg_12_0.isDisable and (not var_13_1 or not arg_12_0.showHudDic[arg_12_0.trackId])

		arg_12_0.cg.alpha = not arg_12_0.isDisable and (not var_13_1 or not arg_12_0.showHudDic[arg_12_0.trackId]) and 1 or 0

		if not var_13_2 then
			return
		end

		local var_13_3 = Vector3.Distance(var_13_0, arg_12_1.transform.position)

		arg_12_0.distanceTxt.text = math.ceil(var_13_3 > var_0_3 and var_13_3 or 0) .. "M"

		local var_13_4 = Vector3(0, 0, 0)
		local var_13_5 = 0
		local var_13_6 = false

		if var_13_3 < var_0_4 then
			var_13_4, var_13_5, var_13_6 = arg_12_0:CalcNearPosition(arg_12_2.transform)
		else
			var_13_4, var_13_5, var_13_6 = arg_12_0:CalcPosition(arg_12_2.transform)
		end

		arg_12_0.targetPosition = Vector3(var_13_4.x, var_13_4.y, 0)
		arg_12_0.arrTr.localEulerAngles = Vector3(0, 0, var_13_5)
		arg_12_0.isAttach = var_13_6

		return
	end, 1, -1)

	arg_12_0.timer:Start()

	return
end

function var_0_0.CalcPosition(arg_14_0, arg_14_1)
	local var_14_0 = IslandCameraMgr.instance._mainCamera:WorldToScreenPoint(arg_14_1.transform.position)

	if Vector3.Dot(IslandCameraMgr.instance._mainCamera.gameObject.transform.forward, (arg_14_1.transform.position - IslandCameraMgr.instance._mainCamera.gameObject.transform.position).normalized) <= 0 then
		var_14_0 = Vector3(arg_14_0.screenSize.x - var_14_0.x, arg_14_0.screenSize.y - var_14_0.y, 0)
	end

	local var_14_1 = Vector2(var_14_0.x, var_14_0.y) - arg_14_0.screenCenter
	local var_14_2 = math.pow(var_14_1.x / arg_14_0.radiusOfEllipse.x, 2) + math.pow(var_14_1.y / arg_14_0.radiusOfEllipse.y, 2)

	if var_14_2 > 1 then
		local var_14_3 = math.sqrt(Mathf.Pow(arg_14_0.radiusOfEllipse.x * arg_14_0.radiusOfEllipse.y, 2) / (Mathf.Pow(arg_14_0.radiusOfEllipse.y, 2) + Mathf.Pow(var_14_1.y / (var_14_1.x + 1e-07), 2) * Mathf.Pow(arg_14_0.radiusOfEllipse.x, 2)))

		if math.sign(var_14_3) ~= math.sign(var_14_1.x) then
			var_14_3 = -1 * var_14_3
		end

		local var_14_4 = Vector2(var_14_3, var_14_3 * (var_14_1.y / (var_14_1.x + 1e-07)))
		local var_14_5 = IslandCalcUtil.SignedAngle(Vector2.up, Vector2(var_14_1.x, var_14_1.y))

		return
	elseif var_14_2 < 1 then
		return arg_14_0:CalcNearPosition(arg_14_1)
	else
		local var_14_7 = IslandCalcUtil.SignedAngle(Vector2.up, Vector2(var_14_1.x, var_14_1.y))

		return
	end

	return
end

function var_0_0.CalcNearPosition(arg_15_0, arg_15_1)
	local var_15_0 = IslandCameraMgr.instance._mainCamera:WorldToScreenPoint((Vector3(arg_15_1.transform.position.x, arg_15_1.transform.position.y + var_0_5, arg_15_1.transform.position.z)))

	return Vector2(var_15_0.x, var_15_0.y) - arg_15_0.screenCenter, 180, true
end

function var_0_0.ShutDown(arg_16_0)
	if arg_16_0.timer then
		arg_16_0.timer:Stop()

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
