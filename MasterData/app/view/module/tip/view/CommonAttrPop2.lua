local CommonAttrPop2 = class("CommonAttrPop2", require("app.fairyGUI.tip.UI_CommonAttrPop2"), function()
	return fgui.GComponent:create({
		resName = "CommonAttrPop2",
		pkgPath = "ui/tip/tip",
		pkgName = "tip"
	})
end)

function CommonAttrPop2:ctor(arg_2_1)
	self._attrData = arg_2_1 or {}

	self:showAtCenter()
	self.m_attrList1:setVirtual()
	self.m_attrList1:setItemRenderer(handler(self, self._onRenderAttrList1))
	self.m_attrList2:setVirtual()
	self.m_attrList2:setItemRenderer(handler(self, self._onRenderAttrList2))
end

function CommonAttrPop2:_onRenderAttrList1(arg_3_1, arg_3_2)
	arg_3_2:updateAttrComp(self._attrData.attrList[arg_3_1 + 1], false)
end

function CommonAttrPop2:_onRenderAttrList2(arg_4_1, arg_4_2)
	arg_4_2:updateAttr(self._attrData.attrList[arg_4_1 + 1])
end

function CommonAttrPop2:onLoad()
	self:updateView()
end

function CommonAttrPop2:updateView()
	local var_6_0 = self._attrData.isMax

	self.m_isMaxController:setSelectedIndex(self._attrData.isMax and 1 or 0)

	local var_6_1 = self._attrData.attrList or {}

	if var_6_0 then
		self.m_isMaxController:setSelectedIndex(1)
		self.m_attrList2:setNumItems(#var_6_1)
	else
		self.m_isMaxController:setSelectedIndex(0)
		self.m_attrList1:setNumItems(#var_6_1)
	end

	if self._attrData.title then
		self.m_bgPanel:setTitle(self._attrData.title)
	end
end

return CommonAttrPop2
