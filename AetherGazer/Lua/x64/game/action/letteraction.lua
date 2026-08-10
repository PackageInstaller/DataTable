local var_0_0 = {}

manager.net:Bind(30017, function(arg_1_0)
	LetterData.LetterInit(arg_1_0)
	var_0_0.UpdateLettersRedPoint()
end)

function var_0_0.TryToCheckLetter(arg_2_0)
	manager.net:SendWithLoadingNew(30018, {
		id = arg_2_0
	}, 30019, var_0_0.OnCheckLetter)
end

function var_0_0.OnCheckLetter(arg_3_0)
	return
end

function var_0_0.SortLetters()
	LetterData.SortLetters()
end

function var_0_0.ReadLetter(arg_5_0)
	var_0_0.TryToCheckLetter(arg_5_0)
	LetterData.CacheReadFlag(arg_5_0)
end

function var_0_0.UpdateLettersRedPoint()
	local var_6_0 = LetterData.GetLetters()

	for iter_6_0, iter_6_1 in pairs(var_6_0) do
		var_0_0.UpdateLetterRedPoint(iter_6_0)
	end
end

function var_0_0.UpdateLetterRedPoint(arg_7_0)
	manager.redPoint:setTip(RedPointConst.LETTER_ID .. arg_7_0, LetterData.GetLetter(arg_7_0).isViewed and 0 or 1)
end

return var_0_0
