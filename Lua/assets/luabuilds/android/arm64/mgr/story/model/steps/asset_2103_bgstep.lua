local BgStep = class("BgStep", import(".DialogueStep"))

function BgStep:Ctor(arg_1_1)
	BgStep.super.Ctor(self, arg_1_1)

	self.bgSpeed = arg_1_1.bgSpeed
	self.blankScreenTime = arg_1_1.blankScreen
	self.unscaleDelay = arg_1_1.unscaleDelay or 0
	self.subBg = arg_1_1.subBgName

	return
end

function BgStep:GetMode()
	return Story.MODE_BG
end

function BgStep:GetFadeSpeed()
	return self.bgSpeed or 0.5
end

function BgStep:GetSubBg()
	return self.subBg
end

function BgStep:GetPainting()
	return nil
end

function BgStep:ShouldBlackScreen()
	return self.blankScreenTime
end

function BgStep:GetUnscaleDelay()
	return self.unscaleDelay
end

return BgStep
