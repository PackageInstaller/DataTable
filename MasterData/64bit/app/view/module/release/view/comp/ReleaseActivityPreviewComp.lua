local var_0_0 = g.core.model.User.releaseActivityData
local ReleaseActivityPreviewComp = class("ReleaseActivityPreviewComp", require("app.fairyGUI.release.UI_ReleaseActivityPreviewComp"))

function ReleaseActivityPreviewComp:updatePreviewComp()
	self._curSpinnerId = var_0_0:getSpinnerId()
	self._spinnerInfo = g.core.config.activity_release_spinner_info.get(self._curSpinnerId)

	self.m_nameTxt:setText(self._spinnerInfo.name)
end

function ReleaseActivityPreviewComp:playAnim()
	self.m_enterTransition:play()
	self.m_eff:addEffectSpine({
		isLoop = false,
		name = "eff_ui_release_levellight",
		anim = "play_" .. self._spinnerInfo.quality
	})
end

function ReleaseActivityPreviewComp:playChangeAnim()
	self.m_cutTransition:setHook("showTxt", handler(self, self._onPlayCutEff))
	self.m_cutTransition:play()
	self.m_eff:addEffectSpine({
		isLoop = false,
		name = "eff_ui_release_levellight",
		anim = "play_" .. self._spinnerInfo.quality
	})
end

function ReleaseActivityPreviewComp:_onPlayCutEff()
	self.m_nameTxt:setText(self._spinnerInfo.name)
end

return ReleaseActivityPreviewComp
