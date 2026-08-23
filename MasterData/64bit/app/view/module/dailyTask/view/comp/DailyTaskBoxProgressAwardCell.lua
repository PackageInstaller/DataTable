local var_0_0 = g.core.model.User.dailyTaskData
local DailyTaskBoxProgressAwardCell = class("DailyTaskBoxProgressAwardCell", require("app.fairyGUI.dailyTask.UI_DailyTaskBoxProgressAwardCell"))

function DailyTaskBoxProgressAwardCell:ctor(arg_1_1)
	self._taskId = 0
	self._rewardListData = {}

	self.m_rewardList:setVirtual(self)
	self.m_rewardList:doFairyBatching(false)
	self.m_rewardList:setItemRenderer(handler(self, self._onAwardListRenderer))
	self.m_getBtn:addClickListener(handler(self, self._onClickAwardButton))
end

function DailyTaskBoxProgressAwardCell:updateItem(arg_2_1)
	local var_2_0, var_2_1, var_2_2

	if arg_2_1 then
		var_2_0 = arg_2_1.info or {}

		if arg_2_1 then
			var_2_1 = arg_2_1.state or 0

			if arg_2_1 then
				var_2_2 = arg_2_1.index or 1
			end
		end
	end

	local var_2_3 = var_2_0.num

	self._taskId = var_2_0.id

	self.m_scoreTxt:setText(var_2_3)
	self.m_rewardTitle:setText((g.core.lang:get(106501, {
		num = g.core.utils.Number.toChineseNumber(var_2_2)
	})))
	self.m_scoreNum:setText((var_2_1 == 0 or nil) and "[color=#e52e2e]" .. arg_2_1.curScore .. "[/color]" .. "/" .. var_2_3)
	self.m_rewardStateController:setSelectedIndex(var_2_1)

	self._rewardListData = var_0_0:getDailyTaskActiveBoxAwardInfo(self._taskId)

	self.m_rewardList:setNumItems(#self._rewardListData)
end

function DailyTaskBoxProgressAwardCell:_onAwardListRenderer(arg_3_1, arg_3_2)
	arg_3_2:updateIcon(self._rewardListData[arg_3_1 + 1])
end

function DailyTaskBoxProgressAwardCell:_onClickAwardButton()
	g.core.network.GameNetProxy:send_C2S_DailyTask_DegreeAward({
		id = self._taskId
	})
end

return DailyTaskBoxProgressAwardCell
