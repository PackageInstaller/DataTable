local PolyhedronComboSkillSelectView = class("PolyhedronComboSkillSelectView", (import("game.views.sectionSelectHero.SectionComboSelectView")))

function PolyhedronComboSkillSelectView:SetComboSkillID(arg_1_1)
	BattleFieldAction.SetComboInfo(self.stageType_, self.params_.activityID, arg_1_1, 0, 0)
end

return PolyhedronComboSkillSelectView
