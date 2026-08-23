local ShopCostComp = class("ShopCostComp", require("app.fairyGUI.base_new.UI_ShopCostComp"))
local RelationType = require("app.core.fairygui.RelationType")
local var_0_2 = g.core.common.Path
local var_0_3 = g.core.model.User.bagData

function ShopCostComp:ctor()
	self._type = 0
	self._value = 0
	self._size = 0
	self._oldSize = 0
	self._showLack = false
	self._discount = false
	self.m_icon = self:getChild("icon")
	self.m_title = self:getChild("title")
end

function ShopCostComp:updateByTVS(arg_2_1)
	if arg_2_1 then
		self._type = arg_2_1.type or 1
	end

	if arg_2_1 then
		self._value = arg_2_1.value or 1
	end

	if arg_2_1 then
		self._size = arg_2_1.size or 0
	end

	if arg_2_1 then
		self._oldSize = arg_2_1.oldSize or 0
	end

	if arg_2_1 then
		self._showLack = arg_2_1.showLack or false
	end

	if arg_2_1 then
		self._discount = arg_2_1.discount or false
	end

	self.m_icon:setURL((var_0_2:getIconByTypeValue(self._type, self._value, true)))
	self.m_title:clearRelations()

	if self._discount then
		self.m_isOnSaleController:setSelectedIndex(1)
		self.m_discountPriceTxt:setText(self._oldSize)
	else
		self.m_isOnSaleController:setSelectedIndex(0)
	end

	self.m_title:setText(self._size)
	self:_updateLackState()
end

function ShopCostComp:updateIcon(arg_3_1)
	arg_3_1 = arg_3_1 or ""

	self:setIcon(arg_3_1)
end

function ShopCostComp:updateNum(arg_4_1)
	self._size = arg_4_1 or 0

	self:setText(self._size)
	self:_updateLackState()
end

function ShopCostComp:setIconSize(arg_5_1)
	self.m_icon:setAutoSize(false)
	self.m_icon:setFill(4)
	self.m_icon:setSize(arg_5_1)
end

function ShopCostComp:_updateLackState()
	if self._showLack then
		local var_6_0 = var_0_3:getOwnNum(self._type, self._value)

		if var_6_0 ~= 0 then
			self.m_lackController:setSelectedIndex(var_6_0 >= self._size and 0 or 1)
		else
			self.m_lackController:setSelectedIndex(1)
		end
	else
		self.m_lackController:setSelectedIndex(0)
	end
end

return ShopCostComp
