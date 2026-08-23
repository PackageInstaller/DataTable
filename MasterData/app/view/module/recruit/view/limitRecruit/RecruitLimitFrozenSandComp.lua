local RecruitLimitCompBase = require("app.view.module.recruit.view.limitRecruit.RecruitLimitCompBase")
local RecruitLimitFrozenSandComp = class("RecruitLimitFrozenSandComp", require("app.fairyGUI.recruitKnight.UI_RecruitLimitFrozenSandComp"), RecruitLimitCompBase)

function RecruitLimitFrozenSandComp:ctor()
	if not self._initSubComps then
		RecruitLimitCompBase.bindClassRef(self, RecruitLimitFrozenSandComp)
		RecruitLimitCompBase.ctor(self)
	end
end

return RecruitLimitFrozenSandComp
