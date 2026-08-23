local TipConst = require("app.view.module.tip.const.TipConst")
local KnightAttrTipExpandComp = class("KnightAttrTipExpandComp", require("app.fairyGUI.tip.UI_KnightAttrTipExpandComp"))

function KnightAttrTipExpandComp:ctor(arg_1_1)
	self.m_attrList:setVirtual()
	self.m_attrList:setItemRenderer(handler(self, self._onAttrListRender))
end

function KnightAttrTipExpandComp:showAttrsExpand(arg_2_1)
	self._attrListData = arg_2_1.attrData or {}

	if arg_2_1.attrType == TipConst.KnightAttrType.BASE_ATTR_TYPE then
		self.m_attrTypeName:setText(g.core.lang:get(201107))
	elseif arg_2_1.attrType == TipConst.KnightAttrType.ELEM_ATTR_TYPE then
		self.m_attrTypeName:setText(g.core.lang:get(201125))
	else
		self.m_attrTypeName:setText(g.core.lang:get(201108))
	end

	self.m_attrList:setNumItems(#self._attrListData)
end

function KnightAttrTipExpandComp:_onAttrListRender(arg_3_1, arg_3_2)
	if self._attrListData[arg_3_1 + 1] then
		arg_3_2:updateAttrContent(self._attrListData[arg_3_1 + 1])
	end
end

return KnightAttrTipExpandComp
