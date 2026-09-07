local OreEnemy = class("OreEnemy")

OreEnemy.TYPE_RIGHT_TO_LEFT = 1
OreEnemy.TYPE_LEFT_TO_RIGHT = 2
OreEnemy.BORDER_X = 300
OreEnemy.ROAD_Y = {
	20,
	-28,
	-73
}
OreEnemy.CLASH_TIME = 0.5
OreEnemy.OFFSET_Y = {
	[9] = 17,
	[5] = 17
}

function OreEnemy:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	self.binder = arg_1_1
	self._tf = arg_1_2
	self.collisionMgr = arg_1_3
	self.id = arg_1_4
	self.config = OreGameConfig.ENEMY_CONFIG[self.id]
	self.type = arg_1_6
	self.roadID = arg_1_5

	self:Init()

	return
end

function OreEnemy:AddListener()
	self.binder:bind(OreGameConfig.EVENT_AKASHI_COLLISION, function(arg_3_0, arg_3_1)
		if self.isDestroy then
			return
		end

		if self == arg_3_1.b then
			self.binder:emit(OreGameConfig.EVENT_AKASHI_HIT, {
				dir = self.type == OreEnemy.TYPE_RIGHT_TO_LEFT and "W" or "E",
				class = self.config.class,
				y = self._tf.anchoredPosition.x
			})
		end

		return
	end)
	self.binder:bind(OreGameConfig.EVENT_ENEMY_COLLISION, function(arg_4_0, arg_4_1)
		if self.isDestroy or self.clashTime then
			return
		end

		self:OnEnemyCollison(arg_4_1.a, arg_4_1.b)

		return
	end)

	return
end

function OreEnemy:AddDftAniEvent()
	eachChild(self._tf:Find("effect"), function(arg_6_0)
		arg_6_0:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
			setActive(arg_6_0, false)

			if arg_6_0.name == "EF_Clash_Heavy" then
				self:Destroy()
			end

			return
		end)

		return
	end)
	self._tf:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		self:Destroy()

		return
	end)

	return
end

function OreEnemy:Init()
	self:AddListener()
	self:AddDftAniEvent()

	self.index = tonumber(self._tf.name)

	if self.type == OreEnemy.TYPE_RIGHT_TO_LEFT then
		self.deltaX = -OreGameConfig.TIME_INTERVAL

		setLocalPosition(self._tf, Vector2(OreEnemy.BORDER_X, OreEnemy.ROAD_Y[self.roadID]))
		setLocalEulerAngles(self._tf, Vector3(0, 0, 0))
	else
		self.deltaX = OreGameConfig.TIME_INTERVAL

		setLocalPosition(self._tf, Vector2(-OreEnemy.BORDER_X, OreEnemy.ROAD_Y[self.roadID]))
		setLocalEulerAngles(self._tf, Vector3(0, 180, 0))
	end

	self.speed = self.config.speed

	self.collisionMgr:AddEnemyObject(self.roadID, self.index, self)

	self.aabbTF = self._tf:Find("Image/aabb")

	setActive(self.aabbTF, OreGameConfig.SHOW_AABB)

	self.aabb = OreGameHelper.GetAABBWithTF(self.aabbTF, self.type == OreEnemy.TYPE_LEFT_TO_RIGHT)

	setActive(self._tf:Find("Image"), true)
	self._tf:GetComponent(typeof(Animator)):Play("Initial")
	self._tf:Find("Image"):GetComponent(typeof(Animator)):Play("Move")
	eachChild(self._tf:Find("effect"), function(arg_10_0)
		setActive(arg_10_0, false)

		return
	end)

	self.posY = OreEnemy.ROAD_Y[self.roadID] + (OreEnemy.OFFSET_Y[self.id] or 0)

	return
end

function OreEnemy:SetSpeed(arg_11_1)
	self.speed = arg_11_1

	return
end

function OreEnemy:OnEnemyCollison(arg_12_1, arg_12_2)
	local var_12_0 = arg_12_1.type == OreEnemy.TYPE_RIGHT_TO_LEFT and (arg_12_1._tf.anchoredPosition.x < arg_12_2._tf.anchoredPosition.x and arg_12_1 or arg_12_2) or arg_12_2._tf.anchoredPosition.x < arg_12_1._tf.anchoredPosition.x and arg_12_1 or arg_12_2
	local var_12_2 = var_12_0 == arg_12_1 and arg_12_2 or arg_12_1
	local var_12_3 = var_12_0.config.class

	if var_12_0.config.class < (var_12_0 == arg_12_1 and arg_12_2 or arg_12_1).config.class then
		if self == var_12_0 then
			if var_12_3 <= 3 and (var_12_0 == arg_12_1 and arg_12_2 or arg_12_1).config.class <= 3 and math.abs(var_12_3 - (var_12_0 == arg_12_1 and arg_12_2 or arg_12_1).config.class) <= 1 then
				self:PlayClashLightAnim()
			else
				self:PlayClashHeavyAnim()
			end
		end
	elseif self == var_12_2 then
		self:SetSpeed(var_12_0.speed)
	end

	return
end

function OreEnemy:PlayClashLightAnim()
	self.collisionMgr:RemoveEnemyObject(self.roadID, self.index, self)
	setActive(self._tf:Find("effect/EF_Clash_Light"), true)
	self._tf:Find("Image"):GetComponent(typeof(Animator)):Play("Clash_Light")

	self.clashTime = 0
	self.startPoint = self._tf.anchoredPosition
	self.endPoint = Vector2(self.startPoint.x + (self.type == OreEnemy.TYPE_RIGHT_TO_LEFT and -150 or 150), self.startPoint.y)
	self.centerPoint = Vector2((self.startPoint.x + self.endPoint.x) / 2, self.startPoint.y + 50)

	return
end

function OreEnemy:PlayClashHeavyAnim()
	self.collisionMgr:RemoveEnemyObject(self.roadID, self.index, self)
	setActive(self._tf:Find("Image"), false)
	setActive(self._tf:Find("effect/EF_Clash_Heavy"), true)

	return
end

function OreEnemy:Destroy()
	if self.isDestroy then
		return self.isDestroy
	end

	self.isDestroy = true

	self.binder:emit(OreGameConfig.EVENT_ENEMY_DESTROY, {
		roadID = self.roadID,
		index = self.index,
		id = self.id
	})
	self.collisionMgr:RemoveEnemyObject(self.roadID, self.index, self)

	return
end

function OreEnemy:Dispose()
	self.isDestroy = true

	return
end

function OreEnemy:OnTimer(arg_17_1)
	if self.clashTime then
		if self.clashTime < OreEnemy.CLASH_TIME then
			self.clashTime = self.clashTime + arg_17_1

			setAnchoredPosition(self._tf, (OreGameHelper.GetBeziersPoints(self.startPoint, self.endPoint, self.centerPoint, self.clashTime)))
		else
			self._tf:GetComponent(typeof(Animator)):Play("fade_away")

			self.clashTime = nil
		end

		return
	end

	setLocalPosition(self._tf, {
		x = self._tf.anchoredPosition.x + self.deltaX * self.speed,
		y = self.posY
	})

	if (self._tf.anchoredPosition.x < -OreEnemy.BORDER_X - 10 or self._tf.anchoredPosition.x > OreEnemy.BORDER_X + 10) and not self.isDestroy then
		self:Destroy()
	end

	return
end

function OreEnemy:GetAABB()
	return self.aabb
end

function OreEnemy:GetCarryTriggerOffset()
	return {
		0,
		10
	}
end

function OreEnemy:GetCollisionInfo()
	local var_20_0 = 0

	var_20_0 = self.type == OreEnemy.TYPE_RIGHT_TO_LEFT and self._tf.anchoredPosition.x + self.aabbTF.anchoredPosition.x or self._tf.anchoredPosition.x - self.aabbTF.anchoredPosition.x

	return {
		pos = {
			x = var_20_0,
			y = self._tf.anchoredPosition.y + self.aabbTF.anchoredPosition.y
		},
		aabb = self:GetAABB(),
		carryOffset = self:GetCarryTriggerOffset()
	}
end

return OreEnemy
