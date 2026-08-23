local KnightAdvOneKeyBlitzCell = class("KnightAdvOneKeyBlitzCell", require("app.fairyGUI.knight.UI_KnightAdvOneKeyBlitzCell"))

function KnightAdvOneKeyBlitzCell:ctor()
	self._dropList = {}

	self.m_dropList:setVirtual()
	self.m_dropList:setItemRenderer(handler(self, self._onRenderDrop))
end

function KnightAdvOneKeyBlitzCell:_onRenderDrop(arg_2_1, arg_2_2)
	arg_2_2:updateIcon(self._dropList[arg_2_1 + 1])
end

function KnightAdvOneKeyBlitzCell:showAwards(arg_3_1)
	self._dropList = arg_3_1

	self.m_dropList:setNumItems(#self._dropList)
end

return KnightAdvOneKeyBlitzCell
