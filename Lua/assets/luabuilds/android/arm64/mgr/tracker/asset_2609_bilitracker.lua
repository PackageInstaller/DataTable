local BiliTracker = class("BiliTracker")

function BiliTracker:Ctor(arg_1_1)
	return
end

function BiliTracker:Tracking(arg_2_1, arg_2_2, arg_2_3)
	if arg_2_1 == TRACKING_USER_LEVELUP then
		originalPrint("tracking lvl:" .. arg_2_3)
		pg.SdkMgr.GetInstance():SdkLevelUp()
	end

	return
end

return BiliTracker
