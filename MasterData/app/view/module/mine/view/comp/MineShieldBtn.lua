local var_0_0 = g.core.model.User.mineData
local MineShieldBtn = class("MineShieldBtn", require("app.fairyGUI.mine.UI_MineShieldBtn"))

function MineShieldBtn:ctor()
	self:addClickListener(handler(self, self._onClickSelf))

	if var_0_0:isShieldingShield() then
		self:setVisible(false)
	end
end

function MineShieldBtn:onLoad()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp
	})
end

function MineShieldBtn:onCD()
	if var_0_0:isMeHasShield() then
		self.m_haveShieldController:setSelectedIndex(1)
		self.m_shieldTimeTxt:setText((var_0_0:getShieldLastTimeStr()))
	else
		self.m_haveShieldController:setSelectedIndex(0)
	end
end

function MineShieldBtn:_onClickSelf()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.mine.view.pop.MineShieldPop").new(), {
		touchDisappear = true
	})
end

return MineShieldBtn
