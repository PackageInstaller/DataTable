local var_0_0 = g.core.model.User.knightSoulData
local KnightSoulSellPop = class("KnightSoulSellPop", require("app.fairyGUI.knightSoul.UI_KnightSoulSellPop"), function()
	return fgui.GComponent:create({
		resName = "KnightSoulSellPop",
		pkgPath = "ui/knightSoul/knightSoul",
		pkgName = "knightSoul"
	}, ...)
end)

function KnightSoulSellPop:ctor()
	self:showAtCenter()

	self._soulItemList = {}
	self._selectQuality = 0

	self.m_sellList:setVirtual()
	self.m_sellList:setItemRenderer(handler(self, self._onSellItemRender))
	self.m_qualityController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onGroupChange))
end

function KnightSoulSellPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SELL, handler(self, self._onRcvSell), self)
	self:_updateListView()
end

function KnightSoulSellPop:onUnload()
	g.core.event.EventManager:removeListenerWithTarget(self)
end

function KnightSoulSellPop:_onRcvSell(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	if arg_5_4.awards then
		g.core.module.ModuleManager:awardSummary(arg_5_4.awards, true)
	end

	self:_updateListView()
end

function KnightSoulSellPop:_updateListView()
	self._soulItemList = var_0_0:getSellKnightSouls(self._selectQuality)

	local var_6_0 = #self._soulItemList

	self.m_isEmptyController:setSelectedIndex(#self._soulItemList == 0 and 1 or 0)
	self.m_sellList:setNumItems(var_6_0)
	self.m_sellList:transitionShowCells("listIconUiScaleIn", 0.03, 1)
end

function KnightSoulSellPop:_onSellItemRender(arg_7_1, arg_7_2)
	arg_7_2:updateCell(self._soulItemList[arg_7_1 + 1])
end

function KnightSoulSellPop:_onGroupChange()
	local var_8_0 = self.m_qualityController:getSelectedIndex()

	if var_8_0 == self._selectQuality then
		return
	end

	self._selectQuality = var_8_0

	self:_updateListView()
end

return KnightSoulSellPop
