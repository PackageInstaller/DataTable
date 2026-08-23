local var_0_0 = g.core.config.voucher_info
local RechargeVoucherPop = class("RechargeVoucherPop", require("app.fairyGUI.recharge.UI_RechargeVoucherPop"), function()
	return fgui.GComponent:create({
		pkgName = "recharge",
		resName = "RechargeVoucherPop",
		pkgPath = "ui/recharge/recharge"
	})
end)

function RechargeVoucherPop:ctor(arg_2_1)
	self:showAtCenter()

	self._voucherInfo = arg_2_1.voucher
	self._targetInfo = arg_2_1.target
	self._rechargeParam = arg_2_1.recharge

	self.m_confirmBtn:addClickListener(handler(self, self._onBuyButtonClicked))
	self.m_cancelBtn:addClickListener(handler(self, self._onCancelBtnClicked))
	self:_updateView()
end

function RechargeVoucherPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_VOUCHER_BUY, handler(self, self._onBuySucceed), self)
	self:_updateView()
end

function RechargeVoucherPop:_updateView()
	local var_4_0 = {
		type = g.core.common.Goods.TYPE_RESOURCE,
		value = g.core.common.Goods.RESOURCE.TYPE_VOUCHER_COIN_RESOURCE
	}

	var_4_0.size = g.core.model.User.resourceData:getResourceById(var_4_0.value)

	self.m_ownResComp:updateByTVS(var_4_0)
	self.m_descText:setText(g.core.lang:get(107092, {
		resIcon = g.core.common.Path:getIconByTypeValue(var_4_0.type, var_4_0.value, true),
		num = var_0_0.match(function(arg_5_0)
			if arg_5_0.item_id == self._voucherInfo.value then
				return true
			end

			return false
		end)[1].cost_value,
		name = self._targetInfo.name
	}))
end

function RechargeVoucherPop:_onBuyButtonClicked()
	g.core.network.GameNetProxy:send_C2S_Voucher_Buy({
		item_num = 1,
		item_id = self._voucherInfo.value
	})
end

function RechargeVoucherPop:_onBuySucceed()
	g.core.common.GlobalFunc.checkBagBeforeOpRecharge(self._rechargeParam.target, self._rechargeParam.rechargeInfo, self._rechargeParam.activityId, self._rechargeParam.taskId, true)
	self:_onCancelBtnClicked()
end

function RechargeVoucherPop:_onCancelBtnClicked()
	g.core.module.ModuleManager:popByDisplay(self)
end

return RechargeVoucherPop
