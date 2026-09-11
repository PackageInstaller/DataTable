local ReversePacmanRole = class("ReversePacmanRole")

ReversePacmanRole.MAX_SPEED = 400
ReversePacmanRole.MOVE_TYPE = {
	INTERVAL = 4,
	TURN = 2,
	STATIC = 3,
	STRAIGHT = 1
}
ReversePacmanRole.SPEED_STATE = {
	SLOW_DOWN = "slowDown",
	NORMAL = "normal",
	STATIC = "static",
	SPEED_UP = "speedUp"
}

function ReversePacmanRole:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.binder = arg_1_1
	self._tf = arg_1_2
	self.type = arg_1_3.type
	self.id = arg_1_3.id
	self.nodeId = arg_1_3.nodeId
	self.iconTF = self._tf:Find("Image")
	self.speedUpTF = self._tf:Find("speedUp")
	self.slowDownTF = self._tf:Find("slowDown")
	self.staticTF = self._tf:Find("static")

	if self.type == ReversePacmanConst.ROLE.SHIP then
		LoadImageSpriteAsync(self:GetConfig("sd_avatar"), self.iconTF)
	end

	setText(self._tf:Find("Text"), self.id)
	setActive(self._tf:Find("Text"), false)

	self.x = self._tf.localPosition.x
	self.y = self._tf.localPosition.y
	self.alive = true
	self.isNeedResetPath = true

	self:ClearPath()

	self.baseSpeed = self:GetConfig("base_speed")
	self.buffMul = 1
	self.eduMul = arg_1_3.eduBuffMul or 1
	self.moveType = self:GetConfig("movement_trait_type")
	self.moveAgr1 = self:GetConfig("movement_trait_param_1")
	self.moveAgr2 = tonumber(self:GetConfig("movement_trait_param_2"))
	self.moveMul = 1
	self._lastSegDir = nil
	self._straightCount = 0
	self._intervalTimer = 0
	self._intervalMoving = true
	self._intervalMul = 1

	if self.moveType == ReversePacmanRole.MOVE_TYPE.STATIC then
		self.moveMul = 0
	end

	self.baseRadius = ReversePacmanConst.ROLE_RADIUS[self.type]
	self.buffRadiusMul = 1

	self:InitWords()
	self:RefreshSpeedState()

	return
end

function ReversePacmanRole:NeedResetPath()
	return self.isNeedResetPath
end

function ReversePacmanRole:RequestReplan()
	self._pendingReplan = true

	return
end

function ReversePacmanRole:GetConfig(arg_4_1)
	return pg.activity_chasing_character[self.id][arg_4_1]
end

function ReversePacmanRole:SetPath(arg_5_1)
	self.path = arg_5_1 or {}
	self.pathIndex = 1
	self.isNeedResetPath = false

	return
end

function ReversePacmanRole:ClearPath()
	self.path = {}
	self.pathIndex = 1

	return
end

function ReversePacmanRole:GetCurrentNodeId(arg_7_1)
	return arg_7_1:GetNodeIdByLocalPos({
		x = self.x,
		y = self.y
	})
end

function ReversePacmanRole:GetCurrentDir(arg_8_1)
	if not self.path[self.pathIndex] then
		return {
			x = 0,
			y = 0
		}
	end

	local var_8_0 = arg_8_1:GetNodeById(self.path[self.pathIndex])

	if not var_8_0 then
		return {
			x = 0,
			y = 0
		}
	end

	local var_8_1 = var_8_0.pos.x - self.x
	local var_8_2 = math.sqrt(var_8_1 * var_8_1 + (var_8_0.pos.y - self.y) * (var_8_0.pos.y - self.y))

	if var_8_2 == 0 then
		return {
			x = 0,
			y = 0
		}
	end

	return {
		x = var_8_1 / var_8_2,
		y = (var_8_0.pos.y - self.y) / var_8_2
	}
end

function ReversePacmanRole:GetSpeedLimit()
	local var_9_0 = tonumber(self:GetConfig("max_speed"))

	if var_9_0 and var_9_0 > 0 then
		return var_9_0
	end

	return ReversePacmanRole.MAX_SPEED
end

function ReversePacmanRole:GetSpeed(arg_10_1)
	return math.min(self:GetSpeedLimit(), self.baseSpeed * ReversePacmanConst.TAG_SPEED_FACTOR[arg_10_1:GetNodeById(self.nodeId).tag] * self.buffMul * self.eduMul * self.moveMul * self._intervalMul)
end

function ReversePacmanRole:GetSpeedState(arg_11_1)
	local var_11_0 = arg_11_1 and self.nodeId and self:GetSpeed(arg_11_1) or math.min(self:GetSpeedLimit(), self.baseSpeed * self.buffMul * self.eduMul * self.moveMul * self._intervalMul)

	if var_11_0 <= 0.01 or self.moveMul <= 0 or self._intervalMul <= 0 then
		return ReversePacmanRole.SPEED_STATE.STATIC
	end

	if var_11_0 > self.baseSpeed + 0.01 then
		return ReversePacmanRole.SPEED_STATE.SPEED_UP
	end

	if var_11_0 < self.baseSpeed - 0.01 then
		return ReversePacmanRole.SPEED_STATE.SLOW_DOWN
	end

	return ReversePacmanRole.SPEED_STATE.NORMAL
end

function ReversePacmanRole:ApplySpeedState(arg_12_1)
	if self.speedState == arg_12_1 then
		return
	end

	self.speedState = arg_12_1

	setActive(self.speedUpTF, arg_12_1 == ReversePacmanRole.SPEED_STATE.SPEED_UP)
	setActive(self.slowDownTF, arg_12_1 == ReversePacmanRole.SPEED_STATE.SLOW_DOWN)
	setActive(self.staticTF, arg_12_1 == ReversePacmanRole.SPEED_STATE.STATIC)

	return
end

function ReversePacmanRole:RefreshSpeedState(arg_13_1)
	self:ApplySpeedState(self:GetSpeedState(arg_13_1 or self._lastGraph))

	return
end

function ReversePacmanRole:GetCaptureRadius()
	return self.baseRadius * self.buffRadiusMul
end

function ReversePacmanRole:GetPerformanceRange(arg_15_1)
	local var_15_0

	if not tonumber(self:GetConfig("performance_range_" .. arg_15_1)) then
		::label_15_0::

		var_15_0 = ReversePacmanConst.SHIP_PERFORMANCE_RANGE[arg_15_1] or 0
	end

	return var_15_0
end

function ReversePacmanRole:IsOccupyingNode(arg_16_1)
	if self.nodeId == arg_16_1 then
		return true
	end

	return self.path and self.path[self.pathIndex] == arg_16_1
end

function ReversePacmanRole:MoveAlongPath(arg_17_1, arg_17_2)
	if not self.alive or not arg_17_2 then
		return
	end

	if not self.path or self.pathIndex > #self.path then
		self.isNeedResetPath = true

		return
	end

	local var_17_0 = self.path[self.pathIndex]
	local var_17_1 = arg_17_2:GetRouteGraph()

	self._lastGraph = var_17_1

	if var_17_1:IsBuffBlockById(var_17_0) then
		local var_17_2 = var_17_1:GetNodeById(self.nodeId)

		self.x = var_17_2.pos.x
		self.y = var_17_2.pos.y
		self.path = {
			self.nodeId
		}
		self.pathIndex = 1
		self.isNeedResetPath = true
		self._prevNodeId = nil

		setLocalPosition(self._tf, {
			x = self.x,
			y = self.y
		})
		self:RefreshSpeedState(var_17_1)

		return
	end

	local var_17_3 = var_17_1:GetNodeById(var_17_0)
	local var_17_4 = self:GetCurrentDir(var_17_1)
	local var_17_5 = self:GetSpeed(var_17_1) * arg_17_1
	local var_17_6
	local var_17_7

	if math.sqrt((var_17_3.pos.x - self.x) * (var_17_3.pos.x - self.x) + (var_17_3.pos.y - self.y) * (var_17_3.pos.y - self.y)) <= var_17_5 then
		self.x = var_17_3.pos.x
		self.y = var_17_3.pos.y
		self.pathIndex = self.pathIndex + 1

		if self.nodeId ~= var_17_0 then
			var_17_6 = var_17_0
			var_17_7 = var_17_3
		end
	else
		self.x = self.x + var_17_4.x * var_17_5
		self.y = self.y + var_17_4.y * var_17_5
	end

	if var_17_6 and var_17_7 then
		self._prevNodeId = self.nodeId
		self.nodeId = var_17_6

		self:_OnArriveNewCell(var_17_4)

		if self._pendingReplan or self.type == ReversePacmanConst.ROLE.MONSTER and var_17_7.tag == ReversePacmanConst.TAG.JUNCTION or var_17_7.tag ~= ReversePacmanConst.TAG.CORRIDOR or self:HasBlockedInRemainingPath(var_17_1) then
			self.path = {
				self.nodeId
			}
			self.pathIndex = 1
			self.isNeedResetPath = true
		elseif self.pathIndex > #self.path then
			self.isNeedResetPath = true
		end

		self._pendingReplan = false
	end

	setLocalPosition(self._tf, {
		x = self.x,
		y = self.y
	})
	self:RefreshSpeedState(var_17_1)

	return
end

function ReversePacmanRole:_OnArriveNewCell(arg_18_1)
	if self.moveType == ReversePacmanRole.MOVE_TYPE.STRAIGHT then
		self._straightCount = self._lastSegDir and self._lastSegDir.x == arg_18_1.x and self._lastSegDir.y == arg_18_1.y and self._straightCount + 1 or 1

		if (self.moveAgr1 or math.huge) <= self._straightCount then
			self.moveMul = self.moveMul * (self.moveAgr2 or 1)
			self._straightCount = 0
		end
	elseif self.moveType == ReversePacmanRole.MOVE_TYPE.TURN and self._lastSegDir then
		if (self._lastSegDir.x * arg_18_1.x + self._lastSegDir.y * arg_18_1.y == 1 and 0 or self._lastSegDir.x * arg_18_1.x + self._lastSegDir.y * arg_18_1.y == -1 and 180 or 90) == self.moveAgr1 then
			self.moveMul = self.moveMul * (self.moveAgr2 or 1)
		end
	end

	self._lastSegDir = arg_18_1

	return
end

function ReversePacmanRole:HasBlockedInRemainingPath(arg_19_1)
	for iter_19_0 = self.pathIndex, #self.path do
		if arg_19_1:IsBuffBlockById(self.path[iter_19_0]) then
			return true
		end
	end

	return false
end

function ReversePacmanRole:GetPredictNodeId(arg_20_1)
	return self.path[self.pathIndex + arg_20_1]
end

function ReversePacmanRole:GetInterceptNodeId(arg_21_1)
	return self.path[self.pathIndex + arg_21_1]
end

function ReversePacmanRole:InitWords()
	self.words = {}

	for iter_22_0, iter_22_1 in ipairs(self:GetConfig("operation_word")) do
		self.words[iter_22_1[1]] = self.words[iter_22_1[1]] or {}

		for iter_22_2 = 2, #iter_22_1 do
			table.insert(self.words[iter_22_1[1]], i18n(iter_22_1[iter_22_2]))
		end
	end

	return
end

function ReversePacmanRole:GetWordByType(arg_23_1)
	local var_23_0 = self.words[arg_23_1] or {}

	if #var_23_0 == 0 then
		return string.format("no word config, id:%s type:%s", self.id, arg_23_1)
	end

	return var_23_0[math.random(1, #var_23_0)]
end

function ReversePacmanRole:IsAlive()
	return self.alive
end

function ReversePacmanRole:Kill()
	self.alive = false
	self.nodeId = nil
	self.path = {}
	self.pathIndex = 1
	self.speedState = nil

	setActive(self._tf, false)

	return
end

function ReversePacmanRole:AddBuff(arg_26_1)
	setImageAlpha(self.iconTF, 1)
	blinkAni(go(self.iconTF), 0.2, 1)

	local var_26_0 = tonumber(pg.activity_chasing_skill[arg_26_1].param) or 1

	if arg_26_1 == ReversePacmanConst.BUFF.SPEED then
		self.buffMul = self.buffMul * var_26_0
	elseif arg_26_1 == ReversePacmanConst.BUFF.GIANT then
		self.buffRadiusMul = self.buffRadiusMul * var_26_0

		setLocalScale(self._tf, Vector3(self.buffRadiusMul, self.buffRadiusMul, self.buffRadiusMul))
	end

	self:RefreshSpeedState()

	return
end

function ReversePacmanRole:SetEffectsScale(arg_27_1)
	for iter_27_0, iter_27_1 in ipairs({
		self.speedUpTF,
		self.slowDownTF,
		self.staticTF
	}) do
		eachChild(iter_27_1, function(arg_28_0)
			if not IsNil((arg_28_0:GetComponent(typeof(ParticleSystem)))) then
				setLocalScale(arg_28_0, Vector3(arg_27_1, arg_27_1, arg_27_1))
			end

			return
		end)
	end

	return
end

function ReversePacmanRole:ShowEffects()
	setActive(self.speedUpTF, true)
	setActive(self.slowDownTF, true)
	setActive(self.staticTF, true)

	return
end

function ReversePacmanRole:HideEffects()
	setActive(self.speedUpTF, false)
	setActive(self.slowDownTF, false)
	setActive(self.staticTF, false)

	return
end

function ReversePacmanRole:Hide()
	setActive(self._tf, false)

	return
end

function ReversePacmanRole:Update(arg_32_1)
	if not self.alive then
		return
	end

	if self.moveType == ReversePacmanRole.MOVE_TYPE.INTERVAL then
		self._intervalTimer = self._intervalTimer + arg_32_1

		if self._intervalMoving then
			if (self.moveAgr1 or 0) <= self._intervalTimer then
				self._intervalTimer = 0
				self._intervalMoving = false
				self._intervalMul = 0
			end
		elseif ((not self.moveAgr2 or nil) and 0) <= self._intervalTimer then
			self._intervalTimer = 0
			self._intervalMoving = true
			self._intervalMul = 1
		end
	end

	self:RefreshSpeedState()

	return
end

function ReversePacmanRole:Dispose()
	return
end

return ReversePacmanRole
