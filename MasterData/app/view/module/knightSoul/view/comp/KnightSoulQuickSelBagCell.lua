local KnightSoulQuickSelBagCell = class("KnightSoulQuickSelBagCell", require("app.fairyGUI.knightSoul.UI_KnightSoulQuickSelBagCell"))

function KnightSoulQuickSelBagCell:ctor()
	return
end

function KnightSoulQuickSelBagCell:updateCell(arg_2_1, arg_2_2)
	if not arg_2_1 then
		return
	end

	local var_2_0 = g.core.config.item_info.get(arg_2_1.id)

	self.m_itemIcon:updateIcon({
		type = g.core.common.Goods.TYPE_ITEM,
		value = arg_2_1.id,
		size = arg_2_1.num
	})
	self.m_nameText:setText(var_2_0.name)
	self.m_addComp:initMinMaxNum({
		min = 0,
		cur = arg_2_2 == 1 and 1 or 0,
		max = arg_2_1.num
	})
end

function KnightSoulQuickSelBagCell:getSelNum()
	return self.m_addComp:getCurNum()
end

return KnightSoulQuickSelBagCell
