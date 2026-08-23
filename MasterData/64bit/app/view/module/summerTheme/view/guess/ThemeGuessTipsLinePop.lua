local ThemeGuessTipsLinePop = class("ThemeGuessTipsLinePop", require("app.fairyGUI.summerThemeGame.UI_ThemeGuessTipsLinePop"), function()
	return fgui.GComponent:create({
		resName = "ThemeGuessTipsLinePop",
		pkgName = "summerThemeGame",
		pkgPath = "ui/summerThemeGame/summerThemeGame"
	}, ...)
end)

function ThemeGuessTipsLinePop:ctor(arg_2_1)
	self._countDownTime = 3

	self:showAtCenter()
	self:init(arg_2_1)
end

function ThemeGuessTipsLinePop:init(arg_3_1)
	local var_3_0

	if arg_3_1 then
		var_3_0 = arg_3_1.isCountDown or false
	end

	self.m_isCountDownController:setSelectedIndex(var_3_0 and 1 or 0)
	self.m_endlessController:setSelectedIndex((arg_3_1 or nil) and (arg_3_1.isEndless or false) and 1 or 0)

	self._closeCallBack = arg_3_1.callBack
	self._title = arg_3_1.title or ""

	if var_3_0 then
		self.m_countDownTransition:play(handler(self, self._endCountDown))
	else
		self:updateTips()
	end
end

function ThemeGuessTipsLinePop:updateTips()
	self.m_tagIcon:setWidth(display.width)
	self.m_bgIcon:setWidth(display.width)
	self.m_title:setText(self._title)
	self.m_enterTransition:play(handler(self, self._onDelayClose))
end

function ThemeGuessTipsLinePop:_endCountDown()
	self.m_isCountDownController:setSelectedIndex(0)
	self:updateTips()
end

function ThemeGuessTipsLinePop:_onDelayClose()
	self._schedulerDelayId = nil

	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

	if self._closeCallBack then
		self._closeCallBack()
	end
end

return ThemeGuessTipsLinePop
