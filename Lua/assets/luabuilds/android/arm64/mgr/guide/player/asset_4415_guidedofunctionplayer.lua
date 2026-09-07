local GuideDoFunctionPlayer = class("GuideDoFunctionPlayer", import(".GuidePlayer"))

function GuideDoFunctionPlayer:OnExecution(arg_1_1, arg_1_2)
	arg_1_1:GetFunction()()
	arg_1_2()

	return
end

return GuideDoFunctionPlayer
