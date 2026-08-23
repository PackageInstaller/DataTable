local var_0_0 = g.core.model.User.userFestivalData
local BirthdayCardPop = class("BirthdayCardPop", require("app.fairyGUI.birthdayCard.UI_BirthdayCardPop"), function()
	return fgui.GComponent:create({
		resName = "BirthdayCardPop",
		pkgPath = "ui/birthdayCard/birthdayCard",
		pkgName = "birthdayCard"
	})
end)

function BirthdayCardPop:ctor()
	self:showAtCenter()
	self.m_touchBg:addClickListener(handler(self, self._onClose))
	self:_updateView()
end

function BirthdayCardPop:_onCrossDayUpdate()
	if var_0_0:isBirthDayExpired() then
		self:_onClose()
	end
end

function BirthdayCardPop:_updateView()
	self.m_cardComp:updateComp()

	if self.m_effBgComp then
		self.m_effBgComp:removeAllEffect()
		self.m_effBgComp:addEffectSpine({
			anim = "play",
			name = "eff_ui_birthdaycard_bg",
			isLoop = true
		})
	end

	if self.m_effFgComp then
		self.m_effFgComp:removeAllEffect()
		self.m_effFgComp:addEffectSpine({
			anim = "play",
			name = "eff_ui_birthdaycard_fg",
			isLoop = true
		})
	end

	if self.m_effBoomComp then
		self.m_effBoomComp:removeAllEffect()
		self.m_effBoomComp:addEffectSpine({
			anim = "play",
			name = "eff_ui_birthdaycard_boom",
			isLoop = false
		})
	end
end

function BirthdayCardPop:_onClose(arg_5_1)
	self.m_backTransition:play(handler(self, self._playBackEnd))
end

function BirthdayCardPop:_playBackEnd()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function BirthdayCardPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDayUpdate), self)
	self.m_enterTransition:play()
end

return BirthdayCardPop
