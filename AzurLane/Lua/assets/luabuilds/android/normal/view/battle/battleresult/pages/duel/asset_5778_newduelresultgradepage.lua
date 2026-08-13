class = var_0_10000

local var_0_0 = "NewDuelResultGradePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..NewBattleResultGradePage"))

function var_0_1.UpdateChapterName(arg_1_0)
	local var_1_0 = arg_1_0.contextData

	getProxy = var_1_10002
	MilitaryExerciseProxy = var_1_10003

	local var_1_1 = var_1_10002(var_1_10003)
	local var_1_2 = var_2.getPreRivalById
	local var_1_3

	if not var_1_0.rivalId then
		var_1_3 = 0
	end

	local var_1_4

	if not var_1_2(var_1_1, var_1_3) or not var_2.name then
		var_1_4 = ""
	end

	setText = var_1_3

	var_1_3(arg_1_0.gradeChapterName, var_1_4)

	return
end

return var_0_1
