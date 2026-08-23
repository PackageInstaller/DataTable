local GmFundConst = require("app.view.module.newFund.const.GmFundConst")
local var_0_1 = {
	[0] = 784,
	785,
	786
}
local var_0_2 = g.core.model.User.gmFundData
local BaseFundNewBtn = class("BaseFundNewBtn", require("app.fairyGUI.base_new.UI_BaseFundNewBtn"))

function BaseFundNewBtn:ctor()
	self:addClickListener(handler(self, self._onClick))
end

function BaseFundNewBtn:onLoad()
	local var_2_0 = self.m_typeController:getSelectedIndex()

	self:setVisible(var_0_2:hasActivityFund(var_2_0 + 1))
	self.m_redPointComp:setId(var_0_1[var_2_0])
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp
	})
end

function BaseFundNewBtn:_onClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.newFund.view.FundNewPop").new({
		fundType = self.m_typeController:getSelectedIndex() + 1
	}), {
		touchDisappear = true
	})
end

return BaseFundNewBtn
