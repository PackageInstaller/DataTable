local var_0_0 = g.core.model.User.commonPassCardDataMgr
local var_0_1 = g.core.common.Path
local CommonPassCartRechargeItem = class("CommonPassCartRechargeItem", require("app.fairyGUI.commonPassCard.UI_CommonPassCartRechargeItem"))

CommonPassCartRechargeItem.specialType = 1
CommonPassCartRechargeItem.specialValue = 2010

function CommonPassCartRechargeItem:ctor()
	self._taskId = 0

	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._onRewardItemRenderer))
	self.m_rechargeBtn:addClickListener(handler(self, self._onRechargeClick))
end

function CommonPassCartRechargeItem:_onRechargeClick()
	g.core.common.GlobalFunc.checkBagBeforeOpRecharge(self, self._rechargeInfo, self._actId, self._taskId)
end

function CommonPassCartRechargeItem:onInitData(arg_3_1, arg_3_2)
	self._actId = arg_3_2
	self._index = arg_3_1

	self:updateView()
end

function CommonPassCartRechargeItem:_onRewardItemRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateIcon(self._rewardItems[arg_4_1 + 1])
end

function CommonPassCartRechargeItem:updateView()
	self._commonPassCardData = var_0_0:getPassCardData(self._actId)

	local var_5_0 = self._commonPassCardData:isRecharge()
	local var_5_1 = {}

	if self._index == 1 then
		local var_5_2, var_5_3 = self._commonPassCardData:getAllPassCardAwards()

		var_5_1 = var_5_3

		if not var_5_0 then
			self._taskId = 1

			local var_5_4 = self._commonPassCardData:getPassCardPayInfo(self._actId, 1)

			self._rechargeInfo = g.core.model.User.rechargeData:getRechargeInfoByTypeAndPrice(var_5_4.recharge_type, var_5_4.recharge_money)

			self.m_rechargeBtn:setTitle(self._rechargeInfo.moneyUnit .. self._rechargeInfo.realMoney)
		else
			self.m_rechargeBtn:setTitle(g.core.lang:get(421405))
		end

		self.m_itemLoader:setURL(var_0_1:getCommonPassCardIcon(self._commonPassCardData:getActivityCfg().entrance_res, 1))
		self.m_stateController:setSelectedIndex(var_5_0 and 1 or 0)
	else
		local var_5_5 = self._commonPassCardData:getRechargeType()
		local var_5_6 = var_5_5 == 2 or var_5_5 == 3

		self._taskId = 2

		local var_5_7 = self._commonPassCardData:getPassCardPayInfo(self._actId, 2)

		if var_5_5 == 1 then
			var_5_7 = self._commonPassCardData:getPassCardPayInfo(self._actId, 3)
			self._taskId = 3
		end

		var_5_1 = g.core.common.Drops:getGoodsArray(var_5_7.drop_id)
		self._rechargeInfo = g.core.model.User.rechargeData:getRechargeInfoByTypeAndPrice(var_5_7.recharge_type, var_5_7.recharge_money)

		self.m_rechargeBtn:setTitle(self._rechargeInfo.moneyUnit .. self._rechargeInfo.realMoney)
		self.m_stateController:setSelectedIndex(var_5_6 and 1 or 0)

		if var_5_6 then
			self.m_rechargeBtn:setTitle(g.core.lang:get(421405))
		end

		self.m_itemLoader:setURL(var_0_1:getCommonPassCardIcon(self._commonPassCardData:getActivityCfg().entrance_res, 2))
	end

	self.m_extTeamGroup:setVisible(g.core.model.User.newSlgDevelopData:getMaxTroopNum() < g.core.model.User.newSlgData:getMaxTeamCnt())

	self._rewardItems = var_5_1

	self.m_rewardList:setNumItems(#self._rewardItems)
end

return CommonPassCartRechargeItem
