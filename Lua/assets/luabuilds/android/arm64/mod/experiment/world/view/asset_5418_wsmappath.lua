local WSMapPath = class("WSMapPath", import("...BaseEntity"))

WSMapPath.Fields = {
	path = "table",
	startPos = "table",
	upOffset = "number",
	theme = "table",
	moveAction = "string",
	wsObject = "table",
	twId = "number",
	paused = "boolean",
	dirType = "number",
	step = "number"
}
WSMapPath.EventStartTrip = "WSMapPath.EventStartTrip"
WSMapPath.EventArrivedStep = "WSMapPath.EventArrivedStep"
WSMapPath.EventArrived = "WSMapPath.EventArrived"

function WSMapPath:Setup(arg_1_1)
	self.theme = arg_1_1

	return
end

function WSMapPath:Dispose()
	if self.twId then
		LeanTween.cancel(self.twId)
	end

	self:Clear()

	return
end

function WSMapPath:UpdateObject(arg_3_1)
	assert(arg_3_1.GetModelAngles and arg_3_1.UpdateModelAngles and arg_3_1.UpdateModelAction)

	self.wsObject = arg_3_1

	return
end

function WSMapPath:UpdateAction(arg_4_1)
	self.moveAction = arg_4_1

	return
end

function WSMapPath:UpdateDirType(arg_5_1)
	self.dirType = arg_5_1

	return
end

function WSMapPath:StartMove(arg_6_1, arg_6_2, arg_6_3)
	self.startPos = arg_6_1
	self.path = arg_6_2
	self.upOffset = arg_6_3 or 0
	self.step = 0
	self.wsObject.isMoving = true

	self.wsObject:UpdateModelAction(self.moveAction)
	self:DispatchEvent(WSMapPath.EventStartTrip)
	self:MoveStep()

	return
end

function WSMapPath:MoveStep()
	local var_7_0 = self.wsObject
	local var_7_1 = self.path
	local var_7_2

	if self.step > 0 then
		var_7_2 = var_7_1[self.step] or self.startPos
	end

	local var_7_3 = var_7_1[self.step + 1]
	local var_7_4 = self.wsObject:GetModelAngles()

	if self.dirType == WorldConst.DirType4 then
		if var_7_3.column < var_7_2.column then
			var_7_4.z = 180
		elseif var_7_3.column > var_7_2.column then
			var_7_4.z = 0
		elseif var_7_3.row < var_7_2.row then
			var_7_4.z = 90
		elseif var_7_3.row > var_7_2.row then
			var_7_4.z = 270
		end

		self.wsObject:UpdateModelAngles(var_7_4)
	elseif self.dirType == WorldConst.DirType2 then
		if var_7_3.column < var_7_2.column or var_7_3.column == var_7_2.column and var_7_1[#var_7_1].column < var_7_2.column then
			var_7_4.y = 180
		elseif var_7_3.column ~= var_7_2.column or var_7_1[#var_7_1].column ~= var_7_2.column then
			var_7_4.y = 0
		end

		self.wsObject:UpdateModelAngles(var_7_4)
	end

	local var_7_5 = self.theme:GetLinePosition(var_7_2.row, var_7_2.column)
	local var_7_6 = self.theme:GetLinePosition(var_7_3.row, var_7_3.column)

	assert(var_7_3.duration, "without move duration")

	self.twId = LeanTween.value(self.wsObject.transform.gameObject, 0, 1, var_7_3.duration):setOnUpdate(System.Action_float(function(arg_8_0)
		local var_8_0, var_8_1 = self:CalcUpOffset(self.step, arg_8_0)

		var_7_0.transform.localPosition = Vector3.Lerp(var_7_5, var_7_6, arg_8_0) + var_8_0

		if var_7_0.rtShadow then
			var_7_0.rtShadow.localPosition = Vector3(0, -var_8_1, 0)
		end

		return
	end)):setOnComplete(System.Action(function()
		self.step = self.step + 1

		if self.step >= #var_7_1 then
			self.twId = nil

			var_7_0:UpdateModelAction(WorldConst.ActionIdle)

			var_7_0.isMoving = false

			self:DispatchEvent(WSMapPath.EventArrived)
		else
			self:DispatchEvent(WSMapPath.EventArrivedStep, var_7_3)
			onDelayTick(function()
				self:MoveStep()

				return
			end, 0.015)
		end

		return
	end)).uniqueId

	self:FlushPaused()

	return
end

function WSMapPath:UpdatePaused(arg_11_1)
	if self.paused ~= arg_11_1 then
		self.paused = arg_11_1

		self:FlushPaused()
	end

	return
end

function WSMapPath:FlushPaused()
	if self.paused then
		LeanTween.pause(self.twId)
		self.wsObject:UpdateModelAction(WorldConst.ActionIdle)
	else
		LeanTween.resume(self.twId)
		self.wsObject:UpdateModelAction(self.moveAction)
	end

	return
end

function WSMapPath:CalcUpOffset(arg_13_1, arg_13_2)
	local var_13_0 = math.clamp(math.sin((arg_13_1 + arg_13_2) / #self.path * math.pi), 0, 1) * self.upOffset

	return Vector3(0, self.theme.cosAngle * var_13_0, -self.theme.sinAngle * var_13_0), var_13_0
end

function WSMapPath:IsMoving()
	return self.twId ~= nil
end

return WSMapPath
