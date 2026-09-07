local Ore = class("Ore")

Ore.TYPE_SMALL = 1
Ore.TYPE_LA = 2
Ore.FallTime = 1

function Ore:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	self.binder = arg_1_1
	self._tf = arg_1_2
	self.collisionMgr = arg_1_3
	self.id = arg_1_4
	self.config = OreGameConfig.ORE_CONFIG[self.id]
	self.startPoint = arg_1_5

	self:Init()

	return
end

function Ore:AddListener()
	self.binder:bind(OreGameConfig.EVENT_UPDATE_ORE_TARGET, function(arg_3_0, arg_3_1)
		if not self.isDestroy then
			setActive(findTF(self.effectTF, "Frame"), self.index == arg_3_1.index)
		end

		self.isTarget = self.index == arg_3_1.index

		return
	end)
	self.binder:bind(OreGameConfig.EVENT_CHECK_CARRY, function(arg_4_0, arg_4_1)
		if not self.isDestroy and self.isTarget then
			if arg_4_1.weight + self.config.weight > OreGameConfig.MAX_WEIGHT then
				setActive(findTF(self.effectTF, "Limit"), true)
				setActive(findTF(self.effectTF, "Full"), true)
			else
				self.binder:emit(OreGameConfig.EVENT_DO_CARRY, {
					weight = self.config.weight,
					point = self.config.score,
					type = self.config.type
				})
				self.animator:Play("Vanish")
				self.collisionMgr:RemoveOreObject(self.index, self)
			end
		end

		return
	end)

	return
end

function Ore:AddDftAniEvent()
	findTF(self._tf, "main"):GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		self:Destroy()

		return
	end)
	findTF(self._tf, "main/Image"):GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		self:Destroy()

		return
	end)
	findTF(self.effectTF, "Limit"):GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		setActive(findTF(self.effectTF, "Limit"), false)

		return
	end)
	findTF(self.effectTF, "Full"):GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		setActive(findTF(self.effectTF, "Full"), false)

		return
	end)

	return
end

function Ore:Init()
	setAnchoredPosition(self._tf, self.startPoint)

	self.effectTF = findTF(self._tf, "effect")
	self.animator = findTF(self._tf, "main/Image"):GetComponent(typeof(Animator))
	self.index = self._tf.name
	self.endPoint = findTF(self._tf.parent.parent, "pos/" .. self._tf.name).anchoredPosition
	self.centerPoint = Vector2(self.startPoint.x + (math.random() > 0.5 and -10 or 10), self.startPoint.y + 80)
	self.time = 0
	self.isFallEnd = false
	self.isTarget = false

	self:AddListener()
	self:AddDftAniEvent()
	self._tf:Find("main"):GetComponent(typeof(Animator)):Play("Initial")
	self._tf:Find("main/Image"):GetComponent(typeof(Animator)):Play("Fall")
	eachChild(self.effectTF, function(arg_11_0)
		setActive(arg_11_0, false)

		return
	end)

	return
end

function Ore:FallEnd()
	self.animator:Play("Spawn")

	self.isFallEnd = true

	self.collisionMgr:AddOreObject(self.index, self)

	return
end

function Ore:PlayBlink()
	findTF(self._tf, "main"):GetComponent(typeof(Animator)):Play("Blink")

	return
end

function Ore:Destroy()
	if self.isDestroy then
		return
	end

	self.binder:emit(OreGameConfig.EVENT_ORE_DESTROY, {
		index = self.index,
		id = self.id
	})
	self.collisionMgr:RemoveOreObject(self.index, self)

	self.isDestroy = true

	return
end

function Ore:Dispose()
	self.isDestroy = true

	return
end

function Ore:OnTimer(arg_16_1)
	if self.time < Ore.FallTime then
		self.time = self.time + arg_16_1

		setAnchoredPosition(self._tf, (OreGameHelper.GetBeziersPoints(self.startPoint, self.endPoint, self.centerPoint, self.time)))
	elseif not self.isFallEnd then
		self:FallEnd()
	end

	if self.isFallEnd then
		self.time = self.time + arg_16_1

		if self.time > Ore.FallTime + self.config.duration then
			self:PlayBlink()
		end
	end

	return
end

function Ore:GetAABB()
	if self.config.size == Ore.TYPE_SMALL then
		return {
			{
				-7,
				7
			},
			{
				7,
				-7
			}
		}
	else
		return {
			{
				-11,
				11
			},
			{
				13,
				-13
			}
		}
	end

	return
end

function Ore:GetCollisionInfo()
	return {
		pos = self._tf.anchoredPosition,
		aabb = self:GetAABB()
	}
end

return Ore
