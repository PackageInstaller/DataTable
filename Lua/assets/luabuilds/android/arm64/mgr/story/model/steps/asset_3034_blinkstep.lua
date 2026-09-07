local BlinkStep = class("BlinkStep", import(".StoryStep"))

function BlinkStep:Ctor(arg_1_1)
	BlinkStep.super.Ctor(self, arg_1_1)

	self.openRange = arg_1_1.openRange or {
		1,
		0.6
	}
	self.openTime = arg_1_1.open or 1
	self.closeRange = arg_1_1.closeRange or {
		0.6,
		1
	}
	self.closeTime = arg_1_1.close or 1
	self.holdRange = arg_1_1.holdRange or {
		1,
		1
	}
	self.holdTime = arg_1_1.hold or 1
	self.ease = arg_1_1.ease or LeanTweenType.easeInOutQuad
	self.nextBgName = arg_1_1.nextBgName
	self.blurTimeFactor = arg_1_1.blurTimeFactor or {
		0.7,
		0.9
	}

	return
end

function BlinkStep:GetMode()
	return Story.MODE_BLINK
end

function BlinkStep:GetOpenEyeData()
	return {
		open = Vector3(self.openRange[1], self.openRange[2], self.openTime),
		close = Vector3(self.closeRange[1], self.closeRange[2], self.closeTime),
		hold = Vector3(self.holdRange[1], self.holdRange[2], self.holdTime),
		ease = self.ease
	}
end

function BlinkStep:GetNextBgName()
	return self.nextBgName
end

return BlinkStep
