local KnightSpProtectAttrPop = class("KnightSpProtectAttrPop", require("app.fairyGUI.knight.UI_KnightSpProtectAttrPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/knight/knight",
		resName = "KnightSpProtectAttrPop",
		pkgName = "knight"
	}, ...)
end)

function KnightSpProtectAttrPop:ctor(arg_2_1)
	self._knightStruct = arg_2_1
	self._protectKnightList = nil

	self:showAtCenter()
	self.m_attrDetailList:setVirtual()
	self.m_attrDetailList:setItemRenderer(handler(self, self._onDetailRenderer))
	self:updateSpProtectPopView()
end

function KnightSpProtectAttrPop:updateSpProtectPopView()
	self._protectKnightList = self._knightStruct:getSpSupportKnights()

	self.m_attrDetailList:setNumItems(#self._protectKnightList)
end

function KnightSpProtectAttrPop:_onDetailRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateAttrDetail(self._protectKnightList[arg_4_1 + 1], self._knightStruct)
end

return KnightSpProtectAttrPop
