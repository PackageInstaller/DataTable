local CGStep = class("CGStep", import(".StoryStep"))

function CGStep:Ctor(arg_1_1)
	CGStep.super.Ctor(self, arg_1_1)

	self.bgs = arg_1_1.bgs or {}
	self.hideBgAlpha = true
	self.reflux = arg_1_1.reflux

	return
end

function CGStep:GetMode()
	return Story.MODE_CG
end

function CGStep:GetBgs()
	if self.reflux then
		return getProxy(RefluxProxy):GetRefluxBgs()
	end

	return self.bgs
end

return CGStep
