local RecruitLimitCompBase = require("app.view.module.recruit.view.limitRecruit.RecruitLimitCompBase")
local RecruitLimitAllianPillarComp = class("RecruitLimitAllianPillarComp", require("app.fairyGUI.recruitKnight.UI_RecruitLimitAllianPillarComp"), RecruitLimitCompBase)

function RecruitLimitAllianPillarComp:ctor()
	if not self._initSubComps then
		RecruitLimitCompBase.bindClassRef(self, RecruitLimitAllianPillarComp)
		RecruitLimitCompBase.ctor(self)
	end
end

function RecruitLimitAllianPillarComp:_continueRecruit(arg_2_1)
	return
end

return RecruitLimitAllianPillarComp
