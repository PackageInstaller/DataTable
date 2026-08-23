local var_0_0 = g.core.model.User.activityMonthCardData
local var_0_1 = g.core.common.Goods
local RechargeBuyMonthCardPop = class("RechargeBuyMonthCardPop", require("app.fairyGUI.recharge.UI_RechargeBuyMonthCardPop"), function()
	return fgui.GComponent:create({
		resName = "RechargeBuyMonthCardPop",
		pkgName = "recharge",
		pkgPath = "ui/recharge/recharge"
	})
end)

function RechargeBuyMonthCardPop:ctor(arg_2_1)
	self:showAtCenter()

	if arg_2_1 then
		self._type = arg_2_1.type or 0
	end

	self._info = arg_2_1.cardInfo
	self._isClose = false

	self.m_buyBtn:addClickListener(handler(self, self._onClickBuyMonthCard))
	self:_updateBuyCardView()
end

function RechargeBuyMonthCardPop:onLoad()
	return
end

function RechargeBuyMonthCardPop:_updateBuyCardView()
	if not self._info then
		return
	end

	if self._type > 0 then
		self.m_typeController:setSelectedIndex(self._type - 1)
	end

	local var_4_0 = self._info.activityId
	local var_4_1 = self._info.activityId == 0 or var_0_0:isExpireById(var_4_0)
	local var_4_2 = self._info.activityId ~= 0 and var_0_0:canGetRewardById(var_4_0)
	local var_4_3 = g.core.model.User.rechargeData:getRechargeInfoById(not var_4_1 and var_4_0 or self._info.rechargeId)

	if not var_4_3 then
		return
	end

	self._config = var_4_3

	self.m_priceText:setText(var_4_3.realMoney)
	self.m_priceUnitText:setText(var_4_3.moneyUnit)
	self.m_cardNameText:setText(var_4_3.name)
	self.m_buyDesc:setText(g.core.lang:get(406009, {
		name = var_0_1:convert({
			value = 1,
			type = var_0_1.TYPE_GOLD
		}).name,
		num = var_4_3.gold_recharge
	}))

	local var_4_4 = var_0_1:convert({
		value = 60,
		type = var_0_1.TYPE_RESOURCE
	})
	local var_4_5 = g.core.common.Drops:getGoodsArray(var_4_3.gold_days)

	if #var_4_5 == 1 then
		self.m_dailyDesc:setText(g.core.lang:get(406003, {
			award1 = tostring(var_4_5[1].name) .. "*" .. var_4_5[1].size,
			award2 = var_4_4.name .. "*" .. var_4_3.month_card_score
		}))
	elseif #var_4_5 == 2 then
		self.m_dailyDesc:setText(g.core.lang:get(406004, {
			award1 = tostring(var_4_5[1].name) .. "*" .. var_4_5[1].size,
			award2 = tostring(var_4_5[2].name) .. "*" .. var_4_5[2].size,
			award3 = var_4_4.name .. "*" .. var_4_3.month_card_score
		}))
	end
end

function RechargeBuyMonthCardPop:_onClickBuyMonthCard()
	if not self._config then
		return
	end

	g.core.common.GlobalFunc.checkBagBeforeOpRecharge(self, self._config, 0, 0)
end

function RechargeBuyMonthCardPop:_onOpRecharge()
	if not self._isClose then
		g.core.module.ModuleManager:popComponent()
		g.core.module.ModuleManager:awardSummary({
			{
				value = 1,
				type = g.core.common.Goods.TYPE_GOLD,
				size = self._config.gold_recharge
			}
		})

		self._isClose = true
	end
end

return RechargeBuyMonthCardPop
