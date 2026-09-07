local SpAnimStep = class("SpAnimStep", import(".StoryStep"))

function SpAnimStep:Ctor(arg_1_1)
	SpAnimStep.super.Ctor(self, arg_1_1)

	self.name = arg_1_1.name
	self.actionName = defaultValue(arg_1_1.actionName, "normal")
	self.speed = defaultValue(arg_1_1.speed, 1)
	self.hideSkip = defaultValue(arg_1_1.hideSkip, false)
	self.stopTime = defaultValue(arg_1_1.stopTime, 0)

	return
end

function SpAnimStep:GetMode()
	return Story.MODE_SPANIM
end

function SpAnimStep:GetSpineName()
	return self.name
end

function SpAnimStep:GetActionName()
	return self.actionName
end

function SpAnimStep:ShouldAdjustSpeed()
	return self:GetSpeed() ~= 1
end

function SpAnimStep:GetSpeed()
	return self.speed
end

function SpAnimStep:ShouldHideSkipBtn()
	return self.hideSkip
end

function SpAnimStep:HasStopTime()
	return self:GetStopTime() ~= 0
end

function SpAnimStep:GetStopTime()
	return self.stopTime
end

return SpAnimStep
