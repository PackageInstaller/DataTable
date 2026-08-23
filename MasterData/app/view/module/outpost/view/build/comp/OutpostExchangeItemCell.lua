local var_0_0 = g.core.const.ConstMgr.outpostConst
local OutpostExchangeItemCell = class("OutpostExchangeItemCell", require("app.fairyGUI.outpost.UI_OutpostExchangeItemCell"))

function OutpostExchangeItemCell:ctor()
	self._info = nil
	self._goods = nil

	self.m_itemComp:addClickListener(handler(self, self._onSelectCell))
	self.m_subBtn:addClickListener(handler(self, self._onSubBtnClicked))
	self.m_addBtn:addClickListener(handler(self, self._onShowOrderNumPop))
	self.m_reduceBtn:addClickListener(handler(self, self._onShowOrderNumPop))
	self.getSharedTrans(self, "enter_scaleOut", "CommonCardCellList", self)
end

function OutpostExchangeItemCell:updateRecipeComp(arg_2_1)
	self._info = arg_2_1

	local var_2_0 = g.core.common.Goods:convert({
		type = var_0_0.EXCHANGE_ITEM_TYPE,
		value = arg_2_1.cfg.item_value,
		size = arg_2_1.cfg.item_size
	})

	self.m_itemComp:updateItemCell(var_2_0)

	self._goods = var_2_0

	if arg_2_1.orderInfo and not arg_2_1.orderInfo.isTemp then
		self:_updateOrderUI()
	else
		self.m_isSelectController:setSelectedIndex(0)
	end
end

function OutpostExchangeItemCell:_updateOrderUI()
	self.m_numTxt:setText(self._info.orderInfo.num)
	self.m_isSelectController:setSelectedIndex(1)
end

function OutpostExchangeItemCell:_onSelectCell()
	self:_onShowOrderNumPop()
end

function OutpostExchangeItemCell:_onSubBtnClicked()
	g.core.model.User.outpostData:getBuildData():getBuild({
		type = var_0_0.BuildType.Exchange
	}):setOrderInfoAndSyncTime(self._info.orderInfo.id, 0)
	self.m_isSelectController:setSelectedIndex(0)
end

function OutpostExchangeItemCell:_onShowOrderNumPop()
	local var_6_0, var_6_1

	if not self._info.orderInfo then
		self._info.orderInfo = {
			num = 0,
			isTemp = true,
			id = self._info.cfg.id
		}
		var_6_0 = {}
		var_6_1 = {}
	end

	var_6_1.cfg = g.core.config.outpost_item_info.get(self._info.cfg.item_value)
	var_6_1.info = {
		item_id = self._info.cfg.item_value,
		item_num = self._info.orderInfo.num
	}
	var_6_0.item = var_6_1
	var_6_0.price = self._info.cfg.gold
	var_6_0.confirm = handler(self, self._onOrderChanged)

	g.core.module.ModuleManager:pushPopup(require("app.view.module.outpost.view.build.OutpostExchangePop").new(var_6_0), {
		touchDisappear = true,
		hideContinue = true
	})
end

function OutpostExchangeItemCell:_onOrderChanged(arg_7_1)
	self._info.orderInfo = self._info.orderInfo or {
		num = 0,
		isTemp = true,
		id = self._info.cfg.id
	}

	local var_7_0 = arg_7_1.num

	if arg_7_1.num == self._info.orderInfo.num then
		return
	end

	self._info.orderInfo.num = var_7_0

	g.core.model.User.outpostData:getBuildData():getBuild({
		type = var_0_0.BuildType.Exchange
	}):setOrderInfoAndSyncTime(self._info.orderInfo.id, self._info.orderInfo.num)
	self.m_numTxt:setText(self._info.orderInfo.num)
end

return OutpostExchangeItemCell
