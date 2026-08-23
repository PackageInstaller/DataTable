local var_0_0 = g.core.const.ConstMgr.outpostConst
local OutpostKnightCoinComp = class("OutpostKnightCoinComp", require("app.fairyGUI.outpost.UI_OutpostKnightCoinComp"))

function OutpostKnightCoinComp:ctor()
	self:setIcon(g.core.common.Path:getOutpostItemIcon(g.core.config.outpost_item_info.get(var_0_0.KNIGHT_COIN_ID).icon, true))
	self:addClickListener(handler(self, self._onGetCoinClick))
end

function OutpostKnightCoinComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_DONATEKNIGHT, handler(self, self.updateCoinView), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_BUILD_ORDERPROCESS, handler(self, self.updateCoinView), self)
end

function OutpostKnightCoinComp:initKnight(arg_3_1)
	self._struct = arg_3_1

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			sid = arg_3_1:getServerId()
		}
	})
	self:updateCoinView()
end

function OutpostKnightCoinComp:updateCoinView()
	if self._struct then
		self:setTitle(self._struct:getOwnCoinNum())
	end
end

function OutpostKnightCoinComp:_onGetCoinClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.outpost.view.knight.OutpostKnightDonatePop").new({
		struct = self._struct
	})))
end

return OutpostKnightCoinComp
