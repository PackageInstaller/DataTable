local RecruitLimitCompBase = require("app.view.module.recruit.view.limitRecruit.RecruitLimitCompBase")
local RecruitLimitComTwoCompReversed = class("RecruitLimitComTwoCompReversed", require("app.fairyGUI.recruitKnight.UI_RecruitLimitComTwoCompReversed"), RecruitLimitCompBase)

function RecruitLimitComTwoCompReversed:ctor()
	if not self._initSubComps then
		RecruitLimitCompBase.bindClassRef(self, RecruitLimitComTwoCompReversed)
		RecruitLimitCompBase.ctor(self)
	end
end

function RecruitLimitComTwoCompReversed:_initOtherUI()
	if self._displayCfg.cfg.time_bg_res and #self._displayCfg.cfg.time_bg_res > 1 then
		self.m_limitTipLoader:setURL("ui://recruit/" .. self._displayCfg.cfg.time_bg_res)
	end
end

return RecruitLimitComTwoCompReversed
