local EchoLabCollectMidUpComp = class("EchoLabCollectMidUpComp", require("app.fairyGUI.echoLab.UI_EchoLabCollectMidUpComp"))

function EchoLabCollectMidUpComp:ctor()
	self._attrListProviderPath = nil
	self._attrs = nil
	self._originSize = self:getSize()

	self:_init()
end

function EchoLabCollectMidUpComp:_init()
	self.m_attrList:setVirtual(self)
	self.m_attrList:setItemProvider(handler(self, self._onAttrListItemProvider))
	self.m_attrList:setItemRenderer(handler(self, self._onRenderAttrListItem))
end

function EchoLabCollectMidUpComp:setProviderPath(arg_3_1)
	self._attrListProviderPath = arg_3_1
end

function EchoLabCollectMidUpComp:_onAttrListItemProvider()
	return self._attrListProviderPath
end

function EchoLabCollectMidUpComp:_onRenderAttrListItem(arg_5_1, arg_5_2)
	arg_5_2:updateView(self._attrs[arg_5_1 + 1])
end

function EchoLabCollectMidUpComp:updateAttrs(arg_6_1)
	self._attrs = arg_6_1

	self.m_attrList:setNumItems(#self._attrs)
	self.m_attrList:resizeToFit(#self._attrs)

	local var_6_0 = self.m_attrList:getPosition().y + self.m_attrList:getSize().height + 10

	if var_6_0 > self._originSize.height then
		self._originSize.height = var_6_0

		self:setSize(self._originSize)
	end
end

return EchoLabCollectMidUpComp
