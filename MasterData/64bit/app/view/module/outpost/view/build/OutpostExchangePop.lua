local var_0_0 = g.core.const.ConstMgr.outpostConst
local OutpostExchangePop = class("OutpostExchangePop", require("app.fairyGUI.outpost.UI_OutpostExchangePop"), function()
	return fgui.GComponent:create({
		resName = "OutpostExchangePop",
		pkgName = "outpost",
		isFullScreen = false,
		pkgPath = "ui/outpost/outpost"
	}, ...)
end)

function OutpostExchangePop:ctor(arg_2_1)
	self._param = arg_2_1
	self._confirmCb = arg_2_1.confirm

	self:_initPop()
	self:showAtCenter()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	g.core.common.Scheduler:newScheduleOnce(function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end, 0.5)
end

function OutpostExchangePop:_initPop()
	self.m_itemNameTxt:setText(self._param.item.cfg.name)
	self.m_desTxt:setText(self._param.item.cfg.des)
	self.m_numTxt:setText((g.core.model.User.outpostData:getBagData():getOwnNum(self._param.item.info.item_id)))
	self.m_itemIcon:updateItemIcon(self._param.item.info)

	self._curNumber = self._param.item.info.item_num

	self:_updateCost()
	self.m_confirmBtn:addClickListener(handler(self, self._onConfirmClick))

	local var_4_0 = {
		min = 1,
		cur = 1
	}

	var_4_0.max = self._param.maxNum or 9999
	var_4_0.callback = handler(self, self._onNumberChange)

	self.m_subAddNumComp:initMinMaxNum(var_4_0)
	self.m_subAddNumComp:setCurNum(self._param.item.info.item_num)
	self.m_addHBtn:addClickListener(handler(self, self._onAddHBtnClicked))
	self.m_subHBtn:addClickListener(handler(self, self._onSubHBtnClicked))
end

function OutpostExchangePop:_onAddHBtnClicked()
	self.m_subAddNumComp:setCurNum(self._curNumber + 100)
end

function OutpostExchangePop:_onSubHBtnClicked()
	self.m_subAddNumComp:setCurNum(self._curNumber - 100)
end

function OutpostExchangePop:_onNumberChange(arg_7_1)
	self._curNumber = arg_7_1

	self:_updateCost()
end

function OutpostExchangePop:_updateCost()
	self.m_resNumComp1:updateByTVS({
		type = var_0_0.EXCHANGE_ITEM_TYPE,
		value = var_0_0.KNIGHT_COIN_ID,
		size = self._param.price * self._curNumber
	})
end

function OutpostExchangePop:_onConfirmClick()
	if self._confirmCb then
		self._confirmCb({
			num = self._curNumber
		})
	end

	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return OutpostExchangePop
