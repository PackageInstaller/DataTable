local var_0_0 = g.core.model.User.userFestivalData
local var_0_1 = {
	31,
	29,
	31,
	30,
	31,
	30,
	31,
	31,
	30,
	31,
	30,
	31
}
local var_0_2 = 1
local var_0_3 = 12
local var_0_4 = g.core.module.ModuleManager
local UserSettingBirthPop = class("UserSettingBirthPop", require("app.fairyGUI.user.UI_UserSettingBirthPop"), function()
	return fgui.GComponent:create({
		pkgName = "user",
		resName = "UserSettingBirthPop",
		pkgPath = "ui/user/user"
	})
end)

function UserSettingBirthPop:ctor()
	self:showAtCenter()
	self:_addUIListener()
	self:_initData()
	self:_initView()
end

function UserSettingBirthPop:_initData()
	local var_3_0, var_3_1 = var_0_0:getFormatBirthMonthDay()

	self._curMonth = var_3_0
	self._curDay = var_3_1
	self._inputMonth = 1
	self._inputDay = 1
	self._birthResetTimes = var_0_0:getBirthResetTimes()
end

function UserSettingBirthPop:_initView()
	local var_4_0 = "01"
	local var_4_1 = "01"

	if self._curMonth ~= "00" then
		var_4_0 = self._curMonth
	end

	if self._curDay ~= "00" then
		var_4_1 = self._curDay
	end

	self.m_monthInput:setText(var_4_0)
	self.m_dayInput:setText(var_4_1)
	self.m_tipTxt:setVisible(var_0_0:getBirthResetTimes() >= 1)
end

function UserSettingBirthPop:_addUIListener()
	self.m_monthInput:addEventListener(fgui.UIEventType.Submit, handler(self, self._onInputMonthEnd))
	self.m_dayInput:addEventListener(fgui.UIEventType.Submit, handler(self, self._onInputDayEnd))
	self.m_btnConfirm:addClickListener(handler(self, self._onSendBirth))
end

function UserSettingBirthPop:_onInputMonthEnd()
	self._inputMonth = self.m_monthInput:getText()

	if not tonumber(self._inputMonth) then
		var_0_4:tip(g.core.lang:get(201702))

		self._inputMonth = 1
	end

	self._inputMonth = tonumber(self._inputMonth)

	if self._inputMonth > var_0_3 then
		self._inputMonth = var_0_3
	elseif self._inputMonth < var_0_2 then
		self._inputMonth = var_0_2
	end

	self.m_monthInput:setText(var_0_0:formatTo02d(self._inputMonth))
	self:_correctDay()
end

function UserSettingBirthPop:_correctDay()
	local var_7_0 = var_0_1[tonumber(self._inputMonth)]

	if var_7_0 < self._inputDay then
		self._inputDay = var_7_0
	elseif self._inputDay < 1 then
		self._inputDay = 1
	end

	self.m_dayInput:setText(var_0_0:formatTo02d(self._inputDay))
end

function UserSettingBirthPop:_onInputDayEnd()
	self._inputDay = self.m_dayInput:getText()

	if not tonumber(self._inputDay) then
		var_0_4:tip(g.core.lang:get(201702))

		self._inputDay = 1
	end

	self._inputDay = tonumber(self._inputDay)

	self:_correctDay()
end

function UserSettingBirthPop:onLoad()
	self.m_content:setVisible(false)
	g.core.common.Scheduler:newScheduleOnce(handler(self, function()
		self.m_enterTransition:play()
		self.m_content:setVisible(true)
	end), 0.2)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FESTIVAL_SET_BIRTHDAY, handler(self, self._onBirthChange), self)
	self.m_monthInput:addEventListener(fgui.UIEventType.Click, handler(self, self._onClickMonthInputText))
	self.m_dayInput:addEventListener(fgui.UIEventType.Click, handler(self, self._onClickDayInputText))
end

function UserSettingBirthPop:_onClickMonthInputText()
	self.m_monthInput:setText("")
end

function UserSettingBirthPop:_onClickDayInputText()
	self.m_dayInput:setText("")
end

function UserSettingBirthPop:_onSendBirth()
	local var_13_0 = self.m_monthInput:getText()
	local var_13_1 = self.m_dayInput:getText()

	if var_13_0 == self._curMonth and var_13_1 == self._curDay or self._birthResetTimes > 1 then
		g.core.module.ModuleManager:tip(g.core.lang:get(201703))
	else
		g.core.network.GameNetProxy:send_C2S_Festival_Set_Birthday({
			birthday_Month = tonumber(var_13_0),
			birthday_Day = tonumber(var_13_1)
		})
	end
end

function UserSettingBirthPop:_closeByAnim()
	g.core.module.ModuleManager:checkAndPlayPopExitAnim()
end

function UserSettingBirthPop:_close()
	g.core.module.ModuleManager:popComponent()
end

function UserSettingBirthPop:_onBirthChange(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	g.core.module.ModuleManager:tip(g.core.lang:get(201704))
	self:_closeByAnim()
end

return UserSettingBirthPop
