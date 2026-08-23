local RecruitLimitCompBase = require("app.view.module.recruit.view.limitRecruit.RecruitLimitCompBase")
local RecruitLimitComonUICfg = require("app.view.module.recruit.const.RecruitLimitComonUICfg")
local RecruitLimitComTwoComp = class("RecruitLimitComTwoComp", require("app.fairyGUI.recruitKnight.UI_RecruitLimitComTwoComp"), RecruitLimitCompBase)

function RecruitLimitComTwoComp:ctor()
	if not self._initSubComps then
		RecruitLimitCompBase.bindClassRef(self, RecruitLimitComTwoComp)
		RecruitLimitCompBase.ctor(self)
	end
end

function RecruitLimitComTwoComp:_initOtherUI()
	local var_2_0 = RecruitLimitComonUICfg.getUICfg(self._recruitCfg.id)

	self.m_titleLoader:setURL(var_2_0.titleRes)
	self.m_titleLoader:setPosition(cc.pAdd(self.m_titleLoader:getPosition(), var_2_0.titleOffset))
	self.m_limitTipLoader:setURL(var_2_0.limitTimesTipBgRes)
	self.m_limitTipLoader:setPosition(cc.pAdd(self.m_limitTipLoader:getPosition(), var_2_0.limitTimesTipBgOffset))
end

return RecruitLimitComTwoComp
