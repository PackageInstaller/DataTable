local SpireBossTransformationPop = class("SpireBossTransformationPop", require("app.fairyGUI.spire.UI_SpireBossTransformationPop"), function()
	return fgui.GComponent:create({
		resName = "SpireBossTransformationPop",
		isFullScreen = true,
		pkgName = "spire"
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
		name = "eff_ui_spire_bosscurtainglow",
		isLoop = true
	})
	self.m_effLoop:addEffectSpine({
		anim = "loop",
		name = "eff_ui_spire_bosscurtain",
		isLoop = true
	})
	self.m_effPlay:addEffectSpine({
		remove = true,
		name = "eff_ui_spire_bosscurtain",
		isLoop = false
	})
	self.m_effDown:addEffectSpine({
		anim = "down",
		name = "eff_ui_spire_bosscurtainglow",
		isLoop = true
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
