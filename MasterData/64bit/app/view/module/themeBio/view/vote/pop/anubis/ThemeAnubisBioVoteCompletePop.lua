local ThemeAnubisBioVoteCompletePop = class("ThemeAnubisBioVoteCompletePop", require("app.fairyGUI.themeBio.UI_ThemeAnubisBioVoteCompletePop"), function()
	return fgui.GComponent:create({
		resName = "ThemeAnubisBioVoteCompletePop",
		pkgPath = "ui/themeBio/themeBio",
		pkgName = "themeBio"
	}, ...)
end)

function ThemeAnubisBioVoteCompletePop:ctor(arg_2_1)
	self:showAtCenter()

	arg_2_1 = arg_2_1 or {}
	self._callback = arg_2_1.callback

	if arg_2_1.tipTxt then
		self.m_tipTxt:setText(arg_2_1.tipTxt)
		self.m_showCDController:setSelectedIndex(1)
	else
		self.m_showCDController:setSelectedIndex(0)
	end
end

function ThemeAnubisBioVoteCompletePop:onLoad()
	self.m_enterTransition:play()
	self.m_effEnter:addEffectSpine({
		anim = "play",
		remove = true,
		isLoop = false,
		name = "eff_ui_themeAnubisBio_completeEnter"
	})
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Waltz_Over)
end

function ThemeAnubisBioVoteCompletePop:onUnload()
	self.m_backTransition:play(function()
		if self._callback then
			self._callback()
		end
	end)
end

return ThemeAnubisBioVoteCompletePop
