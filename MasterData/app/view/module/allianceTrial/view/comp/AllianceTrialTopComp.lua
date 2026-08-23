local var_0_0 = g.core.model.User.allianceTrialData
local AllianceTrialTopComp = class("AllianceTrialTopComp", require("app.fairyGUI.allianceTrial.UI_AllianceTrialTopComp"))

function AllianceTrialTopComp:ctor()
	self.m_loaderBtn:addClickListener(handler(self, self._onClickLoader))
	self:newSchedule(handler(self, self._updateLastTime), 1)
end

function AllianceTrialTopComp:_updateLastTime()
	self.m_lastTime:setText(g.core.common.ServerTime:getCurWeekCountDown())
end

function AllianceTrialTopComp:_onClickLoader()
	g.core.module.ModuleManager:pushPopup(require("app.view.base.component.HelpPop").new({
		id = 383
	}), {
		touchDisappear = true
	})
end

function AllianceTrialTopComp:updateTopComp()
	self.m_stage:setText(var_0_0:getStage())
	self.m_level:setText(g.core.lang:get(2052, {
		level = var_0_0:getLevel()
	}))
	self.m_tipText:setVisible(var_0_0:isLevelFinish())
	self:_updateLastTime()
end

return AllianceTrialTopComp
