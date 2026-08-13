class = var_0_10000

local var_0_0 = var_0_10000("IslandCalcUtil")

function var_0_0.SignedAngle(arg_1_0, arg_1_1)
	Vector2 = var_1_10002

	local var_1_0 = var_1_10002.Angle(arg_1_0, arg_1_1)
	local var_1_1 = arg_1_0.x * arg_1_1.y - arg_1_0.y * arg_1_1.x

	math = var_4

	local var_1_2

	if var_1_0 * var_4.sign(var_1_1) == -0 then
		var_1_2 = 180
	end

	return var_1_2
end

function var_0_0.WorldPosition2LocalPosition(arg_2_0, arg_2_1)
	pg = var_1_10002

	local var_2_0 = var_1_10002.UIMgr.GetInstance().overlayCameraComp

	IslandCameraMgr = var_1_10003

	local var_2_1 = var_1_10003.instance._mainCamera
	local var_2_2 = var_3.WorldToViewportPoint(var_2_1, arg_2_1)
	local var_2_3 = var_2_0:ViewportToScreenPoint(var_2_2)
	local var_2_4 = arg_2_0
	local var_2_5 = arg_2_0.GetComponent(var_2_4, "RectTransform")

	LuaHelper = var_2_4

	return (var_2_4.ScreenToLocal(var_2_5, var_2_3, var_2_0))
end

function var_0_0.IsInViewport(arg_3_0)
	IslandCameraMgr = var_1_10001

	local var_3_0 = var_1_10001.instance._mainCamera

	if var_1.WorldToViewportPoint(var_3_0, arg_3_0).x > 0 and var_2.x < 1 and var_2.y > 0 and var_2.y < 1 and var_2.z > 0 then
		return true
	end

	return false
end

function var_0_0.GetNavPath(arg_4_0, arg_4_1)
	GetOrAddComponent = var_1_10002

	local var_4_0 = arg_4_0

	typeof = var_1_10004
	UnityEngine = var_1_10005

	local var_4_1 = var_1_10002(var_4_0, var_1_10004(var_1_10005.AI.NavMeshAgent))

	var_4_1.nextPosition = arg_4_0.transform.position
	UnityEngine = var_3

	local var_4_2 = var_3.AI.NavMeshPath.New()

	var_4_1:CalculatePath(arg_4_1, var_4_2)

	local var_4_3 = var_4_2.corners

	return (var_4.ToTable(var_4_3))
end

function var_0_0.GetRandomPointOnCircle(arg_5_0, arg_5_1)
	UnityEngine = var_1_10002

	local var_5_0 = var_1_10002.Random.insideUnitCircle.normalized

	Vector3 = var_1_10003

	return arg_5_0 + var_1_10003(var_5_0.x, 0, var_5_0.y) * arg_5_1
end

function var_0_0.GetRandomPointInSector(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	arg_6_4 = arg_6_4 or 0.7
	Vector3 = var_1_10005

	local var_6_0

	if var_1_10005.New(arg_6_1.x, 0, arg_6_1.z).magnitude < 0.01 then
		Vector3 = var_6
		var_6_0 = var_6.New(1, 0, 0)
	else
		var_6_0 = var_6_0.normalized
	end

	math = var_6

	local var_6_1 = var_6.atan2(var_6_0.z, var_6_0.x)
	local var_6_2 = -(arg_6_3 * 0.5)

	UnityEngine = var_1_10009

	local var_6_3 = var_6_2 + var_1_10009.Random.value * (2 * var_7)

	math = var_9

	local var_6_4 = var_6_1 + var_9.rad(var_6_3)
	local var_6_5 = arg_6_2 * arg_6_4

	UnityEngine = var_1_10012

	local var_6_6 = var_6_5 + var_1_10012.Random.value * (arg_6_2 - var_6_5)

	Vector3 = var_13

	local var_6_7 = var_13.New

	math = var_1_10014

	local var_6_8 = var_1_10014.cos(var_6_4)
	local var_6_9 = 0

	math = var_1_10016

	return arg_6_0 + var_6_7(var_6_8, var_6_9, var_1_10016.sin(var_6_4)) * var_6_6
end

function var_0_0.GetPointOffset(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0

	if arg_7_2 % 2 == 0 then
		Vector3 = var_7_0
		var_7_0 = var_7_0(arg_7_1 * 2, 0, 0)
		math = var_4

		return arg_7_0 + var_7_0 * var_4.ceil(arg_7_2 * 0.5)
	else
		Vector3 = var_7_0

		local var_7_1 = var_7_0(arg_7_1 * 2, 0, 0)

		math = var_4

		return arg_7_0 - var_7_1 * var_4.ceil(arg_7_2 * 0.5)
	end

	return
end

function var_0_0.GetTypeAndIdByUniqueId(arg_8_0)
	WorldObjectItem = var_1_10001

	return var_1_10001.GetTypeAndIdByUniqueId(arg_8_0)[0], var_1[1]
end

function var_0_0.GetUnReHexPoints(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0 * 0.5
	local var_9_1 = arg_9_1 * 0.5
	local var_9_2 = {}

	math = var_1_10006

	local var_9_3 = arg_9_2 * var_1_10006.pi / 180

	math = var_1_10007

	local var_9_4 = arg_9_0 * var_1_10007.tan(var_9_3) * 0.5

	table = var_8

	local var_9_5 = var_8.insert
	local var_9_6 = var_9_2

	Vector2 = var_1_10010

	var_9_5(var_9_6, var_1_10010(0, var_9_1))

	table = var_9_5

	local var_9_7 = var_9_5.insert
	local var_9_8 = var_9_2

	Vector2 = var_10

	var_9_7(var_9_8, var_10(-var_9_0, var_9_4))

	table = var_9_7

	local var_9_9 = var_9_7.insert
	local var_9_10 = var_9_2

	Vector2 = var_10

	var_9_9(var_9_10, var_10(-var_9_0, -var_9_4))

	table = var_9_9

	local var_9_11 = var_9_9.insert
	local var_9_12 = var_9_2

	Vector2 = var_10

	var_9_11(var_9_12, var_10(0, -var_9_1))

	table = var_9_11

	local var_9_13 = var_9_11.insert
	local var_9_14 = var_9_2

	Vector2 = var_10

	var_9_13(var_9_14, var_10(var_9_0, -var_9_4))

	table = var_9_13

	local var_9_15 = var_9_13.insert
	local var_9_16 = var_9_2

	Vector2 = var_10

	var_9_15(var_9_16, var_10(var_9_0, var_9_4))

	return var_9_2
end

function var_0_0.Vetor3Table2Array(arg_10_0)
	System = var_1_10001

	local var_10_0 = var_1_10001.Array.CreateInstance

	typeof = var_1_10002
	UnityEngine = var_1_10003

	local var_10_1 = var_10_0(var_1_10002(var_1_10003.Vector3), #arg_10_0)

	ipairs = var_2

	for iter_10_0, iter_10_1 in var_2(arg_10_0) do
		var_10_1[iter_10_0 - 1] = iter_10_1
	end

	return var_10_1
end

function var_0_0.ClampRect(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	local var_11_0 = arg_11_0 * 0.5 - arg_11_2 * 0.5
	local var_11_1 = arg_11_1 * 0.5 - arg_11_3 * 0.5

	if var_11_0 < arg_11_4.x then
		arg_11_4.x = var_11_0
	elseif arg_11_4.x < -var_11_0 then
		arg_11_4.x = -var_11_0
	end

	if var_11_1 < arg_11_4.y then
		arg_11_4.y = var_11_1
	elseif arg_11_4.y < -var_11_1 then
		arg_11_4.y = -var_11_1
	end

	return arg_11_4
end

function var_0_0.IsBehindCamera(arg_12_0)
	IslandCameraMgr = var_1_10001

	local var_12_0 = var_1_10001.instance._mainCamera.transform.forward

	Vector3 = var_1_10003

	return var_1_10003.Dot(var_12_0, arg_12_0) > 0
end

function var_0_0.GetSurroundPoints(arg_13_0)
	local var_13_0 = {}

	table = var_1_10002

	var_1_10002.insert(var_13_0, arg_13_0)

	table = var_2

	local var_13_1 = var_2.insert
	local var_13_2 = var_13_0

	Vector3 = var_4

	var_13_1(var_13_2, var_4(arg_13_0.x * -1, arg_13_0.y, arg_13_0.z * -1))

	table = var_13_1

	local var_13_3 = var_13_1.insert
	local var_13_4 = var_13_0

	Vector3 = var_4

	var_13_3(var_13_4, var_4(arg_13_0.x, arg_13_0.y, arg_13_0.z * -1))

	table = var_13_3

	local var_13_5 = var_13_3.insert
	local var_13_6 = var_13_0

	Vector3 = var_4

	var_13_5(var_13_6, var_4(arg_13_0.x * -1, arg_13_0.y, arg_13_0.z))

	return var_13_0
end

function var_0_0.GetRandomSurroundPoints(arg_14_0)
	Vector2 = var_1_10001

	local var_14_0 = var_1_10001(arg_14_0.x, arg_14_0.z).magnitude

	math = var_3

	local var_14_1 = var_3.Random(1, 360)

	Vector2 = var_4
	Mathf = var_5

	local var_14_2 = var_5.Cos(var_14_1) * var_14_0

	Mathf = var_6

	local var_14_3 = var_4(var_14_2, var_6.Sin(var_14_1) * var_14_0)

	Vector3 = var_14_2

	return var_14_2(var_14_3.x, arg_14_0.y, var_14_3.y)
end

function var_0_0.IsHappen(arg_15_0)
	math = var_1_10001

	return arg_15_0 >= var_1_10001.random(0, 100)
end

function var_0_0.IsCircleInsideNavMesh(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	IslandHelper = var_1_10004

	local var_16_0 = var_1_10004.CircleInsideNavMesh(arg_16_0, arg_16_1, arg_16_2, arg_16_3)

	return #var_4.ToTable(var_16_0) > 0
end

function var_0_0.GetCanReachPoints(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	IslandHelper = var_1_10005

	local var_17_0 = var_1_10005.CircleInsideNavMesh(arg_17_2, arg_17_3, arg_17_1, arg_17_4)
	local var_17_1 = var_5.ToTable(var_17_0)
	local var_17_2 = {}

	ipairs = var_7

	for iter_17_0, iter_17_1 in var_7(var_17_1) do
		IslandHelper = var_1_10012

		if var_1_10012.CanReachPoint(arg_17_0, iter_17_1) then
			table = var_1_10012

			var_1_10012.insert(var_17_2, iter_17_1)
		end
	end

	return var_17_2
end

function var_0_0.GetCanReachOptPoint(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5)
	if #var_0_0.GetCanReachPoints(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_5) <= 0 then
		return nil
	end

	table = var_7

	var_7.sort(var_6, function(arg_19_0, arg_19_1)
		Vector3 = var_2_10002

		local var_19_0 = var_2_10002.Distance(arg_19_0, arg_18_4)

		Vector3 = var_3

		return var_19_0 < var_3.Distance(arg_19_1, arg_18_4)
	end)

	return var_6[1]
end

function var_0_0.CanReachPoint(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	return #var_0_0.GetCanReachPoints(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4) > 0
end

function var_0_0.RotationOffset(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_1 - arg_21_0

	var_21_0.y = 0
	Vector3 = var_4

	local var_21_1 = var_4.Normalize(var_21_0)
	local var_21_2 = arg_21_2 - arg_21_0

	var_21_2.y = 0
	Vector3 = var_5

	local var_21_3 = var_5.Normalize(var_21_2)

	Quaternion = var_5

	local var_21_4 = var_5.FromToRotation(var_21_1, var_21_3).eulerAngles

	Quaternion = var_7

	return (var_7.Euler(0, var_21_4.y, 0))
end

return var_0_0
