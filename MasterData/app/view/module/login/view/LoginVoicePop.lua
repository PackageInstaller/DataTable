local LoginVoicePop = class("LoginVoicePop", require("app.fairyGUI.login.UI_LoginVoicePop"), function()
	return fgui.GComponent:create({
		resName = "LoginVoicePop",
		pkgPath = "ui/login/login",
		pkgName = "login"
	})
end)

function LoginVoicePop:ctor()
	self:showAtCenter()
	self.m_voiceController:setSelectedIndex(g.core.sound.SoundManager:isCurSoundJapanese() and 0 or 1)
	self.m_chinaVoiceArea:addClickListener(handler(self, self._onClickChinaVoice))
	self.m_voiceController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onClickChanged))
end

function LoginVoicePop:_onClickChanged()
	g.core.sound.SoundManager:saveCurSoundLanguage(self.m_voiceController:getSelectedIndex() == 0)
end

function LoginVoicePop:_onClickChinaVoice()
	g.core.module.ModuleManager:tip(g.core.lang:get(303026))
end

return LoginVoicePop
