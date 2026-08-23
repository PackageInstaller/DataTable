local MineForceBuyPop = class("MineForceBuyPop", require("app.fairyGUI.mine.UI_MineForceBuyPop"), function()
	return fgui.GComponent:create({
		pkgName = "mine",
		resName = "MineForceBuyPop",
		pkgPath = "ui/mine/mine"
	})
end)

function MineForceBuyPop:ctor()
	self._power = 0
	self._maxPower = 0

	self:showAtCenter()

	self._count = 1
	self._price = 1

	self.m_confirmBtn:addClickListener(handler(self, self._onBuyClick))
	self:updateView()
end

function MineForceBuyPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MINE_BUYPOWER, self._onRcvBuyPower, self)
end

function MineForceBuyPop:_onRcvBuyPower()
	self:removeSelf()
end

function MineForceBuyPop:updateView()
	local var_5_0 = g.core.common.Goods:convert({
		type = g.core.common.Goods.TYPE_RESOURCE,
		value = g.core.common.Goods.RESOURCE.TYPE_FORCES
	})

	self.m_nameTxt:setText(var_5_0.name)
	self.m_baseItem:setURL(var_5_0.icon)
	self.m_itemBg:setURL(g.core.common.Path:getBaseBuyPopItemBg(var_5_0.quality))

	local var_5_1 = g.core.model.User.mineData:getCurPower()

	self.m_haveNumTxt:setText(var_5_1)

	local var_5_2 = g.core.config.mine_parameter_info.indexOf(1)
	local var_5_3 = math.min(g.core.model.User.resourceData:getResourceById(g.core.common.Goods.RESOURCE.TYPE_GRAIN) * 1000 / var_5_2.conversion_rate, (var_5_2.max_hp - var_5_1) * 1000)

	self._maxPower = math.floor(var_5_3 / 1000)

	self.m_priceCostComp:updateByTVS({
		type = g.core.common.Goods.TYPE_RESOURCE,
		value = g.core.common.Goods.RESOURCE.TYPE_GRAIN,
		size = self._price
	})
	self.m_resNumComp:updateByTVS({
		type = g.core.common.Goods.TYPE_RESOURCE,
		value = g.core.common.Goods.RESOURCE.TYPE_GRAIN,
		size = self._price * self._count
	})

	self._power = var_5_3 / 1000

	self.m_subAddNumComp:initMinMaxNum({
		min = 1,
		max = self._maxPower,
		cur = self._count,
		callback = handler(self, self._setCount)
	})
end

function MineForceBuyPop:_setCount(arg_6_1, arg_6_2)
	self._count = self.m_subAddNumComp:getCurNum()

	self.m_resNumComp:updateByTVS({
		type = g.core.common.Goods.TYPE_RESOURCE,
		value = g.core.common.Goods.RESOURCE.TYPE_GRAIN,
		size = self._price * self._count
	})
end

function MineForceBuyPop:_onBuyClick()
	if self._count > 0 and self._count <= self._maxPower then
		g.core.network.GameNetProxy:send_C2S_Mine_BuyPower({
			num = self._count
		})
	end
end

return MineForceBuyPop
