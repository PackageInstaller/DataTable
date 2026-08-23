local var_0_0 = g.core.common.ServerTime
local var_0_1 = g.core.model.User.redCliffData
local var_0_2 = g.core.const.ConstMgr.RedCliffConst
local RedCliffDetailComp = class("RedCliffDetailComp", require("app.fairyGUI.redCliff.UI_RedCliffDetailComp"))

function RedCliffDetailComp:ctor()
	self.m_ruleBtn:addClickListener(handler(self, self._onClickRuleBtn))
end

function RedCliffDetailComp:updateDetailView()
	local var_2_0, var_2_1 = var_0_1:getGameStageDuration(var_0_2.GAME_STAGE.LADDER)
	local var_2_2, var_2_3 = var_0_1:getGameStageDuration(var_0_2.GAME_STAGE.FINAL)

	self.m_ladderTimeTxt:setText(g.core.lang:get(421021, {
		time1 = var_0_0:getDateMDFormat(var_2_0),
		time2 = var_0_0:getDateMDFormat(var_2_1)
	}))
	self.m_finalTimeTxt:setText(g.core.lang:get(421021, {
		time1 = var_0_0:getDateMDFormat(var_2_2),
		time2 = var_0_0:getDateMDFormat(var_2_3)
	}))
end

function RedCliffDetailComp:_onClickRuleBtn()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.redCliff.view.mainView.RedCliffRulePop").new(), {
		ignoreTouch = false,
		touchDisappear = true
	})
end

return RedCliffDetailComp
