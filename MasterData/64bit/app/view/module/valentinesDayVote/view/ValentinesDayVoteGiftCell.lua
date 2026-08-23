local ValentinesDayVoteGiftCell = class("ValentinesDayVoteGiftCell", require("app.fairyGUI.valentinesDayVote.UI_ValentinesDayVoteGiftCell"))
local var_0_1 = g.core.model.User.giftData
local var_0_2 = g.core.model.User.rechargeData
local var_0_3 = g.core.model.User.valentinesDayVoteData
local var_0_4 = g.core.const.ConstMgr.ValentinesDayVoteConst.ACTIVITY_STAGE
local var_0_5 = g.core.const.ConstMgr.RechargeConst
local var_0_6 = g.core.common.Path

function ValentinesDayVoteGiftCell:ctor()
	self.m_bgLoader:addClickListener(handler(self, self._onDetailClick))
	self.m_bugBtn:addClickListener(handler(self, self._onBuyClick))
	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)
end

function ValentinesDayVoteGiftCell:updateView(arg_2_1)
	self._giftData = arg_2_1

	local var_2_0 = var_0_1:getGiftDataById(arg_2_1.id)

	if var_2_0.recharge_money > 0 then
		self._rechargeInfo = var_0_2:getRechargeInfoByTypeAndPrice(var_2_0.recharge_type, var_2_0.recharge_money)

		self.m_bugBtn:getChild("costText"):setText(self._rechargeInfo.moneyUnit .. self._rechargeInfo.realMoney)
	else
		self.m_bugBtn:getChild("costText"):setText(g.core.lang:get(404002))
	end

	self.m_iconLoader:setURL(var_0_6:getRechargeIconById(arg_2_1.icon))
	self.m_nameTxt:setText(var_2_0.name)
	self.m_offText:setText(g.core.lang:get(108410, {
		num = var_2_0.discount
	}))

	if var_2_0.discount ~= 100 then
		self.m_offController:setSelectedIndex(1)
	else
		self.m_offController:setSelectedIndex(0)
	end

	arg_2_1.buyTimes = arg_2_1.buyTimes or 0

	if arg_2_1.limit_type == var_0_5.GIFT_LIMIT_TYPE.NORMAL then
		self.m_typeController:setSelectedIndex(1)
		self.m_statueController:setSelectedIndex(0)
	else
		local var_2_1 = 502004

		if arg_2_1.limit_type == var_0_5.GIFT_LIMIT_TYPE.DAILY then
			var_2_1 = 502004
		elseif arg_2_1.limit_type == var_0_5.GIFT_LIMIT_TYPE.PERMANENT then
			var_2_1 = 502005
		end

		self.m_typeController:setSelectedIndex(0)

		local var_2_2 = arg_2_1.times - arg_2_1.buyTimes

		if arg_2_1.times - arg_2_1.buyTimes > 0 then
			self.m_statueController:setSelectedIndex(0)
		else
			self.m_statueController:setSelectedIndex(1)
		end

		self.m_limitText:setText(g.core.lang:get(var_2_1, {
			num = var_2_2,
			maxNum = arg_2_1.times
		}))
	end
end

function ValentinesDayVoteGiftCell:_onDetailClick()
	if self.m_statueController:getSelectedIndex() == 0 then
		g.core.module.ModuleManager:pushPopup((require("app.view.module.recharge.view.RechargeGiftPop").new(self._giftData, true)))
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(107013))
	end
end

function ValentinesDayVoteGiftCell:_onBuyClick()
	if var_0_3:getActivityStage() == var_0_4.VOTE then
		if self.m_statueController:getSelectedIndex() == 0 then
			if self._giftData.recharge_money > 0 then
				g.core.common.GlobalFunc.checkBagBeforeOpRecharge(self, self._rechargeInfo, self._giftData.id, 0)
			else
				g.core.network.GameNetProxy:send_C2S_Recharge_GetFreeGiftAward({
					id = self._giftData.id
				})
			end
		else
			g.core.module.ModuleManager:tip(g.core.lang:get(107013))
		end
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(405002))
	end
end

return ValentinesDayVoteGiftCell
