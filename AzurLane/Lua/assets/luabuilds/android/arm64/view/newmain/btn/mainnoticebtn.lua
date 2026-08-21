local var_0_0 = class("MainNoticeBtn", import(".MainBaseBtn"))

function var_0_0.OnClick(arg_1_0)
	if #getProxy(ServerNoticeProxy):getServerNotices(false) > 0 then
		arg_1_0:emit(NewMainMediator.OPEN_NOTICE)
	else
		pg.TipsMgr.GetInstance():ShowTips(i18n("no_notice_tip"))
	end

	return
end

return var_0_0
