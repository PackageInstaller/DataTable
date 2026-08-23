local var_0_0 = g.core.const.ConstMgr.TaskConst.TASK_STATE
local var_0_1 = g.core.model.User.taskData
local PADailyTaskCell = class("PADailyTaskCell", require("app.fairyGUI.peakArena.UI_PADailyTaskCell"))

function PADailyTaskCell:ctor()
	self._info = nil
	self._awardArr = {}

	self.m_taskNumText:enableRich()
	self.m_getAwardBtn:addClickListener(handler(self, self._onGetAwardClick))
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardListRenderer))
	self.getSharedTrans(self, "enter_down", "CommonLongCellList", self)
end

function PADailyTaskCell:updateCell(arg_2_1)
	self._info = arg_2_1

	self.m_taskNameText:setText((g.core.lang:getByString(arg_2_1.name, {
		num = arg_2_1.require_value
	})))

	local var_2_0 = var_0_1:getTaskState(arg_2_1)

	self.m_stateController:setSelectedIndex(var_2_0)

	if var_2_0 == var_0_0.UNFINISHED then
		self.m_taskNumText:setText((g.core.lang:get(307022, {
			cur = var_0_1:getTaskCurValue(arg_2_1),
			target = arg_2_1.require_value
		})))
	end

	self._awardArr = var_0_1:getAwardTVSInfoArr(arg_2_1)

	self.m_awardList:setNumItems(#self._awardArr)
end

function PADailyTaskCell:_onAwardListRenderer(arg_3_1, arg_3_2)
	self._awardArr[arg_3_1 + 1].scaleIndex = 2
	self._awardArr[arg_3_1 + 1].hideNum = false

	arg_3_2:updateIcon(self._awardArr[arg_3_1 + 1])
end

function PADailyTaskCell:_onGetAwardClick()
	if self._info and self.m_stateController:getSelectedIndex() == var_0_0.CAN_ACCEPT then
		g.core.network.GameNetProxy:send_C2S_GetModuleTaskAward({
			task_id = self._info.id
		})
	end
end

return PADailyTaskCell
