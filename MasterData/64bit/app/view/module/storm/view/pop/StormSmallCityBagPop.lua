local var_0_0 = g.core.common.Path
local StormSmallCityBagPop = class("StormSmallCityBagPop", require("app.fairyGUI.storm.UI_StormSmallCityBagPop"), function()
	return fgui.GComponent:create({
		resName = "StormSmallCityBagPop",
		pkgName = "storm",
		pkgPath = "ui/storm/storm"
	}, ...)
end)

function StormSmallCityBagPop:ctor()
	self:showAtCenter()

	self._itemList = {}

	self.m_itemList:setVirtual()
	self.m_itemList:setItemRenderer(handler(self, self._onItemRenderer))
	self.m_itemList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onItemClicked))
	self:updateCompView()
end

function StormSmallCityBagPop:_onItemClicked(arg_3_1)
	self:showItemView(arg_3_1:getDataValue() + 1)
end

function StormSmallCityBagPop:showItemView(arg_4_1)
	local var_4_0 = g.core.common.Goods:convert({
		type = g.core.common.Goods.TYPE_ITEM,
		value = self._itemList[arg_4_1].value
	})

	self.m_nameTxt:setText(var_4_0.name)
	self.m_qualityLoader:setURL(var_0_0:getBagNewQualityBgPath(var_4_0.quality))
	self.m_iconLoader:setURL(var_4_0.icon)
	self.m_numTxt:setText(self._itemList[arg_4_1].size)
	self.m_descTxt:setText(var_4_0.desc)
end

function StormSmallCityBagPop:_onItemRenderer(arg_5_1, arg_5_2)
	arg_5_2:setData(self._itemList[arg_5_1 + 1])
end

function StormSmallCityBagPop:updateCompView()
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in g.core.config.item_info.ipairs() do
		if iter_6_1.item_type == g.core.const.ConstMgr.ITEM_CONST.ITEM_TYPE.STORM then
			local var_6_1 = g.core.model.User.bagData:getOwnNum(g.core.common.Goods.TYPE_ITEM, iter_6_1.id)

			if var_6_1 > 0 then
				table.insert(var_6_0, {
					type = g.core.common.Goods.TYPE_ITEM,
					value = iter_6_1.id,
					size = var_6_1
				})
			end
		end
	end

	self._itemList = var_6_0

	if #self._itemList > 0 then
		self.m_emptyController:setSelectedIndex(0)
		self.m_itemList:setNumItems(#self._itemList)
		self.m_itemList:setSelectedIndex(0)
		self:showItemView(1)
	else
		self.m_emptyController:setSelectedIndex(1)
	end
end

return StormSmallCityBagPop
