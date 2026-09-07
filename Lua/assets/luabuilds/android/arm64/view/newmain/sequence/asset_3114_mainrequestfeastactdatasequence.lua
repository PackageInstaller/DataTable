local MainRequestFeastActDataSequence = class("MainRequestFeastActDataSequence")

function MainRequestFeastActDataSequence:Execute(arg_1_1)
	getProxy(FeastProxy):RequestData(arg_1_1)

	return
end

return MainRequestFeastActDataSequence
