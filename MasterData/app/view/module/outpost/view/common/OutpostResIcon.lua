local OutpostResIcon = class("OutpostResIcon", require("app.fairyGUI.outpost.UI_OutpostResIcon"))

function OutpostResIcon:ctor()
	self:addClickListener(handler(self, self.onClickItem))
end

function OutpostResIcon:updateItemIcon(arg_2_1)
	self._item = {
		id = arg_2_1.item_id,
		num = arg_2_1.item_num,
		ownNum = arg_2_1.ownNum
	}

	local var_2_0 = g.core.config.outpost_item_info.get(arg_2_1.item_id)

	self.m_itemIcon:setURL(g.core.common.Path:getOutpostItemIcon(var_2_0.icon))
	self.m_numTxt:setText(arg_2_1.ownNum or arg_2_1.item_num)
	self.m_quality:setURL("ui://outpost/pic_hxsz_djpinzhi" .. var_2_0.quality + 1)
end

function OutpostResIcon:onClickItem()
	if self._item then
		g.core.common.GlobalFunc.pushInfoPop({
			type = g.core.common.Goods.TYPE_OUTPOST_ITEM,
			value = self._item.id,
			num = self._item.ownNum
		})
	end
end

return OutpostResIcon
