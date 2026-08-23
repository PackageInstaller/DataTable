local ActivityFundBuyPop = class("ActivityFundBuyPop", require("app.fairyGUI.activity.UI_ActivityFuncBuyPop"), function()
	return fgui.GComponent:create({
		resName = "ActivityFuncBuyPop",
		pkgPath = "ui/activity/activity",
		pkgName = "activity"
	})
end)

function ActivityFundBuyPop:ctor(arg_2_1)
	self:showAtCenter()

	self._data = arg_2_1
	self._rechargeInfo = nil
	self._demoCfg = nil

	self.m_rechargeBtn:addClickListener(handler(self, self._onClickBuy))
	self.m_nowGetList:setVirtual()
	self.m_nowGetList:setItemRenderer(handler(self, self._updateAwardCell))
	self.m_allCanGetList:setVirtual()
	self.m_allCanGetList:setItemRenderer(handler(self, self._updateAllAwardCell))

	self._achieveAward, self._allAward = g.core.model.User.activityFundData:getFundAdvanceAward(self._data.stageId)
end

function ActivityFundBuyPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_NOTIFYSUCCESS, self._onRcvRechargeSuccess, self)
	self:_updateView()
end

function ActivityFundBuyPop:_updateView()
	self.m_nameTxt:setText(g.core.lang:get(405604 + self._data.fundType, {
		num = self._data.fundStage
	}))
	self.m_typeController:setSelectedIndex(self._data.fundType - 1)

	local var_4_0 = g.core.model.User.activityFundData:getRechargeDemo(self._data.fundType, self._data.stageId)

	self._demoCfg = var_4_0

	local var_4_1 = g.core.model.User.rechargeData:getRechargeInfoByTypeAndPrice(g.core.const.ConstMgr.RechargeConst.FUND_ID, var_4_0.money)

	self.m_priceTxt:setText(var_4_1.moneyUnit .. var_4_1.realMoney)

	self._rechargeInfo = var_4_1

	self.m_nowGetList:setNumItems(#self._achieveAward)

	if #self._achieveAward == 0 then
		self.m_hasCanGetController:setSelectedIndex(0)
	else
		self.m_hasCanGetController:setSelectedIndex(1)
	end

	self.m_allCanGetList:setNumItems(#self._allAward)
end

function ActivityFundBuyPop:_onRcvRechargeSuccess(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	g.core.module.ModuleManager:popComponent()
end

function ActivityFundBuyPop:_updateAwardCell(arg_6_1, arg_6_2)
	arg_6_2:updateIcon({
		type = self._achieveAward[arg_6_1 + 1].type,
		value = self._achieveAward[arg_6_1 + 1].value,
		size = self._achieveAward[arg_6_1 + 1].size
	})
end

function ActivityFundBuyPop:_updateAllAwardCell(arg_7_1, arg_7_2)
	arg_7_2:updateIcon({
		type = self._allAward[arg_7_1 + 1].type,
		value = self._allAward[arg_7_1 + 1].value,
		size = self._allAward[arg_7_1 + 1].size
	})
end

function ActivityFundBuyPop:_onClickBuy()
	g.core.common.GlobalFunc.checkBagBeforeOpRecharge(self, self._rechargeInfo, self._demoCfg.id, 0)
end

return ActivityFundBuyPop
