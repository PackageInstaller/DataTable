local RecycleCultivateExchangeItemCell = class("RecycleCultivateExchangeItemCell", require("app.fairyGUI.recycleCultivate.UI_RecycleCultivateExchangeItemCell"))

function RecycleCultivateExchangeItemCell:ctor()
	self._index = 0
	self._preSize = 0
	self._ownNum = 0
	self._curSize = 0
	self._allCacheData = nil
	self._cfg = nil
end

function RecycleCultivateExchangeItemCell:updateCellExchangeData(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	self._index = arg_2_3
	self._cfg = arg_2_1
	self._preSize = arg_2_1.original_size

	if arg_2_2[arg_2_1.id] then
		self._curSize = arg_2_2[arg_2_1.id].num * self._preSize or 0
	end

	if self._curSize == 0 then
		self.m_backEnTxt:setText("")
	else
		self.m_backEnTxt:setText(g.core.lang:get(430706, {
			num = self._curSize
		}))
	end

	self._allCacheData = arg_2_2
	self._ownNum = g.core.model.User.bagData:getOwnNum(arg_2_1.original_type, arg_2_1.original_value)

	self.m_isGetController:setSelectedIndex(self._ownNum >= self._preSize and 0 or 1)
	self.m_nameTxt:setText(g.core.common.Goods:convert({
		type = arg_2_1.original_type,
		value = arg_2_1.original_value
	}).name)

	local var_2_0 = {
		type = arg_2_1.original_type,
		value = arg_2_1.original_value,
		size = self._ownNum
	}

	if self._ownNum < arg_2_1.original_size then
		var_2_0.size = 0
	end

	self.m_itemIcon:updateIcon(var_2_0)
	self:updateItemExchange(arg_2_4, arg_2_5)
end

function RecycleCultivateExchangeItemCell:updateItemExchange(arg_3_1, arg_3_2)
	local var_3_0 = self._ownNum

	if arg_3_2 then
		var_3_0 = math.min(self._ownNum, arg_3_1[self._cfg.id] * self._cfg.original_size)
	end

	self.m_numChangeComp:initMinMaxNum({
		min = 0,
		max = var_3_0,
		cur = self._curSize,
		aroundMiniSize = self._preSize,
		callback = handler(self, self.onUpdateExchangeNum),
		exMaxFunc = handler(self, self._checkIsLimitNum)
	})
	self.m_banGraph:setVisible(var_3_0 == 0)
end

function RecycleCultivateExchangeItemCell:onUpdateExchangeNum(arg_4_1)
	self:dispatchCompEvent("EVENT_RECYCLE_EXCHANGE_NUM", {
		num = arg_4_1 / self._preSize,
		index = self._index,
		cfg = self._cfg
	})

	if self._cfg.size * self._allCacheData[self._cfg.id].num == 0 then
		self.m_backEnTxt:setText("")
	else
		self.m_backEnTxt:setText(g.core.lang:get(430706, {
			num = self._cfg.size * self._allCacheData[self._cfg.id].num
		}))
	end
end

return RecycleCultivateExchangeItemCell
