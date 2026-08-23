local var_0_0 = g.core.model.User.furnitureHandBookData
local var_0_1 = g.core.common.Path
local var_0_2 = g.core.common.Goods
local FurnitureHandBookCell = class("FurnitureHandBookCell", require("app.fairyGUI.furnitureHandBook.UI_FurnitureHandBookCell"))

function FurnitureHandBookCell:ctor()
	self._kitHaveArray = {}

	self.m_iconList:setVirtual()
	self.m_iconList:setItemRendererAsync1(handler(self, self._onItemIconRender), 0.02, false)
end

function FurnitureHandBookCell:updateCell(arg_2_1)
	self._kitHaveArray = var_0_0:getFurnituresByKitId(arg_2_1.id)

	local var_2_0 = var_0_0:getCollectKitCount(arg_2_1.id)

	self.m_nameText:setText(g.core.lang:get(113503, {
		name = arg_2_1.name,
		curNum = var_2_0,
		maxNum = #self._kitHaveArray
	}))
	self.m_bgLoader:setURL(var_0_1:getFurnitureBookCellPicBg(arg_2_1.pic))
	self.m_collectProgress:setPercent({
		cur = var_2_0,
		max = #self._kitHaveArray
	})

	local var_2_1 = #self._kitHaveArray > 0 and math.ceil(var_2_0 / #self._kitHaveArray * 100) or 0

	self.m_progressText:setText(var_2_1 .. "%")
	self.m_qualityLoader:setURL("ui://furnitureHandBook/pic_cls_namepinzhi0" .. arg_2_1.quality)

	if arg_2_1.efficiency_type > 0 then
		self.m_collectvalue1:updateValue(arg_2_1.efficiency_type, arg_2_1, var_2_1)
		self.m_isShowEfficiencyController:setSelectedIndex(1)
	else
		self.m_isShowEfficiencyController:setSelectedIndex(0)
	end

	self.m_collectvalue2:updateValue(nil, arg_2_1, var_2_1)

	if self:isVisible() then
		self:updateIconList()
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			id = arg_2_1.id
		}
	})
	var_0_0:cleanFurnitureHandBookNew(arg_2_1.id)
end

function FurnitureHandBookCell:updateIconList()
	self.m_iconList:setNumItems(#self._kitHaveArray)
end

function FurnitureHandBookCell:_onItemIconRender(arg_4_1, arg_4_2)
	if self._kitHaveArray[arg_4_1 + 1] then
		arg_4_2:updateIcon(var_0_2.TYPE_FURNITURE, self._kitHaveArray[arg_4_1 + 1])
	end
end

return FurnitureHandBookCell
