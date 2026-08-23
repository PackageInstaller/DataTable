local var_0_0 = g.core.model.User.dailyTaskData
local DailyTaskBoxComp = class("DailyTaskBoxComp", require("app.fairyGUI.dailyTask.UI_DailyTaskBoxComp"))

function DailyTaskBoxComp:ctor(arg_1_1)
	self._taskId = nil
	self._state = 0
	self._rewardListData = {}

	self.m_rewardList:setIniter()
	self.m_rewardList:setItemRenderer(handler(self, self._onRewardItemRender))
	self.m_getAwardArea:addClickListener(handler(self, self._onClickSelf))
end

function DailyTaskBoxComp:updateBox(arg_2_1)
	self._taskId = arg_2_1.info.id
	self._state = arg_2_1.state

	self.m_drawStateController:setSelectedIndex(self._state)
	self.m_value:setText(arg_2_1.info.num)

	self._rewardListData = var_0_0:getDailyTaskActiveBoxAwardInfo(self._taskId)

	self.m_rewardList:setNumItems(#self._rewardListData)
end

function DailyTaskBoxComp:_onClickSelf()
	if g.core.model.User.dailyTaskData:isExpired() then
		g.core.module.ModuleManager:tip(g.core.lang:get(106505))

		return
	end

	if self._state == 1 then
		g.core.network.GameNetProxy:send_C2S_DailyTask_DegreeAward({
			ids = var_0_0:getDailyTaskAllCanReceiveDegreeId()
		})
	end
end

function DailyTaskBoxComp:_onRewardItemRender(arg_4_1, arg_4_2)
	arg_4_2:updateAwardCell(self._rewardListData[arg_4_1 + 1], self._state)
end

return DailyTaskBoxComp
