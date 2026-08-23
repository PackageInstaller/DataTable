local var_0_0 = g.core.config.parameter_info
local var_0_1 = g.core.common.Goods
local var_0_2 = g.core.const.ConstMgr.PARAMETER_CONST
local var_0_3 = g.core.model.User.activityMonthCardData
local RechargeGiftComp = class("RechargeGiftComp", require("app.fairyGUI.recharge.UI_RechargeMonthCardCell"))

function RechargeGiftComp:ctor()
	self._config = nil
	self._isExpire = nil
	self._canGet = nil

	self.m_getAwardArea:addClickListener(handler(self, self._onGetAwardAreaClick))
	self:addClickListener(handler(self, self._onClickCardBgComp))
end

function RechargeGiftComp:updateBaseCell(arg_2_1)
	if not arg_2_1 then
		return
	end

	local var_2_0 = arg_2_1.activityId

	self._isExpire = arg_2_1.activityId == 0 or var_0_3:isExpireById(var_2_0)
	self._canGet = var_2_0 ~= 0 and var_0_3:canGetRewardById(var_2_0)
	self._config = g.core.model.User.rechargeData:getRechargeInfoById(not self._isExpire and var_2_0 or arg_2_1.rechargeId)

	if not self._config then
		return
	end

	self.m_discountNumTxt:setText(self._config.icon .. "%")
	self.m_discountNumTxt:setVisible(self._config.icon > 0)
	self.m_signedLoader:setVisible(not self._isExpire)
	self.m_canGetAwardController:setSelectedIndex(self._isExpire and 0 or self._canGet and 1 or 2)

	local var_2_1 = var_0_1:convert({
		value = 1,
		type = var_0_1.TYPE_GOLD
	})
	local var_2_2 = var_0_1:convert({
		value = 60,
		type = var_0_1.TYPE_RESOURCE
	})

	self.m_awardComp1:setIcon(var_2_1.icon)
	self.m_awardComp1:setTitle("×" .. self._config.gold_recharge)
	self.m_awardComp1:setCtrlState("isGet", {
		index = self._isExpire and 0 or 1
	})
	self.m_onceGetIcon:setURL(var_2_1.icon)
	self.m_onceGetNumTxt:setText("×" .. self._config.gold_recharge)
	self.m_isSignController:setSelectedIndex(not self._isExpire and 1 or 0)
	self.m_priceText:setText(self._config.moneyUnit .. self._config.realMoney)

	local var_2_3 = var_0_3:getLeftDayById(var_2_0)

	self.m_isRemindController:setSelectedIndex(var_2_3 <= var_0_0.get(var_0_2.MONTH_REMIND_DAY).parameter and 1 or 0)
	self.m_remainTimeTxt:setText(g.core.lang:get(406001, {
		time = var_2_3
	}))

	local var_2_4 = g.core.common.Drops:getGoodsArray(self._config.gold_days, true)

	if #var_2_4 == 1 then
		self.m_awardComp2:setIcon(var_2_4[1].icon)
		self.m_awardComp2:setTitle("×" .. var_2_4[1].size)
		self.m_awardComp2:setCtrlState("isGet", {
			index = self._isExpire and 0 or self._canGet and 0 or 1
		})
		self.m_awardComp3:setIcon(var_2_2.icon)
		self.m_awardComp3:setTitle("×" .. self._config.month_card_score)
		self.m_awardComp3:setCtrlState("isGet", {
			index = self._isExpire and 0 or self._canGet and 0 or 1
		})
		self.m_line:setVisible(false)
		self.m_awardComp4:setVisible(false)
		self.m_allGetIcon1:setURL(var_2_4[1].icon)
		self.m_allGetNumTxt1:setText("×" .. self._config.days * var_2_4[1].size)
		self.m_allGetIcon2:setURL(var_2_2.icon)
		self.m_allGetNumTxt2:setText("×" .. self._config.days * self._config.month_card_score)
	elseif #var_2_4 == 2 then
		self.m_awardComp2:setIcon(var_2_4[1].icon)
		self.m_awardComp2:setTitle("×" .. var_2_4[1].size)
		self.m_awardComp2:setCtrlState("isGet", {
			index = self._isExpire and 0 or self._canGet and 0 or 1
		})
		self.m_awardComp3:setIcon(var_2_4[2].icon)
		self.m_awardComp3:setTitle("×" .. var_2_4[2].size)
		self.m_awardComp3:setCtrlState("isGet", {
			index = self._isExpire and 0 or self._canGet and 0 or 1
		})
		self.m_awardComp4:setIcon(var_2_2.icon)
		self.m_awardComp4:setTitle("×" .. self._config.month_card_score)
		self.m_awardComp4:setCtrlState("isGet", {
			index = self._isExpire and 0 or self._canGet and 0 or 1
		})
		self.m_allGetIcon1:setURL(var_2_4[1].icon)
		self.m_allGetNumTxt1:setText("×" .. self._config.days * var_2_4[1].size)
		self.m_allGetIcon2:setURL(var_2_4[2].icon)
		self.m_allGetNumTxt2:setText("×" .. self._config.days * var_2_4[2].size)
		self.m_allGetIcon3:setURL(var_2_2.icon)
		self.m_allGetNumTxt3:setText("×" .. self._config.days * self._config.month_card_score)
	end
end

function RechargeGiftComp:_onGetAwardAreaClick(arg_3_1)
	arg_3_1:stopPropagation()

	if not self._isExpire and self._canGet then
		if not self._config then
			return
		end

		g.core.common.GlobalFunc.doRechargeById(self, self._config.id)
	elseif self._isExpire and self._canGet then
		g.core.module.ModuleManager:tip(g.core.lang:get(406006))
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(406007))
	end
end

function RechargeGiftComp:_onClickCardBgComp()
	local var_4_0 = self.m_typeController:getSelectedIndex() + 1
	local var_4_1 = var_0_3:getMonthCards()[var_4_0]

	if var_4_1 then
		self:addPopup(require("app.view.module.recharge.view.RechargeBuyMonthCardPop").new({
			type = var_4_0,
			cardInfo = var_4_1
		}))
	end
end

return RechargeGiftComp
