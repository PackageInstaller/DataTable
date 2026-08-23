local DownloadingPop = class("DownloadingPop", require("app.fairyGUI.infoPop.UI_DownloadingPop"))

function DownloadingPop:ctor()
	self.m_effLoading:addEffectSpine({
		name = "eff_ui_infoPop_downloading",
		anim = "play_1",
		isLoop = true
	})
end

function DownloadingPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_PACKAGE_LIST_DOWNLOAD_UPDATED, self._updatePop, self)
	self:_updatePop()
end

function DownloadingPop:_updatePop()
	local var_3_0 = g.core.common.PackageRes:getCurTempDownloadingInfo()

	self.m_proComp:updatePro(var_3_0)
	self.m_proTxt:setText((string.format("%d%%", math.floor(var_3_0.finish / var_3_0.total * 100))))
end

function DownloadingPop:playShow()
	self.m_enterTransition:play(handler(self, self._updatePop))
end

function DownloadingPop:playHide()
	self.m_backTransition:play()
end

return DownloadingPop
