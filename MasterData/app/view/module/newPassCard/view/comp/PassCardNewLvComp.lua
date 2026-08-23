local var_0_0 = g.core.model.User.gmPassCardData
local PassCardNewLvComp = class("PassCardNewLvComp", require("app.fairyGUI.newPassCard.UI_PassCardNewLvComp"))

function PassCardNewLvComp:ctor()
	self.m_buyLvBtn:addClickListener(handler(self, self._onBuyLvBtnClick))
end

function PassCardNewLvComp:updatePassCardLvComp()
	self.m_lvTxt:setText((var_0_0:getPassCardLv()))

	local var_2_0 = var_0_0:getCurPassCardLvCfg()

	self.m_allProTxt:setText("/" .. var_2_0.exp)
	self.m_progressComp:setMax(var_2_0.exp)
	self.m_progressComp:setValue(var_0_0:getCurExp())
	self.m_curProTxt:setText(var_0_0:getCurExp())
	self.m_buyLvBtn:setVisible(not var_0_0:isMaxLv())
end

function PassCardNewLvComp:_onBuyLvBtnClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.newPassCard.view.PassCardNewBuyLevelPop").new(), {
		touchDisappear = true
	})
end

return PassCardNewLvComp
