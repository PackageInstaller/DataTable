local var_0_0 = g.core.model.User.dailyTaskData
local var_0_1 = 600030
local var_0_2 = 45
local var_0_3 = 2
local var_0_4 = 2 + 0.5
local DrawKnight = require("app.view.common.DrawKnight")
local var_0_6 = {
	RANDOM = 1,
	FIRST_ENTER = 2,
	GET_AWARD = 3
}
local DailyTaskDialogComp = class("DailyTaskDialogComp", require("app.fairyGUI.dailyTask.UI_DailyTaskDialogComp"))

function DailyTaskDialogComp:ctor(arg_1_1)
	self._curDialogId = nil
	self._isFirstEnter = true
	self._isBeginAutoRandom = false
	self._isCanClick = true
	self._time = 0

	self:addClickListener(handler(self, self._onClickNpc))

	self._scheduleHandler = self:newSchedule(handler(self, self._triggerDialog), 1)
	self._scheduleAutoRandomHandler = nil
	self._clickHandler = nil
end

function DailyTaskDialogComp:onLoad()
	if self._playerSpine then
		self._playerSpine:removeSelf()

		self._playerSpine = nil
	end

	self._playerSpine = DrawKnight.new({
		isShowBg = true,
		baseId = var_0_1
	})

	self.m_knightComp:addChild(self._playerSpine)
end

function DailyTaskDialogComp:_triggerDialog()
	if self._isBeginAutoRandom then
		self._time = self._time + 1

		if self._time >= var_0_2 then
			self:updateDialog(var_0_6.RANDOM)
		end
	end
end

function DailyTaskDialogComp:onUnload()
	if self._scheduleHandler then
		self:cancelSchedule(self._scheduleHandler)

		self._scheduleHandler = nil
	end

	if self._scheduleAutoRandomHandler then
		self:cancelSchedule(self._scheduleAutoRandomHandler)

		self._scheduleAutoRandomHandler = nil
	end

	if self._clickHandler then
		self:cancelSchedule(self._clickHandler)

		self._clickHandler = nil
	end
end

function DailyTaskDialogComp:updateDialog(arg_5_1)
	local var_5_0

	if self._isFirstEnter then
		self._isFirstEnter = false
		var_5_0 = var_0_0:getCurDialogText({
			talkType = var_0_6.FIRST_ENTER
		})
	elseif arg_5_1 then
		var_5_0 = var_0_0:getCurDialogText({
			talkType = arg_5_1
		})
	end

	self._time = 0

	if var_5_0 then
		self._isBeginAutoRandom = false

		self.m_showLinesController:setSelectedIndex(1)
		self.m_linesText:setText(var_5_0)

		self._scheduleAutoRandomHandler = self:newScheduleOnce(handler(self, function()
			self.m_showLinesController:setSelectedIndex(0)

			self._isBeginAutoRandom = true
		end), var_0_3)
	else
		self.m_showLinesController:setSelectedIndex(0)

		self._isBeginAutoRandom = true
	end
end

function DailyTaskDialogComp:_onClickNpc()
	if self._isCanClick then
		self._isCanClick = false

		self:updateDialog(var_0_6.RANDOM)

		self._clickHandler = self:newScheduleOnce(handler(self, function()
			self._isCanClick = true
		end), var_0_4)
	end
end

return DailyTaskDialogComp
