local var_0_0 = g.core.model.User.dailyTaskData
local DailyTaskProfileInfoComp = class("DailyTaskProfileInfoComp", require("app.fairyGUI.dailyTask.UI_DailyTaskProfileInfoComp"))

function DailyTaskProfileInfoComp:ctor(arg_1_1)
	self.m_dialogBtn:addClickListener(handler(self, self._onDialogClick))
end

function DailyTaskProfileInfoComp:updateInfo(arg_2_1)
	local var_2_0 = var_0_0:getProfileLevelInfo()[arg_2_1]

	if not var_2_0 then
		return
	end

	self.m_title:setText(var_2_0.proflie)
	self.m_descLable:setTitle(var_2_0.proflie_content)

	self._talkId = var_2_0.talk_num

	self.m_isHasDialogController:setSelectedIndex(var_2_0.talk_num ~= 0 and 1 or 0)
end

function DailyTaskProfileInfoComp:_onDialogClick()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_STORY_FORCE_START, false, {
		id = self._talkId
	})
end

return DailyTaskProfileInfoComp
