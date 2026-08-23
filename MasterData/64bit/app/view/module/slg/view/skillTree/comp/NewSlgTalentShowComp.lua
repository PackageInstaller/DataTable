local NewSlgTalentShowComp = class("NewSlgTalentShowComp", require("app.fairyGUI.newSlg.UI_NewSlgTalentShowComp"))

function NewSlgTalentShowComp:ctor()
	self._attrList = {}
	self._skillInfoList = {}

	self.m_attrList:setIniter(self)
	self.m_attrList:setItemRenderer(handler(self, self._onRenderAttrList))
end

function NewSlgTalentShowComp:_onRenderAttrList(arg_2_1, arg_2_2)
	arg_2_2:getChild("attrName"):setText(self._attrList[arg_2_1 + 1].attrName)
	arg_2_2:getChild("attrValue"):setText(self._attrList[arg_2_1 + 1].attrValue)
end

function NewSlgTalentShowComp:updateShowComp(arg_3_1)
	self._attrList = arg_3_1

	self.m_attrList:setNumItems(#arg_3_1)
	self.m_attrList:resizeToFit(#arg_3_1)
end

return NewSlgTalentShowComp
