local ThemeAnubisBioVoteTargetPop = class("ThemeAnubisBioVoteTargetPop", require("app.fairyGUI.themeBio.UI_ThemeAnubisBioVoteTargetPop"), function()
	return fgui.GComponent:create({
		resName = "ThemeAnubisBioVoteTargetPop",
		pkgPath = "ui/themeBio/themeBio",
		isFullScreen = true,
		pkgName = "themeBio"
	}, ...)
end)

function ThemeAnubisBioVoteTargetPop:ctor(arg_2_1)
	self:getView():center(true)

	arg_2_1 = arg_2_1 or {}

	if arg_2_1.descTxt then
		self.m_descTxt:setText(arg_2_1.descTxt)
	end
end

function ThemeAnubisBioVoteTargetPop:onLoad()
	self.m_enterTransition:play(handler(self, self.openTouch))
	self.m_effEnter:addEffectSpine({
		anim = "play",
		name = "eff_ui_themeAnubisBio_targetEnter",
		remove = true,
		isLoop = false
	})
end

function ThemeAnubisBioVoteTargetPop:openTouch()
	self.m_touchBg:setTouchable(false)
end

function ThemeAnubisBioVoteTargetPop:onUnload()
	self.m_backTransition:play()
end

return ThemeAnubisBioVoteTargetPop
