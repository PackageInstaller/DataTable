local GuideDoNothingStep = class("GuideDoNothingStep", import(".GuideStep"))

function GuideDoNothingStep:Ctor(arg_1_1)
	GuideDoNothingStep.super.Ctor(self, arg_1_1)

	self.eventFlag = arg_1_1.doNothing

	return
end

function GuideDoNothingStep:GetType()
	return GuideStep.TYPE_DONOTHING
end

function GuideDoNothingStep:ExistTrigger()
	return self.eventFlag
end

return GuideDoNothingStep
