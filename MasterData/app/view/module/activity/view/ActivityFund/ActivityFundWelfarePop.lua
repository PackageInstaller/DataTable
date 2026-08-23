local ActivityFundWelfarePop = class("ActivityFundWelfarePop", require("app.fairyGUI.activity.UI_ActivityFundWelfarePop"), function()
	return fgui.GComponent:create({
		resName = "ActivityFundWelfarePop",
		pkgPath = "ui/activity/activity",
		pkgName = "activity"
	})
end)

function ActivityFundWelfarePop:ctor(arg_2_1, arg_2_2)
	self:showAtCenter()

	self._jumpParams = arg_2_2

	if g.core.model.User.activityFundData:isRechargeFund(arg_2_2.stageId) then
		self.m_goToRecharge:setVisible(false)
	end

	self.m_goToRecharge:addClickListener(handler(self, self._onClickBuy))

	self._fundType = arg_2_1

	self.m_welfareList:setVirtual()
	self.m_welfareList:setItemRenderer(handler(self, self._updateAwardCell))
end

function ActivityFundWelfarePop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFUNDRECHARGEAWARD, self._onRcvFundReward, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_NOTIFYSUCCESS, self._onRcvRechargeSuccess, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_FUNDBUYNOTIFY, handler(self, self._onRcvFundNitify), self)
	self:_updateBuyState()
	self:_updateList()
end

function ActivityFundWelfarePop:_onRcvFundReward(arg_4_1, arg_4_2, arg_4_3)
	if arg_4_3.id then
		self:_updateList()
	end
end

function ActivityFundWelfarePop:_onRcvRechargeSuccess(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	self:_updateBuyState()
end

function ActivityFundWelfarePop:_onRcvFundNitify(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	self:_updateList()
	self:_updateBuyState()
end

function ActivityFundWelfarePop:_updateBuyState()
	if g.core.model.User.activityFundData:isRechargeFundByType(self._fundType) then
		self.m_goToRecharge:setVisible(false)
	end

	self.m_curTimesTxt:setText((g.core.model.User.activityFundData:getActiveNumByType(self._fundType)))
end

function ActivityFundWelfarePop:_updateList()
	self._awardData = g.core.model.User.activityFundData:getFundWelfareDataByType(self._fundType)

	self.m_welfareList:setNumItems(#self._awardData)
end

function ActivityFundWelfarePop:_updateAwardCell(arg_9_1, arg_9_2)
	arg_9_2:updateAward({
		data = self._awardData[arg_9_1 + 1]
	})
end

function ActivityFundWelfarePop:_onClickBuy()
	g.core.module.ModuleManager:popComponent()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.activity.view.ActivityFund.ActivityFuncBuyPop").new(self._jumpParams)))
end

return ActivityFundWelfarePop
