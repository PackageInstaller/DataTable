local KwxyKrTracker = class("KwxyKrTracker")

function KwxyKrTracker:Ctor(arg_1_1)
	self.mapping = {
		[TRACKING_TUTORIAL_COMPLETE_1] = "tutorial_complete_1",
		[TRACKING_USER_LEVELUP] = "user_levelup",
		[TRACKING_EXP_LV_10] = "stdlevel10",
		[TRACKING_EXP_LV_20] = "stdlevel20",
		[TRACKING_EXP_LV_30] = "stdlevel30",
		[TRACKING_STRIKE_FAILD] = "stdexhausted",
		[TRACKING_PAY_OIL] = "stdstaminapurchase",
		[TRACKING_PAY_FAILD] = "stdrechargeprompt",
		[TRACKING_PAY_SUCCESS] = "stdrecharge",
		[TRACKING_BUILD_OR_SKIN_FAILD] = "stdlackofdiamonds"
	}

	return
end

function KwxyKrTracker:Tracking(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	if self.mapping[arg_2_1] then
		pg.SdkMgr.GetInstance():EventTrack(self.mapping[arg_2_1])
	end

	return
end

return KwxyKrTracker
