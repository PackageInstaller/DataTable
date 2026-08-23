local var_0_0 = g.core.const.ConstMgr.outpostConst
local OutpostBagData = class("OutpostBagData")

function OutpostBagData:ctor()
	self._itemDic = {}
	self._itemSidIndexDic = {}
end

function OutpostBagData:setItemInfo(arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1 or {}) do
		self:addItem(iter_2_1)
	end
end

function OutpostBagData:addItem(arg_3_1)
	self._itemDic[var_0_0.EXCHANGE_ITEM_TYPE] = self._itemDic[var_0_0.EXCHANGE_ITEM_TYPE] or {}
	self._itemDic[var_0_0.EXCHANGE_ITEM_TYPE][#self._itemDic[var_0_0.EXCHANGE_ITEM_TYPE] + 1] = arg_3_1
	self._itemSidIndexDic[arg_3_1.item_id] = arg_3_1
end

function OutpostBagData:updateItem(arg_4_1)
	if not self._itemSidIndexDic[arg_4_1.item_id] then
		return
	end

	self._itemSidIndexDic[arg_4_1.item_id].item_num = arg_4_1.item_num
end

function OutpostBagData:removeItem(arg_5_1)
	if not self._itemSidIndexDic[arg_5_1] then
		return
	end

	local var_5_0 = self._itemDic[var_0_0.EXCHANGE_ITEM_TYPE]

	for iter_5_0, iter_5_1 in ipairs(self._itemDic[var_0_0.EXCHANGE_ITEM_TYPE]) do
		if iter_5_1.item_id == arg_5_1 then
			table.remove(var_5_0, iter_5_0)

			break
		end
	end

	self._itemSidIndexDic[arg_5_1] = nil
end

function OutpostBagData:getOwnNum(arg_6_1)
	return (self._itemSidIndexDic[arg_6_1] or nil) and self._itemSidIndexDic[arg_6_1].item_num
end

function OutpostBagData:getBagItemList(arg_7_1)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs(self._itemDic[var_0_0.EXCHANGE_ITEM_TYPE]) do
		if not arg_7_1 or iter_7_1.item_id ~= var_0_0.KNIGHT_COIN_ID then
			var_7_0[#var_7_0 + 1] = iter_7_1
		end
	end

	table.sort(var_7_0, function(arg_8_0, arg_8_1)
		return arg_8_0.item_id < arg_8_1.item_id
	end)

	return var_7_0
end

function OutpostBagData:onFlushItems(arg_9_1)
	self._itemDic = {}
	self._itemSidIndexDic = {}

	self:setItemInfo(arg_9_1)
end

function OutpostBagData:onS2COpObject(arg_10_1)
	local var_10_0 = false

	for iter_10_0, iter_10_1 in ipairs(arg_10_1.insert or {}) do
		self:addItem(iter_10_1)

		var_10_0 = true
	end

	for iter_10_2, iter_10_3 in ipairs(arg_10_1.update or {}) do
		self:updateItem(iter_10_3)

		var_10_0 = true
	end

	for iter_10_4, iter_10_5 in ipairs(arg_10_1.del or {}) do
		self:removeItem(iter_10_5)

		var_10_0 = true
	end

	if var_10_0 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_OUTPOST_BAG_ITEM_CHANGED, false)
	end
end

return OutpostBagData
