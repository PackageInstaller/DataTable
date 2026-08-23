local var_0_0 = g.core.event.EventManager
local var_0_1 = g.core.event.enum
local var_0_2 = g.core.model.User
local var_0_3 = g.core.const.ConstMgr.SpineConst
local ActivitySubscriptionComp = class("ActivitySubscriptionComp", require("app.fairyGUI.activity.UI_ActivitySubscriptionComp"))

function ActivitySubscriptionComp:ctor()
	self._init = false
	self._subConfig = nil
	self._descTxtMap = nil

	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._onRewardRenderer))
	self.m_descList:setVirtual()
	self.m_descList:setItemRenderer(handler(self, self._onDescRenderer))
	self.m_rewardBtn:addClickListener(handler(self, self._onRewardClick))
	self.m_rechargeBtn:addClickListener(handler(self, self._onRechargeClick))
end

function ActivitySubscriptionComp:onLoad()
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_RECHARGE_OPRECHARGE, handler(self, self._onOpRecharge), self)
end

function ActivitySubscriptionComp:updateComp(arg_3_1)
	self.m_enterTransition:play()
	self:updateView()
end

function ActivitySubscriptionComp:updateView()
	self._data = var_0_2.activityMonthCardData:getSubs()[1]

	local var_4_0 = self._data.activityId
	local var_4_1 = self._data.rechargeId
	local var_4_2 = var_0_2.activityMonthCardData
	local var_4_3 = self._data.activityId == 0 or var_4_2:isExpireById(var_4_0)
	local var_4_4 = self._data.activityId ~= 0 and var_4_2:canGetRewardById(var_4_0)
	local var_4_5 = (not var_4_3 or var_4_4 or var_4_1 == 0) and var_4_0 or var_4_1

	if ((not var_4_3 or var_4_4 or var_4_1 == 0) and var_4_0 or var_4_1) == 0 then
		return
	end

	local var_4_6 = g.core.config.recharge_info.get(var_4_5)

	if not var_4_6 then
		return
	end

	self._config = var_4_6

	self:_initShowInfo(var_4_6)

	local var_4_7 = g.core.model.User.rechargeData:getRechargeInfoByTypeAndPrice(var_4_6.recharge_type, var_4_6.money)

	self.m_priceTxt:setText(var_4_7.moneyUnit .. var_4_7.realMoney)

	if var_4_3 then
		self.m_rechargeBtn:setGrayed(false)
		self.m_rechargeBtn:setTouchable(true)
		self.m_rewardStateController:setSelectedIndex(0)
		self.m_rewardBtn:setGrayed(true)
		self.m_rewardBtn:setCtrlState("gray", {
			index = 1
		})
		self.m_buyStateController:setSelectedIndex(0)
		self.m_buyDescTxt:setText(g.core.lang:get(405614))
	else
		self.m_rewardBtn:setCtrlState("gray", {
			index = 0
		})
		self.m_rewardBtn:setGrayed(false)
		self.m_rewardBtn:setTouchable(true)

		if var_4_4 then
			self.m_rewardStateController:setSelectedIndex(1)
		else
			self.m_rewardStateController:setSelectedIndex(2)
		end

		self.m_buyStateController:setSelectedIndex(1)
	end
end

function ActivitySubscriptionComp:_onDescRenderer(arg_5_1, arg_5_2)
	arg_5_2:updateByData(arg_5_1 + 1, self._descTxtMap[arg_5_1 + 1])
end

function ActivitySubscriptionComp:_initShowInfo(arg_6_1)
	if self._init then
		return
	end

	self._init = true

	local var_6_0 = g.core.config.subscription_info.get((var_0_2.activityMonthCardData:getSubCfgIdByRechargeId(arg_6_1.id)))

	if var_6_0 then
		local var_6_1 = string.split(var_6_0.txt, "\n")

		for iter_6_0, iter_6_1 in ipairs(var_6_1) do
			var_6_1[iter_6_0] = string.split(iter_6_1, ".")[2]
		end

		self._descTxtMap = var_6_1
		self._subConfig = var_6_0

		self.m_rewardList:setNumItems((var_6_0.getKeyLength("reward_type_%d")))
		self.m_descList:setNumItems(#self._descTxtMap)
	end

	self.m_knightPicComp:updateKnight({
		resId = 500070
	})
	self.m_knightPicComp:setAlphaRect(var_0_3.MASK_TYPE.HORIZON, cc.rect(-250 / 2, 0, 250 * 2, 0), 250)
end

function ActivitySubscriptionComp:_onRewardClick()
	if not self._config then
		return
	end

	if var_0_2.activityMonthCardData:isExpireById(self._config.id) then
		g.core.module.ModuleManager:tip(g.core.lang:get(400503))
	else
		g.core.common.GlobalFunc.doRechargeById(self, self._config.id, false)
	end
end

function ActivitySubscriptionComp:_onRechargeClick()
	if not self._config then
		return
	end

	g.core.common.GlobalFunc.checkBagBeforeOpRecharge(self, self._config, 0, 0)
end

function ActivitySubscriptionComp:_onRewardRenderer(arg_9_1, arg_9_2)
	arg_9_2:updateIcon({
		type = self._subConfig["reward_type_" .. arg_9_1 + 1],
		value = self._subConfig["reward_value_" .. arg_9_1 + 1],
		size = self._subConfig["reward_size_" .. arg_9_1 + 1]
	})
end

function ActivitySubscriptionComp:_useSubRecharge(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	if arg_10_4.id == self._data.activityId then
		self:updateView()
	end

	if arg_10_4.awards then
		g.core.module.ModuleManager:awardSummary(arg_10_4.awards, true)
	end
end

function ActivitySubscriptionComp:_onOpRecharge(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	if not arg_11_4.sub_recharge then
		return
	end

	self:updateView()
end

return ActivitySubscriptionComp
