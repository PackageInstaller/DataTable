local OreMiner = class("OreMiner")

function OreMiner:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.binder = arg_1_1
	self._tf = arg_1_2
	self.interval = arg_1_3
	self.animator = findTF(self._tf, "Image"):GetComponent(typeof(Animator))

	self:Init()

	return
end

function OreMiner:AddListener()
	self.binder:bind(OreGameConfig.EVENT_ORE_EF_MINED, function(arg_3_0, arg_3_1)
		self:PlayEFMined(arg_3_1.index)

		return
	end)

	return
end

function OreMiner:AddDftAniEvent()
	findTF(self._tf, "Image"):GetComponent(typeof(DftAniEvent)):SetTriggerEvent(function()
		self.binder:emit(OreGameConfig.EVENT_ORE_NEW, {
			index = self.index,
			pos = self._tf.parent.anchoredPosition
		})

		return
	end)
	findTF(self._tf, "EF"):GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		setActive(findTF(self._tf, "EF"), false)

		return
	end)

	return
end

function OreMiner:Init()
	self:AddListener()
	self:AddDftAniEvent()

	self.time = 1.5
	self.index = self._tf.name

	return
end

function OreMiner:Reset()
	self.interval = 1.5 + math.random()
	self.time = 1.5

	return
end

function OreMiner:PlayEFMined(arg_9_1)
	if self.index == arg_9_1 then
		setActive(findTF(self._tf, "EF"), true)
	end

	return
end

function OreMiner:OnTimer(arg_10_1)
	if self.time >= self.interval then
		self.animator:Play("Mining")

		self.time = 0
	end

	self.time = self.time + arg_10_1

	return
end

return OreMiner
