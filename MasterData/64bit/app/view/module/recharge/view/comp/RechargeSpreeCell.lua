local var_0_1 = g.core.common.Goods
local var_0_2 = g.core.model.User.bagData
local var_0_3 = g.core.model.User.shopData
local var_0_4 = g.core.const.ConstMgr.ShopConst
local RechargeSpreeCell = class("RechargeSpreeCell", require("app.fairyGUI.recharge.UI_RechargeSpreeCell"))

function RechargeSpreeCell:ctor()
	self._info = nil
	self._isEnough = true
	self._isBuy = false
	self._costType = 0
	self._costValue = 0
	self._costHasNum = 0

	self:_addListeners()
end

function RechargeSpreeCell:_addListeners()
	self:addClickListener(handler(self, self._onClick))
end

function RechargeSpreeCell:_onClick()
	return
end

function RechargeSpreeCell:updateCell(arg_4_1, arg_4_2)
	if not arg_4_1 then
		self:setVisible(false)

		return
	end

	self:setVisible(true)

	self._info = arg_4_1

	local var_4_0 = var_0_1:convert({
		type = arg_4_1.type,
		value = arg_4_1.value,
		size = arg_4_1.size
	})

	var_4_0.hideNum = false

	self.m_item:setURL(var_4_0.icon)
	self.m_nameTxt:setText(var_4_0.name)
	self:_updateCost(arg_4_1)
end

function RechargeSpreeCell:_updateCost(arg_5_1)
	self._isEnough = true

	local function var_5_0(arg_6_0, arg_6_1)
		local var_6_0 = var_0_2:getOwnNum(arg_5_1["price_type_" .. arg_6_1], arg_5_1["price_value_" .. arg_6_1])

		if var_6_0 < arg_6_0 then
			self._costType = arg_5_1["price_type_" .. arg_6_1]
			self._costValue = arg_5_1["price_value_" .. arg_6_1]
			self._costHasNum = var_6_0
			self._isEnough = false
		end
	end

	for iter_5_0 = 1, var_0_4.COST_MAX_NUM do
		local var_5_1, var_5_2, var_5_3 = var_0_3:getBuyItemPrice(arg_5_1, 1, iter_5_0)

		if false and var_5_2 ~= 0 and var_5_2 ~= 100 then
			if arg_5_1["price_type_" .. iter_5_0] > 0 then
				self.m_priceComp:updateByTVS({
					showLack = true,
					discount = true,
					type = arg_5_1["price_type_" .. iter_5_0],
					value = arg_5_1["price_value_" .. iter_5_0],
					size = var_5_1,
					oldSize = var_5_3
				})
				var_5_0(var_5_1, iter_5_0)
			end
		elseif arg_5_1["price_type_" .. iter_5_0] > 0 then
			self.m_priceComp:updateByTVS({
				showLack = true,
				discount = false,
				type = arg_5_1["price_type_" .. iter_5_0],
				value = arg_5_1["price_value_" .. iter_5_0],
				size = var_5_1
			})
			var_5_0(var_5_1, iter_5_0)
		end
	end
end

return RechargeSpreeCell
