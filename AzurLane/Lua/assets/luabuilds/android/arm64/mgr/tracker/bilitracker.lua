local var_0_0 = class("BiliTracker")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	return
end

function var_0_0.Tracking(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if arg_2_1 == TRACKING_USER_LEVELUP then
		originalPrint("tracking lvl:" .. arg_2_3)
		pg.SdkMgr.GetInstance():SdkLevelUp()
	end

	return
end

return var_0_0
