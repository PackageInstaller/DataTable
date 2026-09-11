local MainRequestReversePacmanActDataSequence = class("MainRequestReversePacmanActDataSequence")

function MainRequestReversePacmanActDataSequence:Execute(arg_1_1)
	getProxy(ReversePacmanDormProxy):RequestData(arg_1_1)

	return
end

return MainRequestReversePacmanActDataSequence
