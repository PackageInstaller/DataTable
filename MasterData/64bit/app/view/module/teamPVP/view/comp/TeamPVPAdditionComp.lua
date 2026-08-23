local var_0_0 = g.core.const.ConstMgr.TeamPvpConst
local TeamPVPAdditionComp = class("TeamPVPAdditionComp", require("app.fairyGUI.teamPVP.UI_TeamPVPAdditionComp"))

function TeamPVPAdditionComp:ctor()
	self._clickType = 0

	self:addClickListener(handler(self, self._onClickSelf))
end

function TeamPVPAdditionComp:updateComp(arg_2_1)
	self.m_value:setText(g.core.lang:get(420420, {
		value = arg_2_1.value
	}))

	self._clickType = arg_2_1.type or 0
end

function TeamPVPAdditionComp:_onClickSelf()
	if self._clickType == 0 then
		self:_onClickTimeTipBtn()
	else
		self:_onClickTeamTipBtn()
	end
end

function TeamPVPAdditionComp:_onClickTimeTipBtn()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.teamPVP.view.TeamPVPAddInfoPop").new({
		popType = var_0_0.ADD_POP_TYPE.TIME
	}), {
		touchDisappear = true
	})
end

function TeamPVPAdditionComp:_onClickTeamTipBtn()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.teamPVP.view.TeamPVPAddInfoPop").new({
		popType = var_0_0.ADD_POP_TYPE.TEAM
	}), {
		touchDisappear = true
	})
end

return TeamPVPAdditionComp
