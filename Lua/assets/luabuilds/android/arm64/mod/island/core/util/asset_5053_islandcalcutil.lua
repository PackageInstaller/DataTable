local IslandCalcUtil = class("IslandCalcUtil")

function IslandCalcUtil:SignedAngle(arg_1_1)
	local var_1_0 = Vector2.Angle(self, arg_1_1) * math.sign(self.x * arg_1_1.y - self.y * arg_1_1.x)

	if var_1_0 == -0 then
		var_1_0 = 180
	end

	return var_1_0
end

function IslandCalcUtil:WorldPosition2LocalPosition(arg_2_1)
	local var_2_0 = pg.UIMgr.GetInstance().overlayCameraComp

	return (LuaHelper.ScreenToLocal(self:GetComponent("RectTransform"), var_2_0:ViewportToScreenPoint((IslandCameraMgr.instance._mainCamera:WorldToViewportPoint(arg_2_1))), var_2_0))
end

function IslandCalcUtil:IsInViewport()
	local var_3_0 = IslandCameraMgr.instance._mainCamera:WorldToViewportPoint(self)

	if var_3_0.x > 0 and var_3_0.x < 1 and var_3_0.y > 0 and var_3_0.y < 1 and var_3_0.z > 0 then
		return true
	end

	return false
end

function IslandCalcUtil:GetNavPath(arg_4_1)
	local var_4_0 = GetOrAddComponent(self, typeof(UnityEngine.AI.NavMeshAgent))

	var_4_0.nextPosition = self.transform.position

	local var_4_1 = UnityEngine.AI.NavMeshPath.New()

	var_4_0:CalculatePath(arg_4_1, var_4_1)

	return (var_4_1.corners:ToTable())
end

function IslandCalcUtil:GetRandomPointOnCircle(arg_5_1)
	return self + Vector3(UnityEngine.Random.insideUnitCircle.normalized.x, 0, UnityEngine.Random.insideUnitCircle.normalized.y) * arg_5_1
end

function IslandCalcUtil:GetRandomPointInSector(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	arg_6_4 = arg_6_4 or 0.7

	local var_6_0 = Vector3.New(arg_6_1.x, 0, arg_6_1.z)

	var_6_0 = var_6_0.magnitude < 0.01 and Vector3.New(1, 0, 0) or var_6_0.normalized

	local var_6_1 = math.atan2(var_6_0.z, var_6_0.x) + math.rad(-(arg_6_3 * 0.5) + UnityEngine.Random.value * (2 * (arg_6_3 * 0.5)))

	return self + Vector3.New(math.cos(var_6_1), 0, math.sin(var_6_1)) * (arg_6_2 * arg_6_4 + UnityEngine.Random.value * (arg_6_2 - arg_6_2 * arg_6_4))
end

function IslandCalcUtil:GetPointOffset(arg_7_1, arg_7_2)
	if arg_7_2 % 2 == 0 then
		return self + Vector3(arg_7_1 * 2, 0, 0) * math.ceil(arg_7_2 * 0.5)
	else
		return self - Vector3(arg_7_1 * 2, 0, 0) * math.ceil(arg_7_2 * 0.5)
	end

	return
end

function IslandCalcUtil:GetTypeAndIdByUniqueId()
	local var_8_0 = WorldObjectItem.GetTypeAndIdByUniqueId(self)

	return var_8_0[0], var_8_0[1]
end

function IslandCalcUtil:GetUnReHexPoints(arg_9_1, arg_9_2)
	local var_9_0 = {}
	local var_9_1 = self * math.tan(arg_9_2 * math.pi / 180) * 0.5

	table.insert(var_9_0, Vector2(0, arg_9_1 * 0.5))
	table.insert(var_9_0, Vector2(-(self * 0.5), var_9_1))
	table.insert(var_9_0, Vector2(-(self * 0.5), -var_9_1))
	table.insert(var_9_0, Vector2(0, -(arg_9_1 * 0.5)))
	table.insert(var_9_0, Vector2(self * 0.5, -var_9_1))
	table.insert(var_9_0, Vector2(self * 0.5, var_9_1))

	return var_9_0
end

function IslandCalcUtil:Vetor3Table2Array()
	local var_10_0 = System.Array.CreateInstance(typeof(UnityEngine.Vector3), #self)

	for iter_10_0, iter_10_1 in ipairs(self) do
		var_10_0[iter_10_0 - 1] = iter_10_1
	end

	return var_10_0
end

function IslandCalcUtil:ClampRect(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	local var_11_0 = arg_11_1 * 0.5 - arg_11_3 * 0.5

	if self * 0.5 - arg_11_2 * 0.5 < arg_11_4.x then
		arg_11_4.x = self * 0.5 - arg_11_2 * 0.5
	elseif arg_11_4.x < -(self * 0.5 - arg_11_2 * 0.5) then
		arg_11_4.x = -(self * 0.5 - arg_11_2 * 0.5)
	end

	if var_11_0 < arg_11_4.y then
		arg_11_4.y = var_11_0
	elseif arg_11_4.y < -var_11_0 then
		arg_11_4.y = -var_11_0
	end

	return arg_11_4
end

function IslandCalcUtil:IsBehindCamera()
	return Vector3.Dot(IslandCameraMgr.instance._mainCamera.transform.forward, self) > 0
end

function IslandCalcUtil:GetSurroundPoints()
	local var_13_0 = {}

	table.insert(var_13_0, self)
	table.insert(var_13_0, Vector3(self.x * -1, self.y, self.z * -1))
	table.insert(var_13_0, Vector3(self.x, self.y, self.z * -1))
	table.insert(var_13_0, Vector3(self.x * -1, self.y, self.z))

	return var_13_0
end

function IslandCalcUtil:GetRandomSurroundPoints()
	local var_14_0 = Vector2(self.x, self.z).magnitude
	local var_14_1 = math.Random(1, 360)
	local var_14_2 = Vector2(Mathf.Cos(var_14_1) * var_14_0, Mathf.Sin(var_14_1) * var_14_0)

	return Vector3(var_14_2.x, self.y, var_14_2.y)
end

function IslandCalcUtil:IsHappen()
	return self >= math.random(0, 100)
end

function IslandCalcUtil:IsCircleInsideNavMesh(arg_16_1, arg_16_2, arg_16_3)
	return #IslandHelper.CircleInsideNavMesh(self, arg_16_1, arg_16_2, arg_16_3):ToTable() > 0
end

function IslandCalcUtil:GetCanReachPoints(arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	local var_17_0 = {}

	for iter_17_0, iter_17_1 in ipairs((IslandHelper.CircleInsideNavMesh(arg_17_2, arg_17_3, arg_17_1, arg_17_4):ToTable())) do
		if IslandHelper.CanReachPoint(self, iter_17_1) then
			table.insert(var_17_0, iter_17_1)
		end
	end

	return var_17_0
end

function IslandCalcUtil:GetCanReachOptPoint(arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5)
	local var_18_0 = IslandCalcUtil.GetCanReachPoints(self, arg_18_1, arg_18_2, arg_18_3, arg_18_5)

	if #var_18_0 <= 0 then
		return nil
	end

	table.sort(var_18_0, function(arg_19_0, arg_19_1)
		return Vector3.Distance(arg_19_0, arg_18_4) < Vector3.Distance(arg_19_1, arg_18_4)
	end)

	return var_18_0[1]
end

function IslandCalcUtil:CanReachPoint(arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	return #IslandCalcUtil.GetCanReachPoints(self, arg_20_1, arg_20_2, arg_20_3, arg_20_4) > 0
end

function IslandCalcUtil:RotationOffset(arg_21_1, arg_21_2)
	(arg_21_1 - self).y = 0
	;(arg_21_2 - self).y = 0

	return (Quaternion.Euler(0, Quaternion.FromToRotation(Vector3.Normalize(arg_21_1 - self), (Vector3.Normalize(arg_21_2 - self))).eulerAngles.y, 0))
end

return IslandCalcUtil
