local RecruitLimitCompBase = require("app.view.module.recruit.view.limitRecruit.RecruitLimitCompBase")
local RecruitLimitRoyalComp = class("RecruitLimitRoyalComp", require("app.fairyGUI.recruitKnight.UI_RecruitLimitRoyalComp"), RecruitLimitCompBase)

function RecruitLimitRoyalComp:ctor()
	if not self._initSubComps then
		RecruitLimitCompBase.bindClassRef(self, RecruitLimitRoyalComp)
		RecruitLimitCompBase.ctor(self)
	end
end

return RecruitLimitRoyalComp
