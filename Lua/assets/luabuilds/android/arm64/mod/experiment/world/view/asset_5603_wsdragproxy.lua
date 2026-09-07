local WSDragProxy = class("WSDragProxy", import("...BaseEntity"))

WSDragProxy.Fields = {
	map = "table",
	gid = "number",
	topExtend = "number",
	transform = "userdata",
	longPressTrigger = "userdata",
	leftExtend = "number",
	twFocusId = "number",
	dragTrigger = "userdata",
	wsTimer = "table",
	onDragFunction = "function",
	isDraging = "boolean",
	bottomExtend = "number",
	callInfo = "table",
	rightExtend = "number"
}

function WSDragProxy:Setup(arg_1_1)
	self.callInfo = arg_1_1
	self.dragTrigger = GetOrAddComponent(self.transform, typeof(EventTriggerListener))

	self.dragTrigger:AddBeginDragFunc(function()
		self.isDraging = true

		return
	end)
	self.dragTrigger:AddDragEndFunc(function()
		self.isDraging = false

		return
	end)
	self.dragTrigger:AddPointClickFunc(function(arg_4_0, arg_4_1)
		if not self.isDraging then
			self.callInfo.clickCall(arg_4_0, arg_4_1)
		end

		return
	end)

	self.dragTrigger.enabled = true
	self.longPressTrigger = GetOrAddComponent(self.transform, typeof(UILongPressTrigger))

	local var_1_0 = self.callInfo.longPressCall

	function self.callInfo.longPressCall(...)
		if self.isDraging then
			return
		end

		var_1_0(...)

		return
	end

	self.longPressTrigger.onLongPressed:AddListener(self.callInfo.longPressCall)

	self.longPressTrigger.enabled = true

	return
end

function WSDragProxy:Dispose()
	self.transform.localPosition = Vector3.zero

	if self.map then
		self.dragTrigger:RemoveDragFunc()
	end

	self.dragTrigger:RemoveBeginDragFunc()
	self.dragTrigger:RemoveDragEndFunc()
	self.dragTrigger:RemovePointClickFunc()

	self.dragTrigger.enabled = true

	self.longPressTrigger.onLongPressed:RemoveListener(self.callInfo.longPressCall)

	self.longPressTrigger.enabled = true

	self:Clear()

	return
end

function WSDragProxy:Focus(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	local var_7_0 = self.transform:Find("plane")

	assert(var_7_0, "plane not exist.")

	local var_7_1 = self.transform.parent:InverseTransformVector(arg_7_1 - var_7_0.position)

	var_7_1.x = var_7_1.x + var_7_0.localPosition.x
	var_7_1.y = var_7_1.y + var_7_0.localPosition.y - var_7_0.localPosition.z * math.tan(math.pi / 180 * self.map.theme.angle)
	var_7_1.x = math.clamp(-var_7_1.x, -self.rightExtend, self.leftExtend)
	var_7_1.y = math.clamp(-var_7_1.y, -self.topExtend, self.bottomExtend)
	var_7_1.z = 0

	if self.twFocusId then
		self.wsTimer:RemoveInMapTween(self.twFocusId)
	end

	local var_7_2 = {}

	if arg_7_3 then
		table.insert(var_7_2, function(arg_8_0)
			if self.isDraging then
				self.isDraging = false
			end

			self.dragTrigger.enabled = false
			self.longPressTrigger.enabled = false
			arg_7_2 = arg_7_2 or (self.transform.localPosition - var_7_1).magnitude > 0 and (self.transform.localPosition - var_7_1).magnitude / (40 * math.sqrt((self.transform.localPosition - var_7_1).magnitude)) or 0
			self.twFocusId = LeanTween.moveLocal(self.transform.gameObject, var_7_1, arg_7_2):setEase(arg_7_3):setOnComplete(System.Action(arg_8_0)).uniqueId

			self.wsTimer:AddInMapTween(self.twFocusId)

			return
		end)
	else
		self.transform.localPosition = var_7_1
	end

	seriesAsync(var_7_2, function()
		self.dragTrigger.enabled = true
		self.longPressTrigger.enabled = true

		if arg_7_4 then
			arg_7_4()
		end

		return
	end)

	return
end

function WSDragProxy:UpdateMap(arg_10_1)
	if self.map ~= arg_10_1 or self.gid ~= arg_10_1.gid then
		self.map = arg_10_1
		self.gid = arg_10_1.gid

		self:UpdateDrag()
	end

	return
end

function WSDragProxy:UpdateDrag()
	local var_11_0, var_11_1, var_11_2 = getSizeRate()
	local var_11_3 = var_11_2 * 0.5 / math.tan(math.deg2Rad * self.map.theme.fov * 0.5)
	local var_11_4 = math.deg2Rad * self.map.theme.angle
	local var_11_5 = var_11_0 * math.clamp((var_11_3 - Vector3.Dot(Vector3(0, -math.sin(math.deg2Rad * self.map.theme.angle), -math.cos(math.deg2Rad * self.map.theme.angle)), Vector3(self.map.theme.offsetx, self.map.theme.offsety, self.map.theme.offsetz) + WorldConst.DefaultMapOffset)) / var_11_3, 0, 1)

	self.leftExtend, self.rightExtend, self.topExtend, self.bottomExtend = self:GetDragExtend(var_11_1, var_11_2)
	self.transform.sizeDelta = Vector2(var_11_1 + math.max(self.leftExtend, self.rightExtend) * 2, var_11_2 + math.max(self.topExtend, self.bottomExtend) * 2)

	self.dragTrigger:RemoveDragFunc()
	self.dragTrigger:AddDragFunc(function(arg_12_0, arg_12_1)
		if self.onDragFunction then
			self.onDragFunction()
		end

		local var_12_0 = self.transform.localPosition

		var_12_0.x = math.clamp(self.transform.localPosition.x + arg_12_1.delta.x * var_11_5.x, -self.rightExtend, self.leftExtend)
		var_12_0.y = math.clamp(var_12_0.y + arg_12_1.delta.y * var_11_5.y / math.cos(var_11_4), -self.topExtend, self.bottomExtend)
		self.transform.localPosition = var_12_0

		return
	end)

	return
end

function WSDragProxy:GetDragExtend(arg_13_1, arg_13_2)
	local var_13_0 = self.transform:Find("plane")

	assert(var_13_0, "plane not exist.")

	local var_13_1 = var_13_0.localPosition.y - var_13_0.localPosition.z * math.tan(math.pi / 180 * self.map.theme.angle)
	local var_13_2 = 99999999
	local var_13_3 = 0
	local var_13_4 = 0

	for iter_13_0, iter_13_1 in pairs(self.map.cells) do
		if var_13_2 > iter_13_1.row then
			var_13_2 = iter_13_1.row
		end

		if var_13_3 < iter_13_1.row then
			var_13_3 = iter_13_1.row
		end

		if var_13_4 < iter_13_1.column then
			var_13_4 = iter_13_1.column
		end
	end

	return 1000 - var_13_0.localPosition.x, math.max(var_13_4 * (self.map.theme.cellSize + self.map.theme.cellSpace).x - arg_13_1 * 0.5, 0) + var_13_0.localPosition.x, math.max((WorldConst.MaxRow * 0.5 - var_13_2) * (self.map.theme.cellSize + self.map.theme.cellSpace).y, 0) + var_13_1, math.max((var_13_3 - WorldConst.MaxRow * 0.5) * (self.map.theme.cellSize + self.map.theme.cellSpace).y, 0) - var_13_1
end

function WSDragProxy:ShakePlane(arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5)
	arg_14_2 = math.clamp(arg_14_2, 0, 90)
	arg_14_3 = math.max(arg_14_3, 1)
	arg_14_4 = math.max(arg_14_4, 1)

	local var_14_0 = Vector3(math.cos(math.pi / 180 * arg_14_2), math.sin(math.pi / 180 * arg_14_2), 0) * arg_14_1

	self.dragTrigger.enabled = false
	self.longPressTrigger.enabled = false

	self.wsTimer:AddInMapTween(LeanTween.moveLocal(self.transform.gameObject, self.transform.anchoredPosition3D + var_14_0, 0.0333 * arg_14_3 * 0.5).uniqueId)
	self.wsTimer:AddInMapTween(LeanTween.moveLocal(self.transform.gameObject, self.transform.anchoredPosition3D - var_14_0, 0.0333 * arg_14_3):setDelay(0.0333 * arg_14_3 * 0.5):setLoopPingPong(arg_14_4).uniqueId)
	self.wsTimer:AddInMapTween(LeanTween.moveLocal(self.transform.gameObject, self.transform.anchoredPosition3D, 0.0333 * arg_14_3 * 0.5):setDelay(0.0333 * arg_14_3 * 0.5 + 0.0333 * arg_14_3 * arg_14_4 * 2):setOnComplete(System.Action(function()
		self.dragTrigger.enabled = true
		self.longPressTrigger.enabled = true

		arg_14_5()

		return
	end)).uniqueId)

	return
end

return WSDragProxy
