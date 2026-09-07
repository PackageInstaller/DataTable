local CarouselStep = class("CarouselStep", import(".StoryStep"))

function CarouselStep:Ctor(arg_1_1)
	CarouselStep.super.Ctor(self, arg_1_1)

	self.bgs = arg_1_1.bgs

	return
end

function CarouselStep:GetMode()
	return Story.MODE_CAROUSE
end

function CarouselStep:GetBgs()
	return self.bgs
end

return CarouselStep
