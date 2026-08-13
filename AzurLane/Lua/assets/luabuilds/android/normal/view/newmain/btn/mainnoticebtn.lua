class = var_0_10000

local var_0_0 = "MainNoticeBtn"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MainBaseBtn"))

function var_0_1.OnClick(arg_1_0)
	getProxy = var_1_10001
	ServerNoticeProxy = var_1_10002

	local var_1_0 = var_1_10001(var_1_10002)
	local var_1_2

	if #var_1.getServerNotices(var_1_0, false) > 0 then
		local var_1_1 = arg_1_0

		var_1_2 = arg_1_0.emit
		NewMainMediator = var_1_10005

		var_1_2(var_1_1, var_1_10005.OPEN_NOTICE)
	else
		pg = var_1_2

		local var_1_3 = var_1_2.TipsMgr.GetInstance()
		local var_1_4 = var_3.ShowTips

		i18n = var_1_10005

		var_1_4(var_1_3, var_1_10005("no_notice_tip"))
	end

	return
end

return var_0_1
