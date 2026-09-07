local FileDownloadPanel = class("FileDownloadPanel", import(".MsgboxSubPanel"))

function FileDownloadPanel:getUIName()
	return "FileDownloadBox"
end

function FileDownloadPanel:OnInit()
	self:findUI()
	self:addListener()

	return
end

function FileDownloadPanel:UpdateView(arg_3_1)
	local var_3_0 = arg_3_1.onYes

	function arg_3_1.onYes()
		pg.FileDownloadMgr.GetInstance():SetRemind(self.curStopValue)
		var_3_0()

		return
	end

	self:PreRefresh(arg_3_1)
	setText(self.contextText, arg_3_1.content)

	rtf(self.viewParent._window).sizeDelta = Vector2.New(1000, 638)

	setActive(self.toggleTF, not arg_3_1.hideToggle)
	self:PostRefresh(arg_3_1)

	return
end

function FileDownloadPanel:findUI()
	self.contextText = self._tf:Find("Context")
	self.toggleTF = self._tf:Find("Toggle")
	self.tickTF = self.toggleTF:Find("Tip/TickBG/Tick")

	return
end

function FileDownloadPanel:addListener()
	self.curStopValue = false

	onToggle(self, self.toggleTF, function(arg_7_0)
		self.curStopValue = arg_7_0

		return
	end, SFX_CONFIRM, SFX_CANCEL)

	return
end

return FileDownloadPanel
