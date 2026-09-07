local GuideDoFunctionStep = class("GuideDoFunctionStep", import(".GuideStep"))

function GuideDoFunctionStep:Ctor(arg_1_1)
	GuideDoFunctionStep.super.Ctor(self, arg_1_1)

	self.func = arg_1_1.doFunc

	return
end

function GuideDoFunctionStep:GetType()
	return GuideStep.TYPE_DOFUNC
end

function GuideDoFunctionStep:GetFunction()
	return self.func
end

function GuideDoFunctionStep:ExistTrigger()
	return true
end

return GuideDoFunctionStep
