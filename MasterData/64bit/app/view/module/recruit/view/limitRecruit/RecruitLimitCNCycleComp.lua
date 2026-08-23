local RecruitLimitCompBase = require("app.view.module.recruit.view.limitRecruit.RecruitLimitCompBase")
local RecruitLimitCNCycleComp = class("RecruitLimitCNCycleComp", require("app.fairyGUI.recruitKnight.UI_RecruitLimitCNCycleComp"), RecruitLimitCompBase)

function RecruitLimitCNCycleComp:ctor()
	if not self._initSubComps then
		RecruitLimitCompBase.bindClassRef(self, RecruitLimitCNCycleComp)
		RecruitLimitCompBase.ctor(self)
	end

	self._originBtnPos = self.m_tipKnightBtn1:getPosition()
end

return RecruitLimitCNCycleComp
