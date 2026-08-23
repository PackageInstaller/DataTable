local var_0_0 = g.core.const.ConstMgr.outpostConst
local OutpostRecoverSelltem = class("OutpostRecoverSelltem", require("app.fairyGUI.outpost.UI_OutpostRecoverSelltem"))

function OutpostRecoverSelltem:ctor()
	self._data = nil
	self._lastNum = 0

	self.m_wayBtn:addClickListener(handler(self, self._onWayBtnClicked))
end

function OutpostRecoverSelltem:updateItemComp(arg_2_1, arg_2_2)
	self._data = arg_2_1

	local var_2_0 = arg_2_1.itemInfo

	self.m_itemIcon:setURL((g.core.common.Path:getIconByTypeValue(arg_2_1.itemInfo.type, arg_2_1.itemInfo.value)))
	self.m_costIcon:setURL((g.core.common.Path:getIconByTypeValue(var_0_0.EXCHANGE_ITEM_TYPE, var_0_0.KNIGHT_COIN_ID, true)))

	if arg_2_2 then
		self.m_itemNumTxt:runChangeAni(self._lastNum, var_2_0.size, true)
	else
		self.m_itemNumTxt:setText(var_2_0.size)
	end

	self.m_costValueTxt:setText(var_2_0.realCoin)
	self.m_wayBtn:setVisible(var_2_0.size == 0)

	self._lastNum = var_2_0.size
end

function OutpostRecoverSelltem:_onWayBtnClicked()
	g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
		size = 0,
		type = self._data.itemInfo.type,
		value = self._data.itemInfo.value
	})
end

return OutpostRecoverSelltem
