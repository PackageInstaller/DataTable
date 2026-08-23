local var_0_0 = g.core.common.Path
local KnightSoulSelectSellPop = class("KnightSoulSelectSellPop", require("app.fairyGUI.knightSoul.UI_KnightSoulSelectSellPop"), function()
	return fgui.GComponent:create({
		resName = "KnightSoulSelectSellPop",
		pkgName = "knightSoul",
		pkgPath = "ui/knightSoul/knightSoul"
	})
end)

function KnightSoulSelectSellPop:ctor(arg_2_1)
	self:showAtCenter()

	self._params = arg_2_1.award
	self._costItem = arg_2_1.costItem
	self._count = 1

	self:_initRegisterUI()
	self:_updateMainView()
end

function KnightSoulSelectSellPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SELL, handler(self, self._onRcvSell), self)
end

function KnightSoulSelectSellPop:onUnload()
	g.core.event.EventManager:removeListenerWithTarget(self)
end

function KnightSoulSelectSellPop:_onRcvSell()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function KnightSoulSelectSellPop:_initRegisterUI()
	self.m_confirmBtn:addClickListener(handler(self, self._onBuyClick))
end

function KnightSoulSelectSellPop:_updateMainView()
	local var_7_0 = g.core.common.Goods:convert({
		type = self._params.type,
		value = self._params.value
	})

	self.m_nameTxt:setText(var_7_0.name)
	self.m_itemBg:setURL(g.core.common.Path:getBaseBuyPopItemBg(var_7_0.quality))
	self.m_nameBg:setURL(var_0_0:getBaseBuyPopNameBg(var_7_0.quality))
	self.m_soulCardComp:updateCard({
		kSoulId = self._params.value,
		num = self._params.size
	})

	local var_7_1 = g.core.model.User.bagData:getOwnNum(self._params.type, self._params.value)

	self.m_haveNumTxt:setText(var_7_1)

	self._maxCount = var_7_1

	self.m_priceCostComp:updateByTVS({
		type = self._costItem.type,
		value = self._costItem.value,
		size = self._costItem.size
	})
	self.m_resNumComp:updateByTVS({
		type = self._costItem.type,
		value = self._costItem.value,
		size = self._costItem.size * self._count
	})
	self.m_subAddNumComp:initMinMaxNum({
		min = 1,
		max = self._maxCount,
		cur = self._count,
		callback = handler(self, self._setCount)
	})
end

function KnightSoulSelectSellPop:_setCount(arg_8_1, arg_8_2)
	self._count = self.m_subAddNumComp:getCurNum()

	self.m_resNumComp:updateByTVS({
		type = self._costItem.type,
		value = self._costItem.value,
		size = self._costItem.size * self._count
	})
end

function KnightSoulSelectSellPop:_onBuyClick()
	g.core.network.GameNetProxy:send_C2S_Sell({
		consumes = {
			{
				type = self._params.type,
				value = self._params.value,
				size = self._count
			}
		}
	})
end

return KnightSoulSelectSellPop
