local var_0_0 = g.core.model.User.echoLabData
local EchoLabBgComp = class("EchoLabBgComp", require("app.fairyGUI.echoLab.UI_EchoLabBgComp"))

function EchoLabBgComp:ctor()
	self._loopEff = nil
	self._beginAniName = ""
	self._endAniName = ""
end

function EchoLabBgComp:updateBgEffect()
	self._loopEff = nil

	self.m_effBg:removeAllEffect()

	local var_2_0, var_2_1 = var_0_0:isUnlockEchoLabTerminal()

	self._beginAniName = var_2_0 and "playUp" or "playDown"
	self._endAniName = var_2_0 and "playUpLoop" or "playDownLoop"

	if not self._loopEff then
		self._loopEff = self.m_effBg:addEffectSpine({
			name = "eff_ui_echoLab_bg",
			isLoop = false,
			anim = self._beginAniName
		})

		self._loopEff:addSpineEventListener(handler(self, self._onBgEneterEventFinish))
	end
end

function EchoLabBgComp:_onBgEneterEventFinish(arg_3_1)
	if arg_3_1.type == "complete" then
		self._loopEff:setAnimation(0, self._endAniName, true)
	end
end

return EchoLabBgComp
