local StoryTimer = class("StoryTimer")

function StoryTimer:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.duration = arg_1_2
	self.func = arg_1_1
	self.loop = arg_1_3

	return
end

function StoryTimer:Start()
	self.passed = 0
	self.running = true
	self.paused = nil
	self.handle = self.handle or UpdateBeat:CreateListener(self.Update, self)

	UpdateBeat:AddListener(self.handle)

	return
end

function StoryTimer:Pause()
	self.paused = true

	return
end

function StoryTimer:Resume()
	self.paused = nil

	return
end

function StoryTimer:Stop()
	if not self.running then
		return
	end

	self.running = false
	self.paused = nil
	self.passed = 0

	if self.handle then
		UpdateBeat:RemoveListener(self.handle)
	end

	return
end

function StoryTimer:Update()
	if not self.running or self.paused then
		return
	end

	self.passed = self.passed + Time.deltaTime

	if self.passed >= self.duration then
		self.passed = 0

		self.func()

		self.loop = self.loop - 1
	end

	if self.loop == 0 then
		self:Stop()
	end

	return
end

return StoryTimer
