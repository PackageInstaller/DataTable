local GatewayNoticeLayer = class("GatewayNoticeLayer", import("..base.BaseUI"))

function GatewayNoticeLayer:getUIName()
	return "GatewayNoticeUI"
end

function GatewayNoticeLayer:init()
	self.trFrame = self._tf:Find("frame")
	self.txtTitle = self._tf:Find("frame/title"):GetComponent("Text")
	self.txtContent = self._tf:Find("frame/content"):GetComponent("RichText")
	self.btnBack = self._tf:Find("frame/title_pop/btnBack")

	return
end

function GatewayNoticeLayer:didEnter()
	onButton(self, self.btnBack, function()
		self:showNext()

		return
	end)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function GatewayNoticeLayer:updateNotices(arg_5_1)
	self.notices = arg_5_1

	self:showNext()

	return
end

function GatewayNoticeLayer:showNext()
	if self.notice then
		self.notice:markAsRead()
	end

	if #self.notices > 0 then
		self.notice = table.remove(self.notices, 1)
		self.txtTitle.text = self.notice.title
		self.txtContent.text = self.notice.content

		local var_6_0 = self.trFrame:GetComponent("CanvasGroup")

		LeanTween.cancel(go(self.trFrame))
		LeanTween.value(go(self.trFrame), 0, 1, 0.3):setEase(LeanTweenType.easeOutBack):setOnUpdate(System.Action_float(function(arg_7_0)
			var_6_0.alpha = arg_7_0
			self.trFrame.localScale = Vector3(0.8, 0.8, 1) + Vector3(0.2, 0.2, 0) * arg_7_0

			return
		end))
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_PANEL)
	else
		self:emit(BaseUI.ON_CLOSE)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
	end

	return
end

function GatewayNoticeLayer:willExit()
	LeanTween.cancel(go(self.trFrame))
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return GatewayNoticeLayer
