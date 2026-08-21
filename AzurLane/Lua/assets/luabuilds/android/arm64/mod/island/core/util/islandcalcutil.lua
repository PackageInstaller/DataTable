local var_0_0 = class("IslandCalcUtil")

function var_0_0.SignedAngle(arg_1_0, arg_1_1)
	local var_1_0 = Vector2.Angle(arg_1_0, arg_1_1) * math.sign(arg_1_0.x * arg_1_1.y - arg_1_0.y * arg_1_1.x)

	if var_1_0 == -0 then
		var_1_0 = 180
	end

	return var_1_0
end

function var_0_0.WorldPosition2LocalPosition(arg_2_0, arg_2_1)
	local var_2_0 = pg.UIMgr.GetInstance().overlayCameraComp

	return (LuaHelper.ScreenToLocal(arg_2_0:GetComponent("RectTransform"), var_2_0:ViewportToScreenPoint((IslandCameraMgr.instance._mainCamera:WorldToViewportPoint(arg_2_1))), var_2_0))
end

function var_0_0.IsInViewport(arg_3_0)
	local var_3_0 = IslandCameraMgr.instance._mainCamera:WorldToViewportPoint(arg_3_0)

	if var_3_0.x > 0 and var_3_0.x < 1 and var_3_0.y > 0 and var_3_0.y < 1 and var_3_0.z > 0 then
		return true
	end

	return false
end

function var_0_0.GetNavPath(arg_4_0, arg_4_1)
	local var_4_0 = GetOrAddComponent(arg_4_0, typeof(UnityEngine.AI.NavMeshAgent))

	var_4_0.nextPosition = arg_4_0.transform.position

	local var_4_1 = UnityEngine.AI.NavMeshPath.New()

	var_4_0:CalculatePath(arg_4_1, var_4_1)

	return (var_4_1.corners:ToTable())
end

function var_0_0.GetRandomPointOnCircle(arg_5_0, arg_5_1)
	return arg_5_0 + Vector3(UnityEngine.Random.insideUnitCircle.normalized.x, 0, UnityEngine.Random.insideUnitCircle.normalized.y) * arg_5_1
end

function var_0_0.GetRandomPointInSector(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	arg_6_4 = arg_6_4 or 0.7

	local var_6_0 = Vector3.New(arg_6_1.x, 0, arg_6_1.z)

	var_6_0 = var_6_0.magnitude < 0.01 and Vector3.New(1, 0, 0) or var_6_0.normalized

	local var_6_1 = math.atan2(var_6_0.z, var_6_0.x) + math.rad(-(arg_6_3 * 0.5) + UnityEngine.Random.value * (2 * (arg_6_3 * 0.5)))

	return arg_6_0 + Vector3.New(math.cos(var_6_1), 0, math.sin(var_6_1)) * (arg_6_2 * arg_6_4 + UnityEngine.Random.value * (arg_6_2 - arg_6_2 * arg_6_4))
end

function var_0_0.GetPointOffset(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_2 % 2 == 0 then
		return arg_7_0 + Vector3(arg_7_1 * 2, 0, 0) * math.ceil(arg_7_2 * 0.5)
	else
		return arg_7_0 - Vector3(arg_7_1 * 2, 0, 0) * math.ceil(arg_7_2 * 0.5)
	end

	return
end

function var_0_0.GetTypeAndIdByUniqueId(arg_8_0)
	local var_8_0 = WorldObjectItem.GetTypeAndIdByUniqueId(arg_8_0)

	return var_8_0[0], var_8_0[1]
end

function var_0_0.GetUnReHexPoints(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0 * math.tan(arg_9_2 * math.pi / 180) * 0.5

	table.insert({}, Vector2(0, arg_9_1 * 0.5))
	table.insert({}, Vector2(-(arg_9_0 * 0.5), var_9_0))
	table.insert({}, Vector2(-(arg_9_0 * 0.5), -var_9_0))
	table.insert({}, Vector2(0, -(arg_9_1 * 0.5)))
	table.insert({}, Vector2(arg_9_0 * 0.5, -var_9_0))
	table.insert({}, Vector2(arg_9_0 * 0.5, var_9_0))

	return {}
end

function var_0_0.Vetor3Table2Array(arg_10_0)
	local var_10_0 = System.Array.CreateInstance(typeof(UnityEngine.Vector3), #arg_10_0)

	for iter_10_0, iter_10_1 in ipairs(arg_10_0) do
		var_10_0[iter_10_0 - 1] = iter_10_1
	end

	return var_10_0
end

function var_0_0.ClampRect(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	local var_11_0 = arg_11_1 * 0.5 - arg_11_3 * 0.5

	if arg_11_0 * 0.5 - arg_11_2 * 0.5 < arg_11_4.x then
		arg_11_4.x = arg_11_0 * 0.5 - arg_11_2 * 0.5
	elseif arg_11_4.x < -(arg_11_0 * 0.5 - arg_11_2 * 0.5) then
		arg_11_4.x = -(arg_11_0 * 0.5 - arg_11_2 * 0.5)
	end

	if var_11_0 < arg_11_4.y then
		arg_11_4.y = var_11_0
	elseif arg_11_4.y < -var_11_0 then
		arg_11_4.y = -var_11_0
	end

	return arg_11_4
end

function var_0_0.IsBehindCamera(arg_12_0)
	return Vector3.Dot(IslandCameraMgr.instance._mainCamera.transform.forward, arg_12_0) > 0
end

function var_0_0.GetSurroundPoints(arg_13_0)
	table.insert({}, arg_13_0)
	table.insert({}, Vector3(arg_13_0.x * -1, arg_13_0.y, arg_13_0.z * -1))
	table.insert({}, Vector3(arg_13_0.x, arg_13_0.y, arg_13_0.z * -1))
	table.insert({}, Vector3(arg_13_0.x * -1, arg_13_0.y, arg_13_0.z))

	return {}
end

function var_0_0.GetRandomSurroundPoints(arg_14_0)
	local var_14_0 = Vector2(arg_14_0.x, arg_14_0.z).magnitude
	local var_14_1 = math.Random(1, 360)
	local var_14_2 = Vector2(Mathf.Cos(var_14_1) * var_14_0, Mathf.Sin(var_14_1) * var_14_0)

	return Vector3(var_14_2.x, arg_14_0.y, var_14_2.y)
end

function var_0_0.IsHappen(arg_15_0)
	return arg_15_0 >= math.random(0, 100)
end

function var_0_0.IsCircleInsideNavMesh(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = #IslandHelper.CircleInsideNavMesh(arg_16_0, arg_16_1, arg_16_2, arg_16_3):ToTable()

	return var_16_0 > 0
end

function var_0_0.GetCanReachPoints(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	for iter_17_0, iter_17_1 in ipairs((IslandHelper.CircleInsideNavMesh(arg_17_2, arg_17_3, arg_17_1, arg_17_4):ToTable())) do
		if IslandHelper.CanReachPoint(arg_17_0, iter_17_1) then
			table.insert({}, iter_17_1)
		end
	end

	return {}
end

function var_0_0.GetCanReachOptPoint(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5)
	local var_18_0 = var_0_0.GetCanReachPoints(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_5)

	if #var_18_0 <= 0 then
		return nil
	end

	table.sort(var_18_0, function(arg_19_0, arg_19_1)
		return Vector3.Distance(arg_19_0, arg_18_4) < Vector3.Distance(arg_19_1, arg_18_4)
	end)

	return var_18_0[1]
end

function var_0_0.CanReachPoint(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	return #var_0_0.GetCanReachPoints(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4) > 0
end

function var_0_0.RotationOffset(arg_21_0, arg_21_1, arg_21_2)
	(arg_21_1 - arg_21_0).y = 0
	;(arg_21_2 - arg_21_0).y = 0

	return (Quaternion.Euler(0, Quaternion.FromToRotation(Vector3.Normalize(arg_21_1 - arg_21_0), (Vector3.Normalize(arg_21_2 - arg_21_0))).eulerAngles.y, 0))
end

return var_0_0
