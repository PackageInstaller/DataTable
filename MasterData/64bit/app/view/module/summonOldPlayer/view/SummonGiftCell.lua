local SummonGiftCell = class("SummonGiftCell", require("app.fairyGUI.summonOldPlayer.UI_SummonGiftCell"))

function SummonGiftCell:updateSummonGiftCell(arg_1_1)
	self.m_itemIcon:setURL((g.core.common.Path:getRechargeIconById(arg_1_1.pic)))

	local var_1_0 = string.gsub(math.ceil(arg_1_1.origin_price / arg_1_1.pay_value * 100), "%d$", "0")

	var_1_0 = arg_1_1.pay_value == 0 and 100 or string.gsub(var_1_0, "%d$", "0")

	self.m_discountTxt:setText(var_1_0 .. "%")
end

return SummonGiftCell
