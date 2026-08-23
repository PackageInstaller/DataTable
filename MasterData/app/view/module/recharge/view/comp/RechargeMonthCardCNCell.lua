local var_0_0 = g.core.common.Goods
local var_0_1 = g.core.model.User.activityMonthCardData
local var_0_2 = g.core.module.ModuleManager
local var_0_3 = g.core.model.User.rechargeData
local RechargeGiftComp = class("RechargeGiftComp", require("app.fairyGUI.recharge.UI_RechargeMonthCardCNCell"))

function RechargeGiftComp:ctor()
	self._config = nil
	self._isExpire = nil
	self._canGet = nil

	self.m_signBtn:addClickListener(handler(self, self._onClickSignBtn))
	self.m_drawBtn:addClickListener(handler(self, self._onClickDrawBtn))
end

function RechargeGiftComp:updateBaseCell(arg_2_1)
	if not arg_2_1 then
		return
	end

	local var_2_0 = arg_2_1.activityId

	self._isExpire = arg_2_1.activityId == 0 or var_0_1:isExpireById(var_2_0)
	self._canGet = var_2_0 ~= 0 and var_0_1:canGetRewardById(var_2_0)
	self._config = var_0_3:getRechargeInfoById(not self._isExpire and var_2_0 or arg_2_1.rechargeId)

	if not self._config then
		return
	end

	self.m_canGetAwardController:setSelectedIndex(self._isExpire and 0 or self._canGet and 1 or 2)

	local var_2_1 = var_0_1:getPrivilegeDict()

	self.m_privilege1:setText(var_2_1[arg_2_1.rechargeId][1].name or "")
	self.m_privilege2:setText(var_2_1[arg_2_1.rechargeId][2].name or "")

	local var_2_2 = var_0_0:convert({
		value = 60,
		type = var_0_0.TYPE_RESOURCE
	})

	self.m_instantGetIcon:updateAward({
		icon = var_0_0:convert({
			value = 1,
			type = var_0_0.TYPE_GOLD
		}).icon,
		config = self._config
	})
	self.m_isSignController:setSelectedIndex(not self._isExpire and 1 or 0)
	self.m_remainTimeTxt:setText(g.core.lang:get(406001, {
		time = var_0_1:getLeftDayById(var_2_0)
	}))
	self:_updateSignBtn(arg_2_1)
	self:_updateDrawBtn()

	local var_2_3 = g.core.common.Drops:getGoodsArray(self._config.gold_days, true)

	if #var_2_3 == 1 then
		self.m_dayGetIcon1:setIcon(var_2_3[1].icon)
		self.m_dayGetIcon1:setTitle("×" .. var_2_3[1].size)
		self.m_dayGetIcon2:setIcon(var_2_2.icon)
		self.m_dayGetIcon2:setTitle("×" .. self._config.month_card_score)
		self.m_dayGetIcon3:setVisible(false)
		self.m_allGetIcon1:setIcon(var_2_3[1].icon)
		self.m_allGetIcon1:setText("×" .. self._config.days * var_2_3[1].size)
		self.m_allGetIcon2:setIcon(var_2_2.icon)
		self.m_allGetIcon2:setText("×" .. self._config.days * self._config.month_card_score)
		self.m_allGetIcon3:setVisible(false)
	elseif #var_2_3 == 2 then
		self.m_dayGetIcon1:setIcon(var_2_3[1].icon)
		self.m_dayGetIcon1:setTitle("×" .. var_2_3[1].size)
		self.m_dayGetIcon2:setIcon(var_2_3[2].icon)
		self.m_dayGetIcon2:setTitle("×" .. var_2_3[2].size)
		self.m_dayGetIcon3:setIcon(var_2_2.icon)
		self.m_dayGetIcon3:setTitle("×" .. self._config.month_card_score)
		self.m_allGetIcon1:setIcon(var_2_3[1].icon)
		self.m_allGetIcon1:setText("×" .. self._config.days * var_2_3[1].size)
		self.m_allGetIcon2:setIcon(var_2_3[2].icon)
		self.m_allGetIcon2:setText("×" .. self._config.days * var_2_3[2].size)
		self.m_allGetIcon3:setIcon(var_2_2.icon)
		self.m_allGetIcon3:setText("×" .. self._config.days * self._config.month_card_score)
	end
end

function RechargeGiftComp:_onClickSignBtn()
	local var_3_0 = self.m_typeController:getSelectedIndex() + 1
	local var_3_1 = var_0_1:getMonthCards()[var_3_0]

	if var_3_1 then
		self:addPopup(require("app.view.module.recharge.view.RechargeBuyMonthCardPop").new({
			type = var_3_0,
			cardInfo = var_3_1
		}))
	end
end

function RechargeGiftComp:_onClickDrawBtn(arg_4_1)
	arg_4_1:stopPropagation()

	if not self._isExpire and self._canGet then
		if not self._config then
			return
		end

		g.core.common.GlobalFunc.doRechargeById(self, self._config.id)
	elseif self._isExpire and self._canGet then
		var_0_2:tip(g.core.lang:get(406006))
	else
		var_0_2:tip(g.core.lang:get(406007))
	end
end

function RechargeGiftComp:_updateSignBtn(arg_5_1)
	local var_5_0 = var_0_3:getRechargeInfoById((not self._isExpire or nil) and (arg_5_1.activityId or arg_5_1.rechargeId))

	if not var_5_0 then
		return
	end

	if not var_5_0.moneyUnit then
		-- block empty
	end

	if not var_5_0.realMoney then
		-- block empty
	end

	if self._isExpire then
		self.m_signBtn:setTitle(var_5_0.moneyUnit .. var_5_0.realMoney .. g.core.lang:get(406010))
	else
		self.m_signBtn:setTitle(var_5_0.moneyUnit .. var_5_0.realMoney .. g.core.lang:get(406011))
	end
end

function RechargeGiftComp:_updateDrawBtn()
	self.m_drawBtn:setCtrlState("status", {
		index = self._canGet and 0 or 1
	})

	local var_6_0 = self.m_drawBtn:getChild("eff_get")

	if self._canGet and var_6_0 then
		var_6_0:removeAllEffect()
		var_6_0:addEffectSpine({
			anim = "play",
			name = "eff_ui_monthcard_getbtn",
			isLoop = true
		})
	end
end

return RechargeGiftComp
