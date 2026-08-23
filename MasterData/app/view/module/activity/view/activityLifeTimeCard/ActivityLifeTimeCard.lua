local var_0_0 = g.core.event.EventManager
local var_0_1 = g.core.event.enum
local var_0_2 = g.core.model.User.activityLifeTimeCardData
local ActivityLifeTimeCard = class("ActivityLifeTimeCard", require("app.fairyGUI.activity.UI_ActivityLifeTimeCard"))

function ActivityLifeTimeCard:ctor()
	self._state = 0
	self._subscriptionIds = {}
	self._buyAwardList = {}
	self._subscriptionRewards = {}
	self._rechargeInfo = {}

	self:_initView()
end

function ActivityLifeTimeCard:_initView()
	self.m_rechargeBtn:addClickListener(handler(self, self._onClickBtn))
	self.m_privilegeList:setVirtual()
	self.m_privilegeList:setItemRenderer(handler(self, self._onRenderPrivilegeList))
	self.m_dailyAwardList:setVirtual()
	self.m_dailyAwardList:setItemRenderer(handler(self, self._onRenderDailyAwardList))
	self.m_rechargeAwardList:setVirtual()
	self.m_rechargeAwardList:setItemRenderer(handler(self, self._onRenderRechargeAwardList))

	self._subscriptionIds = var_0_2:getSubscriptionIds()
	self._buyAwardList = var_0_2:getBuyAwardList()
	self._subscriptionRewards = var_0_2:getSubscriptionRewards()
	self._rechargeInfo = var_0_2:getRechargeInfo()

	self.m_priceText:setText(self._rechargeInfo.moneyUnit .. self._rechargeInfo.realMoney)

	self.m_privilegeInfos = {
		405616,
		405617,
		405618,
		405619,
		405629,
		405620,
		405621
	}

	self.m_privilegeList:setNumItems(#self.m_privilegeInfos)
	self.m_rechargeAwardList:setNumItems(#self._buyAwardList)
end

function ActivityLifeTimeCard:_onRenderRechargeAwardList(arg_3_1, arg_3_2)
	local var_3_0 = arg_3_2:getChild("iconComp")

	var_3_0:setIconGray(self._state ~= 0)
	var_3_0:updateIcon(self._buyAwardList[arg_3_1 + 1])
end

function ActivityLifeTimeCard:_onRenderDailyAwardList(arg_4_1, arg_4_2)
	local var_4_0 = arg_4_2:getChild("iconComp")

	var_4_0:setIconGray(self._state == 2)

	local var_4_1 = g.core.common.Goods:convert(self._subscriptionRewards[arg_4_1 + 1])

	if var_4_1 then
		var_4_0:updateIcon(var_4_1)
	end
end

function ActivityLifeTimeCard:_onRenderPrivilegeList(arg_5_1, arg_5_2)
	arg_5_2:setTitle((g.core.lang:get(self.m_privilegeInfos[arg_5_1 + 1])))
end

function ActivityLifeTimeCard:onLoad()
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_RECHARGE_SUBRECHARGENOTIFY, handler(self, self._onSubRechargeNotify), self)
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_RECHARGE_OPRECHARGE, handler(self, self._onOpRecharge), self)
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_RECHARGE_USESUBRECHARGE, handler(self, self._onReceiveRewards), self)
	var_0_0:addEventListener(var_0_1.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDayUpdate), self)
	var_0_0:dispatchEvent(var_0_1.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_rechargeBtn
	})
	self:updateComp()
end

function ActivityLifeTimeCard:updateComp(arg_7_1, arg_7_2)
	self._state = var_0_2:getStatus()

	self.m_stateController:setSelectedIndex(self._state)
	self.m_dailyAwardList:setNumItems(#self._subscriptionRewards)

	if not self.m_enterTransition:isPlaying() then
		self.m_enterTransition:play()
	end
end

function ActivityLifeTimeCard:_onOpRecharge(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	self:updateComp()
end

function ActivityLifeTimeCard:_onReceiveRewards(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	if arg_9_4.awards then
		g.core.module.ModuleManager:awardSummary(arg_9_4.awards)

		self._state = 2

		self.m_stateController:setSelectedIndex(self._state)
		self.m_dailyAwardList:setNumItems(#self._subscriptionRewards)
	end
end

function ActivityLifeTimeCard:_onSubRechargeNotify(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	if arg_10_4.awards then
		g.core.module.ModuleManager:awardSummary(arg_10_4.awards)
		self:updateComp()
	end
end

function ActivityLifeTimeCard:_onCrossDayUpdate()
	self:updateComp()
end

function ActivityLifeTimeCard:_onClickBtn()
	local var_12_0 = self.m_stateController:getSelectedIndex()

	if var_12_0 == 0 then
		g.core.common.GlobalFunc.checkBagBeforeOpRecharge(self, self._rechargeInfo, 0, 0)
	elseif var_12_0 == 1 then
		g.core.network.GameNetProxy:send_C2S_Recharge_UseSubRecharge({
			id = var_0_2:getCardId()
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(405615))
	end
end

return ActivityLifeTimeCard
