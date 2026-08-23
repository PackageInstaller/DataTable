local RecruitLimitCompBase = require("app.view.module.recruit.view.limitRecruit.RecruitLimitCompBase")
local RecruitLimitTwinComp = class("RecruitLimitTwinComp", require("app.fairyGUI.recruitKnight.UI_RecruitLimitTwinComp"), RecruitLimitCompBase)

function RecruitLimitTwinComp:ctor()
	if not self._initSubComps then
		RecruitLimitCompBase.bindClassRef(self, RecruitLimitTwinComp)
		RecruitLimitCompBase.ctor(self)
	end
end

return RecruitLimitTwinComp
