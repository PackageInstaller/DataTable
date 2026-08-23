local var_0_0 = g.core.common.Path
local var_0_1 = g.core.common.Goods
local NewSlgBagSelectItem = class("NewSlgBagSelectItem", require("app.fairyGUI.newSlg.UI_NewSlgBagSelectItem"))

function NewSlgBagSelectItem:ctor()
	self._itemData = nil
end

function NewSlgBagSelectItem:updateNewSlgItem(arg_2_1)
	self._itemData = arg_2_1

	local var_2_0 = arg_2_1.info
	local var_2_1 = arg_2_1.num

	self.m_redPointComp:setShow(arg_2_1.info.id == 2669 or var_2_0.id == 2670)

	local var_2_2 = var_0_1:convert({
		type = var_0_1.TYPE_ITEM,
		value = var_2_0.id,
		size = var_2_1
	})

	self.m_iconLoader:updateIcon({
		type = var_2_2.type,
		value = var_2_2.value,
		size = var_2_2.size
	})
	self.m_iconLoader:setIconQualityBgVisible(false)
	self.m_bgLoader:setURL(var_0_0:getBaseIconQualityBg(var_2_2.quality))
end

function NewSlgBagSelectItem:getItemData()
	return self._itemData
end

return NewSlgBagSelectItem
