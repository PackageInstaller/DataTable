local RecruitLimitCompBase = require("app.view.module.recruit.view.limitRecruit.RecruitLimitCompBase")
local RecruitLimitComTwoCompOrder = class("RecruitLimitComTwoCompOrder", require("app.fairyGUI.recruitKnight.UI_RecruitLimitComTwoCompOrder"), RecruitLimitCompBase)

function RecruitLimitComTwoCompOrder:ctor()
	if not self._initSubComps then
		RecruitLimitCompBase.bindClassRef(self, RecruitLimitComTwoCompOrder)
		RecruitLimitCompBase.ctor(self)
	end
end

function RecruitLimitComTwoCompOrder:_initOtherUI()
	if self._displayCfg.cfg.time_bg_res and #self._displayCfg.cfg.time_bg_res > 1 then
		self.m_limitTipLoader:setURL("ui://recruit/" .. self._displayCfg.cfg.time_bg_res)
	end
end

return RecruitLimitComTwoCompOrder
