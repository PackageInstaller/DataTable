local SpirePassTransformationPop = class("SpirePassTransformationPop", require("app.fairyGUI.spire.UI_SpirePassTransformationPop"), function()
	return fgui.GComponent:create({
		pkgName = "spire",
		resName = "SpirePassTransformationPop"
	}, ...)
end)

function SpirePassTransformationPop:ctor(arg_2_1)
	self._callback = arg_2_1

	self.m_effLoop:addEffectSpine({
		isLoop = false,
		name = "eff_ui_spire_endcurtain",
		anim = "loop",
		remove = true
	})
	self:showAtCenter()
end

function SpirePassTransformationPop:onLoad()
	self.m_enterTransition:play(handler(self, self._playBack))
	self.m_effPlay:addEffectSpine({
		isLoop = false,
		name = "eff_ui_spire_endcurtain",
		remove = true
	})
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EvilCastle_Win)
end

function SpirePassTransformationPop:onUnload()
	if self._callback then
		self._callback()
	end
end

function SpirePassTransformationPop:_playBack()
	self:newScheduleOnce(handler(self, function(arg_6_0)
		arg_6_0.m_backTransition:play(handler(arg_6_0, arg_6_0._closeSelf))
	end), 1)
end

function SpirePassTransformationPop:_closeSelf()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return SpirePassTransformationPop
