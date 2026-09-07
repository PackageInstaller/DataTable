local IslandTargetTracker = class("IslandTargetTracker")
local var_0_1 = {
	200,
	200
}
local var_0_2 = 25
local var_0_3 = 2
local var_0_4 = 6
local var_0_5 = 2

function IslandTargetTracker:Ctor(arg_1_1)
	self._tf = arg_1_1
	self.distanceTr = self._tf

	setActive(self.distanceTr, true)

	self.cg = GetOrAddComponent(self.distanceTr, typeof(CanvasGroup))
	self.cg.alpha = 0
	self.arrTr = findTF(self.distanceTr, "arr")
	self.distanceTxt = self.distanceTr:Find("Text"):GetComponent(typeof(Text))
	self.screenSize = Vector2(Screen.width, Screen.height)
	self.screenCenter = Vector2(self.screenSize.x * 0.5, self.screenSize.y * 0.5)
	self.radiusOfEllipse = Vector2(var_0_1[1], var_0_1[2])
	self.targetPosition = Vector3.zero
	self.lerpSpeed = 25
	self.showHudDic = {}

	return
end

function IslandTargetTracker:Tracking(arg_2_1, arg_2_2, arg_2_3)
	self:SetUp(arg_2_1, arg_2_2, arg_2_3)

	return
end

function IslandTargetTracker:UnTracking()
	self:Clear()

	return
end

function IslandTargetTracker:Update(arg_4_1)
	if self.cg.alpha == 0 then
		return
	end

	if arg_4_1 and not self.isAttach then
		self:AdjustTargetPosition(arg_4_1)
	end

	self.distanceTr.localPosition = Vector3.Lerp(self.distanceTr.localPosition, self.targetPosition, Time.deltaTime * self.lerpSpeed)

	return
end

function IslandTargetTracker:GetShowTargetPosition()
	return (self.cg.alpha ~= 0 or nil) and (self.targetPosition or nil)
end

function IslandTargetTracker:AdjustTargetPosition(arg_6_1)
	if math.abs(math.rad2Deg * math.atan2(self.targetPosition.x - 1, self.targetPosition.y) - math.rad2Deg * math.atan2(arg_6_1.x - 1, arg_6_1.y)) < var_0_2 then
		local var_6_0, var_6_1 = self:RotatePoint(arg_6_1.x, arg_6_1.y, var_0_2)

		self.targetPosition = Vector3(var_6_0, var_6_1, 0)
	end

	return
end

function IslandTargetTracker:RotatePoint(arg_7_1, arg_7_2, arg_7_3)
	return arg_7_1 * math.cos(math.deg2Rad * arg_7_3) - arg_7_2 * math.sin(math.deg2Rad * arg_7_3), arg_7_1 * math.sin(math.deg2Rad * arg_7_3) + arg_7_2 * math.cos(math.deg2Rad * arg_7_3)
end

function IslandTargetTracker:Disable()
	self.isDisable = true
	self.cg.alpha = 0

	return
end

function IslandTargetTracker:Enable()
	self.isDisable = false

	return
end

function IslandTargetTracker:OnShowHud(arg_10_1)
	self.showHudDic[arg_10_1] = true

	return
end

function IslandTargetTracker:OnHideHud(arg_11_1)
	self.showHudDic[arg_11_1] = nil

	return
end

function IslandTargetTracker:SetUp(arg_12_1, arg_12_2, arg_12_3)
	self:ShutDown()

	self.trackId = arg_12_3
	self.timer = FrameTimer.New(function()
		if IsNil(arg_12_2) then
			self.cg.alpha = 0

			return
		end

		local var_13_0 = arg_12_2.transform.position
		local var_13_1 = not self.isDisable and (not IslandCalcUtil.IsInViewport(arg_12_2.transform.position) or not self.showHudDic[self.trackId])

		self.cg.alpha = not self.isDisable and (not IslandCalcUtil.IsInViewport(arg_12_2.transform.position) or not self.showHudDic[self.trackId]) and 1 or 0

		if not var_13_1 then
			return
		end

		local var_13_2 = Vector3.Distance(var_13_0, arg_12_1.transform.position)

		self.distanceTxt.text = math.ceil(var_13_2 > var_0_3 and var_13_2 or 0) .. "M"

		local var_13_3 = Vector3(0, 0, 0)
		local var_13_4 = 0
		local var_13_5 = false

		if var_13_2 < var_0_4 then
			var_13_3, var_13_4, var_13_5 = self:CalcNearPosition(arg_12_2.transform)
		else
			var_13_3, var_13_4, var_13_5 = self:CalcPosition(arg_12_2.transform)
		end

		self.targetPosition = Vector3(var_13_3.x, var_13_3.y, 0)
		self.arrTr.localEulerAngles = Vector3(0, 0, var_13_4)
		self.isAttach = var_13_5

		return
	end, 1, -1)

	self.timer:Start()

	return
end

function IslandTargetTracker:CalcPosition(arg_14_1)
	local var_14_0 = IslandCameraMgr.instance._mainCamera:WorldToScreenPoint(arg_14_1.transform.position)

	if Vector3.Dot(IslandCameraMgr.instance._mainCamera.gameObject.transform.forward, (arg_14_1.transform.position - IslandCameraMgr.instance._mainCamera.gameObject.transform.position).normalized) <= 0 then
		var_14_0 = Vector3(self.screenSize.x - var_14_0.x, self.screenSize.y - var_14_0.y, 0)
	end

	local var_14_1 = Vector2(var_14_0.x, var_14_0.y) - self.screenCenter
	local var_14_2 = math.pow(var_14_1.x / self.radiusOfEllipse.x, 2) + math.pow(var_14_1.y / self.radiusOfEllipse.y, 2)

	if var_14_2 > 1 then
		local var_14_3 = math.sqrt(Mathf.Pow(self.radiusOfEllipse.x * self.radiusOfEllipse.y, 2) / (Mathf.Pow(self.radiusOfEllipse.y, 2) + Mathf.Pow(var_14_1.y / (var_14_1.x + 1e-07), 2) * Mathf.Pow(self.radiusOfEllipse.x, 2)))

		if math.sign(var_14_3) ~= math.sign(var_14_1.x) then
			var_14_3 = -1 * var_14_3
		end

		local var_14_4 = Vector2(var_14_3, var_14_3 * (var_14_1.y / (var_14_1.x + 1e-07)))
		local var_14_5 = IslandCalcUtil.SignedAngle(Vector2.up, Vector2(var_14_1.x, var_14_1.y))

		return
	elseif var_14_2 < 1 then
		return self:CalcNearPosition(arg_14_1)
	else
		local var_14_7 = IslandCalcUtil.SignedAngle(Vector2.up, Vector2(var_14_1.x, var_14_1.y))

		return
	end

	return
end

function IslandTargetTracker:CalcNearPosition(arg_15_1)
	local var_15_0 = IslandCameraMgr.instance._mainCamera:WorldToScreenPoint((Vector3(arg_15_1.transform.position.x, arg_15_1.transform.position.y + var_0_5, arg_15_1.transform.position.z)))

	return Vector2(var_15_0.x, var_15_0.y) - self.screenCenter, 180, true
end

function IslandTargetTracker:ShutDown()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	self.cg.alpha = 0
	self.trackId = nil

	return
end

function IslandTargetTracker:Clear()
	self:ShutDown()

	return
end

function IslandTargetTracker:Dispose()
	self.showHudDic = nil

	self:Clear()

	return
end

return IslandTargetTracker
