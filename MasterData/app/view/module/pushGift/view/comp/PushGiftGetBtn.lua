local var_0_0 = g.core.model.User.pushGiftData
local var_0_1 = g.core.const.ConstMgr.PushGiftConst
local RechargeCell = class("RechargeCell", require("app.fairyGUI.pushGift.UI_PushGiftGetBtn"))

function RechargeCell:updateButton(arg_1_1)
	local var_1_0 = var_0_0:getPushGiftContentInfo(arg_1_1.gift_id)

	if var_1_0 then
		if var_1_0.buy_type == var_0_1.GOLD_TYPE then
			self.m_priceTxt:setText(g.core.lang:get(406503, {
				price = var_1_0.price
			}))
			self.m_originalCostTxt:setText(g.core.lang:get(406503, {
				price = var_1_0.original_price
			}))
		elseif var_1_0.buy_type == var_0_1.GOLD_EXCHANGE_TYPE then
			self.m_priceTxt:setText(g.core.lang:get(406510, {
				price = var_1_0.price
			}))
			self.m_originalCostTxt:setText(g.core.lang:get(406510, {
				price = var_1_0.original_price
			}))
		else
			local var_1_1 = g.core.model.User.rechargeData:getRechargeInfoByTypeAndPrice(g.core.const.ConstMgr.RechargeConst.RECHARGE_TYPE.PUSH_GIFT, var_1_0.price)

			if var_1_1 then
				self.m_priceTxt:setText(var_1_1.moneyUnit .. var_1_1.realMoney)
				self.m_originalCostTxt:setText(var_1_1.moneyUnit .. g.core.model.User.rechargeData:safeCalPriceString(var_1_1.id, var_1_0.original_price / var_1_0.price, "*"))
			else
				self.m_priceTxt:setText("")
				self.m_originalCostTxt:setText("")
				self:getChild("n22"):setVisible(false)
			end
		end
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			id = arg_1_1.id
		}
	})
end

return RechargeCell
