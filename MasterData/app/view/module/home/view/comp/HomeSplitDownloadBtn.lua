local HomeSplitDownloadBtn = class("HomeSplitDownloadBtn", require("app.fairyGUI.home.UI_HomeSplitDownloadBtn"))

function HomeSplitDownloadBtn:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_PACKAGE_LIST_DOWNLOAD_UPDATED, handler(self, self._updateDownloadTxt), self)
end

function HomeSplitDownloadBtn:_updateDownloadTxt()
	local var_2_0 = g.core.common.PackageRes:getCurMainDownloadInfo()

	if var_2_0.total == 0 then
		self.m_proTxt:setText("")
	else
		self.m_proTxt:setText((string.format("%d%%", math.floor(var_2_0.finish / var_2_0.total * 100))))
	end
end

return HomeSplitDownloadBtn
