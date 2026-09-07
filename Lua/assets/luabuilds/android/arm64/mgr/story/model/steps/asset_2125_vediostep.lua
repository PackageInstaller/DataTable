local VedioStep = class("VedioStep", import(".StoryStep"))

function VedioStep:Ctor(arg_1_1)
	VedioStep.super.Ctor(self, arg_1_1)

	self.cpkPath = arg_1_1.cpkPath
	self.skippable = defaultValue(arg_1_1.skippable, true)
	self.blackFg = 1

	return
end

function VedioStep:GetMode()
	return Story.MODE_VEDIO
end

function VedioStep:GetVedioPath()
	return self.cpkPath
end

function VedioStep:GetSkipFlag()
	return self.skippable
end

return VedioStep
