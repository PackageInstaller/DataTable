local var_0_0 = import("game.views.sectionSelectHero.SectionComboSelectView")
local var_0_1 = class("PolyhedronComboSkillSelectView", var_0_0)

function var_0_1.SetComboSkillID(arg_1_0, arg_1_1)
	BattleFieldAction.SetComboInfo(arg_1_0.stageType_, arg_1_0.params_.activityID, arg_1_1, 0, 0)
end

return var_0_1
