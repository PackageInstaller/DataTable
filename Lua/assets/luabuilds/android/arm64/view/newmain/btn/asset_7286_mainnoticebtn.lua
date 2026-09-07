local MainNoticeBtn = class("MainNoticeBtn", import(".MainBaseBtn"))

function MainNoticeBtn:OnClick()
	if #getProxy(ServerNoticeProxy):getServerNotices(false) > 0 then
		self:emit(NewMainMediator.OPEN_NOTICE)
	else
		pg.TipsMgr.GetInstance():ShowTips(i18n("no_notice_tip"))
	end

	return
end

return MainNoticeBtn
