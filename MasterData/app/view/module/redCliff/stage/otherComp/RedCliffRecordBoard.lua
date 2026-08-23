local var_0_0 = g.core.model.User.redCliffData
local var_0_1 = g.core.const.ConstMgr.RedCliffConst
local RedCliffRecordBoard = class("RedCliffRecordBoard", require("app.fairyGUI.redCliff.UI_RedCliffRecordBoard"))

function RedCliffRecordBoard:ctor()
	self._recordList = {}

	self.m_recordList:setVirtual()
	self.m_recordList:setItemRenderer(handler(self, self._onRenderRecordList))
end

function RedCliffRecordBoard:updateRecordBoard()
	self._recordList = var_0_0:getRecordList()

	self.m_recordList:setNumItems(#self._recordList)
	self.m_recordList:scrollToView(#self._recordList - 1)
end

function RedCliffRecordBoard:_onRenderRecordList(arg_3_1, arg_3_2)
	local var_3_0 = g.core.config.chibi_component_info.get(self._recordList[arg_3_1 + 1].componentId)

	arg_3_2:setTitle(self._recordList[arg_3_1 + 1].recordType == var_0_1.RECORD_TYPE.ATK_LOSE and g.core.lang:get(421001, {
		other = self._recordList[arg_3_1 + 1].pre:getUserName()
	}) or self._recordList[arg_3_1 + 1].recordType == var_0_1.RECORD_TYPE.DEFEND_LOSE and g.core.lang:get(421002, {
		other = self._recordList[arg_3_1 + 1].occupy:getUserName(),
		editor = var_3_0.name
	}) or self._recordList[arg_3_1 + 1].recordType == var_0_1.RECORD_TYPE.ATK_WIN and g.core.lang:get(421003, {
		other = self._recordList[arg_3_1 + 1].pre:getUserName(),
		editor = var_3_0.name
	}) or g.core.lang:get(421035, {
		editor = var_3_0.name
	}))
end

return RedCliffRecordBoard
