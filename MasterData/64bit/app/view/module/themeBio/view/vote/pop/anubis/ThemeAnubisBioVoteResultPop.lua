local ThemeAnubisBioVoteResultPop = class("ThemeAnubisBioVoteResultPop", require("app.fairyGUI.themeBio.UI_ThemeAnubisBioVoteResultPop"), function()
	return fgui.GComponent:create({
		resName = "ThemeAnubisBioVoteResultPop",
		pkgName = "themeBio",
		isFullScreen = true,
		pkgPath = "ui/themeBio/themeBio"
	}, ...)
end)

function ThemeAnubisBioVoteResultPop:ctor(arg_2_1)
	self:getView():center(true)
end

function ThemeAnubisBioVoteResultPop:onLoad()
	self.m_enterTransition:play()
	self.m_effEnter:addEffectSpine({
		isLoop = false,
		remove = true,
		anim = "play",
		name = "eff_ui_themeAnubisBio_resultEnter"
	})
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Waltz_ZXJX)
end

function ThemeAnubisBioVoteResultPop:onUnload()
	self.m_backTransition:play()
end

return ThemeAnubisBioVoteResultPop
