local RechargePriceOriginTitle = class("RechargePriceOriginTitle", require("app.fairyGUI.recharge.UI_RechargePriceOriginTitle"))

function RechargePriceOriginTitle:setGold(arg_1_1, arg_1_2, arg_1_3)
	if arg_1_3 then
		self:setText(g.core.lang:get(407907, {
			price = arg_1_1
		}))
	else
		self:setText(g.core.lang:get(407906, {
			price = arg_1_1
		}))
	end

	self.m_originNum:setText(arg_1_2)
end

function RechargePriceOriginTitle:setDiamond(arg_2_1, arg_2_2, arg_2_3)
	if arg_2_3 then
		self:setText(g.core.lang:get(406512, {
			price = arg_2_1
		}))
	else
		self:setText(g.core.lang:get(406503, {
			price = arg_2_1
		}))
	end

	self.m_originNum:setText(arg_2_2 or "")
end

return RechargePriceOriginTitle
