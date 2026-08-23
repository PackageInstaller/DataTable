local SpireChallengeDeepComp = class("SpireChallengeDeepComp", require("app.fairyGUI.spire.UI_SpireChallengeDeepComp"))

function SpireChallengeDeepComp:ctor()
	self._targetDeep = nil

	self.m_addTransition:setHook("txtNew", handler(self, self._onShowNewDeepTxt))
end

function SpireChallengeDeepComp:playUpDeepAnim(arg_2_1, arg_2_2)
	self._targetDeep = arg_2_1

	self.m_effComp:addEffectSpine({
		name = "eff_ui_spire_deeplight",
		isLoop = false,
		remove = true
	})

	if arg_2_2 then
		self.m_addTransition:play(arg_2_2)
	else
		self.m_addTransition:play()
	end

	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EvilCastle_03)
end

function SpireChallengeDeepComp:_onShowNewDeepTxt()
	self:setTitle(self._targetDeep)

	self._targetDeep = nil
end

return SpireChallengeDeepComp
