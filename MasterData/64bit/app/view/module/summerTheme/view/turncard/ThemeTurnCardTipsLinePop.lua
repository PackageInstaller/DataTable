local var_0_0 = g.core.const.ConstMgr
local ThemeTurnCardTipsLinePop = class("ThemeTurnCardTipsLinePop", require("app.fairyGUI.summerThemeGame.UI_ThemeTurnCardTipsLinePop"), function()
	return fgui.GComponent:create({
		resName = "ThemeTurnCardTipsLinePop",
		pkgPath = "ui/summerThemeGame/summerThemeGame",
		pkgName = "summerThemeGame"
	}, ...)
end)

function ThemeTurnCardTipsLinePop:ctor(arg_2_1)
	self._countDownTime = 3

	self:showAtCenter()
	self:init(arg_2_1)
end

function ThemeTurnCardTipsLinePop:init(arg_3_1)
	if arg_3_1 and arg_3_1.numType then
		self.m_num_typeController:setSelectedIndex(arg_3_1.numType)
	end

	if arg_3_1 then
		self._onlyShowTime = arg_3_1.onlyShowTime or false
	end

	local var_3_0

	if arg_3_1 then
		var_3_0 = arg_3_1.isCountDown or false
	end

	self.m_isCountDownController:setSelectedIndex(var_3_0 and 1 or 0)
	self.m_endlessController:setSelectedIndex((arg_3_1 or nil) and (arg_3_1.isEndless or false) and 1 or 0)

	self._closeCallBack = arg_3_1.callBack
	self._title = arg_3_1.title or ""

	if var_3_0 then
		g.core.sound.SoundManager:playSound(var_0_0.SoundConst.Sound.TURN_CARD_COUNTDOWN)

		if self._onlyShowTime then
			self.m_countDownTransition:play(handler(self, self._onDelayClose))
		else
			self.m_countDownTransition:play(handler(self, self._endCountDown))
		end
	else
		self:updateTips()
	end
end

function ThemeTurnCardTipsLinePop:updateTips()
	self.m_tagIcon:setWidth(display.width)
	self.m_bgIcon:setWidth(display.width)
	self.m_title:setText(self._title)
	g.core.sound.SoundManager:playSound(var_0_0.SoundConst.Sound.TURN_CARD_START)
	self.m_enterTransition:play(handler(self, self._onDelayClose))
end

function ThemeTurnCardTipsLinePop:_endCountDown()
	self.m_isCountDownController:setSelectedIndex(0)
	self:updateTips()
end

function ThemeTurnCardTipsLinePop:_onDelayClose()
	self._schedulerDelayId = nil

	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

	if self._closeCallBack then
		self._closeCallBack()
	end
end

return ThemeTurnCardTipsLinePop
