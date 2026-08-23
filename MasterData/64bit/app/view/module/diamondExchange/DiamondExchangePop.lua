local DiamondExchangePop = class("DiamondExchangePop", require("app.fairyGUI.diamondExchange.UI_DiamondExchangePop"), function()
	return fgui.GComponent:create({
		resName = "DiamondExchangePop",
		pkgName = "diamondExchange",
		pkgPath = "ui/diamondExchange/diamondExchange"
	}, ...)
end)
local var_0_1 = g.core.common.Goods

function DiamondExchangePop:ctor()
	self.m_icon1:updateIcon({
		value = 1,
		size = 0,
		type = var_0_1.TYPE_GOLD
	})
	self.m_icon2:updateIcon({
		value = 0,
		size = 0,
		type = var_0_1.TYPE_GOLD
	})
	self.m_inputNum:addEventListener(fgui.UIEventType.Changed, handler(self, self._onInputNumEnd))
	self.m_slider:addEventListener(fgui.UIEventType.Changed, handler(self, self._onSliderChange))
	self.m_btnCancel:addClickListener(handler(self, self._onCancel))
	self.m_btnConfirm:addClickListener(handler(self, self._onConfirm))
	self.m_slider:setMax(g.core.model.User:getGold())
	self.m_maxNum:setText(g.core.model.User:getGold())

	self._inputNum = 1

	self:initNumView()
	self:showAtCenter()
end

function DiamondExchangePop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GOLD_EXCHANGE, handler(self, self._onResult), self)
end

function DiamondExchangePop:initNumView()
	self.m_inputNum:setText(self._inputNum)
	self.m_slider:setValue(0)
end

function DiamondExchangePop:_onCancel()
	g.core.module.ModuleManager:popComponent()
end

function DiamondExchangePop:_onConfirm()
	self._inputNum = self._inputNum or 0

	if self._inputNum > 0 then
		g.core.network.GameNetProxy:send_C2S_Gold_Exchange({
			gold = self._inputNum
		})
	end
end

function DiamondExchangePop:_onInputNumEnd()
	local var_7_0 = g.core.model.User:getGold()
	local var_7_1 = self.m_inputNum:getText()

	if not tonumber(var_7_1) then
		var_7_1 = 0
	end

	self._inputNum = tonumber(var_7_1)

	if var_7_0 < self._inputNum then
		self._inputNum = var_7_0
	elseif self._inputNum < 0 then
		self._inputNum = 0
	end

	self.m_inputNum:setText(self._inputNum)
	self.m_slider:setValue(self._inputNum)
	self.m_icon1:updateIcon({
		value = 1,
		type = g.core.common.Goods.TYPE_GOLD,
		size = self._inputNum
	})
	self.m_icon2:updateIcon({
		value = 0,
		type = g.core.common.Goods.TYPE_GOLD,
		size = self._inputNum * g.core.config.parameter_info.get(100).parameter
	})
end

function DiamondExchangePop:_onSliderChange()
	self._inputNum = self.m_slider:getValue()

	self.m_inputNum:setText(self._inputNum)
	self.m_icon1:updateIcon({
		value = 1,
		type = g.core.common.Goods.TYPE_GOLD,
		size = self._inputNum
	})
	self.m_icon2:updateIcon({
		value = 0,
		type = g.core.common.Goods.TYPE_GOLD,
		size = self._inputNum * g.core.config.parameter_info.get(100).parameter
	})
end

function DiamondExchangePop:_onResult(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	g.core.module.ModuleManager:awardSummary(arg_9_4.awards or {}, nil, nil, g.core.lang:get(300001))
	g.core.module.ModuleManager:popComponent()
end

return DiamondExchangePop
