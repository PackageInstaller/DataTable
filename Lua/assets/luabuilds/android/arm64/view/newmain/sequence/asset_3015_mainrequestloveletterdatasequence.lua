local MainRequestLoveLetterDataSequence = class("MainRequestLoveLetterDataSequence")

function MainRequestLoveLetterDataSequence:Execute(arg_1_1)
	getProxy(LoveLetterProxy):GetSystemData(arg_1_1)

	return
end

return MainRequestLoveLetterDataSequence
