local PrimaryShowPopCellSRList = class("PrimaryShowPopCellSRList", require("app.fairyGUI.recruitKnight.UI_PrimaryShowPopCellSRList"))

function PrimaryShowPopCellSRList:ctor()
	self.m_list:setVirtual(self)
	self.m_list:setItemRenderer(handler(self, self._onListItemRender))

	self._knights = nil
end

function PrimaryShowPopCellSRList:_onListItemRender(arg_2_1, arg_2_2)
	arg_2_2:setIcon((g.core.common.Path:getKnightIconById(self._knights[arg_2_1 + 1].value)))
end

function PrimaryShowPopCellSRList:updateIcon(arg_3_1)
	self._knights = arg_3_1.data

	self.m_list:setNumItems(math.min(#self._knights, 4))
end

return PrimaryShowPopCellSRList
