MallLayer = class("MallLayer", function()
	return cc.Layer:create()
end)

require("view.Layer.PopLayer")

local shop_manager = require("controller.shop_manager")
local alert_manager = require("controller.alert_manager")
local item_data = require("data.item_data")
local var_0_3 = {
	MALL_TYPE_SHOP,
	MALL_TYPE_MARKET,
	MALL_TYPE_RECHARGE
}
local var_0_4 = {
	[MALL_TYPE_SHOP] = "button_market",
	[MALL_TYPE_MARKET] = "button_heishi",
	[MALL_TYPE_RECHARGE] = "button_recharge"
}
local var_0_5 = {
	[MALL_TYPE_SHOP] = "MarketLayer",
	[MALL_TYPE_MARKET] = "TwisteggLayer",
	[MALL_TYPE_RECHARGE] = "RechargeLayer"
}

function MallLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = MallLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function MallLayer:init(arg_3_1)
	if arg_3_1 then
		self.exitCallback = arg_3_1.exitCallback
	end

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Mall.json" or "Mall.ExportJson")

	self:addChild(self.rootLayer)

	self.button_return = ccui.Helper:seekWidgetByName(self.rootLayer, "button_return")

	self.button_return:addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.exitCallback then
			self.exitCallback()
		else
			local var_4_0 = cc.EventCustom:new("switchShowLayer")

			var_4_0.layerName = "MainLayer"

			cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_4_0)
		end
	end)
	self:initSwitchButton()
end

function MallLayer:initSwitchButton()
	self.switchButtons = {}

	for iter_5_0 = 1, 3 do
		self.switchButtons[iter_5_0] = ccui.Helper:seekWidgetByName(self.rootLayer, var_0_4[iter_5_0])
		self.switchButtons[iter_5_0].tag = iter_5_0

		self.switchButtons[iter_5_0]:addTouchEventListener(function(arg_6_0, arg_6_1)
			if arg_6_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:switchPanel(var_0_3[arg_6_0.tag])
		end)
	end
end

function MallLayer.switchPanel(arg_7_0, arg_7_1)
	local var_7_0 = cc.EventCustom:new("switchShowLayer")

	var_7_0.layerName = var_0_5[arg_7_1]

	cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_7_0)
end

function MallLayer:updateAlert()
	alert_manager:add_alert(ALERT_SHOP, self.switchButtons[MALL_TYPE_SHOP], alert_manager:isSystemNewAlert(ALERT_SHOP), cc.p(30, 270))
	alert_manager:add_alert(ALERT_MARKET, self.switchButtons[MALL_TYPE_MARKET], alert_manager:isSystemNewAlert(ALERT_TWISTEGG), cc.p(30, 270))
end
