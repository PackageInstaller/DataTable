local EchoLabCollectAttrsComp = class("EchoLabCollectAttrsComp", require("app.fairyGUI.echoLab.UI_EchoLabCollectAttrsComp"))

function EchoLabCollectAttrsComp:ctor()
	self._attrListProviderPath = nil
	self._attrs = nil
	self._originSize = self:getSize()

	self:_init()
	self.m_titleDes:enableRich()
end

function EchoLabCollectAttrsComp:_init()
	self.m_attrList:setVirtual(self)
	self.m_attrList:setItemProvider(handler(self, self._onAttrListItemProvider))
	self.m_attrList:setItemRenderer(handler(self, self._onRenderAttrListItem))
end

function EchoLabCollectAttrsComp:setProviderPath(arg_3_1)
	self._attrListProviderPath = arg_3_1
end

function EchoLabCollectAttrsComp:_onAttrListItemProvider()
	return self._attrListProviderPath
end

function EchoLabCollectAttrsComp:_onRenderAttrListItem(arg_5_1, arg_5_2)
	arg_5_2:updateView(self._attrs[arg_5_1 + 1])
end

function EchoLabCollectAttrsComp:updateAttrs(arg_6_1, arg_6_2)
	self.m_titleDes:setText(arg_6_2 or "", true)

	self._attrs = arg_6_1

	self.m_attrList:setNumItems(#self._attrs)
	self.m_attrList:resizeToFit(#self._attrs)

	local var_6_0 = self.m_attrList:getPosition().y + self.m_attrList:getSize().height + 10

	if var_6_0 > self._originSize.height then
		self._originSize.height = var_6_0

		self:setSize(self._originSize)
	end
end

return EchoLabCollectAttrsComp
