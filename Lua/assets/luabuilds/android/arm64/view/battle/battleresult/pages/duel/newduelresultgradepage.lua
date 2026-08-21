local var_0_0 = class("NewDuelResultGradePage", import("..NewBattleResultGradePage"))

function var_0_0.UpdateChapterName(arg_1_0)
	local var_1_0 = arg_1_0.contextData.rivalId or 0
	local var_1_1 = getProxy(MilitaryExerciseProxy):getPreRivalById(var_1_0)

	if var_1_1 then
		local var_1_2 = var_1_1.name or ""

		setText(arg_1_0.gradeChapterName, var_1_2)

		return
	end
end

return var_0_0
