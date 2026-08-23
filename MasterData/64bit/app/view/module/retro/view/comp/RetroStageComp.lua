local var_0_0 = g.core.model.User.retroData
local RetroStageComp = class("RetroStageComp", require("app.fairyGUI.retro.UI_RetroStageComp"))

function RetroStageComp:ctor()
	self.m_stageList:setVirtual()
	self.m_stageList:setItemRenderer(handler(self, self._onStageItemRender))
end

function RetroStageComp:_onStageItemRender(arg_2_1, arg_2_2)
	arg_2_2:updateCell(self._stageData[arg_2_1 + 1], arg_2_1 + 1)
end

function RetroStageComp:updateStageComp()
	self._taskData = var_0_0:getTaskData()
	self._stageData = self._taskData:getRetroStageList()

	local var_3_0 = self._taskData:getCurProgressStageIndex()
	local var_3_1 = var_3_0 + 1

	if var_3_0 + 1 > #self._stageData then
		var_3_1 = var_3_0
	end

	self.m_stageList:setNumItems(#self._stageData)
	self.m_stageList:scrollToView(self._taskData:getCurCanAwardStageIndex() - 1)

	local var_3_2 = self._taskData:getCurStageProgress()

	if self._stageData[var_3_1].action_value < var_3_2 then
		var_3_2 = self._stageData[var_3_1].action_value
	end

	self.m_progressTxt:setText(g.core.lang:get(430302, {
		cur = var_3_2,
		max = self._stageData[var_3_1].action_value
	}))
end

return RetroStageComp
