local var_0_0 = g.core.model.User.commonPassCardDataMgr
local CommonPassCardLvComp = class("CommonPassCardLvComp", require("app.fairyGUI.commonPassCard.UI_CommonPassCardLvComp"))

function CommonPassCardLvComp:ctor()
	self.m_buyLvBtn:addClickListener(handler(self, self._onBuyLvBtnClick))
end

function CommonPassCardLvComp:updatePassCardLvComp(arg_2_1)
	self._actId = arg_2_1
	self._commonPassCardData = var_0_0:getPassCardData(self._actId)

	self.m_lvTxt:setText((self._commonPassCardData:getPassCardLv()))

	local var_2_0 = self._commonPassCardData:getCurPassCardLvCfg()

	self.m_allProTxt:setText("/" .. var_2_0.exp)
	self.m_progressComp:setMax(var_2_0.exp)
	self.m_progressComp:setValue(self._commonPassCardData:getCurExp())
	self.m_curProTxt:setText(self._commonPassCardData:getCurExp())
	self.m_buyLvBtn:setVisible(not self._commonPassCardData:isMaxLv())
	self.m_isShowBuyLvController:setSelectedIndex(self._commonPassCardData:getActivityTime() + self._commonPassCardData:getActivityCfg().time <= g.core.common.ServerTime:getTime() and 1 or 0)
end

function CommonPassCardLvComp:_onBuyLvBtnClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.commonPassCard.view.CommonPassCardBuyLevelPop").new({
		activityId = self._actId
	}), {
		touchDisappear = true
	})
end

return CommonPassCardLvComp
