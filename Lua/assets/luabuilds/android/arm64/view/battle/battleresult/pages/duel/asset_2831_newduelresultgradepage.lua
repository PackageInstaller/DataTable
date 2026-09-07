local NewDuelResultGradePage = class("NewDuelResultGradePage", import("..NewBattleResultGradePage"))

function NewDuelResultGradePage:UpdateChapterName()
	local var_1_1 = getProxy(MilitaryExerciseProxy):getPreRivalById(self.contextData.rivalId or 0)

	setText(self.gradeChapterName, (var_1_1 or nil) and (var_1_1.name or ""))

	return
end

return NewDuelResultGradePage
