local RecruitLimitCompBase = require("app.view.module.recruit.view.limitRecruit.RecruitLimitCompBase")
local RecruitLimitDevilComp = class("RecruitLimitDevilComp", require("app.fairyGUI.recruitKnight.UI_RecruitLimitDevilComp"), RecruitLimitCompBase)

function RecruitLimitDevilComp:ctor()
	if not self._initSubComps then
		RecruitLimitCompBase.bindClassRef(self, RecruitLimitDevilComp)
		RecruitLimitCompBase.ctor(self)
	end
end

return RecruitLimitDevilComp
