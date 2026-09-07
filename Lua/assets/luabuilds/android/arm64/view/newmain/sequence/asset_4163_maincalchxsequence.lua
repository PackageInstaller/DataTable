local MainCalcHxSequence = class("MainCalcHxSequence")

function MainCalcHxSequence:Execute(arg_1_1)
	HXSet.calcLocalizationUse()
	arg_1_1()

	return
end

return MainCalcHxSequence
