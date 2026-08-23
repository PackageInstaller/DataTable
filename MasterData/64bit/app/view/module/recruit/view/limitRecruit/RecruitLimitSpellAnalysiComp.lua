local RecruitLimitCompBase = require("app.view.module.recruit.view.limitRecruit.RecruitLimitCompBase")
local RecruitLimitSpellAnalysiComp = class("RecruitLimitSpellAnalysiComp", require("app.fairyGUI.recruitKnight.UI_RecruitLimitSpellAnalysiComp"), RecruitLimitCompBase)

function RecruitLimitSpellAnalysiComp:ctor()
	if not self._initSubComps then
		RecruitLimitCompBase.bindClassRef(self, RecruitLimitSpellAnalysiComp)
		RecruitLimitCompBase.ctor(self)
	end
end

return RecruitLimitSpellAnalysiComp
