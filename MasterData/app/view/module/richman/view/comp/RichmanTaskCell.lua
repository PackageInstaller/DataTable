local var_0_0 = g.core.model.User.richmanData
local RichmanTaskCell = class("RichmanTaskCell", require("app.fairyGUI.richman.UI_RichmanTaskCell"))

function RichmanTaskCell:ctor()
	self.m_itemList:setVirtual()
	self.m_itemList:setItemRenderer(handler(self, self._onItemRenderer))
	self.m_rewardBtn:addClickListener(handler(self, self._onRewardBtnClick))
end

function RichmanTaskCell:_onItemRenderer(arg_2_1, arg_2_2)
	arg_2_2:updateIcon(self._taskAwardList[arg_2_1 + 1])
end

function RichmanTaskCell:updateRichmanTaskCell(arg_3_1)
	local var_3_0 = var_0_0:getTaskData()

	self._taskData = arg_3_1
	self._taskAwardList = arg_3_1.awards

	self.m_itemList:setNumItems(#self._taskAwardList)

	local var_3_1 = arg_3_1.cfg

	self.m_descTxt:setText(g.core.lang:getByString(arg_3_1.cfg.task_describe, {
		num = arg_3_1.cfg.goal
	}))
	self.m_stateController:setSelectedIndex(arg_3_1.state)
	self.m_typeController:setSelectedIndex(var_3_1.refresh == 2 and 1 or 0)
	self.m_progressTxt:setText(var_3_0:getTaskValue(var_3_1.action_key, var_3_1.action_type) .. "/" .. var_3_1.goal)
end

function RichmanTaskCell:_onRewardBtnClick()
	g.core.network.GameNetProxy:send_C2S_RichMan_TaskAward({
		ids = {
			self._taskData.cfg.id
		}
	})
end

return RichmanTaskCell
