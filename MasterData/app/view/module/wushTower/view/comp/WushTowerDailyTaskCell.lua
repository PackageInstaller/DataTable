local var_0_0 = g.core.const.ConstMgr.TaskConst.TASK_STATE
local WushTowerDailyTaskCell = class("WushTowerDailyTaskCell", require("app.fairyGUI.wushTower.UI_WushTowerDailyTaskCell"))

function WushTowerDailyTaskCell:ctor()
	self._taskStruct = nil

	self.m_progressTxt:enableRich()
	self.m_getBtn:addClickListener(handler(self, self._onGetAwardClick))
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onRenderAwardList))
	self.getSharedTrans(self, "enter_down", "CommonLongCellList", self)
end

function WushTowerDailyTaskCell:updateCell(arg_2_1)
	self._taskStruct = arg_2_1

	self.m_indexTxt:setText(arg_2_1.taskCfg.name)
	self.m_descTxt:setText((g.core.lang:getByString(arg_2_1.taskCfg.des, {
		num = arg_2_1.taskCfg.task_value
	})))

	if arg_2_1.state == var_0_0.UNFINISHED then
		self.m_progressTxt:setText((g.core.lang:get(200524, {
			curNum = arg_2_1.value,
			totalNum = arg_2_1.taskCfg.task_value
		})))
	end

	self.m_awardList:setNumItems(#arg_2_1.awardArr)
	self.m_statusController:setSelectedIndex(arg_2_1.state)
end

function WushTowerDailyTaskCell:_onRenderAwardList(arg_3_1, arg_3_2)
	local var_3_0 = {
		scaleIndex = 2,
		hideNum = false
	}

	table.merge(var_3_0, self._taskStruct.awardArr[arg_3_1 + 1])
	arg_3_2:updateIcon(var_3_0)
end

function WushTowerDailyTaskCell:_onGetAwardClick()
	local var_4_0, var_4_1

	if not self._taskStruct then
		do return end

		var_4_0 = {}
		var_4_1 = {}
	end

	var_4_1[1] = self._taskStruct.taskCfg.id
	var_4_0.ids = var_4_1

	g.core.network.GameNetProxy:send_C2S_DeadTower_TaskAward(var_4_0)
end

return WushTowerDailyTaskCell
