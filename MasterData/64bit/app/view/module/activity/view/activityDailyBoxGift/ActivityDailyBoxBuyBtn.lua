local ActivityDailyBoxBuyBtn = class("ActivityDailyBoxBuyBtn", require("app.fairyGUI.activity.UI_ActivityDailyBoxBuyBtn"))

function ActivityDailyBoxBuyBtn:updateView(arg_1_1)
	self.m_priceDesc:setText(g.core.lang:get(404011, {
		unit = arg_1_1.unit,
		price = arg_1_1.price
	}))
end

return ActivityDailyBoxBuyBtn
