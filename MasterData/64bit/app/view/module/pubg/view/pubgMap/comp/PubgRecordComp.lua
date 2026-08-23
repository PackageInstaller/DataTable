local var_0_1 = g.core.model.User.pubgData
local PubgRecordComp = class("PubgRecordComp", require("app.fairyGUI.pubg.UI_PubgRecordComp"))

function PubgRecordComp:ctor()
	self._recordList = {}

	self:_initListView()
end

function PubgRecordComp:_initListView()
	self.m_recordList:setVirtual()
	self.m_recordList:setItemRenderer(handler(self, self._onRenderRecordList))
end

function PubgRecordComp:_onRenderRecordList(arg_3_1, arg_3_2)
	arg_3_2:setTitle(self._recordList[arg_3_1 + 1])
end

function PubgRecordComp:updateComp()
	self._recordList = var_0_1:getGameRecordList()

	self.m_recordList:setNumItems(#self._recordList)
	self.m_recordList:scrollToView(#self._recordList - 1)
end

return PubgRecordComp
