local MysteryBossBattleRecordComp = class("MysteryBossBattleRecordComp", require("app.fairyGUI.mystery.UI_MysteryBossBattleRecordComp"))

function MysteryBossBattleRecordComp:ctor()
	self._recordData = {}

	self.m_recordList:setVirtual()
	self.m_recordList:setItemRenderer(handler(self, self._onRecordItemRender))

	self.m_buttonController = self:getController("button")

	self.m_buttonController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onButtonStateChange))
end

function MysteryBossBattleRecordComp:_onRecordItemRender(arg_2_1, arg_2_2)
	arg_2_2:updateRecordCell(self._recordData[arg_2_1 + 1])
end

function MysteryBossBattleRecordComp:updateRecordComp(arg_3_1)
	self._recordData = arg_3_1:getHistoryKillers()

	self.m_recordList:setNumItems(#self._recordData)
end

function MysteryBossBattleRecordComp:_onButtonStateChange()
	self.m_recordList:setNumItems(#self._recordData)
end

return MysteryBossBattleRecordComp
