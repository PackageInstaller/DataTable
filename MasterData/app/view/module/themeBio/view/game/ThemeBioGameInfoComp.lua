local var_0_0 = g.core.const.ConstMgr.ThemeBioConst
local var_0_1 = g.core.const.ConstMgr.ThemeBioMapConst
local ThemeBioGameInfoComp = class("ThemeBioGameInfoComp", require("app.fairyGUI.themeBio.UI_ThemeBioGameInfoComp"))

function ThemeBioGameInfoComp:ctor()
	self._curNum = 0
	self._maxNum = 0
	self._clickAddNum = 0
	self._secondMinNum = 0
	self._isClickAdd = true
	self._schedule = nil
end

function ThemeBioGameInfoComp:onUnload()
	self:stopAllFGActions()
	self:_clearSchedule()
end

function ThemeBioGameInfoComp:updateEventInfo(arg_3_1)
	if not arg_3_1 then
		return
	end

	self.m_nameText:setText(arg_3_1.name)
	self.m_tipsText:setText(arg_3_1.des)

	if arg_3_1.event_type == var_0_1.EVENT_TYPE.CLICK then
		self._curNum = 0
		self._maxNum = arg_3_1.event_value_1
		self._clickAddNum = arg_3_1.event_value_2
		self._secondMinNum = arg_3_1.event_value_3

		self.m_hasProgController:setSelectedIndex(var_0_1.GAME_CTRL_PROG_SHOW)
	elseif arg_3_1.event_type == var_0_1.EVENT_TYPE.QTE then
		self._maxNum = arg_3_1.event_value_1
		self._curNum = self._maxNum
		self._clickAddNum = -arg_3_1.event_value_2
		self._secondMinNum = -arg_3_1.event_value_3
		self._isClickAdd = false

		self.m_hasProgController:setSelectedIndex(var_0_1.GAME_CTRL_PROG_SHOW)
	elseif arg_3_1.event_type == var_0_1.EVENT_TYPE.TREE then
		self.m_hasProgController:setSelectedIndex(var_0_1.GAME_CTRL_PROG_UNSHOW)

		return
	end

	self._schedule = self:newSchedule(handler(self, self._onSchedule), 0.1)

	self:_updateProgress()
end

function ThemeBioGameInfoComp:_updateProgress()
	self.m_progBar:setPercent({
		tween = true,
		cur = g.core.utils.Number.formatNumberByLimit(self._curNum, 0, self._maxNum),
		max = self._maxNum,
		dur = var_0_0.BIO_CLICK_GAME_PROGRESS_TWEEN_TIME
	})
end

function ThemeBioGameInfoComp:_onSchedule()
	if self._schedule and (self._isClickAdd and self._curNum > 0 or not self._isClickAdd and self._curNum < self._maxNum) then
		self._curNum = self._curNum - self._secondMinNum

		self:_updateProgress()
		self:dispatchCompEvent("progressChanging")
	end
end

function ThemeBioGameInfoComp:_clearSchedule()
	if self._schedule then
		self:cancelSchedule(self._schedule)

		self._schedule = nil
	end
end

function ThemeBioGameInfoComp:onClickOnce()
	if not self._schedule then
		return false
	end

	self._curNum = self._curNum + self._clickAddNum

	self:_updateProgress()

	if self._isClickAdd and self._curNum >= self._maxNum or not self._isClickAdd and self._curNum <= 0 then
		self:_clearSchedule()
		self:runFGAction(fgui.FSequence:create(fgui.FDelayTime:create(var_0_0.BIO_CLICK_GAME_PROGRESS_TWEEN_TIME), (fgui.FCallFunc:create(function()
			if not tolua.isnull(self) then
				self:dispatchCompEvent("progress_bar_is_over")
			end
		end))))

		return true
	end

	return false
end

function ThemeBioGameInfoComp:getCurPercent()
	if self.m_progBar then
		return self.m_progBar:getCurPercent()
	end

	return 0
end

function ThemeBioGameInfoComp:getMaxPercent()
	return self._maxNum or 0
end

return ThemeBioGameInfoComp
