local SpireBossTransformationPop = class("SpireBossTransformationPop", require("app.fairyGUI.spire.UI_SpireBossTransformationPop"), function()
	return fgui.GComponent:create({
		pkgName = "spire",
		isFullScreen = true,
		resName = "SpireBossTransformationPop"
	}, ...)
end)

function SpireBossTransformationPop:ctor(arg_2_1, arg_2_2)
	self._callback = arg_2_2

	self.m_nameTxt:setText(arg_2_1:getCfg().name)
end

function SpireBossTransformationPop:onLoad()
	self.m_enterTransition:play(handler(self, self._playBack))
	self.m_effUp:addEffectSpine({
		anim = "up",
		isLoop = true,
		name = "eff_ui_spire_bosscurtainglow"
	})
	self.m_effLoop:addEffectSpine({
		anim = "loop",
		isLoop = true,
		name = "eff_ui_spire_bosscurtain"
	})
	self.m_effPlay:addEffectSpine({
		remove = true,
		isLoop = false,
		name = "eff_ui_spire_bosscurtain"
	})
	self.m_effDown:addEffectSpine({
		anim = "down",
		isLoop = true,
		name = "eff_ui_spire_bosscurtainglow"
	})
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EvilCastle_Boss01)
end

function SpireBossTransformationPop:onUnload()
	if self._callback then
		self._callback()
	end
end

function SpireBossTransformationPop:_playBack()
	self.m_backTransition:play(handler(self, self._closeSelf))
end

function SpireBossTransformationPop:_closeSelf()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return SpireBossTransformationPop
